locals {
  source_bucket_name    = "${var.name}-${var.environment}-source-bucket"
  cloud_function_name   = "cf-${var.name}-${var.environment}"
  topic_name            = "${var.name}-${var.environment}-logs-ingestor-topic"
  create_pubsub_topic   = var.create_pubsub_topic ? [0] : []
  robot_service_account = "service-${data.google_project.project.number}@gcf-admin-robot.iam.gserviceaccount.com"
  build_service_account = var.build_service_account == "" ? local.robot_service_account : var.build_service_account
}

data "google_project" "project" {
  project_id = var.project_id
}

data "google_storage_bucket_object" "src" {
  name   = var.storage_source_object_name
  bucket = var.storage_source_bucket_name
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

resource "google_cloudfunctions2_function" "function" {
  name        = local.cloud_function_name
  project     = var.project_id
  location    = var.region
  description = var.cloud_function_description

  build_config {
    service_account = local.build_service_account
    runtime         = var.runtime
    entry_point     = var.entry_point
    source {
      storage_source {
        bucket = var.storage_source_bucket_name
        object = data.google_storage_bucket_object.src.name
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
    environment_variables = var.environment_variables
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
