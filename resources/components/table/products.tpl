<script>
    function getAllData() {
        $.ajax({
            url: "api/products",
            type: "GET",
            dataType: "json",
            success: function(response) {
                console.log('Success Get', response.data);

                let tbody = $("#tableProduct tbody");
                tbody.empty();

                if (response.data && response.data.length > 0) {
                    response.data.forEach(function(product) {
                        console.log('Products : ', product);
                        let row =
                            "<tr class='odd'>" +
                            "<td class='dtr-control sorting_1'>" + (product.id ? product.id :
                                'N/A') + "</td>" +
                            "<td class='d-none d-xl-table-cell'>" + (product.name ? product.name :
                                'N/A') + "</td>" +
                            "<td class='d-none d-xl-table-cell'>" + (product.price ? product.price :
                                'N/A') + "</td>" +
                            "<td class='table-action'>" +
                                "<button class='btn btn-transparent text-black mx-2' style='text-decoration: none;'>" +
                                "<svg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round' class='feather feather-plus-circle'><circle cx='12' cy='12' r='10'></circle><line x1='12' y1='8' x2='12' y2='16'></line><line x1='8' y1='12' x2='16' y2='12'></line></svg>" +
                                "</button>" +
                                "<button class='btn btn-transparent text-black mx-2' style='text-decoration: none;'>" +
                                "<svg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round' class='feather feather-edit'><path d='M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7'></path><path d='M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z'></path></svg>" +
                                "</button>" +
                            "</td >" +
                            "</tr>";
                        tbody.append(row);
                    });
                } else {
                    tbody.append('<tr><td colspan="3">No data available</td></tr>');
                }
            },
            error: function(xhr, status, error) {
                console.log(xhr);
                console.log(error);
                console.error("AJAX Error:", status, error);
            }
        });
    }
    
    // document.addEventListener('DOMContentLoaded', getAllData);
</script>
<table id="tableProduct" class="table table-hover table-striped table-responsive">
    <thead>
        <tr>
            <th>ID</th>
            <th class="sorting" tabindex="0" aria-controls="datatables-orders" rowspan="1" colspan="1"
                style="width: 256px;" aria-label="Billing Name: activate to sort column ascending">
                Product Name
            </th>
            <th class="d-none d-xl-table-cell">Price</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <tr class="odd">
            <td class="dtr-control sorting_1">1</td>
            <td>GATSBY Powder Clay Unbrekable smooth</td>
            <td class="d-none d-xl-table-cell">Rp 47.500</td>
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