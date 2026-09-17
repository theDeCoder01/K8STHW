
output "role_name" {
  description = "The name of the IAM role created."
  value       = aws_iam_role.this.name
}

output "instance_profile_name" {
  description = "The name of the IAM instance profile created."
  value       = aws_iam_instance_profile.this.name
}

output "role_arn" {
  description = "The ARN of the IAM role created."
  value       = aws_iam_role.this.arn
}
output "instance_profile_arn" {
  description = "The ARN of the IAM instance profile created."
  value       = aws_iam_instance_profile.this.arn
}
