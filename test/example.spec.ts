import { test, expect } from "@playwright/test";

test("has title", async ({ page }) => {
    await page.goto("http://exampleapp/");
    await expect(page).toHaveTitle(/HTMIN/);
});

test("includes work", async ({ page }) => {
    await page.goto("http://exampleapp/");
    await expect(page).toHaveTitle(/HTMIN/);
});

test("contains a <footer> element", async ({ page }) => {
    await page.goto("http://exampleapp");
    const footer = await page.locator("footer");
    await expect(footer).toHaveCount(1);
});

test("files with _ prefix are not public", async ({ page }) => {
    const response = await page.goto("http://exampleapp/_partial/footer");
    expect(response.status()).toBe(404);
});

test("serve assets", async ({ page }) => {
    const response = await page.goto("http://exampleapp/assets/favicon.ico");
    expect(response.status()).toBe(200);
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
