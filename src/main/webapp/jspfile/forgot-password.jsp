<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verify Email | Expense Tracker</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --primary-blue: #2563eb;
            --dark-navy: #0f172a;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
            color: #f8fafc;
        }

        .forgot-card {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border-radius: 24px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            padding: 2.5rem;
            width: 100%;
            max-width: 420px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
        }

        .icon-circle {
            width: 70px;
            height: 70px;
            background: rgba(37, 99, 235, 0.2);
            color: var(--primary-blue);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            margin: 0 auto 1.5rem;
            border: 1px solid rgba(37, 99, 235, 0.3);
        }

        .form-label {
            font-weight: 500;
            font-size: 0.9rem;
            color: #cbd5e1;
            margin-bottom: 0.5rem;
        }

        .input-group-text {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: #94a3b8;
            border-radius: 12px 0 0 12px;
        }

        .form-control {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: white;
            padding: 0.75rem 1rem;
            border-radius: 0 12px 12px 0;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            background: rgba(255, 255, 255, 0.1);
            border-color: var(--primary-blue);
            box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.15);
            color: white;
        }

        .btn-verify {
            background: var(--primary-blue);
            border: none;
            padding: 0.8rem;
            border-radius: 12px;
            font-weight: 600;
            letter-spacing: 0.5px;
            margin-top: 1rem;
            transition: all 0.3s ease;
        }

        .btn-verify:hover {
            background: #1d4ed8;
            transform: translateY(-2px);
            box-shadow: 0 10px 15px -3px rgba(37, 99, 235, 0.4);
        }

        .back-link {
            color: #94a3b8;
            text-decoration: none;
            font-size: 0.85rem;
            transition: color 0.2s;
        }

        .back-link:hover {
            color: var(--primary-blue);
        }

        .msg-alert {
            font-size: 0.85rem;
            padding: 0.75rem;
            border-radius: 12px;
            margin-bottom: 1.5rem;
        }
    </style>
</head>
<body>

<div class="forgot-card text-center">
    <div class="icon-circle">
        <i class="fas fa-envelope-open-text"></i>
    </div>
    
    <h3 class="fw-bold mb-1">Verify Email</h3>
    <p class="text-muted small mb-4">Enter your email to receive a reset link</p>

    <% String msg = request.getParameter("msg"); 
       if("invalid".equals(msg)) { %>
        <div class="alert alert-danger msg-alert border-0 bg-danger bg-opacity-10 text-danger">
            <i class="fas fa-times-circle me-1"></i> Email not found in our records.
        </div>
    <% } %>

    <form action="${pageContext.request.contextPath}/ForgotPasswordServlet" method="post">
        
        <div class="text-start mb-4">
            <label class="form-label">Registered Email</label>
            <div class="input-group">
                <span class="input-group-text"><i class="fas fa-at"></i></span>
                <input type="email" name="email" class="form-control" 
                       placeholder="example@mail.com" required>
            </div>
        </div>

        <button type="submit" class="btn btn-primary btn-verify w-100">
            Verify & Continue <i class="fas fa-chevron-right ms-2"></i>
        </button>
    </form>

    <div class="mt-4">
        <a href="login.jsp" class="back-link">
            <i class="fas fa-arrow-left me-1"></i> Back to Login
        </a>
    </div>
</div>

</body>
</html>