variable "instance_family_image" {
  description = "Instance image"
  type        = string
  default     = "lamp"
}

variable "vpc_subnet_id" {
  description = "VPC subnet network id"
  type        = string
}


variable "instance_zone" {
  description = "Instance zone"
  type        = string
  default     = "ru-central1-a"
}


variable "instance_meta" {
  description = "Instance metadata"
  type        = string
  default     = "hi"
}
