import { CartItem } from "../..";
import CartManager from "./cart-manager";

export default class CartUI {
    private cartManager: CartManager

    constructor(cartManager: CartManager) {
        this.cartManager = cartManager
        this.cartManager.loadFromStorage().then(() => this.updateCartDisplay());
    }

    public updateCartDisplay = () => {
        const cartContainer = document.getElementById('cart-items') as HTMLTableSectionElement;
        const subTotalPriceEl = document.getElementById('cart-sub-total') as HTMLParagraphElement;
        const totalPriceEl = document.getElementById('cart-total') as HTMLParagraphElement;
        const totalDiscountEl = document.getElementById('cart-total-discount') as HTMLParagraphElement;

        const carts = this.cartManager.getCart()

        if (carts.items.length === 0) {
            cartContainer.innerHTML = '<tr class="empty-cart odd"><h2>Keranjang kosong</h2></tr>';
            totalPriceEl.textContent = 'Rp0';
            totalDiscountEl.textContent = 'Rp0';
            subTotalPriceEl.textContent = 'Rp0';
            return;
        }

        cartContainer.innerHTML = carts.items.map(item => `
            <tr class="cart-item odd" id="cart-items" data-id="${item.id}">
                <td class="dtr-control sorting_1">${item.id}</td>
                <td class="d-none d-xl-table-cell">${item.barcode}</td>
                <td class="item-name">${item.name}</td>
    
                <td class="item-quantity d-none d-xl-table-cell">
                    <div class="d-flex gap-2">
                        <button type="button" class="qty-minus btn btn-secondary px-1">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                                class="feather feather-minus">
                                <line x1="5" y1="12" x2="19" y2="12"></line>
                            </svg>
                        </button>
                        <span class="fs-3">${item.quantity}</span>
                        <button type="button" class="qty-plus btn btn-secondary px-1">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                                class="feather feather-plus">
                                <line x1="12" y1="5" x2="12" y2="19"></line>
                                <line x1="5" y1="12" x2="19" y2="12"></line>
                            </svg>
                        </button>
                    </div>
                </td>
                <td class="item-price d-none d-xl-table-cell">Rp${Number(item.price).toLocaleString()}</td>
                <td class="d-none d-md-table-cell">${item.discount * 100}%</td>
                <td class="item-price d-none d-xl-table-cell">Rp${((item.price - (item.price * item.discount)) * item.quantity).toLocaleString()}</td>
                <td class="table-action">
                    <button type="button" class="btn btn-secondary px-1" style="text-decoration: none;">
                        <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none"
                            stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                            class="feather feather-edit">
                            <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path>
                            <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
                        </svg>
                    </button>
                    <button type="button" class="item-remove btn btn-secondary px-1" style="text-decoration: none;">
                        <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none"
                            stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                            class="feather feather-trash-2">
                            <polyline points="3 6 5 6 21 6"></polyline>
                            <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                            <line x1="10" y1="11" x2="10" y2="17"></line>
                            <line x1="14" y1="11" x2="14" y2="17"></line>
                        </svg>
                    </button>
                </td>
            </tr>
        `).join('');

        totalPriceEl.textContent = `Rp${carts.total.toLocaleString()}`;
        totalDiscountEl.textContent = `Rp${carts.totalDiscount.toLocaleString()}`;
        subTotalPriceEl.textContent = `Rp${carts.subtotal.toLocaleString()}`;

        // Add event listeners
        document.querySelectorAll<HTMLButtonElement>('.qty-minus').forEach(btn => {
            btn.addEventListener('click', this.handleDecreaseQty);
        });

        document.querySelectorAll<HTMLButtonElement>('.qty-plus').forEach(btn => {
            btn.addEventListener('click', this.handleIncreaseQty);
        });

        document.querySelectorAll<HTMLButtonElement>('.item-remove').forEach(btn => {
            btn.addEventListener('click', this.handleRemoveItem);
        });
    }

    public handleDecreaseQty = (e: Event) => {
        const target = e.target as HTMLButtonElement;
        const itemElement = target.closest<HTMLTableRowElement>('.cart-item');
        if (!itemElement) return;

        const itemId = parseInt(itemElement.dataset.id || '0');
        const carts = this.cartManager.getCart()
        const item = carts.items.find(item => item.id === itemId);

        if (item && item.quantity > 1) {
            this.cartManager.updateQuantity(itemId, item.quantity - 1);
            this.updateCartDisplay();
        }
    }

    public handleIncreaseQty = (e: Event) => {
        const target = e.target as HTMLButtonElement;
        const itemElement = target.closest<HTMLTableRowElement>('.cart-item');
        if (!itemElement) return;

        const itemId = parseInt(itemElement.dataset.id || '0');
        console.log('Finding cart with id', itemId);
        const carts = this.cartManager.getCart()
        const item = carts.items.find(item => item.id === itemId);
        console.log('Found item', item);

        if (item) {
            this.cartManager.updateQuantity(itemId, item.quantity + 1);
            this.updateCartDisplay();
        }
    }

    public handleRemoveItem = (e: Event) => {
        const target = e.target as HTMLButtonElement;
        const itemElement = target.closest<HTMLTableRowElement>('.cart-item');
        if (!itemElement) return;

        const itemId = parseInt(itemElement.dataset.id || '0');
        this.cartManager.removeItem(itemId);
        this.updateCartDisplay();
    }

    public addToCart(input: string): void {
        fetch("api/product/name", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: `name=${encodeURIComponent(input)}`
        })
            .then(response => response.json())
            .then(response => {
                console.log(response);
                const product = response.data;
                const data = {
                    id: product.id,
                    name: product.name,
                    price: product.price,
                    quantity: 1,
                    tax_rate: product.tax_rate,
                    barcode: product.barcode,
                    discount: product.discount
                } as CartItem;
                this.cartManager.addItem(data);
                document.dispatchEvent(new CustomEvent('cartUpdated'));
                alert(`${product.name} ditambahkan ke keranjang`);
            })
            .catch(error => {
                console.error("Fetch Error:", error);
            });
    }
}