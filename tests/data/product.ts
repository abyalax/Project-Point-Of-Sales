import { CartItem } from "../types/cart";

/**
 *     INSERT INTO products (name, price, discount, barcode, category_id, stock_qty, is_active, cost_price, tax_rate)
 *     ('Sabun Cuci Piring Sunlight 755ml', 14500.00, 0.10, '8999999998888', 3, 40, true, 11000.00, 0.10),
 */
export const productCart: CartItem = {
    id: 5,
    name: "Sabun Cuci Piring Sunlight 755ml",
    barcode: 8999999998888,
    quantity: 1,
    price: 14500,
    cost_price: 11000,
    discount: 0.10,
    tax_rate: 0.10
}