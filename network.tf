resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "vpc-dos-capas-free-tier"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw-dos-capas"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "rt-publica"
  }
}

# Subred 1: Frontend
resource "aws_subnet" "frontend" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.frontend_cidr #[cite: 2, 3]
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = { 
    Name = "subnet-frontend" 
    }
}

# Subred 2: Backend
resource "aws_subnet" "backend" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.backend_cidr #[cite: 2, 3]
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = { 
    Name = "subnet-backend" 
    }
}

# Subred 3: Database (PostgreSQL)
resource "aws_subnet" "database" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.database_cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = { 
    Name = "subnet-database" 
    }
}

resource "aws_route_table_association" "frontend_assoc" {
  subnet_id      = aws_subnet.frontend.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "backend_assoc" {
  subnet_id      = aws_subnet.backend.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "database_assoc" {
  subnet_id      = aws_subnet.database.id
  route_table_id = aws_route_table.public.id
}