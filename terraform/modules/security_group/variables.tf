
variable "name" {
  description = "Name of the security group."
  type        = string
}

variable "description" {
  description = "Description of the security group."
  type        = string
  default     = "Managed by Terraform"
}

variable "vpc_id" {
  description = "ID of the VPC in which to create the security group."
  type        = string
}
