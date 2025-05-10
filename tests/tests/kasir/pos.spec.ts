import test, { expect } from "@playwright/test";
import dotenv from 'dotenv';
import path from 'path';
import { productCart } from "../../data/product";
import { kasir } from "../../data/user";
dotenv.config({ path: path.resolve(__dirname, '.env') });

const domain = process.env.DOMAIN;

test.describe.configure({ mode: 'serial' });

test.describe('Point of Sales Kasir Testing', () => {

    test.beforeEach(async ({ page }) => {
        await page.goto(`/${domain}/login`);
        await page.getByTestId('login-email').fill(kasir.email);
        await page.getByTestId('login-password').fill(kasir.password);
        await page.getByTestId('btn-login').click();
        await page.waitForURL(`/${domain}/transaction`);
    })

    test('should can insert product and update ui', async ({ page }) => {
        await page.goto(`/${domain}/transaction`);

        // 1. cari produk
        await page.getByTestId('input-search-product').fill(productCart.name);
        await page.getByTestId('btn-insert-cart').click();

        // 2. produk muncul di keranjang
        const cartRow = page.locator('[data-id="5"]');
        await expect(cartRow).toBeVisible();

        await page.getByTestId('pay-transaction').fill('20000');
        await expect(page.getByTestId('return-transaction')).toHaveValue('Rp 4.485');

        // 3. cek summary belanja
        // await expect(page.getByTestId('summary-total')).toHaveText('Rp10.000');
        // await expect(page.getByTestId('summary-total-item')).toHaveText('1');

        // 4. preview struct
        await page.getByTestId('btn-preview-struct').click();
    });
});