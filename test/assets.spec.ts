import { test, expect } from "@playwright/test";

test("serve assets", async ({ page }) => {
    const response = await page.goto("/assets/favicon.ico");
    expect(response.status()).toBe(200);
});

