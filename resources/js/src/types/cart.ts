import { PaymentMethod } from "./payment";

export interface CartItem {
    id: number;
    barcode: number;
    name: string;
    price: number;
    tax_rate: number;
    discount: number;
    quantity: number;
}

export interface CartState {
    items: CartItem[];
    subtotal: number;
    total: number;
    totalItem: number;
    totalDiscount: number;
    paymentMethod: PaymentMethod;
    payReceived: number;
    payChange: number;
    tax: number;
    lastUpdated: string;
}