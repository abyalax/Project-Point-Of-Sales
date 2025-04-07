import CartManager from "./module/cart-manager";
import CartUI from "./module/cart-ui";

let stateCart = {
    items: [],
    subtotal: 0,
    tax: 0,
    total: 0,
    lastUpdated: new Date().toISOString()
};
let storageCart = JSON.parse(localStorage.getItem('pos_cart') ?? "{}") || {};
const cartManager = new CartManager(stateCart, storageCart)

const cartUI = new CartUI(cartManager)

export default function initCartMechanism() {
    const input = document.getElementById("searchProducts") as HTMLInputElement;
    document.addEventListener('DOMContentLoaded', () => {
        
        cartUI.updateCartDisplay();

        document.addEventListener('cartUpdated', cartUI.updateCartDisplay);
        (document.getElementById('checkout-btn') as HTMLButtonElement).addEventListener('click', () => {
            console.log('Checkout clicked');
            // window.location.href = '/transaction';
        });

        (document.getElementById('cart-form') as HTMLFormElement).addEventListener('submit', (e) => {
            e.preventDefault();
            cartUI.addToCart(input.value)
        });
    });
}