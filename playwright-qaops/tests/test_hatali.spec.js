const { test, expect } = require('@playwright/test');

test('Bilerek Patlayan Efsanevi QAOps Testi', async ({ page }) => {
  // 1. Google'a gidiyoruz panpa
  await page.goto('https://google.com');

  // 2. Olmayacak bir başlığı assert ederek testi bilerek patlatıyoruz!
  await expect(page).toHaveTitle(/TÜRİB e-Fatura Sistemi/);
});
