import test, { expect } from "@playwright/test";
import dotenv from 'dotenv';
import path from 'path';
import { kasir } from "../data/user";
import { cart, productCart } from "../data/product";
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

    test('should can do transaction at cashier', async ({ page }) => {
        await page.goto(`/${domain}/transaction`);

        // insert produk
        await page.getByTestId('input-search-product').fill(productCart.name);
        await page.getByTestId('btn-insert-cart').click();

        // produk muncul di keranjang
        const cartRow = page.locator('[data-id="5"]');
        await expect(cartRow).toBeVisible();

        await page.getByTestId('pay-transaction').fill(cart.pay_received);
        await expect(page.getByTestId('return-transaction')).toHaveValue(cart.pay_return);
        
        // cek summary belanja
        await expect(page.locator('#cart-total-item')).toHaveText(cart.total_item);
        await expect(page.locator('#cart-sub-total')).toHaveText(cart.subtotal);
        await expect(page.locator('#cart-total-tax')).toHaveText(cart.total_tax);
        await expect(page.locator('#cart-total-discount')).toHaveText(cart.total_discount);
        await expect(page.locator('#cart-total')).toHaveText(cart.total);

        // preview struct
        await page.getByTestId('btn-preview-struct').click();
    });
});