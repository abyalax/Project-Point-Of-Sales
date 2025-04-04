<h2>Post Data with JQuery</h2>
<form id="updateUserForm" style="display: flex;flex-direction: column;gap: 10px; width: 50vw;">
    <input type="hidden" name="id" value="{$users.id}">
    <input type="text" name="name" value="{$users.name}">
    <input type="email" name="email" value="{$users.email}">
    <input type="number" name="phone" value="{$users.phone}"
        style="appearance: textfield; -moz-appearance: textfield; -webkit-appearance: none;">
    <button type="submit">Update</button>
</form>

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