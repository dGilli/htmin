import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
    use: {
        baseURL: process.env.base_url || "http://exampleapp",
    },
    projects: [
        {
            name: 'chromium',
            use: { ...devices['Desktop Chrome'] },
        },
    ],
});
