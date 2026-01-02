import { test, expect } from "@playwright/test";

test("files with _ prefix are not public", async ({ page }) => {
    const response = await page.goto("/_partial/footer");
    expect(response.status()).toBe(404);
});

test.skip("serve subpage", async ({ page }) => {
    await page.goto("/privacy");
    await expect(page).toHaveTitle(/Privacy/);
});

test("htmx request via query", async ({ page }) => {
    const response = await page.goto("/?hxboost=true");
    const headerValue = response.headers()["hx-response"];
    expect(headerValue).toBe("true");
});

