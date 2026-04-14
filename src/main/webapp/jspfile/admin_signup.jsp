<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Secret Admin Registration</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
    
    <style>
        body {
            background: #1a1a2e;
            font-family: 'Poppins', sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }
        .admin-card {
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
            width: 100%;
            max-width: 400px;
        }
        .btn-danger { background: #e94560; border: none; border-radius: 10px; padding: 12px; }
        .form-control { border-radius: 10px; padding: 12px; margin-bottom: 20px; }
        h3 { color: #1a1a2e; font-weight: bold; text-align: center; margin-bottom: 30px; }
    </style>
</head>
<body>

    <div class="admin-card">
        <form action="${pageContext.request.contextPath}/AdminRegisterServlet" method="post">
            <h3>🛡️ Admin Join</h3>
            
            <div class="mb-3">
                <input type="text" name="name" placeholder="Full Name" class="form-control" required>
            </div>
            
            <div class="mb-3">
                <input type="email" name="email" placeholder="Admin Email" class="form-control" required>
            </div>

            <div class="mb-3">
                <input type="text" name="mobile" placeholder="Mobile Number" class="form-control" required>
            </div>
            
            <div class="mb-3">
                <input type="password" name="password" placeholder="Set Password" class="form-control" required>
            </div>

            <div class="mb-3">
                <input type="password" name="secret_key" placeholder="System Secret Key" class="form-control" required>
            </div>
            
            <button type="submit" class="btn btn-danger w-100 fw-bold">CREATE ADMIN ACCOUNT</button>
            
            <div class="text-center mt-3">
                <a href="login.jsp" class="text-decoration-none small text-muted">Back to Login</a>
            </div>
        </form>
    </div>

</body>
</html>