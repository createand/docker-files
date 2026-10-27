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

# count = 3 yazarak bu konteynerden yan yana 3 adet üretmesini söylüyoruz
resource "docker_container" "nginx_sunucu_local" {
  count = 3 
  
  image = docker_image.nginx_imaj.image_id
  
  # count.index (0, 1, 2) kullanarak her konteynere benzersiz isim veriyoruz:
  # QA-Lokal-Test-Sunucusu-IRFAN-YILDIRIM-XXXXX-0
  # QA-Lokal-Test-Sunucusu-IRFAN-YILDIRIM-XXXXX-1 ... gibi.
  name  = "QA-Lokal-Test-Sunucusu-IRFAN-YILDIRIM-XXXXX-${count.index}"

  ports {
    internal = 80
    
    # Her konteynerin dış portunu otomatik artırıyoruz:
    # 0. indeks için -> 8090
    # 1. indeks için -> 8091
    # 2. indeks için -> 8092
    external = 8090 + count.index
  }
}
