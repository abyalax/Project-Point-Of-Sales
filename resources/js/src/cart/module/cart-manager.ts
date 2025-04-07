import { CartItem, CartState } from "../..";

export default class CartManager {
    private cart: CartState;
    private _storageCart: CartState;
    constructor(stateCart: Partial<CartState>, storageCart: Partial<CartState>) {
        this.cart = {
            items: stateCart.items ?? [],
            subtotal: stateCart.subtotal ?? 0,
            tax: stateCart.tax ?? 0,
            total: stateCart.total ?? 0,
            totalDiscount: stateCart.totalDiscount ?? 0,
            lastUpdated: new Date().toISOString()
        };
        
        this._storageCart = {
            items: storageCart.items ?? [],
            subtotal: storageCart.subtotal ?? 0,
            tax: storageCart.tax ?? 0,
            total: storageCart.total ?? 0,
            totalDiscount: storageCart.totalDiscount ?? 0,
            lastUpdated: new Date().toISOString()
        };
    }
    public getCart() {
        return this.cart;
    }

    addItem(product: CartItem): void {
        const existingItem = this.cart.items.find(item => item.id === product.id);

        if (existingItem) {
            existingItem.quantity += product.quantity ?? 1;
        } else {
            this.cart.items.push({
                ...product,
                quantity: product.quantity || 1
            });
        }

        this.calculateTotals();
        this.save();
    }

    removeItem(productId: string | number): void {
        this.cart.items = this.cart.items.filter(item => item.id !== productId);
        this.calculateTotals();
        this.save();
    }

    updateQuantity(productId: string | number, newQuantity: number): void {
        console.log('Updating item with:', 'productId: ', productId, 'newQuantity: ', newQuantity);
        const item = this.cart.items.find(item => item.id === productId);
        const carts = this.cart.items;

        console.log({ carts });
        console.log('Updating quantity for item:', item);

        if (item) {
            item.quantity = newQuantity;
            this.calculateTotals();
            this.save();
            console.log('Cart after update:', this.cart);
        }
    }

    private calculateTotals(): void {
        console.log('Calculating...');
        const cartItems = this.cart.items;
        const cart = this.cart;
        console.log(this.cart);
        this.cart.subtotal = cartItems.reduce((sum, item) => sum + (item.price * item.quantity),0);
        console.log('Sub Total', cart.subtotal);
        cart.totalDiscount = cartItems.reduce((sum, item) => sum + (item.price * item.discount * item.quantity),0);
        console.log('Total Discount', cart.totalDiscount);
        cart.tax = cartItems.reduce((sum, item) => sum + (item.tax_rate * item.price * item.quantity),0);
        console.log('Tax', cart.tax);
        cart.total = cart.subtotal - cart.totalDiscount + cart.tax;
        console.log('Total', cart.total);
        cart.lastUpdated = new Date().toISOString();
    }
    

    private save(): void {
        localStorage.setItem('pos_cart', JSON.stringify(this.cart));
        this.syncWithStorage();
    }

    private async syncWithStorage(): Promise<void> {
        console.log('Sync with storage...');
        this.storageCart = { ...this.cart };
    }

    async loadFromStorage(): Promise<void> {
        console.log('Load from storage...');
        const savedCart = localStorage.getItem('pos_cart');
        if (savedCart) {
            this.cart = JSON.parse(savedCart);
            this.storageCart = { ...this.cart };
        }
    }

    clearCart(): void {
        this.cart = {
            items: [],
            subtotal: 0,
            tax: 0,
            total: 0,
            totalDiscount: 0,
            lastUpdated: new Date().toISOString()
        };
        this.save();
    }
    public get storageCart(): CartState {
        return this._storageCart;
    }
    public set storageCart(value: CartState) {
        this._storageCart = value;
    }
}