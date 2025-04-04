{capture name="memberPage"}
    <main class="content">
        <h1>{$page|default:'Members (default)'}</h1>
    </main>
{/capture}

{include file="../components/layouts/dashboard.tpl" children=$smarty.capture.memberPage }