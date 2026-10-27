# 1. Terraform'a bulut yerine yereldeki DOCKER'ı kullanacağını söylüyoruz
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

# Yerel Docker soketine bağlanma ayarı
provider "docker" {
  host = "unix:///var/run/docker.sock" # Linux/Mac için. (Windows ise: "npipe:////./pipe/docker_engine")
}

# 2. Docker Hub'dan hangi imajı indireceğini söylüyoruz (Örn: Nginx Web Server)
resource "docker_image" "nginx_imaj" {
  name         = "nginx:latest"
  keep_locally = false
}

# 3. Bu imajdan bir konteyner (lokal sunucu) türetiyoruz
resource "docker_container" "nginx_sunucu" {
  image = docker_image.nginx_imaj.image_id
  name  = "QA-Lokal-Test-Sunucusu"

  # Bilgisayarının 8080 portunu Docker'ın 80 portuna bağlıyoruz
  ports {
    internal = 80
    external = 8080
  }
}
