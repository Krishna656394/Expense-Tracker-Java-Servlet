<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ExpenseTracker | Smart Finance Management</title>
    
    <link rel="stylesheet" href="../cssfile/index.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
</head>
<body>

    <div class="hero-section">
        <div class="overlay">
            <nav class="navbar">
                <div class="logo">Expense<span>Tracker</span></div>
            </nav>

            <div class="container">
                <div class="hero-content">
                    <h1>Take Control of Your <br><span class="highlight">Financial Future</span></h1>
                    <p class="tagline">
                        The simplest way to track expenses, set budgets, and save more money every month. Join thousands of users managing wealth smartly.
                    </p>

                    <div class="features-grid">
                        <div class="feature-item">
                            <span>📊</span>
                            <p>Real-time Analytics</p>
                        </div>
                        <div class="feature-item">
                            <span>🔒</span>
                            <p>Secure & Private</p>
                        </div>
                        <div class="feature-item">
                            <span>📱</span>
                            <p>Cloud Sync</p>
                        </div>
                    </div>

                    <button class="cta-button" onclick="goToLogin()">Get Started for Free 🚀</button>
                </div>
            </div>
        </div>
    </div>

<script>
function goToLogin(){
    window.location.href = "login.jsp";
}
</script>

</body>
</html>