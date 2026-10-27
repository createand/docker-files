# 1. AWS Sağlayıcı (Provider) Ayarları
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Stabil AWS eklenti sürümü
    }
  }
}

provider "aws" {
  region = "eu-north-1" # Senin belirlediğin Stockholm bölgesi
}

# 2. Güvenlik Grubu (Security Group) Oluşturma (22 ve 80 Portlarını Açar)
resource "aws_security_group" "qaops_sg" {
  name        = "qaops-sunucu-guvenlik-grubu"
  description = "SSH ve HTTP portlarini dunyaya acar"

  # SSH (Port 22) İzni
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP (Port 80) İzni
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Sunucunun dış dünyaya (internete) çıkış izni (Güncellemeler için şart)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 3. Apache Kurulumlu Sanal Sunucu (EC2)
resource "aws_instance" "apache_server" {
  ami                    = "ami-021aaf3749be66813" # Senin verdiğin Stockholm Ubuntu imajı
  instance_type          = "t3.micro"
  
  # Buradaki isim hatasını senin 'qaops_sg' kaynağına göre düzelttik:
  vpc_security_group_ids = [aws_security_group.qaops_sg.id]

  # 🚀 Sunucu açılırken Apache'yi otomatik kuran bash scripti
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install apache2 -y
              sudo systemctl start apache2
              sudo systemctl enable apache2
              
              # Ana sayfayı kendimize göre özelleştirelim (Türkçe karakter destekli)
              echo "<html lang='tr'><head><meta charset='UTF-8'></head><body><h1 style='color:darkblue; text-align:center; padding-top:100px;'>🚀 İrfan Yıldırım - Terraform ile AWS'de Apache Sunucusu Başarıyla Kuruldu!</h1></body></html>" | sudo tee /var/www/html/index.html
              EOF

  tags = {
    Name = "Terraform-Ateslenen-QAOps-Sunucusu"
  }
}

# 4. Sunucu açıldığında Public IP adresini terminale otomatik yazdır
output "sunucu_public_ip" {
  # Buradaki isim hatasını da yukarıdaki 'apache_server' kaynağına göre eşitledik kanka:
  value       = aws_instance.apache_server.public_ip
  description = "Açılan sunucunun dünyaya açık IP adresi"
}

