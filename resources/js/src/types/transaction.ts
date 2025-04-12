import { CartState } from "./cart";

export interface TransactionState {
    transactionId: string;
    cashier: {
        id: number;
        name: string;
    };
    cart: CartState;
    createdAt: string;
    notes?: string;
}