variable "aws_region" {
  type        = string
  default     = "sa-east-1"
  description = "AWS region to deploy"
}

variable "instance_type" {
  type        = string
  default     = "t3.xlarge"
  description = "Instance type EC2 (SLES recommended 4 vCPU/8GB RAM)"
}
