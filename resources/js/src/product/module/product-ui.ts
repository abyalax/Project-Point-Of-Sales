import ProductManager from "./product-manager";

export default class ProductUI {
    private productManager: ProductManager

    constructor(productManager: ProductManager) {
        this.productManager = productManager
        this.bindEvents();
    }

    private bindEvents(): void {
        console.log('Bind Events...');
        this.renderInterface();
        // document.addEventListener('productUpdated', this.renderInterface)
    }

    private async renderInterface(): Promise<void> {
        const table = document.getElementById('bx-table-search-product') as HTMLTableSectionElement;
        const products = await this.productManager.getProducts();

        table.innerHTML = products.map(product =>
            `
            <tr class="" data-id="${product.id}">
                <td class="d-xl-table-cell">${product.barcode}</td>
                <td class="d-xl-table-cell">${product.name}</td>
                <td class="d-xl-table-cell">
                <button class="btn btn-secondary box-search-products-addcart">
                    +
                </button>
                </td>
            </tr>    
        `).join('')
    }
}