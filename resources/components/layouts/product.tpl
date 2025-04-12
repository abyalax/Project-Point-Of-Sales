{extends file="./dashboard.tpl"}

{block name="head"}
<!-- Mode Development -->
{* <script type="module" src="http://localhost:5173/src/product/index.ts"></script> *}
<!-- Mode Production -->
<script src="/resources/js/dist/product.js" type="module"></script>
{/block}

{block name="content"}
<main class="pt-0">
    <h1>{$page|default:'Products (default)'}</h1>
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <style>
                .breadcrumb-item:hover {
                    text-decoration: underline !important;
                    color: black !important;
                }
                .breadcrum-active {
                    color: black !important;
                }
            </style>
            <a class="breadcrumb-item" style="text-decoration:none;color:gray;" href="/point-of-sales/">Home</a>
            <a class="breadcrumb-item" style="text-decoration:none;color:gray;" href="/point-of-sales/products">Product</a>
            <a class="breadcrumb-item breadcrum-active" style="text-decoration:none;color:gray;" href="/point-of-sales/products/create">Create</a>
        </ol>
    </nav>
    {block name="product-content"}{/block}
</main>
{/block}