import { defineConfig } from '@playwright/test';

export default defineConfig({
    use: {
        baseURL: process.env.base_url || "http://exampleapp",
    },
});
