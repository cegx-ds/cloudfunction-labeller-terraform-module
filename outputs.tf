output "service_account_email" {
  value = google_service_account.function.email
}

output "service_account_member" {
  value = google_service_account.function.member
}

output "name" {
  value      = google_pubsub_topic.topic[0].id
  depends_on = [var.create_pubsub_topic]
}
