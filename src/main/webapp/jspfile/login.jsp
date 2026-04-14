<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Expense Tracker</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), 
                        url('../image/bgimage.png') no-repeat center center fixed;
            background-size: cover;
            height: 100vh;
            display: flex;
            align-items: center;
        }

        .login-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            padding: 2.5rem;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
        }

        .form-control {
            border-radius: 10px;
            padding: 12px;
            border: 1px solid #ddd;
        }

        .form-control:focus {
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
            border-color: #2563eb;
        }

        .btn-login {
            background-color: #2563eb;
            border: none;
            padding: 12px;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-login:hover {
            background-color: #1d4ed8;
            transform: translateY(-2px);
        }

        .forgot-link {
            font-size: 0.85rem;
            color: #64748b;
            text-decoration: none;
            transition: color 0.2s;
        }

        .forgot-link:hover {
            color: #2563eb;
        }

        .brand-logo {
            font-size: 1.5rem;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 0.5rem;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-12 col-sm-8 col-md-6 col-lg-4">
            
            <div class="login-card">
                <div class="text-center mb-4">
                    <div class="brand-logo">Welcome Back! 💸</div>
                    <p class="text-muted small">Please enter your details to sign in</p>
                </div>

                <form action="../LoginServlet" method="post">
                    <div class="form-floating mb-3">
                        <input type="email" name="email" class="form-control" id="floatingInput" placeholder="name@example.com" required>
                        <label for="floatingInput">Email Address</label>
                    </div>

                    <div class="form-floating mb-2">
                        <input type="password" name="password" class="form-control" id="floatingPassword" placeholder="Password" required>
                        <label for="floatingPassword">Password</label>
                    </div>

                    <div class="text-end mb-4">
                        <a href="forgot-password.jsp" class="forgot-link">Forgot password?</a>
                    </div>

                    <button type="submit" class="btn btn-primary btn-login w-100 mb-3">Login</button>
                </form>

                <div class="text-center">
                    <p class="mb-2" style="font-size: 0.9rem;">
                        Don't have an account? <a href="register.jsp" class="fw-bold text-primary text-decoration-none">Register</a>
                    </p>
                    <a href="index.jsp" class="btn btn-link btn-sm text-muted">← Back to Home</a>
                </div>
            </div>

        </div>
    </div>
</div>

</body>
</html>