locals {
  source_bucket_name  = "${var.name}-${var.environment}-source-bucket"
  cloud_function_name = "cf-${var.name}-${var.environment}"
  topic_name          = "${var.name}-${var.environment}-logs-ingestor-topic"
  create_pubsub_topic = [var.create_pubsub_topic ? 1 : 0]
}

resource "google_pubsub_topic" "topic" {
  count    = var.create_pubsub_topic ? 1 : 0
  provider = google-beta
  project  = var.project_id
  name     = local.topic_name
  labels = {
    project_id = var.project_id
    topic_name = local.topic_name
  }
}

resource "google_service_account" "function" {
  project      = var.project_id
  account_id   = "sa-${var.name}-${var.environment}"
  display_name = "Service Account for impersonation to run Cloud Function ${local.cloud_function_name}"
}

resource "google_storage_bucket_iam_member" "function" {
  bucket = var.storage_source_bucket_name
  role   = "roles/storage.objectViewer"
  member = google_service_account.function.member
}

resource "google_cloudfunctions2_function" "function" {
  depends_on  = [google_storage_bucket_iam_member.function]
  name        = local.cloud_function_name
  project     = var.project_id
  location    = var.region
  description = var.cloud_function_description

  build_config {
    runtime     = var.runtime
    entry_point = var.entry_point
    source {
      storage_source {
        bucket = var.storage_source_bucket_name
        object = var.storage_source_object_name
      }
    }
  }

  service_config {
    service_account_email = google_service_account.function.email
    max_instance_count    = var.max_instance_count
    min_instance_count    = var.min_instance_count
    available_memory      = var.available_memory
    available_cpu         = var.available_cpu
    timeout_seconds       = var.timeout_seconds
    ingress_settings      = "ALLOW_INTERNAL_ONLY"
  }

  dynamic "event_trigger" {
    for_each = toset(local.create_pubsub_topic)
    content {
      trigger_region = var.region
      event_type     = "google.cloud.pubsub.topic.v1.messagePublished"
      pubsub_topic   = google_pubsub_topic.topic[0].id
      retry_policy   = "RETRY_POLICY_RETRY"
    }
  }
}
