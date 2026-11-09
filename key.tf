# 1. Generación de clave privada de forma local (Proveedor TLS)
resource "tls_private_key" "rsa_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# 2. Registro de la llave pública en AWS (Proveedor AWS)
resource "aws_key_pair" "aws_deployer_key" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa_key.public_key_openssh
}

# 3. Guardar el archivo .pem localmente en tu máquina Windows (Proveedor Local)
resource "local_file" "ssh_private_key" {
  content         = tls_private_key.rsa_key.private_key_pem
  filename        = "./${var.key_name}.pem"
  file_permission = "0400"
}