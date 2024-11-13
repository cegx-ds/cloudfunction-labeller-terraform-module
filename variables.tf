variable "name" {
  type        = string
  description = "Friendly name for all resources"
}

variable "region" {
  type        = string
  description = "region in which to deploy resource"
  default     = "europe-west2"
}

variable "environment" {
  type        = string
  description = "environment name i.e. prod|dev|staging"
}

variable "project_id" {
  type        = string
  description = "project ID to apply resources to"
}

# CloudFunction
variable "entry_point" {
  description = "entry point for cloud function"
  type        = string
}

variable "runtime" {
  description = "cloud function runtime"
  type        = string
}

variable "cloud_function_description" {
  description = "decription for cloud function"
  type        = string
  default     = "Cloud Function Managed by Terraform"
}

variable "max_instance_count" {
  description = "The maximum number of instances for the Cloud Function."
  type        = number
  default     = 10
}

variable "min_instance_count" {
  description = "The minimum number of instances for the Cloud Function."
  type        = number
  default     = 1
}

variable "available_memory" {
  description = "The amount of memory available for the Cloud Function."
  type        = string
  default     = "256MB"
}

variable "available_cpu" {
  description = "The amount of CPU available for the Cloud Function."
  type        = number
  default     = 1
}

variable "timeout_seconds" {
  description = "The timeout for the Cloud Function in seconds."
  type        = number
  default     = 120
}

variable "storage_source_bucket_name" {
  type        = string
  description = "Name of the bucket that stores source zip file for cloudfunction"
}

variable "storage_source_object_name" {
  type        = string
  description = "Name of the object that contains source code for cloudfunction"
}

variable "create_pubsub_topic" {
  type        = bool
  description = "Whether to create a pubsub topic and attach it to cloud function event trigger"
}

