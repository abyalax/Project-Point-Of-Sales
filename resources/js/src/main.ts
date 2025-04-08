import CartManager from "./cart/module/cart-manager";
import CartUI from "./cart/module/cart-ui";
import ProductManager from "./product/module/product-manager";
import ProductUI from "./product/module/product-ui";

document.addEventListener('DOMContentLoaded', async () => {
    console.log('Start Load Cart Mecahanism...');
    const cartManager = new CartManager()
    const productManager = new ProductManager();

    new ProductUI(productManager);
    new CartUI(cartManager)
})