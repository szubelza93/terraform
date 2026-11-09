/*

resource "aws_instance" "frontend" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.frontend.id
  vpc_security_group_ids      = [aws_security_group.frontend.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.aws_deployer_key.key_name # <-- Referencia dinámica

  tags = {
    Name  = "servidor-frontend"
    Layer = "frontend"
  }
}

resource "aws_instance" "backend" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.backend.id
  vpc_security_group_ids      = [aws_security_group.backend.id]
  associate_public_ip_address = true 
  key_name                    = aws_key_pair.aws_deployer_key.key_name # <-- Referencia dinámica

  tags = {
    Name  = "servidor-backend"
    Layer = "backend"
  }
}


# 2. Servidor EC2: Capa Backend (API Node.js + MySQL con Cloud-Init)
resource "aws_instance" "backend" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.backend.id
  vpc_security_group_ids      = [aws_security_group.backend.id]
  associate_public_ip_address = true 
  key_name                    = aws_key_pair.aws_deployer_key.key_name

  # Inyección de configuración automatizada mediante Cloud-Init y Templatefile
  user_data = templatefile("${path.module}/cloud-init.yaml", {
    db_name     = "sistemadeasistencia_db"
    db_user     = "admin_user"
    db_password = "SecurePassword123!"
  })

  tags = {
    Name  = "servidor-backend"
    Layer = "backend"
  }
}

*/
/*  */
# 1. Instancia Frontend
resource "aws_instance" "frontend" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type #[cite: 3]
  subnet_id                   = aws_subnet.frontend.id
  vpc_security_group_ids      = [aws_security_group.frontend.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.aws_deployer_key.key_name

  user_data = templatefile("${path.module}/base-cloud-init.yaml.tftpl", {})

  tags = { Name = "servidor-frontend", Layer = "frontend" }
}

# 2. Instancia Base de Datos (PostgreSQL)
resource "aws_instance" "database" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type #[cite: 3]
  subnet_id                   = aws_subnet.database.id
  vpc_security_group_ids      = [aws_security_group.database.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.aws_deployer_key.key_name

  user_data = templatefile("${path.module}/base-cloud-init.yaml.tftpl", {})

  tags = { Name = "servidor-database", Layer = "database" }
}

# 3. Instancia Backend (Node.js conectado a la IP privada de PostgreSQL)
resource "aws_instance" "backend" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type #[cite: 3]
  subnet_id                   = aws_subnet.backend.id
  vpc_security_group_ids      = [aws_security_group.backend.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.aws_deployer_key.key_name
  tags = { Name = "servidor-backend", Layer = "backend" }
  
  user_data = templatefile("${path.module}/base-cloud-init.yaml.tftpl", {})

  depends_on = [aws_instance.database]
}
