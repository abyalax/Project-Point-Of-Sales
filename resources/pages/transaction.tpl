{extends file="../components/layouts/dashboard.tpl"}

{block name="content"}
    <main class="content">
        <h1 class="fw-bold">{$page|default:'Transactions'}</h1>
        <div class="row">
            <div class="col-12 col-lg-8 col-xxl-9 d-flex">
                <div class="card flex-fill">

                    {include file="../components/form/transaction-form.tpl"}

                    <div class="card-header d-flex justify-content-between align-items-center">
                        <form id="cart-form" class="d-flex gap-2">
                            <div>
                                <input id="searchProducts" class="form-control form-control-lg" type="text"
                                    placeholder="Search Products" />
                            </div>
                            <button type="submit" class="btn btn-secondary">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                    style="width: 1.2rem;height: 1.2rem;" viewBox="0 0 24 24" fill="none"
                                    stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                                    class="feather feather-plus-square">
                                    <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                                    <line x1="12" y1="8" x2="12" y2="16"></line>
                                    <line x1="8" y1="12" x2="16" y2="12"></line>
                                </svg>
                                Add Item
                            </button>
                        </form>
                    </div>
                    <div class="card-body">
                        {include file="../components/table/transaction.tpl"}
                    </div>
                    <div class="card-footer">
                        <div class="d-flex w-100 justify-content-between align-items-center p-4">
                            <div class="dataTables_info" id="datatables-orders_info" role="status" aria-live="polite">
                                Showing 1 to 10 of 15 entries
                            </div>
                            <div class="my-3">
                                <div class="dataTables_paginate paging_simple_numbers" id="datatables-orders_paginate">
                                    <ul class="pagination">
                                        <li class="paginate_button page-item previous disabled"
                                            id="datatables-orders_previous">
                                            <a aria-controls="datatables-orders" aria-disabled="true" aria-role="link"
                                                data-dt-idx="previous" tabindex="0" class="page-link">Previous
                                            </a>
                                        </li>
                                        <!-- Dynamic page numbers will be inserted here -->
                                        <li class="paginate_button page-item next" id="datatables-orders_next">
                                            <a href="#" aria-controls="datatables-orders" aria-role="link"
                                                data-dt-idx="next" tabindex="0" class="page-link">Next
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 col-lg-4 col-xxl-3 d-flex">
                <div class="card flex-fill w-100">
                    <div class="card-header">
                        <h5 class="card-title mb-0">Overview</h5>
                    </div>
                    <div class="card-body d-flex flex-column justify-content-between w-100">
                        <div class="d-flex w-100">
                            <div class="align-self-center w-100">
                                <div class="d-flex justify-content-between">
                                    <p>Subtotal Cart</p>
                                    <p id="cart-sub-total"></p>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <p>Total Discount</p>
                                    <p id="cart-total-discount"></p>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <p>Total Cart</p>
                                    <p id="cart-total"></p>
                                </div>
                            </div>
                        </div>
                        <button id="checkout-btn" class="btn btn-primary">
                            Process
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </main>
{/block}
{block name="scripts"}
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            Fancybox.bind("[data-fancybox]", {
                padding: 20,
                transition: "elastic",
                Toolbar: {
                    display: {
                        left: [],
                        middle: ["title"],
                        right: ["close"],
                    },
                },
            });
            $("#searchProducts").autocomplete({
                source: function(request, response) {
                    $.ajax({
                        url: "api/products",
                        type: "POST",
                        data: {
                            keyword: request.term
                        },
                        dataType: "json",
                        success: function(data) {
                            response(data.data);
                        },
                        error: function(xhr, status, error) {
                            console.log(xhr);
                            console.error("AJAX Error:", status, error);
                        }
                    });
                },
                minLength: 2
            });
        })
    </script>
{/block}