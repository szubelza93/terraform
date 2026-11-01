terraform {
  backend "s3" {
    bucket         = "mi-estado-terraform-dos-capas-9660830" # El mismo nombre exacto que pusiste arriba
    key            = "architecture/terraform.tfstate"       # Ruta interna dentro del bucket donde se guardará el archivo
    region         = "us-east-1"
    encrypt        = true
  }
}