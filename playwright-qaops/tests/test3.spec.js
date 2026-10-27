const { test, expect } = require('@playwright/test'); test('Test 3', async ({ page }) => { await page.goto('https://github.com'); await expect(page).toHaveTitle(/GitHub/); });
