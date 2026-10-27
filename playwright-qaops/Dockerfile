# 1. Taban İmaj: Playwright'ın resmi Node.js ve tarayıcı imajı
FROM mcr.microsoft.com/playwright:v1.64.1-noble

# 2. Kurulum Kilitlerini Kırma
ENV DEBIAN_FRONTEND=noninteractive

# 3. Operasyon Odası
WORKDIR /usr/app

# 4. Bağımlılık Katmanı
RUN npm init -y && npm install @playwright/test

# 5. Test Kodlarını İçeri Üfleme
COPY tests/ ./tests/
COPY playwright.config.js ./

RUN mkdir -p /usr/app/test-results /usr/app/playwright-report && \
    chown -R pwuser:pwuser /usr/app

RUN mkdir -p /usr/app/playwright-report

# 🔥 SİHİRLİ DOKUNUŞ: Klasörün sahipliğini pwuser kullanıcısına devrediyoruz kanka!
# Böylece içeride istediği gibi klasör (test-results, playwright-report) açabilecek moruk.
RUN chown -R pwuser:pwuser /usr/app

# 6. Güvenlik Katmanı (Artık tam yetkili pwuser seansı başlıyor)
USER pwuser

# 7. Tetikleme: Doğrudan Chromium tarayıcı parametresiyle ateşliyoruz
CMD ["npx", "playwright", "test"]
