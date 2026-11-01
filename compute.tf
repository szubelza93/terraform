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