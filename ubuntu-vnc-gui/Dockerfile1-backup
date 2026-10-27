# 1. Taban İmaj: Tertemiz, safkan resmi Ubuntu imajı kanka
FROM ubuntu:22.04

# 2. Kurulum Kilitlerini Kırma: İnteraktif soru pencerelerini bypass ediyoruz moruk
ENV DEBIAN_FRONTEND=noninteractive

# 3. Ekstrem Paket Enjeksiyonu: XFCE4 masaüstünü, TigerVNC ve NoVNC köprülerini çakıyoruz kanka
RUN apt-get update && apt-get install -y \
    xfce4 xfce4-goodies \
    tigervnc-standalone-server \
    novnc websockify \
    curl wget net-tools \
    && apt-get clean && rm -rf /var/list/apt/lists/*

# 4. Operasyon Odası: Konteyner içi başlangıç dizini
WORKDIR /root

# 5. Başlangıç Script'i: VNC ve NoVNC servislerini arka planda tetikleyecek sihirli satırlar
RUN echo '#!/bin/sh\n\
rm -rf /tmp/.X11-unix /tmp/.X*-lock\n\
vncserver :1 -geometry 1366x768 -depth 24 -SecurityTypes None\n\
/usr/share/novnc/utils/launch.sh --vnc localhost:5901 --listen 7900\n' > /root/entrypoint.sh \
    && chmod +x /root/entrypoint.sh

# 6. Şanlı Port İlanı: 5901 (Düz VNC) ve 7900 (Tarayıcı NoVNC Köprüsü) portlarını dünyaya aç moruk!
EXPOSE 5901 7900

# 7. Tetikleme: Konteyner havalandığında script aslanlar gibi uçsun kanka
CMD ["/root/entrypoint.sh"]
