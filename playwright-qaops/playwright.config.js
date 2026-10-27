const { defineConfig, devices } = require('@playwright/test');

module.exports = defineConfig({
  testDir: './tests',
  fullyParallel: true, // Testlerin iki tarayıcıda aynı anda akmasını sağlar moruk!
  workers: 2,
  
  // Raporların Docker Compose içindeki klasöre yazılması için:
  reporter: [['html', { outputFolder: 'playwright-report', open: 'never' }]],
  
  // Videoların ve ekran görüntülerinin yerel klasörünüze tam hedefle gitmesini sağlar!
  outputDir: './test-results',

  use: {
    // 🎥 VİDEO VE FOTOĞRAF GARANTİ KATMANI:
    video: 'on',             // Tüm testlerin videosunu çek diyoruz panpa!
    screenshot: 'on',        // Fotoğrafı da her halükarda çek mühürle!
  },
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
    {
      name: 'firefox',
      use: { ...devices['Desktop Firefox'] },
    },
  ],
});

