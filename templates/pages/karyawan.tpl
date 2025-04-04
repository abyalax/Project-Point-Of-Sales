{capture name="karyawanPage"}
    <main class="fs-1">
        <h1>{$page|default:'Karyawans (default)'}</h1>
    </main>
{/capture}

{include file="../components/layouts/dashboard.tpl" children=$smarty.capture.karyawanPage }