{extends file="../components/layouts/dashboard.tpl"}

{block name="content"}
    <main class="fs-1">
        <h1>{$page|default:'Products (default)'}</h1>
        {foreach from=$products item=item}
            <pre>{$item['name']}</pre>
        {/foreach}
        {include file="../components/table/products.tpl"}
        {* {include file="../components/ui/cart.tpl"} *}
    </main>
{/block}