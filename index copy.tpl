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

        {* <h1>{$message}</h1> *}
        <h2>Get data via template engine Smarty</h2>
        <table id="userTable">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                </tr>
            </thead>
            <tbody>
                {* {foreach from=$users item=user}
                    <tr>
                        <td>{$user.id}</td>
                        <td>{$user.name}</td>
                        <td>{$user.email}</td>
                        <td>{$user.phone}</td>
                    </tr>
                {/foreach} *}
            </tbody>
        </table>

        <button onclick="updateFunction()">Update</button>

        <script>
            // function updateFunction() {
            //     $.ajax({
            //         url: "../public/api.php",
            //         type: "GET",
            //         data: {
            //             action: "user.getAllUsers",
            //         },
            //         dataType: "json",
            //         success: function(data) {
            //             console.log(data);
            //         },
            //         error: function(xhr, status, error) {
            //             console.log(xhr);
            //             console.error("AJAX Error:", status, error);
            //         }
            //     });
            // }

            function updateFunction() {
                $.ajax({
                    url: "../public/api.php",
                    type: "GET",
                    data: { action: "user.getAllUsers" },
                    dataType: "json",
                    success: function(response) {
                        console.log('Success Get');

                        if (response && response.length > 0) {
                            let tbody = $("#userTable tbody");
                            tbody.empty();
                            console.log(response);
                            // $.each(response, function(index, user) {
                            //     tbody.append(`
                            //         <tr>
                            //             <td>${user.id}</td>
                            //             <td>${user.name}</td>
                            //             <td>${user.email}</td>
                            //             <td>${user.phone}</td>
                            //         </tr>
                            //     `);
                            // });
                        } else {
                            console.warn("No user data received.");
                        }
                    },
                    error: function(xhr, status, error) {
                        console.log(xhr);
                        console.error("AJAX Error:", status, error);
                    }
                });
            }
        </script>

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

        <h2>Post Data with JQuery</h2>
        {* <form id="updateUserForm" style="display: flex;flex-direction: column;gap: 10px; width: 50vw;">
            <input type="hidden" name="id" value="{$users[0].id}">
            <input type="text" name="name" value="{$users[0].name}">
            <input type="email" name="email" value="{$users[0].email}">
            <input type="text" name="phone" value="{$users[0].phone}">
            <button type="submit">Update</button>
        </form> *}

        <p id="response">text ini akan berubah menjadi response</p>

        <script>
            var elResponse = document.getElementById('response'); // ✅ Benar
            $(document).ready(function() {
                $("#updateUserForm").submit(function(e) {
                    e.preventDefault();
                    $.ajax({
                        url: "../public/api.php",
                        type: "POST",
                        data: $(this).serialize() + "&action=insert",
                        dataType: "json",
                        success: function(response) {
                            if (response.status === "success") {
                                elResponse.innerText = response.message
                                alert("Sukses: " + response.message);
                            } else {
                                console.log(JSON.stringify(response.message, null, 2));
                                console.log(response.message);
                                elResponse.innerText = response.data
                            }
                        },
                        error: function(xhr, status, error) {
                            var response = JSON.parse(xhr.responseText);
                            console.log(response);
                            var errorMessages = Object.values(response.data);
                            var errorMessage = errorMessages.length > 0 ? errorMessages[0] :
                                "Data tidak valid";
                            elResponse.innerText = errorMessage;
                        }
                    });



                });
            });
        </script>

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