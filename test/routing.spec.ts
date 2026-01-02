import { test, expect } from "@playwright/test";

test("files with _ prefix are not public", async ({ page }) => {
    const response = await page.goto("http://exampleapp/_partial/footer");
    expect(response.status()).toBe(404);
});

test.skip("serve subpage", async ({ page }) => {
    await page.goto("http://exampleapp/privacy");
    await expect(page).toHaveTitle(/Privacy/);
});

test("htmx request via query", async ({ page }) => {
    const response = await page.goto("http://exampleapp?hxboost=true");
    const headerValue = response.headers()["hx-response"];
    expect(headerValue).toBe("true");
});

