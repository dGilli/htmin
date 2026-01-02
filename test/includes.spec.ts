import { test, expect } from "@playwright/test";

test("includes work", async ({ page }) => {
    await page.goto("/");
    await expect(page).toHaveTitle(/HTMIN/);
});

