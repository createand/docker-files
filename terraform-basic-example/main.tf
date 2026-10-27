terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.25.0" # Senin Docker API sürümünle uyumlu olan stabil versiyon
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# 1. ÖZELLEŞTİRİLMİŞ İMAJ BUILD ETME
resource "docker_image" "custom_nginx_imaj" {
  name = "irfan-nginx:v1" # İmajımıza bir isim ve etiket veriyoruz
  
  build {
    context = "." # Dockerfile'ın olduğu mevcut klasörü taramasını söylüyoruz
  }
}

# 2. ÜRETİLEN ÖZEL İMAJDAN KONTEYNER AÇMA
resource "docker_container" "custom_nginx_sunucu" {
  image = docker_image.custom_nginx_imaj.image_id
  name  = "QA-Custom-Sunucu-IRFAN"

  ports {
    internal = 80
    external = 9095 # Tarayıcıdan erişeceğimiz port
  }
}
