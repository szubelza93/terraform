# Recurso para crear el Bucket S3 que almacenará el estado remoto
resource "aws_s3_bucket" "terraform_state" {
  bucket        = "mi-estado-terraform-dos-capas-9660830" # Debe ser un nombre globalmente único en AWS (puedes añadir tu C.I. o números al final)
  force_destroy = true                                    # Permite destruir el bucket si haces terraform destroy en el futuro

  tags = {
    Name        = "Terraform State Bucket"
    Environment = "Production"
  }
}

# Habilitar versionado de estado (Permite recuperar versiones anteriores ante fallos)
resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Habilitar cifrado por defecto en el bucket S3
resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}