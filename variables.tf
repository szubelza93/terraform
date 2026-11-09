variable "aws_region" {
  type        = string
  description = "Región de AWS para el despliegue"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  type        = string
  description = "Bloque CIDR principal de la VPC"
  default     = "10.0.0.0/24"
}

variable "backend_cidr" {
  type        = string
  description = "Bloque CIDR para la subred del backend (>70 hosts)"
  default     = "10.0.0.0/25"
}

variable "frontend_cidr" {
  type        = string
  description = "Bloque CIDR para la subred del frontend (>50 hosts)"
  default     = "10.0.0.128/26"
}

variable "database_cidr" {
  type        = string
  description = "Bloque CIDR para la subred de la base de datos PostgreSQL"
  default     = "10.0.0.192/26"
}

variable "admin_ssh_cidr" {
  type        = string
  description = "Direccion IP o bloque CIDR autorizado para conexion SSH (ej. Tu_IP/32)"
  default     = "0.0.0.0/0" # Cambia esto por tu IP real por seguridad (ej. "200.10.20.30/32")
}

variable "instance_type" {
  type        = string
  description = "Tipo de instancia EC2 compatible con Free Tier"
  default     = "t3.micro"
}

variable "key_name" {
  type        = string
  description = "Nombre del par de llaves SSH existente en AWS para acceder a las instancias"
  default     = "mi-llave-aws" # Cambia esto por el nombre real de tu key pair en AWS
}