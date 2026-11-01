# 1. Obtener las Zonas de Disponibilidad disponibles en la región
data "aws_availability_zones" "available" {
  state = "available"
}

# 2. Obtener la AMI oficial más reciente de Ubuntu 22.04 LTS (x86_64)
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # ID de cuenta oficial de Canonical (Ubuntu)
}