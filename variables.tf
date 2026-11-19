variable "aws_region" {
  type        = string
  default     = "sa-east-1"
  description = "Região da AWS para o deploy"
}

variable "instance_type" {
  type        = string
  default     = "t3.xlarge"
  description = "Tipo da instância EC2 (SLES recomenda 4 vCPU/8GB RAM)"
}