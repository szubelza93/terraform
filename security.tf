# 1. Security Group para la Capa Frontend (Expuesta a Internet)
resource "aws_security_group" "frontend" {
  name        = "frontend-dos-capas-sg" # <-- CORREGIDO: Ya no comienza con "sg-"
  description = "Reglas de firewall para el servidor web frontend"
  vpc_id      = aws_vpc.main.id

  # Tráfico HTTP web público
  ingress {
    description = "HTTP desde internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Tráfico HTTPS web público
  ingress {
    description = "HTTPS desde internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Acceso SSH de administración
  ingress {
    description = "SSH administrativo"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_ssh_cidr]
  }

  # Salida libre hacia internet
  egress {
    description = "Salida libre a internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-frontend" # En los tags SÍ está permitido usar "sg-" porque son solo etiquetas descriptivas
  }
}

# 2. Security Group para la Capa Backend (Aislada de Internet)
resource "aws_security_group" "backend" {
  name        = "backend-dos-capas-sg" # <-- CORREGIDO: Ya no comienza con "sg-"
  description = "Reglas de firewall para el servidor backend / API"
  vpc_id      = aws_vpc.main.id

  # TRÁFICO RESTRINGIDO: Solo se permite la comunicación desde el Security Group del Frontend
  ingress {
    description     = "Trafico API exclusivo desde el Frontend"
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.frontend.id]
  }

  # Acceso SSH de administración
  ingress {
    description = "SSH administrativo"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_ssh_cidr]
  }

  # Salida libre hacia internet
  egress {
    description = "Salida libre a internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-backend"
  }
}

# Security Group: Database (PostgreSQL)
resource "aws_security_group" "database" {
  name        = "database-tres-capas-sg"
  description = "Trafico PostgreSQL exclusivo desde Backend"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "PostgreSQL exclusivo desde Backend"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.backend.id]
  }

  ingress {
    description = "SSH administrativo"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_ssh_cidr] #[cite: 3]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "sg-database" }
}