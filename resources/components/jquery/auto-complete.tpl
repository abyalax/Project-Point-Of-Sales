{literal}
<script>
    $(document).ready(function () {
        $("#search").autocomplete({
            source: function (request, response) {
                $.ajax({
                    url: "api/products",
                    type: "GET",
                    data: { keyword: request.term },
                    dataType: "json",
                    success: function (data) {
                        console.log(data);
                        response(data.data);
                    },
                    error: function (xhr, status, error) {
                        console.log(xhr);
                        console.error("AJAX Error:", status, error);
                    }
                });
            },
            minLength: 2
        });
    });
</script>
{/literal}

<div>
    <h2>Auto Complete JQuery</h2>
    <p>Try with type 'Product'</p>
    <form action="">
        <input type="text" name="search" id="search">
    </form>
</div>