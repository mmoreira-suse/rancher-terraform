resource "tls_private_key" "rancher_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "rancher-suse-key"
  public_key = tls_private_key.rancher_key.public_key_openssh
}

resource "local_file" "private_key" {
  content         = tls_private_key.rancher_key.private_key_pem
  filename        = "${path.module}/rancher-key.pem"
  file_permission = "0400" 
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "rancher_sg" {
  name        = "rancher-suse-sg"
  description = "SSH access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
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
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "rancher_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  key_name = aws_key_pair.generated_key.key_name

  vpc_security_group_ids = [aws_security_group.rancher_sg.id]

  root_block_device {
    volume_size           = 40
    volume_type           = "gp3"
    delete_on_termination = true
  }
  user_data = <<-EOF
              #!/bin/bash
              
              apt-get update -y
              apt-get install -y docker.io

              systemctl enable --now docker
              usermod -aG docker ubuntu

              docker run -d --name rancher-server --restart=unless-stopped -p 80:80 -p 443:443 --privileged rancher/rancher:v2.13.3
              EOF

  tags = { Name = "rancher-manager-ubuntu" }
}
