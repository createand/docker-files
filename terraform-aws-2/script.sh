#!/bin/bash
sudo apt-get update -y
sudo apt-get install apache2 -y

# HTML içeriğini buraya çok daha rahat ve temiz bir şekilde yazabilirsin kanka:
echo "
<html lang='tr'>
<head><meta charset='UTF-8'></head>
<body>
    <h1 style='color:darkblue; text-align:center; padding-top:100px;'>
        🚀 İrfan Yıldırım - Terraform ile AWS'de Apache Sunucusu Başarıyla Kuruldu!
    </h1>
</body>
</html>
" | sudo tee /var/www/html/index.html
