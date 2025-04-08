import { CartItem, CartState } from "../..";

export default class CartManager {
    private _stateCart: CartState;

    constructor() {
        this._stateCart = {
            items: [],
            subtotal: 0,
            tax: 0,
            total: 0,
            totalDiscount: 0,
            lastUpdated: new Date().toISOString()
        }
        this.loadFromStorage();
    }

    public getCart(): CartState {
        return this._stateCart;
    }

    public fetchByID = () => {} 

    public fetchByName(name: string) {
        const fetchData = fetch("api/product/name", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: `name=${encodeURIComponent(name)}`
        })
        const response = fetchData.then(response => response.json())
        return response
    }

    public addItem(product: CartItem): void {
        const existingItem = this._stateCart.items.find(item => item.id === product.id);
        if (existingItem) {
            existingItem.quantity += product.quantity ?? 1;
        } else {
            this._stateCart.items.push({
                ...product,
                quantity: product.quantity || 1
            });
        }
        this.calculateTotals();
        this.save();
    }

    public removeItem(productId: number): void {
        this._stateCart.items = this._stateCart.items.filter(item => item.id !== productId);
        this.calculateTotals();
        this.save();
    }

    public updateQuantity(productId: number, newQuantity: number): void {
        console.log('Updating item with:', 'productId: ', productId, 'newQuantity: ', newQuantity);
        const item = this._stateCart.items.find(item => item.id === productId);

        console.log('Updating quantity for item:', item);

        if (item) {
            item.quantity = newQuantity;
            this.calculateTotals();
            this.save();
            console.log('Cart after update:', this._stateCart);
        }
    }

    private calculateTotals(): void {
        console.log('Calculating...');
        const cartItems = this._stateCart.items;
        const cart = this._stateCart;
        console.log('Carts : ', this._stateCart);
        this._stateCart.subtotal = cartItems.reduce((sum, item) => sum + (item.price * item.quantity), 0);
        console.log('Sub Total : ', cart.subtotal);
        cart.totalDiscount = cartItems.reduce((sum, item) => sum + (item.price * item.discount * item.quantity), 0);
        console.log('Total Discount : ', cart.totalDiscount);
        cart.tax = cartItems.reduce((sum, item) => sum + (item.tax_rate * item.price * item.quantity), 0);
        console.log('Tax : ', cart.tax);
        cart.total = cart.subtotal - cart.totalDiscount + cart.tax;
        console.log('Total : ', cart.total);
        cart.lastUpdated = new Date().toISOString();
    }

    private save(): void {
        console.log('Save To Storage...');
        localStorage.setItem('pos_cart', JSON.stringify(this._stateCart));
    }

    public loadFromStorage() {
        console.log('Load from storage...');
        const savedCart = localStorage.getItem('pos_cart');
        if (savedCart) {
            this._stateCart = JSON.parse(savedCart);
            console.log('stateCart : ', this._stateCart);
        }
    }

    public clearCart(): void {
        this._stateCart = {
            items: [],
            subtotal: 0,
            tax: 0,
            total: 0,
            totalDiscount: 0,
            lastUpdated: new Date().toISOString()
        };
        this.save();
        console.log('Cart cleared...');
    }
}