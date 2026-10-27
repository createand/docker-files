# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: test_hatali.spec.js >> Bilerek Patlayan Efsanevi QAOps Testi
- Location: tests/test_hatali.spec.js:3:1

# Error details

```
Error: expect(page).toHaveTitle(expected) failed

Expected pattern: /TÜRİB e-Fatura Sistemi/
Received string:  "Google"
Timeout: 5000ms

Call log:
  - Expect "toHaveTitle" with timeout 5000ms
    14 × locator resolved to <html lang="tr" itemscope="" itemtype="http://schema.org/WebPage">…</html>
       - unexpected value "Google"

```

```yaml
- navigation:
  - link "Gmail":
    - /url: https://mail.google.com/mail/&ogbl
  - link "Görsellerde arama yapın":
    - /url: https://www.google.com/imghp?hl=tr&ogbl
    - text: Görseller
  - button "Google uygulamaları"
  - link "Oturum açın":
    - /url: https://accounts.google.com/ServiceLogin?hl=tr&passive=true&continue=https://www.google.com/&ec=futura_exp_og_so_72776762_e
- img "Google"
- search:
  - button "Dosya ve araç ekleyin"
  - combobox "Ara"
  - button "Harf çevirme aracı"
  - button "Sesle arama yapın"
  - button "Görselle arama"
  - link "AI Modu"
  - button "Google'da Ara"
  - button "Kendimi Şanslı Hissediyorum"
- link "Google'ın gelişmiş özellikleriyle sizi dolandırıcılardan nasıl koruduğunu öğrenin"
- text: "Google'ı kullanabileceğiniz diğer diller:"
- link "English":
  - /url: https://www.google.com/setprefs?sig=0_zwdGms5uw4TuDATLvYtH5OFE9mg%3D&hl=en&source=homepage&sa=X&ved=0ahUKEwiRj6m18cqXAxVxhP0HHUezED4Q2ZgBCCk
- contentinfo:
  - text: Türkiye
  - link "Hakkında":
    - /url: https://about.google/?utm_source=google-TR&utm_medium=referral&utm_campaign=hp-footer&fg=1
  - link "Reklam":
    - /url: https://www.google.com/intl/tr_tr/ads/?subid=ww-ww-et-g-awa-a-g_hpafoot1_1!o2&utm_source=google.com&utm_medium=referral&utm_campaign=google_hpafooter&fg=1
  - link "İşletme":
    - /url: https://www.google.com/services/?subid=ww-ww-et-g-awa-a-g_hpbfoot1_1!o2&utm_source=google.com&utm_medium=referral&utm_campaign=google_hpbfooter&fg=1
  - link "Arama nasıl çalışır?":
    - /url: https://google.com/search/howsearchworks/?fg=1
  - link "İklimle ilgili çalışmalarımızın üçüncü on yılı":
    - /url: https://sustainability.google/intl/tr/carbon-free/?utm_source=googlehpfooter&utm_medium=housepromos&utm_campaign=bottom-footer&utm_content=
  - link "Gizlilik":
    - /url: https://policies.google.com/privacy?hl=tr&fg=1
  - link "Şartlar":
    - /url: https://policies.google.com/terms?hl=tr&fg=1
  - button "Ayarlar"
```

# Test source

```ts
  1  | const { test, expect } = require('@playwright/test');
  2  | 
  3  | test('Bilerek Patlayan Efsanevi QAOps Testi', async ({ page }) => {
  4  |   // 1. Google'a gidiyoruz panpa
  5  |   await page.goto('https://google.com');
  6  | 
  7  |   // 2. Olmayacak bir başlığı assert ederek testi bilerek patlatıyoruz!
> 8  |   await expect(page).toHaveTitle(/TÜRİB e-Fatura Sistemi/);
     |                      ^ Error: expect(page).toHaveTitle(expected) failed
  9  | });
  10 | 
```