<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="/vendor/components/jquery/jquery.min.js"></script>
    <script src="/vendor/components/jqueryui/jquery-ui.min.js"></script>
    <link rel="stylesheet" href="/vendor/components/jqueryui/themes/smoothness/jquery-ui.min.css">
    <link rel="stylesheet" href="/vendor/components/jqueryui/themes/smoothness/theme.css">
    <link rel="stylesheet" href="/public/styles.css" />
    <title>{$title}</title>
</head>

<body>
    <main class="container">
        <h3>Navbar</h3>
        {include file="./components/navbar.tpl"}

        <h1>{$message}</h1>
        <h2>Get data via template engine Smarty</h2>
        <p id="data">Data</p>

        {include file="./components/table/user.tpl"}

        <h2>Interaktif with JQuery</h2>
        <button id="btn-click">Klik Saya</button>
        <p id="result">Belum diklik.</p>
        <script>
            let bool = true
            $(document).ready(function() {
                $("#btn-click").click(function() {
                    bool = !bool
                    let msg = bool ? 'Clicked' : 'UnClicked'
                    $("#result").text(msg);
                    console.log(bool);

                });
            });
        </script>

        {include file="./components/form/user.tpl"}

    </main>


</body>

</html>