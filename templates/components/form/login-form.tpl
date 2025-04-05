<form id="loginForm">
    <div class="mb-3">
        <label class="form-label">Email</label>
        <input class="form-control form-control-lg" type="email" name="email" placeholder="Enter your email" />
    </div>
    <div class="mb-3">
        <label class="form-label">Password</label>
        <input class="form-control form-control-lg" type="password" name="password" placeholder="Enter your password" />
    </div>
    <div>
        <div class="form-check align-items-center">
            <input id="customControlInline" type="checkbox" class="form-check-input" value="remember-me"
                name="remember-me" checked>
            <label class="form-check-label text-small" for="customControlInline">
                Remember me
            </label>
        </div>
    </div>
    <div class="d-grid gap-2 mt-3">
        <button type="submit" class="btn btn-lg btn-primary">Sign in</button>
    </div>
    <p id="response" class="my-3">response</p>
</form>


<script>
    var elResponse = document.getElementById('response'); // ✅ Benar
    $(document).ready(function() {
        $("#loginForm").submit(function(e) {
            e.preventDefault();

            const formData = new FormData();
            formData.append('email', 'abyaadmin@gmail.com');
            formData.append('password', 'abya-admin');

            fetch('api/login', {
                    method: 'POST',
                    body: formData
                }).then(response => {
                    // Handle redirect
                    if (response.redirected) {
                        console.log(response);
                        window.location.href = response.url; // 👈 Ini yang kurang
                    }
                    // Handle response JSON (jika tidak redirect)
                    else {
                        return response.json().then(data => {
                            document.getElementById('response').innerText = data.message;
                        });
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        })
    });
</script>
{* 
.then(response => response.json())
.then(data => console.log('Response:', data))
.catch(error => console.error('Error:', error));
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
 *}