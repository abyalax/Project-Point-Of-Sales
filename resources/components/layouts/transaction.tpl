{extends file="./dashboard.tpl"}

{block name="head"}
    <!-- Mode Development -->
    <script type="module" src="http://localhost:5173/src/transaction/index.ts"></script>
    <!-- Mode Production -->
    {* <script src="/resources/js/dist/transaction.js" type="module"></script> *}
{/block}

{block name="content"}
    <main class="pt-0">
        <h3>{$page|default:'Transaction (default)'}</h3>
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <style>
                    .breadcrumb-item:hover {
                        text-decoration: underline !important;
                        color: black !important;
                    }
                    .breadcrum-active {
                        font-weight: bold;
                        color: black !important;
                        text-decoration: underline;
                    }
                </style>
                <a class="breadcrumb-item {$url == '/point-of-sales/dashboard' ? " breadcrum-active" : "" }"
                    style="text-decoration:none;color:gray;" href="/point-of-sales/dashboard">Home</a>
                <a class="breadcrumb-item {$url == '/point-of-sales/transactions' ? " breadcrum-active" : "" }"
                    style="text-decoration:none;color:gray;" href="/point-of-sales/transactions">Transaction</a>
            </ol>

        </nav>
        {block name="transaction-content"}{/block}
    </main>
{/block}