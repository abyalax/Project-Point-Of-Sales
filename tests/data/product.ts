
import { CartItem } from "../../src/types/cart"
import { formatPrice } from "../../src/helper/index"
/**
 *     INSERT INTO products (name, price, discount, barcode, category_id, stock_qty, is_active, cost_price, tax_rate)
 *     ('Sabun Cuci Piring Sunlight 755ml', 14500.00, 0.10, '8999999998888', 3, 40, true, 11000.00, 0.10),
 */
export const productCart: CartItem = {
    id: 5,
    name: "Sabun Cuci Piring Sunlight 755ml",
    category: "Perlengkapan Rumah",
    barcode: 8999999998888,
    quantity: 1,
    cost_price: 11000,
    price: 14500,
    discount: 0.10,
    tax_rate: 0.10
}

export const cart = {
    total_item: '1',
    subtotal: formatPrice(14500),
    total_tax: formatPrice(1450),
    total_discount: formatPrice(1450),
    total: formatPrice(14500),
    pay_received: '20000',
    pay_return: formatPrice(5500)
}