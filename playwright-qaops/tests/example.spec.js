const { test, expect } = require('@playwright/test');

test('Test 1: Playwright Sayfa Başlığı Kontrolü', async ({ page }) => {
  await page.goto('https://playwright.dev');
  await expect(page).toHaveTitle(/Playwright/);
  console.log("🚀 Worker-1 Görevini Tamamladı!");
});

test('Test 2: Google Arama Sayfası Kontrolü', async ({ page }) => {
  await page.goto('https://google.com');
  await expect(page).toHaveTitle(/Google/);
  console.log("🚀 Worker-2 Görevini Tamamladı!");
});

test('Test 3: GitHub Ana Sayfa Kontrolü', async ({ page }) => {
  await page.goto('https://github.com');
  await expect(page).toHaveTitle(/GitHub/);
  console.log("🚀 Worker-3 Görevini Tamamladı!");
});
