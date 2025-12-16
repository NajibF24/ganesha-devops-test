provider "aws" {
  region = "ap-southeast-1"
}

# Security Group dengan HTTPS (443)
resource "aws_security_group" "web_sg" {
  name        = "ganesha-https-sg"
  description = "Allow HTTP, HTTPS and SSH"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_server" {
  ami           = "ami-060e277c0d4cce553" # Amazon Linux 2
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  # User Data untuk install Docker Compose di AWS
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install docker -y
              service docker start
              usermod -a -G docker ec2-user
              
              # Install Docker Compose
              curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
              chmod +x /usr/local/bin/docker-compose
              
              # (Script selanjutnya akan clone repo & up compose)
              EOF
}