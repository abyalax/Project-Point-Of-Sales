{capture name="supplierPage"}
    <main class="content">
        <h1>{$page|default:'Suppliers (default)'}</h1>
    </main>
{/capture}

{include file="../components/layouts/dashboard.tpl" children=$smarty.capture.supplierPage }