<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password | Expense Tracker</title>
    
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

        .reset-card {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border-radius: 24px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            padding: 2.5rem;
            width: 100%;
            max-width: 450px;
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

        .btn-update {
            background: var(--primary-blue);
            border: none;
            padding: 0.8rem;
            border-radius: 12px;
            font-weight: 600;
            letter-spacing: 0.5px;
            margin-top: 1rem;
            transition: all 0.3s ease;
        }

        .btn-update:hover {
            background: #1d4ed8;
            transform: translateY(-2px);
            box-shadow: 0 10px 15px -3px rgba(37, 99, 235, 0.4);
        }

        .alert-custom {
            background: rgba(239, 68, 68, 0.1);
            border: 1px solid rgba(239, 68, 68, 0.2);
            color: #fca5a5;
            border-radius: 12px;
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
    </style>
</head>
<body>

<div class="reset-card text-center">
    <div class="icon-circle">
        <i class="fas fa-shield-alt"></i>
    </div>
    
    <h3 class="fw-bold mb-1">Reset Password</h3>
    <p class="text-muted small mb-4">Secure your account with a new password</p>

    <% 
        String email = (String) request.getAttribute("email"); 
        if(email == null) { 
    %>
        <div class="alert alert-custom py-2 mb-4">
            <i class="fas fa-exclamation-circle me-2"></i> Session expired!
        </div>
        <a href="forgot-password.jsp" class="btn btn-outline-secondary w-100 border-0 text-white" style="background: rgba(255,255,255,0.1)">
            Go back to verify email
        </a>
    <% } else { %>
    
        <form action="${pageContext.request.contextPath}/ResetPasswordServlet" method="post" id="resetForm">
            <input type="hidden" name="email" value="<%= email %>">
            
            <div class="text-start mb-3">
                <label class="form-label">New Password</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                    <input type="password" name="newPassword" id="newPass" class="form-control" 
                           placeholder="••••••••" required minlength="6">
                </div>
            </div>

            <div class="text-start mb-4">
                <label class="form-label">Confirm Password</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-check-circle"></i></span>
                    <input type="password" id="confirmPass" class="form-control" 
                           placeholder="••••••••" required>
                </div>
                <div id="matchError" class="text-danger small mt-2" style="display:none;">
                    <i class="fas fa-times-circle"></i> Passwords do not match!
                </div>
            </div>

            <button type="submit" class="btn btn-primary btn-update w-100">
                Update Password <i class="fas fa-arrow-right ms-2"></i>
            </button>
        </form>
    <% } %>

    <div class="mt-4">
        <a href="login.jsp" class="back-link">
            <i class="fas fa-chevron-left me-1"></i> Back to Login
        </a>
    </div>
</div>

<script>
    document.getElementById('resetForm').onsubmit = function() {
        var pass = document.getElementById('newPass').value;
        var confirm = document.getElementById('confirmPass').value;
        var errorDiv = document.getElementById('matchError');

        if (pass !== confirm) {
            errorDiv.style.display = 'block';
            return false;
        }
        errorDiv.style.display = 'none';
        return true;
    };
</script>

</body>
</html>