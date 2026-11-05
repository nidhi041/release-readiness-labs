variable "aws_secret_key" {
  type        = string
  description = "AWS secret key — must be provided via environment variable TF_VAR_aws_secret_key or secrets manager. Never hardcoded."
  sensitive   = true
}
