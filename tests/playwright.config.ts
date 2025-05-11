import { defineConfig, devices } from '@playwright/test';

/**
 * Read environment variables from file.
 * https://github.com/motdotla/dotenv
 */
import dotenv from 'dotenv';
import path from 'path';
dotenv.config({ path: path.resolve(__dirname, '.env') });

/**
 * See https://playwright.dev/docs/test-configuration.
 */
export default defineConfig({
  testDir: './.',
  fullyParallel: false,
  reporter: 'list',
  use: {
    headless: false,
    launchOptions: {
      headless: false,
      slowMo: 2000,
      args: ['--start-maximized'],
    },
    baseURL: process.env.BASE_URL,
    trace: 'on-first-retry',
  },
  projects: [
    {
      name: 'chromium',
      use: {
        ...devices['Desktop Chrome'],
        viewport: { width: 1920, height: 1080 },
        deviceScaleFactor: 1.25,
      },
    },
  ],
});

// Headless

// export default defineConfig({
//   testDir: './.',
//   fullyParallel: true,
//   reporter: 'list',
//   use: {
//     headless: true,
//     viewport: { width: 1280, height: 720 },
//     launchOptions: {
//       headless: true,
//       slowMo: 0,
//     },
//     baseURL: process.env.BASE_URL,
//     trace: 'on-first-retry',
//   },
//   projects: [
//     {
//       name: 'chromium',
//       use: {
//         ...devices['Desktop Chrome'],
//       },
//     },
//   ],
// });


/**
 * See https://playwright.dev/docs/test-configuration.
 */
// export default defineConfig({

//   testDir: './.',
//   /* Run tests in files in parallel */
//   fullyParallel: true,
//   /* Fail the build on CI if you accidentally left test.only in the source code. */
//   // forbidOnly: !!process.env.CI,
//   /* Retry on CI only */
//   // retries: process.env.CI ? 2 : 0,
//   /* Opt out of parallel tests on CI. */
//   // workers: process.env.CI ? 1 : undefined,
//   /* Reporter to use. See https://playwright.dev/docs/test-reporters */
//   reporter: 'list',
//   /* Shared settings for all the projects below. See https://playwright.dev/docs/api/class-testoptions. */
//   use: {
//     // headless: true,
//     headless: false,
//     viewport: { width: 1280, height: 720 },
//     launchOptions: {
//       headless: true,
//       slowMo: 2000,
//       // slowMo: 0,
//     },
//     /* Base URL to use in actions like `await page.goto('/')`. */
//     baseURL: process.env.BASE_URL,
//     /* Collect trace when retrying the failed test. See https://playwright.dev/docs/trace-viewer */
//     trace: 'on-first-retry',
//   },
//   /* Configure projects for major browsers */
//   projects: [
//     {
//       name: 'chromium',
//       use: {
//         ...devices['Desktop Chrome'],
//       },
//     },

//     // {
//     //   name: 'firefox',
//     //   use: { ...devices['Desktop Firefox'] },
//     // },

//     // {
//     //   name: 'webkit',
//     //   use: { ...devices['Desktop Safari'] },
//     // },

//     /* Test against mobile viewports. */
//     // {
//     //   name: 'Mobile Chrome',
//     //   use: { ...devices['Pixel 5'] },
//     // },
//     // {
//     //   name: 'Mobile Safari',
//     //   use: { ...devices['iPhone 12'] },
//     // },

//     /* Test against branded browsers. */
//     // {
//     //   name: 'Microsoft Edge',
//     //   use: { ...devices['Desktop Edge'], channel: 'msedge' },
//     // },
//     // {
//     //   name: 'Google Chrome',
//     //   use: { ...devices['Desktop Chrome'], channel: 'chrome' },
//     // },
//   ],

//   /* Run your local dev server before starting the tests */
//   // webServer: {
//   //   command: 'npm run start',
//   //   url: 'http://127.0.0.1:3000',
//   //   reuseExistingServer: !process.env.CI,
//   // },
// });
