{extends file="../components/layouts/dashboard.tpl"}

{block name="content"}
<main class="content">
    <div class="container-fluid p-0">

        <h1 class="h3 mb-5 fw-semibold"><strong class="fw-bolder">Welcome to</strong> Point Of Sales</h1>

        <div class="row row-cols-md-4 row-cols-sm-3 row-cols-1 mx-5 justify-content-center gap-4">

            {include file="../components/ui/card.tpl"
            link="transactions"
            title="Create Transaction"
            menu="Menu Transaction"
            role="Cashier"
            icon="dollar-sign"
            message="Go To Transaction page"
            button="Transaction" }

            {include file="../components/ui/card.tpl"
            link="inventaris"
            title="Create and Manage Inventaris"
            menu="Menu Inventaris"
            role="Admin"
            icon="file-text"
            message="Go To Inventaris page"
            button="Inventaris" }

            {include file="../components/ui/card.tpl"
            link="analytics"
            title="Analyze Your Data"
            menu="Analytics & report"
            role="Manager"
            icon="pie-chart"
            message="Go To Analytics page"
            button="Analytics" }

            {include file="../components/ui/card.tpl"
            link="suppliers"
            title="Manage Suppliers"
            menu="Menu Supliers"
            role="Admin"
            icon="truck"
            message="Go To Suppliers page"
            button="Suppliers" }

            {include file="../components/ui/card.tpl"
            link="members"
            title="Create and Manage Members"
            menu="Menu Members"
            role="Owner"
            icon="user-plus"
            message="Go To Members page"
            button="Members" }

            {include file="../components/ui/card.tpl"
            link="karyawans"
            title="Manage Karyawan"
            menu="Menu Karyawan"
            role="Human Resource Development"
            icon="users"
            message="Go To Karyawan page"
            button="Karyawan" }

            {include file="../components/ui/card.tpl"
            link="products"
            title="Manage Products"
            menu="Menu Products"
            role="Admin"
            icon="box"
            message="Go To Products page"
            button="Products" }

            {include file="../components/ui/card.tpl"
            link="payments"
            title="Manage Payments"
            menu="Menu Payments"
            role="Owner"
            icon="dollar-sign"
            message="Go To Payments page"
            button="Payments" }

            {include file="../components/ui/card.tpl"
            link="settings"
            title="Manage Configuration"
            menu="Settings"
            role="Admin"
            icon="settings"
            message="Go To Settings page"
            button="Settings" }

        </div>

    </div>
</main>
{/block}