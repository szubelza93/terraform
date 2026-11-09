/*

output "vpc_id" {
  description = "ID de la VPC principal"
  value       = aws_vpc.main.id
}

output "frontend_public_ip" {
  value = aws_instance.frontend.public_ip
}

output "backend_public_ip" {
  value = aws_instance.backend.public_ip
}

output "database_public_ip" {
  value = aws_instance.database.public_ip
}

output "ssh_connection_command_backend" {
  value = "ssh -i ${var.key_name}.pem ubuntu@${aws_instance.backend.public_ip}"
}

*/