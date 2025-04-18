import { getUserSession } from "../../auth";
import { CartItem, CartState } from "../../types/cart";
import { PaymentMethod } from "../../types/payment";

export default class CartManager {
    private _stateCart: CartState;

    constructor() {
        this._stateCart = {
            items: [],
            subtotal: 0,
            tax: 0,
            total: 0,
            totalItem: 0,
            totalDiscount: 0,
            paymentMethod: PaymentMethod.Cash,
            payChange: 0,
            payReceived: 0,
            lastUpdated: new Date().toISOString()
        }
        this.loadFromStorage();
    }

    public static async createTransaction({ cart, notes }: { cart: CartState, notes?: string }) {
        console.log('Saving Transaction : ', cart);
        const userSession = await getUserSession()
        const data = {
            cart: cart,
            cashier: {
                id: userSession.id,
                name: userSession.name
            },
            notes: notes ?? '',
        }
        console.log('Transaction Data: ', data);
        const response = await fetch('api/transaction/create', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            credentials: 'include',
            body: JSON.stringify(data)
        })
        const res = await response.json();
        console.log('Transaction Saved: ', res);
    }

    public getCart(): CartState {
        return this._stateCart;
    }

    public setPaymentMethod(paymentMethod: PaymentMethod) {
        this._stateCart.paymentMethod = paymentMethod
    }

    public setPayReceived(pay: number) {
        this._stateCart.payReceived = pay
    }

    public setPayChange(pay: number) {
        this._stateCart.payChange = pay
    }

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
        alert(product.name + ' ditambahkan ke keranjang')
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
        console.log('Calculating totals...');

        const cart = this._stateCart;
        const items = cart.items;

        let subtotal = 0;
        let totalDiscount = 0;
        let tax = 0;
        let totalItem = 0;

        for (const item of items) {
            const itemTotal = item.price * item.quantity;
            const itemDiscount = item.price * (item.discount || 0) * item.quantity;
            const itemTax = (item.tax_rate || 0) * item.price * item.quantity;

            subtotal += itemTotal;
            totalDiscount += itemDiscount;
            tax += itemTax;
            totalItem += item.quantity;
        }

        cart.subtotal = subtotal;
        cart.totalDiscount = totalDiscount;
        cart.tax = tax;
        cart.total = subtotal - totalDiscount + tax;
        cart.totalItem = totalItem;
        cart.lastUpdated = new Date().toISOString();

        console.log('Cart calculated:', {
            subtotal,
            totalDiscount,
            tax,
            total: cart.total,
            totalItem
        });
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
            totalItem: 0,
            totalDiscount: 0,
            paymentMethod: PaymentMethod.Cash,
            payChange: 0,
            payReceived: 0,
            lastUpdated: new Date().toISOString()
        };
        this.save();
        console.log('Cart cleared...');
    }
}