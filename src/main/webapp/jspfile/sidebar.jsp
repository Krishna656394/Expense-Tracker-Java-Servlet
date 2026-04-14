<style>
    :root {
        --sidebar-bg: #0f172a; /* Slate 900 - More premium than pure black */
        --sidebar-active: #6366f1; /* Indigo 500 */
        --sidebar-hover: rgba(99, 102, 241, 0.1);
        --text-muted: #94a3b8;
    }

    .sidebar {
        height: 100vh;
        width: 250px;
        position: fixed;
        left: 0;
        top: 0;
        background: var(--sidebar-bg);
        color: var(--text-muted);
        padding: 24px 16px;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        box-shadow: 4px 0 25px rgba(0,0,0,0.2);
        z-index: 1000;
        border-right: 1px solid rgba(255,255,255,0.05);
    }

    /* Logo Section */
    .sidebar .brand {
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 10px 0 40px 0;
        text-decoration: none;
    }

    .sidebar .brand-icon {
        background: linear-gradient(135deg, #6366f1 0%, #4338ca 100%);
        width: 35px;
        height: 35px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 10px;
        margin-right: 12px;
        box-shadow: 0 4px 12px rgba(99, 102, 241, 0.3);
    }

    .sidebar .brand-text {
        color: #ffffff;
        font-size: 1.4rem;
        font-weight: 800;
        letter-spacing: -0.5px;
    }

    .sidebar .brand-text span {
        color: var(--sidebar-active);
    }

    /* Nav Links */
    .nav-label {
        font-size: 0.75rem;
        text-transform: uppercase;
        letter-spacing: 1px;
        color: #475569;
        margin: 20px 0 10px 15px;
        font-weight: 700;
    }

    .sidebar a {
        display: flex;
        align-items: center;
        color: var(--text-muted);
        padding: 12px 18px;
        text-decoration: none;
        border-radius: 12px;
        margin-bottom: 6px;
        font-size: 0.95rem;
        font-weight: 500;
        transition: 0.25s ease;
    }

    .sidebar a i {
        margin-right: 15px;
        font-size: 1.2rem;
        opacity: 0.7;
    }

    .sidebar a:hover {
        background: var(--sidebar-hover);
        color: #ffffff;
    }

    .sidebar a:hover i {
        opacity: 1;
        color: var(--sidebar-active);
    }

    .sidebar a.active {
        background: var(--sidebar-active);
        color: #ffffff;
        box-shadow: 0 10px 15px -3px rgba(99, 102, 241, 0.3);
    }

    .sidebar a.active i {
        opacity: 1;
        color: #ffffff;
    }

    /* Logout Specific */
    .logout-btn {
        margin-top: auto;
        color: #fca5a5 !important;
        background: rgba(239, 68, 68, 0.05) !important;
    }

    .logout-btn:hover {
        background: #ef4444 !important;
        color: #ffffff !important;
    }

    hr {
        border-color: rgba(255,255,255,0.05);
        margin: 25px 0;
    }

    /* Smooth responsiveness for main content */
    .main { 
        margin-left: 250px; 
        padding: 30px;
        min-height: 100vh;
    }
</style>

<div class="sidebar">
    <a href="dashboard.jsp" class="brand">
        <div class="brand-icon"><i class="fas fa-coins text-white"></i></div>
        <div class="brand-text">Finance<span>Tracker</span></div>
    </a>

    <div class="nav-label">Main Menu</div>
    <a href="dashboard.jsp" class="<%= request.getRequestURI().contains("dashboard.jsp") ? "active" : "" %>">
        <i class="fa fa-th-large"></i> Dashboard
    </a>
    <a href="expense.jsp" class="<%= request.getRequestURI().contains("expense.jsp") ? "active" : "" %>">
        <i class="fa fa-wallet"></i> Expenses
    </a>
    <a href="report.jsp" class="<%= request.getRequestURI().contains("report.jsp") ? "active" : "" %>">
        <i class="fa fa-chart-pie"></i> Reports
    </a>

    <div class="nav-label">Settings</div>
    <a href="profile.jsp" class="<%= request.getRequestURI().contains("profile.jsp") ? "active" : "" %>">
        <i class="fa fa-user-circle"></i> My Profile
    </a>
    
    <hr>
    
    <a href="${pageContext.request.contextPath}/LogoutServlet" class="logout-btn">
        <i class="fa fa-sign-out-alt"></i> Logout
    </a>
</div>