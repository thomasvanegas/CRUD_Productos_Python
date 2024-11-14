provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "my_key" {
  key_name   = "id_rsa"
  public_key = file("~/.ssh/id_rsa.pub")
}

# Crear un grupo de seguridad para permitir tráfico en el puerto 80
resource "aws_security_group" "allow_http" {
  name_prefix = "allow_http_"

  ingress {
    from_port   = 80
    to_port     = 80
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

# Crear una instancia EC2 con el grupo de seguridad
resource "aws_instance" "web_server" {
  ami           = "ami-0866a3c8686eaeeba" # AMI de Amazon Linux 2 (puede variar por región)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.my_key.key_name

  vpc_security_group_ids = [aws_security_group.allow_http.id]

  provisioner "file" {
    source      = "./install.sh"
    destination = "/home/ec2-user/install.sh"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ec2-user/install.sh",
      "/home/ec2-user/install.sh"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
      host        = self.public_ip
    }
  }

  tags = {
    Name = "Terraform-Telematica-Web-Server"
  }
}

# Salida para ver la IP pública de la instancia
output "instance_ip" {
  value = aws_instance.web_server.public_ip
}