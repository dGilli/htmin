import { test, expect } from "@playwright/test";

test("includes work", async ({ page }) => {
    await page.goto("http://exampleapp/");
    await expect(page).toHaveTitle(/HTMIN/);
});

