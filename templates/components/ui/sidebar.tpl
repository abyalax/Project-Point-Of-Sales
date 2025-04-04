{literal}
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const currentPath = window.location.pathname;
            const sidebarItems = document.querySelectorAll('.sidebar-item');

            sidebarItems.forEach(item => {
                const link = item.querySelector('.sidebar-link');
                const href = link.getAttribute('href');

                item.classList.remove('active');
                link.classList.remove('active');

                if (currentPath === href ||
                    (currentPath.startsWith(href) && href !== '/point-of-sales/')) {
                    item.classList.add('active');
                    link.classList.add('active');
                }
            });
        });
    </script>
{/literal}

<nav id="sidebar" class="sidebar js-sidebar">
    <div class="sidebar-content js-simplebar">
        <a class="sidebar-brand" href="/point-of-sales/">
            <span class="align-middle">Abya's Point Of Sales</span>
        </a>
        <ul class="sidebar-nav">
            <li class="sidebar-header">
                Pages
            </li>

            <li class="sidebar-item active">
                <a class="sidebar-link" href="/point-of-sales/">
                    <i class="align-middle" data-feather="monitor"></i> <span class="align-middle">Dashboard</span>
                </a>
            </li>

            <li class="sidebar-item">
                <a class="sidebar-link" href="/point-of-sales/transactions">
                    <i class="align-middle" data-feather="dollar-sign"></i> <span
                        class="align-middle">Transaction</span>
                </a>
            </li>

            <li class="sidebar-item">
                <a class="sidebar-link" href="/point-of-sales/inventaris">
                    <i class="align-middle" data-feather="file-text"></i> <span class="align-middle">Inventaris</span>
                </a>
            </li>

            <li class="sidebar-item">
                <a class="sidebar-link" href="/point-of-sales/analytics">
                    <i class="align-middle" data-feather="bar-chart-2"></i> <span class="align-middle">Analytics</span>
                </a>
            </li>

            <li class="sidebar-item">
                <a class="sidebar-link" href="/point-of-sales/suppliers">
                    <i class="align-middle" data-feather="truck"></i> <span class="align-middle">Suppliers</span>
                </a>
            </li>

            <li class="sidebar-item">
                <a class="sidebar-link" href="/point-of-sales/members">
                    <i class="align-middle" data-feather="user-plus"></i> <span class="align-middle">Members</span>
                </a>
            </li>

            <li class="sidebar-item">
                <a class="sidebar-link" href="/point-of-sales/karyawans">
                    <i class="align-middle" data-feather="users"></i> <span class="align-middle">Karyawan</span>
                </a>
            </li>

            <li class="sidebar-item">
                <a class="sidebar-link" href="/point-of-sales/products">
                    <i class="align-middle" data-feather="box"></i> <span class="align-middle">Products</span>
                </a>
            </li>


            <li class="sidebar-item">
                <a class="sidebar-link" href="/point-of-sales/payments">
                    <i class="align-middle" data-feather="dollar-sign"></i> <span class="align-middle">Payments</span>
                </a>
            </li>


            <li class="sidebar-item">
                <a class="sidebar-link" href="/point-of-sales/settings">
                    <i class="align-middle" data-feather="user"></i> <span class="align-middle">Profile</span>
                </a>
            </li>

            <li class="sidebar-item">
                <a class="sidebar-link" href="/point-of-sales/login">
                    <i class="align-middle" data-feather="log-in"></i> <span class="align-middle">Sign In</span>
                </a>
            </li>

            <li class="sidebar-item">
                <a class="sidebar-link" href="/point-of-sales/settings">
                    <i class="align-middle" data-feather="settings"></i> <span class="align-middle">Pengaturan</span>
                </a>
            </li>

        </ul>

        <div class="sidebar-cta">
            <div class="sidebar-cta-content">
                <strong class="d-inline-block mb-2">Logout</strong>
                <div class="mb-3 text-sm">
                    Are you sure for logout ?
                </div>
                <div class="d-grid">
                    <a href="upgrade-to-pro.html"
                        class="btn btn-primary px-5 d-flex gap-2 justify-content-center align-items-center">
                        Logout
                        <i class="align-middle" data-feather="log-out"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>
</nav>