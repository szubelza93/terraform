output "vpc_id" {
  description = "ID de la VPC principal"
  value       = aws_vpc.main.id
}

output "frontend_public_ip" {
  description = "Direccion IP publica del servidor Frontend"
  value       = aws_instance.frontend.public_ip
}

output "backend_public_ip" {
  description = "Direccion IP publica del servidor Backend (Aislado por Security Group)"
  value       = aws_instance.backend.public_ip
}

output "ssh_connection_command_frontend" {
  description = "Comando para conectar al Frontend mediante SSH desde Windows"
  value       = "ssh -i vps-dos-capas-key.pem ubuntu@${aws_instance.frontend.public_ip}"
}

output "ssh_connection_command_backend" {
  description = "Comando para conectar al Backend mediante SSH desde Windows"
  value       = "ssh -i vps-dos-capas-key.pem ubuntu@${aws_instance.backend.public_ip}"
}