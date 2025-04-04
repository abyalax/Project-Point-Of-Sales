<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    {* JQuery *}
    <script src="../vendor/components/jquery/jquery.min.js"></script>
    {* <script src="https://code.jquery.com/jquery-1.8.3.js"></script> *}
    <!-- Load jQuery UI -->
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <!-- Load jQuery UI CSS (untuk styling autocomplete) -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
    {* JQuery Fancybox*}
    <script type="text/javascript" src="../vendor/components/fancybox/jquery.mousewheel-3.0.4.pack.js"></script>
    <link rel="stylesheet" type="text/css" href="../vendor/components/fancybox/jquery.fancybox-1.3.4.css"
        media="screen" />
    <script type="text/javascript" src="../vendor/components/fancybox/jquery.fancybox-1.3.4.pack.js"></script>
    <link rel="stylesheet" href="../public/styles.css" />
    {* <title>{$title}</title> *}
</head>

<body>
    <main class="container">

        <h2>Fancy Box Pop Up</h2>
        <button><a id="various1" href="#inline1"
                title="This Is title, edit at atribut title in tag HTML">Inline</a></button>
        <button><a id="various2" class="various2 fancybox.iframe" href="../public/components/form.html"
                title="This Is title, edit at atribut title in tag HTML">Inline from other file</a></button>

        {* <div style="display: none;">
            <div id="inline1" style="">
                <form id="updateUserForm" style="display: flex;flex-direction: column;gap: 10px;margin: 20;">
                    <input type="hidden" name="id" value="{$user.id}">
                    <input type="text" name="name" value="{$user.name}">
                    <input type="email" name="email" value="{$user.email}">
                    <input type="text" name="phone" value="{$user.phone}">
                    <button type="submit">Update</button>
                </form>
            </div>
        </div> *}

        <script>
            $("#various1").fancybox({
                'padding': '20',
                'titlePosition': 'inside',
                'transitionIn': 'elastic',
                'transitionOut': 'elastic'
            });
            $("#various2").fancybox({
                'type': 'iframe'
            })
        </script>

        <h2>Auto Complete JQuery</h2>
        <p>Try with type 'Product'</p>
        <form action="">
            <input type="text" name="search" id="search">
        </form>

        <script>
            $(document).ready(function() {
                $("#search").autocomplete({
                    source: function(request, response) {
                        $.ajax({
                            url: "../public/api.php",
                            type: "POST",
                            data: {
                                action: "product.search",
                                keyword: request.term
                            },
                            dataType: "json",
                            success: function(data) {
                                console.log(data);
                                response(data.data);
                            },
                            error: function(xhr, status, error) {
                                console.log(xhr);
                                console.error("AJAX Error:", status, error);
                            }
                        });
                    },
                    minLength: 2
                });
            });
        </script>

    </main>


</body>

</html>