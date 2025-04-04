{capture name="inventarisPage"}
    <main class="badge fs-1">
        <h1>{$page|default:'Inventaris (default)'}</h1>
    </main>
{/capture}

{include file="../components/layouts/dashboard.tpl" children=$smarty.capture.inventarisPage }