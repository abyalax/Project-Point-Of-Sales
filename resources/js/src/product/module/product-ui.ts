import { Category, Product } from "../../types/product";
import { addCategory, addProduct, getCategories, getProducts } from "./product-manager";

let stateProduct: Product;

export default class ProductUI {

    constructor() {
        this.bindEvents();
    }

    private bindEvents(): void {
        console.log('Bind Events...');
        const formAddProduct = document.getElementById('form-add-product') as HTMLFormElement;
        if (formAddProduct) {
            formAddProduct.addEventListener('submit', this.handleAddProduct);
        }
        const formAddCategory = document.getElementById('form-add-category') as HTMLFormElement;
        if (formAddCategory) {
            formAddCategory.addEventListener('submit', this.handleAddCategory);
        }
        this.handleSelectCategories();
        this.renderInterface();
    }

    private async renderInterface(): Promise<void> {
        const table = document.getElementById('table-product') as HTMLTableSectionElement;
        const products = await getProducts();
        if (table) {
            table.innerHTML = products.map(product =>
                `
                    <tr class="odd product-item" data-id="${product.id}">
                        <td class="d-xl-table-cell">${product.barcode}</td>
                        <td class="d-xl-table-cell">${product.name}</td>

                        <td class="d-xl-table-cell">Rp ${product.price.toLocaleString('id-ID')}</td>

                        <td class="d-xl-table-cell">${product.tax_rate * 100}%</td>

                        <td class="d-xl-table-cell ${product.discount > 0 ? " text-success fw-bold" : "text-muted"}">
                            ${product.discount * 100}%
                        </td>
                        <td class="d-xl-table-cell ${product.stock_qty < 5 ? " text-danger fw-bold" : "text-body"}">
                            ${product.stock_qty}
                        </td>
                        <td class="d-xl-table-cell table-action">
                            <button class="btn btn-secondary update-product">
                                <i class="align-middle" data-feather="edit-2"></i>
                            </button>
                            <button class="btn btn-secondary delete-product ">
                                <i class="align-middle" data-feather="trash-2"></i>
                            </button>
                        </td>
                    </tr>
                `).join('')
        }

        document.querySelectorAll<HTMLButtonElement>('.update-product').forEach(btn => {
            btn.removeEventListener('click', this.handleUpdateProduct);
            btn.addEventListener('click', this.handleUpdateProduct);
        })
    }

    private handleSelectCategories = async () => {
        const select = document.getElementById('select-categories') as HTMLSelectElement;
        if (!select) return;
        select.innerHTML = '';
        const defaultOption = document.createElement('option');
        defaultOption.value = '';
        defaultOption.textContent = '-- Pilih Kategori --';
        select.appendChild(defaultOption);

        const categories: Category[] = await getCategories();

        // Isi dengan data dari API
        categories.forEach(category => {
            const option = document.createElement('option') as HTMLOptionElement;
            option.value = category.id.toString();
            option.textContent = category.name;
            select.appendChild(option);
        });
    }

    private handleAddCategory = async (e: Event) => {
        e.preventDefault();
        console.log('Add Category...');
        const form = e.target as HTMLFormElement;
        const name = form.querySelector('input[name="name"]') as HTMLInputElement;
        const idCategory: Category = await addCategory(name.value);
        stateProduct.category_id = idCategory.id;
    }

    // TODO
    private handleAddProduct = async (e: Event) => {
        e.preventDefault()

        const form = e.target as HTMLFormElement;
        const name = form.querySelector('input[name="name"]') as HTMLInputElement;
        const barcode = form.querySelector('input[name="barcode"]') as HTMLInputElement;
        const price = form.querySelector('input[name="price"]') as HTMLInputElement;
        const cost_price = form.querySelector('input[name="cost_price"]') as HTMLInputElement;
        const stock_qty = form.querySelector('input[name="stock_qty"]') as HTMLInputElement;
        const category = document.getElementById('select-categories') as HTMLSelectElement;
        const is_active = form.querySelector('input[name="is_active"]') as HTMLInputElement;
        const tax_rate = form.querySelector('input[name="tax_rate"]') as HTMLInputElement;
        const discount = form.querySelector('input[name="discount"]') as HTMLInputElement;

        console.log('Add Product...');

        stateProduct = {
            name: name.value,
            barcode: Number(barcode.value),
            price: Number(price.value),
            stock_qty: Number(stock_qty.value),
            is_active: is_active.checked,
            tax_rate: Number(tax_rate.value),
            discount: Number(discount.value),
            cost_price: Number(cost_price.value),
            category_id: Number(category.value),
        }

        console.log(stateProduct);
        await addProduct(stateProduct);
    }

    private handleUpdateProduct = (e: Event) => {
        e.preventDefault()
        console.log('Update Product...');
        const target = e.target as HTMLButtonElement;
        const itemElement = target.closest<HTMLTableRowElement>('.product-item');
        if (!itemElement) console.error('Item element not found.');

        const itemId = parseInt(itemElement?.dataset.id || '0');
        console.log('Finding product with id', itemId);
        window.location.href = `products/update/${itemId}`;
    }
}