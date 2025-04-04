{capture name="paymentPage"}
    <main class="">
        <h1>{$page|default:'Payments (default)'}</h1>
    </main>
{/capture}

{include file="../components/layouts/dashboard.tpl" children=$smarty.capture.paymentPage }