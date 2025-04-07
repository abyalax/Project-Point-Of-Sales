interface Product {
    id: number;
    name: string;
    price: number;
    discount: number;
    barcode: number;
    stock_qty: number;
    category: string;
    is_active: boolean;
    cost_price: number;
    tax_rate: number;
    created_at: string;
    updated_at: string;
}

export interface CartItem {
    id: string | number;
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
    totalDiscount: number;
    tax: number;
    lastUpdated: string;
}