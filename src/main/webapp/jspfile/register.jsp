<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration - Expense Tracker</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
    
		    /* 🔥 Background Image */
		    background: url('../image/bgimage.png');
		    background-attachment: fixed;
		     background-repeat: no-repeat;
		     background-size: cover;
		    background-position: center;
		    height: 100vh;
            margin: 0;
        }

        .card {
            margin-top: 20px;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(5px);
            border-radius: 15px;
            border: none;
        }
        
        /* Chhoti screen par scroll allow karne ke liye */
        .container {
            padding-bottom: 30px;
        }
    </style>
</head>
<body>

<div class="container d-flex justify-content-center">
    <div class="col-md-6">
        <div class="card p-4 shadow-lg">

            <h3 class="text-center mb-3">Join Us! 🚀</h3>

            <form action="RegisterServlet" method="post" onsubmit="return validatePassword()">

                <div class="row">
                    <div class="col-md-6">
                        <input type="text" name="name" class="form-control mb-3" placeholder="Full Name" required>
                    </div>
                    <div class="col-md-6">
                        <input type="email" name="email" class="form-control mb-3" placeholder="Email" required>
                    </div>
                </div>

                <input type="tel" name="mobile" class="form-control mb-3" placeholder="Mobile Number" required>

                <div class="mb-3">
                    <label class="form-label">Gender</label><br>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="gender" value="Male" required> Male
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="gender" value="Female"> Female
                    </div>
                </div>

                <label class="form-label">Date of Birth</label>
                <input type="date" name="dob" class="form-control mb-3" required>

                <input type="text" name="city" class="form-control mb-3" placeholder="City (Optional)">

                <div class="row">
                    <div class="col-md-6">
                        <input type="password" name="password" class="form-control mb-3" placeholder="Password" required>
                    </div>
                    <div class="col-md-6">
                        <input type="password" name="confirmPassword" class="form-control mb-3" placeholder="Confirm Password" required>
                    </div>
                </div>

                <div class="form-check mb-3">
                    <input type="checkbox" class="form-check-input" id="terms" required>
                    <label class="form-check-label" for="terms">I agree to Terms & Conditions</label>
                </div>

                <button type="submit" class="btn btn-success w-100">Create Account</button>

            </form>

            <p class="text-center mt-3">
                Already have an account? 
                <a href="login.jsp" class="text-decoration-none">Login here</a>
            </p>

        </div>
    </div>
</div>
<script>
function validatePassword() {
    // Name attributes se fields ko pakadna
    var pass = document.getElementsByName("password")[0].value;
    var confirmPass = document.getElementsByName("confirmPassword")[0].value;

    if (pass != confirmPass) {
    	alert("Password and Confirm Password do not match!");
        return false; // Isse form submit nahi hoga
    }
    return true; // Sab sahi hai toh submit ho jayega
}
</script>
</body>
</html>
