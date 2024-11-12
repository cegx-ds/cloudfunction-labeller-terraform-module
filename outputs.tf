output "service_account_email" {
  value = google_service_account.function.email
}

output "service_account_member" {
  value = google_service_account.function.member
}
