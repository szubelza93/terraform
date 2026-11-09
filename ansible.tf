resource "local_file" "ansible_inventory" {
  content = <<-EOT
    [frontend]
    ${aws_instance.frontend.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=${var.key_name}.pem

    [backend]
    ${aws_instance.backend.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=${var.key_name}.pem

    [database]
    ${aws_instance.database.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=${var.key_name}.pem

    [all:vars]
    ansible_ssh_common_args='-o StrictHostKeyChecking=no'
  EOT
  filename = "${path.module}/inventory.ini"
}