import { test, expect } from "@playwright/test";

test("has title", async ({ page }) => {
    await page.goto("/");
    await expect(page).toHaveTitle(/HTMIN/);
});

test("contains a <footer> element", async ({ page }) => {
    await page.goto("/");
    const footer = await page.locator("footer");
    await expect(footer).toHaveCount(1);
});

