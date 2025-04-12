{extends file="../../components/layouts/product.tpl"}

{block name="product-content"}
    <main style="padding: 1rem;">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title">Product form</h5>
                <h6 class="card-subtitle text-muted">Create new product for your store</h6>
            </div>
            <div class="card-body">
                <form>
                    <div class="mb-3 row">
                        <label class="col-form-label col-sm-2 text-sm-end">Product Barcode</label>
                        <div class="col-sm-10">
                            <input type="number" class="form-control" value={$product['barcode']}
                                placeholder="Example : 8986892639798">
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label class="col-form-label col-sm-2 text-sm-end">Product Name</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" value="{$product['name']|escape:'html'}"
                                placeholder="Example : Nivea MEN Extra Bright 50ml">
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label class="col-form-label col-sm-2 text-sm-end">Product Price</label>
                        <div class="col-sm-10">
                            <input type="number" class="form-control"
                                value="{number_format($product['price'], 0, ',', '.')}"
                                placeholder="Example : 10000 for Rp, 10.000">
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label class="col-form-label col-sm-2 text-sm-end">Product Cost</label>
                        <div class="col-sm-10">
                            <input type="number" class="form-control"
                                value="{number_format($product['cost_price'], 0, ',', '.')}"
                                placeholder="Example : 10000 for Rp, 10.000">
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label class="col-form-label col-sm-2 text-sm-end">Product Tax</label>
                        <div class="col-sm-10">
                            <input type="number" class="form-control" value={$product['tax_rate']}
                                placeholder="Example : 0.10 for 10%">
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label class="col-form-label col-sm-2 text-sm-end">Product Discount</label>
                        <div class="col-sm-10">
                            <input type="number" class="form-control" value={$product['discount']}
                                placeholder="Example : 0.05 for 5%">
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label class="col-form-label col-sm-2 text-sm-end">Product Stock</label>
                        <div class="col-sm-10">
                            <input type="number" class="form-control" value={$product['stock_qty']}
                                placeholder="Stock Product">
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label class="col-form-label col-sm-2 text-sm-end">Category Product</label>
                        <div class="col-sm-10">
                            <select class="form-control choices-single">
                                <option value="AZ">{$product['category']}</option>
                                <option value="CO">Accesoris</option>
                                <option value="ID">Rumah Tangga</option>
                                <option value="ID">Styling</option>
                            </select>
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label class="col-form-label col-sm-2 text-sm-end pt-sm-0">Ready For Sale</label>
                        <div class="col-sm-10">
                            <label class="form-check m-0">
                                <input type="checkbox" class="form-check-input" {$product.is_active == 1 ? 'checked' : ''}>
                                <span class="form-check-label">cheklist</span>
                            </label>
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <div class="col-sm-10 ms-sm-auto">
                            <button type="submit" class="btn btn-secondary" onclick="alert('Belum diimplement')">Create</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </main>
{/block}