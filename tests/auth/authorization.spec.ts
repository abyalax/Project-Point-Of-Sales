import test, { expect } from "@playwright/test";
import { kasir, admin, owner, karyawan, manager } from "../data/user"
import { url_test } from "../config";

test.describe('Authorization Testing', () => {
    test('login as a kasir', async ({ page }) => {
        await page.goto(`${url_test}/login`);
        await page.getByTestId('login-email').fill(kasir.email);
        await page.getByTestId('login-password').fill(kasir.password);
        await page.getByTestId('btn-login').click();
        await page.waitForURL(`${url_test}/transaction`);
        await expect(page.getByTestId('page-transaction')).toBeVisible();
    });

    test('login as a admin', async ({ page}) => {
        await page.goto(`${url_test}/login`);
        await page.getByTestId('login-email').fill(admin.email);
        await page.getByTestId('login-password').fill(admin.password);
        await page.getByTestId('btn-login').click();
        await page.waitForURL(`${url_test}/products`);
        await expect(page.getByTestId('page-products')).toBeVisible();
    });
    
    test('login as a owner', async ({ page}) => {
        await page.goto(`${url_test}/login`);
        await page.getByTestId('login-email').fill(owner.email);
        await page.getByTestId('login-password').fill(owner.password);
        await page.getByTestId('btn-login').click();
        await page.waitForURL(`${url_test}/dashboard`);
        await expect(page.getByTestId('page-dashboard')).toBeVisible();
    });

    test('login as a manager', async ({ page}) => {
        await page.goto(`${url_test}/login`);
        await page.getByTestId('login-email').fill(manager.email);
        await page.getByTestId('login-password').fill(manager.password);
        await page.getByTestId('btn-login').click();
        await page.waitForURL(`${url_test}/product`);
        await expect(page.getByTestId('page-product')).toBeVisible();
    });

    test('login as a karyawan', async ({ page}) => {
        await page.goto(`${url_test}/login`);
        await page.getByTestId('login-email').fill(karyawan.email);
        await page.getByTestId('login-password').fill(karyawan.password);
        await page.getByTestId('btn-login').click();
        await page.waitForURL(`${url_test}/karyawans`);
        await expect(page.getByTestId('page-karyawans')).toBeVisible();
    });

});