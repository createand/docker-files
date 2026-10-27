# 1. Taban İmaj: Resmi Ubuntu 22.04 (ARM altyapınla tam uyumlu)
FROM ubuntu:22.04

# 2. Kurulum Kilitlerini Kırma: İnteraktif soru pencerelerini bypass ediyoruz
ENV DEBIAN_FRONTEND=noninteractive

# 3. Ekstrem Paket Enjeksiyonu ve Temel Araçlar
RUN apt-get update && apt-get install -y \
    xfce4 xfce4-goodies \
    tigervnc-standalone-server \
    novnc websockify \
    curl wget net-tools sudo software-properties-common \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 4. 🔥 CHROMIUM KESİN KURULUM KATMANI (ARM64 & SNAP BAĞIMSIZ)
# Güvenilir XtraDeb PPA'ini ekleyip Chromium'u doğrudan yerel paket olarak kuruyoruz kanka!
RUN add-apt-repository ppa:xtradeb/apps -y && \
    apt-get update && \
    apt-get install -y chromium && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# 5. KULLANICILARI VE SİSTEM ŞİFRELERİNİ OLUŞTURMA
RUN useradd -m -s /bin/bash ahmet && echo "ahmet:ahmet123" | chpasswd && usermod -aG sudo ahmet
RUN useradd -m -s /bin/bash mehmet && echo "mehmet:mehmet123" | chpasswd && usermod -aG sudo mehmet

# 6. VNC LOGIN ŞİFRELERİNİ AYARLAMA
RUN mkdir -p /home/ahmet/.vnc && echo "ahmetvnc" | vncpasswd -f > /home/ahmet/.vnc/passwd && chown -R ahmet:ahmet /home/ahmet/.vnc && chmod 600 /home/ahmet/.vnc/passwd
RUN mkdir -p /home/mehmet/.vnc && echo "mehmetvnc" | vncpasswd -f > /home/mehmet/.vnc/passwd && chown -R mehmet:mehmet /home/mehmet/.vnc && chmod 600 /home/mehmet/.vnc/passwd

# 7. Operasyon Odası: Başlangıç dizini
WORKDIR /root

# 8. Sihirli Başlangıç Script'i (Oturumlar izole ve hazır başlatılır)
RUN echo '#!/bin/sh\n\
rm -rf /tmp/.X11-unix /tmp/.X*-lock\n\
\n\
# --- AHMET İÇİN MASAÜSTÜ (Port: 7901) ---\n\
su - ahmet -c "vncserver :1 -geometry 1366x768 -depth 24 -SecurityTypes VncAuth -rfbauth /home/ahmet/.vnc/passwd"\n\
/usr/share/novnc/utils/launch.sh --vnc localhost:5901 --listen 7901 &\n\
\n\
# --- MEHMET İÇİN MASAÜSTÜ (Port: 7902) ---\n\
su - mehmet -c "vncserver :2 -geometry 1366x768 -depth 24 -SecurityTypes VncAuth -rfbauth /home/mehmet/.vnc/passwd"\n\
/usr/share/novnc/utils/launch.sh --vnc localhost:5902 --listen 7902 &\n\
\n\
wait' > /root/entrypoint.sh \
    && chmod +x /root/entrypoint.sh

# 9. Şanlı Port İlanı ve Tetikleme
EXPOSE 7901 7902
CMD ["/root/entrypoint.sh"]

