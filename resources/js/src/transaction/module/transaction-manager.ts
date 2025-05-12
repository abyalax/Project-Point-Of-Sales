import { TransactionState } from "../../types/transaction";

export default class TransactionManager {

    public static async insert(transactionState: TransactionState): Promise<{data: {transaction_id: string}}> {
        const res = await fetch('api/transaction/insert', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            credentials: 'include',
            body: JSON.stringify(transactionState)
        })
        const response = await res.json();
        return response
    }

    public static async get() {
        const res = await fetch('api/transaction/insert', {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            },
            credentials: 'include',
        })
        const response = await res.json();
        return response
    }
}   