
variable "name" {
  description = "Name prefix for VPC resources."
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
  validation {
    condition     = can(cidrsubnet(var.cidr_block, 0))
    error_message = "Invalid CIDR block for VPC. Please provide a valid IPv4 CIDR block."
  }
}
