{capture name="settingPage"}
    <main class="">
        <h1>{$page|default:'Settings (default)'}</h1>
    </main>
{/capture}

{include file="../components/layouts/dashboard.tpl" children=$smarty.capture.settingPage }