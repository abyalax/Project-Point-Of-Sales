interface Product {
    id: number;
    name: string;
    price: number;
    discount: number;
    barcode: number;
    stock_qty: number;
    category: string;
    tax_rate: number;
    cost_price: number;
    is_active: boolean;
    created_at: string;
    updated_at: string;
}

export default class ProductManager {
    constructor() { }

    public getProducts = async (): Promise<Product[]> => {
        try {
            const response = await fetch('api/products', {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                },
                credentials: 'include',
            });
            const response_1 = await response.json();
            return response_1.data;
        } catch (error) {
            console.log('Get Product Error: ', error);
            return [];
        }
    }

    public getProductsByName = () => {
        
    } 
}