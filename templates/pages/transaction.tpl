{capture name="transactionPage"}
<main class="content">
    <h1>{$page|default:'Transactions'}</h1>

    <div class="row">
        <div class="col-12 col-lg-8 col-xxl-9 d-flex">
            <div class="card flex-fill">
                <div class="card-header">
                    <h5 class="card-title mb-0">Latest Projects</h5>
                </div>

                <table class="table table-hover table-striped table-responsive">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th class="sorting" tabindex="0" aria-controls="datatables-orders" rowspan="1" colspan="1"
                                style="width: 256px;" aria-label="Billing Name: activate to sort column ascending">
                                Name
                            </th>
                            <th class="d-none d-xl-table-cell">Start Date</th>
                            <th class="d-none d-xl-table-cell">End Date</th>
                            <th>Status</th>
                            <th class="d-none d-md-table-cell">Assignee</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="odd">
                            <td class="dtr-control sorting_1">1</td>
                            <td>Project Apollo</td>
                            <td class="d-none d-xl-table-cell">01/01/2023</td>
                            <td class="d-none d-xl-table-cell">31/06/2023</td>
                            <td><span class="badge bg-success">Done</span></td>
                            <td class="d-none d-md-table-cell">Vanessa Tucker</td>
                            <td class="table-action">
                                <a href="#" class="text-black mx-2" style="text-decoration: none;">
                                    <i class="align-middle" data-feather="edit-2"></i>
                                </a>
                                <a href="#" class="text-black mx-2" style="text-decoration: none;">
                                    <i class="align-middle" data-feather="trash-2"></i>
                                </a>
                            </td>
                        </tr>
                        <tr class="even">
                            <td class="dtr-control sorting_1">2</td>
                            <td>Project Fireball</td>
                            <td class="d-none d-xl-table-cell">01/01/2023</td>
                            <td class="d-none d-xl-table-cell">31/06/2023</td>
                            <td><span class="badge bg-danger">Cancelled</span></td>
                            <td class="d-none d-md-table-cell">William Harris</td>
                            <td class="table-action">
                                <a href="#" class="text-black mx-2" style="text-decoration: none;">
                                    <i class="align-middle" data-feather="edit-2"></i>
                                </a>
                                <a href="#" class="text-black mx-2" style="text-decoration: none;">
                                    <i class="align-middle" data-feather="trash-2"></i>
                                </a>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <div class="d-flex w-100 justify-content-between align-items-center p-4">
                    <div class="dataTables_info" id="datatables-orders_info" role="status" aria-live="polite">
                        Showing 1 to 10 of 15 entries
                    </div>
                    <div class="my-3">
                        <div class="dataTables_paginate paging_simple_numbers" id="datatables-orders_paginate">
                            <ul class="pagination">
                                <li class="paginate_button page-item previous disabled" id="datatables-orders_previous">
                                    <a aria-controls="datatables-orders" aria-disabled="true" aria-role="link"
                                        data-dt-idx="previous" tabindex="0" class="page-link">Previous
                                    </a>
                                </li>
                                <!-- Dynamic page numbers will be inserted here -->
                                <li class="paginate_button page-item next" id="datatables-orders_next">
                                    <a href="#" aria-controls="datatables-orders" aria-role="link" data-dt-idx="next"
                                        tabindex="0" class="page-link">Next
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-12 col-lg-4 col-xxl-3 d-flex">
            <div class="card flex-fill w-100">
                <div class="card-header">
                    <h5 class="card-title mb-0">Monthly Sales</h5>
                </div>
                <div class="card-body d-flex w-100">
                    <div class="align-self-center chart chart-lg">
                        <canvas id="chartjs-dashboard-bar"></canvas>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        // $(document).ready(function () {
        //     // Initial parameters
        //     let currentPage = 1;
        //     const itemsPerPage = 10;
        //     let totalItems = 0;
        //     let totalPages = 0;

        //     // Initialize pagination
        //     function initPagination(data) {
        //         totalItems = data.total;
        //         totalPages = Math.ceil(totalItems / itemsPerPage);

        //         updatePaginationUI();
        //         updateDataTableInfo();
        //     }

        //     // Update pagination UI
        //     function updatePaginationUI() {
        //         const $pagination = $('#datatables-orders_paginate ul.pagination');

        //         // Clear existing page items (except Previous and Next)
        //         $pagination.find('li:not(.previous):not(.next)').remove();

        //         // Add page numbers
        //         for (let i = 1; i <= totalPages; i++) {
        //             const activeClass = i === currentPage ? 'active' : '';
        //             $pagination.find('li.previous').after(`
        //         <li class="paginate_button page-item {$activeClass}">
        //             <a href="#" aria-controls="datatables-orders" aria-role="link" 
        //                 data-dt-idx="{$i}" tabindex="0" class="page-link">{$i}
        //             </a>
        //         </li>
        //     `);
        //         }

        //         // Update Previous/Next button states
        //         $pagination.find('li.previous').toggleClass('disabled', currentPage === 1);
        //         $pagination.find('li.next').toggleClass('disabled', currentPage === totalPages);
        //     }

        //     // Update "Showing X to Y of Z entries" info
        //     function updateDataTableInfo() {
        //         const start = (currentPage - 1) * itemsPerPage + 1;
        //         const end = Math.min(currentPage * itemsPerPage, totalItems);
        //         $('#datatables-orders_info').text(`Showing {$start} to {$end} of {$totalItems} entries`);
        //     }

        //     // Fetch data from server
        //     function fetchData() {
        //         $.ajax({
        //             url: '/public/api.php',
        //             type: 'GET',
        //             data: {
        //                 page: currentPage,
        //                 per_page: itemsPerPage
        //             },
        //             success: function (response) {
        //                 // Update your table data here
        //                 // renderTableData(response.data);

        //                 // Update pagination
        //                 initPagination({
        //                     total: response.total,
        //                     data: response.data
        //                 });
        //             }
        //         });
        //     }

        //     // Event delegation for pagination clicks
        //     $(document).on('click', '#datatables-orders_paginate a.page-link', function (e) {
        //         e.preventDefault();

        //         const $this = $(this);
        //         const action = $this.data('dt-idx');

        //         if (action === 'previous' && currentPage > 1) {
        //             currentPage--;
        //         } else if (action === 'next' && currentPage < totalPages) {
        //             currentPage++;
        //         } else if (!isNaN(action)) {
        //             currentPage = parseInt(action);
        //         }

        //         fetchData();
        //     });

        //     // Initial load
        //     fetchData();
        // });
    </script>
</main>
{/capture}

{include file="../components/layouts/dashboard.tpl" children=$smarty.capture.transactionPage }