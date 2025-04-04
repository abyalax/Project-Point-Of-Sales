{capture name="productPage"}
    <main class="fs-1">
        <h1>{$page|default:'Products (default)'}</h1>
    </main>
{/capture}

{include file="../components/layouts/dashboard.tpl" children=$smarty.capture.productPage }