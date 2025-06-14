import { test as base } from '@playwright/test';
import { url_test } from '../config';
import { kasir } from '../data/user';

type MyFixtures = {
    withLogin: boolean;
};

export const test = base.extend<MyFixtures>({
    withLogin: [false, { option: true }],

    page: async ({ page, withLogin }, use) => {
        if (withLogin) {
            await page.goto(`${url_test}/login`);
            await page.getByTestId('login-email').fill(kasir.email);
            await page.getByTestId('login-password').fill(kasir.password);
            await page.getByTestId('btn-login').click();
            await page.waitForURL(`${url_test}/transaction`);
        }
        await use(page);
    }
});

export { expect } from '@playwright/test';
