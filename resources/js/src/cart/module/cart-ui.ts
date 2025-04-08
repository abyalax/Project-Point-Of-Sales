import CartManager from "./cart-manager";
let debounceTimer: number;

export default class CartUI {
    private cartManager: CartManager

    constructor(cartManager: CartManager) {
        this.cartManager = cartManager
        this.bindEvents();
    }

    private bindEvents(): void {
        console.log('Bind Events...');
        this.renderInterface();
        document.addEventListener('cartUpdated', this.renderInterface)

        const formSearchInput = document.getElementById('form-search-products') as HTMLFormElement
        formSearchInput.addEventListener('submit', this.hanldeAddToCartForm)

        const payInput = document.getElementById('pay-transaction') as HTMLInputElement;
        payInput.addEventListener('input', this.handleInputPay);

        const boxFormSearchInput = document.getElementById('box-search-products') as HTMLFormElement;
        boxFormSearchInput.addEventListener('submit', this.hanldeAddToCartBox);

        const selectProductBtn = document.getElementById('select-product-btn') as HTMLButtonElement;
        selectProductBtn.addEventListener('click', () => {
            setTimeout(() => {
                this.bindAddToCartBtn()
            }, 1000);
        });
    }

    private bindAddToCartBtn = () => {
        const buttons = document.querySelectorAll('.box-search-products-addcart') as NodeListOf<HTMLButtonElement>;
        console.log('Bind Add To Cart Button...');
        buttons.forEach((btn) => {
            btn.addEventListener('click', (e) => {
                e.preventDefault();
                console.log('Add Cart clicked...');
                const row = btn.closest('tr');
                const productId = row?.dataset.id;
                console.log('Add Cart clicked, ID:', productId);
                // bisa panggil fungsi lain di sini
                // addToCart(productId);
            });
        });
    }

    private renderInterface = () => {
        console.log('Update Cart Display...');

        const rowCart = document.getElementById('cart-items') as HTMLTableSectionElement;
        const subTotalPriceEl = document.getElementById('cart-sub-total') as HTMLParagraphElement;
        const totalPriceEl = document.getElementById('cart-total') as HTMLParagraphElement;
        const totalDiscountEl = document.getElementById('cart-total-discount') as HTMLParagraphElement;
        const totalTaxEl = document.getElementById('cart-total-tax') as HTMLParagraphElement;

        const carts = this.cartManager.getCart()
        console.log('Carts : ', carts);

        if (carts.items.length === 0) {
            rowCart.innerHTML = '<tr class="empty-cart odd"><h2>Keranjang kosong</h2></tr>';
            totalPriceEl.textContent = 'Rp0';
            totalDiscountEl.textContent = 'Rp0';
            subTotalPriceEl.textContent = 'Rp0';
            totalTaxEl.textContent = 'Rp0';
            return;
        }

        rowCart.innerHTML = carts.items.map(item => `
            <tr class="cart-item" data-id="${item.id}">
                <td class="dtr-control sorting_1">${item.id}</td>
                <td class=" d-xl-table-cell">${item.barcode}</td>
                <td class="item-name">${item.name}</td>
    
                <td class="item-quantity  d-xl-table-cell">
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
                <td class="item-price  d-xl-table-cell">Rp${Number(item.price).toLocaleString()}</td>
                <td class=" d-md-table-cell">${item.discount * 100}%</td>
                <td class="item-price  d-xl-table-cell">Rp${((item.price - (item.price * item.discount)) * item.quantity).toLocaleString()}</td>
                <td class="table-action d-xl-table-cell d-flex flex-wrap gap-2 justify-content-center align-items-center">
                    <button type="button" class="btn btn-secondary" style="text-decoration: none;">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" style="width:1rem;height:1rem;" viewBox="0 0 24 24" fill="none"
                            stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                            class="feather feather-edit">
                            <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path>
                            <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
                        </svg>
                    </button>
                    <button type="button" class="item-remove btn btn-secondary" style="text-decoration: none;">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" style="width:1rem;height:1rem;" viewBox="0 0 24 24" fill="none"
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
        totalTaxEl.textContent = `Rp${carts.tax.toLocaleString()}`;

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

    private addToCart = async (e: Event, id: string) => {
        e.preventDefault()
        console.log('Add To Cart...');
        const searchInput = document.getElementById(id) as HTMLInputElement
        try {
            const response = await this.cartManager.fetchByName(searchInput.value)
            const product = response.data
            searchInput.value = '';
            this.cartManager.addItem(product);
            this.renderInterface();
        } catch (error) {
            console.log('addToCart error: ', error);
        }
    }

    private hanldeAddToCartBox = (e: Event) => {
        this.addToCart(e, 'bx-search-products')
    }

    private hanldeAddToCartForm = (e: Event) => {
        this.addToCart(e, 'fm-search-products')
    }

    private handleInputPay = (e: Event) => {
        console.log('Handle Input Pay...');

        const target = e.target as HTMLInputElement;
        const returnInput = document.getElementById('return-transaction') as HTMLInputElement;

        clearTimeout(debounceTimer);
        const cart = this.cartManager.getCart()
        debounceTimer = window.setTimeout(() => {
            const bayar = parseFloat(target.value) || 0;
            const kembali = bayar - cart.total;
            const kembalian = kembali > 0 ? kembali.toLocaleString('id-ID') : '0';
            returnInput.value = "Rp " + kembalian;
        }, 300);
    }

    private handleDecreaseQty = (e: Event) => {
        const target = e.target as HTMLButtonElement;
        const itemElement = target.closest<HTMLTableRowElement>('.cart-item');
        if (!itemElement) return;

        const itemId = parseInt(itemElement.dataset.id || '0');
        const carts = this.cartManager.getCart()
        const item = carts.items.find(item => item.id === itemId);

        if (item && item.quantity > 1) {
            this.cartManager.updateQuantity(itemId, item.quantity - 1);
            this.renderInterface();
        }
    }

    private handleIncreaseQty = (e: Event) => {
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
            this.renderInterface();
        }
    }

    private handleRemoveItem = (e: Event) => {
        const target = e.target as HTMLButtonElement;
        const itemElement = target.closest<HTMLTableRowElement>('.cart-item');
        if (!itemElement) return;

        const itemId = parseInt(itemElement.dataset.id || '0');
        this.cartManager.removeItem(itemId);
        this.renderInterface();
    }

}
