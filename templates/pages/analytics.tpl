{capture name="analyticsPage"}
    <main class="">
        <h1>{$page|default:'Analytics (default)'}</h1>
    </main>
{/capture}

{include file="../components/layouts/dashboard.tpl" children=$smarty.capture.analyticsPage }