output "rancher_access_url" {
  value       = "https://${aws_instance.rancher_server.public_ip}"
  description = "URL para acessar o painel do Rancher"
}

output "instance_id" {
  value       = aws_instance.rancher_server.id
  description = "ID da instância EC2 criada"
}

output "ssh_command" {
  value       = "ssh -i rancher-key.pem ubuntu@${aws_instance.rancher_server.public_ip}"
  description = "Comando para conectar via SSH na maquina"
}