<style>
    .icon {
        width: 60px;
        height: 60px;
    }
</style>
<div class="card col px-2">
    <div class="card-body d-flex flex-column gap-1">
        <p>{$title}</p>
        <div class="col-auto d-flex justify-content-start align-items-center gap-4">
            <i class="align-middle icon" data-feather="{$icon}"></i>
            <h2 class="fw-semibold">{$menu}</h2>
        </div>
        <a href="/point-of-sales/{$link}" class="btn btn-secondary" data-bs-toggle="tooltip" data-bs-placement="bottom"
        data-bs-title="You must login as {$role}">
        {$button}
        <i class="align-middle" data-feather="arrow-right"></i>
        </a>
        <span class="text-secondary fs-5">{$message}</span>
    </div>
</div>