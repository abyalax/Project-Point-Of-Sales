{extends file="../../components/layouts/transaction.tpl"}

{block name="transaction-content"}
<div data-testid="page-transactions" class="bg-[#f0f0f8]">
    <!-- Mode Development -->
    <script src="http://localhost:5173/src/transaction/index" type="module"></script>
    <!-- Mode Production -->
    
    <!-- <script src="/resources/js/dist/transaction.js" type="module"></script> -->
    <div class="d-flex gap-3">
        <div class="card p-3">
            <p class="text-[#727272] fs-4">Total Profit</p>
            <h1>Rp. 25.500.400,00</h1>
            <a href="#" class="fw-bold fs-4">View All</a>
        </div>
        <div class="card p-3">
            <p class="text-[#727272] fs-4">Total Revenue</p>
            <h1>Rp. 25.500.400,00</h1>
            <a href="#" class="fw-bold fs-4">View All</a>
        </div>
        <div class="card p-3">
            <p class="text-[#727272] fs-4">Total Sales</p>
            <h1>Rp. 25.500.400,00</h1>
            <a href="#" class="fw-bold fs-4">View All</a>
        </div>
    </div>
    <div class="d-grid gap-2 d-md-flex">
        <div class="card col-8">
            <div class="card-header">
                <p class="fw-bold fs-4">Revenue Statistic</p>
            </div>
            <div class="card-body p-3">
                <div class="bg-white">
                    <canvas id="revenue-chart"></canvas>
                </div>
            </div>
        </div>
        <div class="card col-4">
            <div class="card-header">
                <p class="fw-bold fs-4">Sales By Category</p>
            </div>
            <div class="card-body p-3">
                <div class="bg-white">
                    <canvas id="category-chart"></canvas>
                </div>
            </div>
        </div>
    </div>
</div>
{/block}