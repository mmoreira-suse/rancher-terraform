output "rancher_access_url" {
  value       = "https://${aws_instance.rancher_server.public_ip}"
  description = "Rancher URL"
}

output "instance_id" {
  value       = aws_instance.rancher_server.id
  description = "ec2 instance ID"
}

output "ssh_command" {
  value       = "ssh -i rancher-key.pem ubuntu@${aws_instance.rancher_server.public_ip}"
  description = "SSH command to EC2 instance"
}
