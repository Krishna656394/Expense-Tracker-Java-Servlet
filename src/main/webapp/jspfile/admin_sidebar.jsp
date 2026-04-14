<style>
    .sidebar { height: 100vh; width: 260px; position: fixed; background: #1a1a2e; color: white; padding-top: 30px; }
    .sidebar .brand { text-align: center; font-size: 20px; font-weight: 700; display: block; margin-bottom: 40px; color: white; text-decoration: none; text-transform: uppercase; }
    .sidebar .brand span { color: #e94560; } /* Accent Color */
    .sidebar a { display: block; color: rgba(255,255,255,0.7); padding: 15px 30px; text-decoration: none; transition: 0.3s; font-size: 15px; border-left: 4px solid transparent; }
    .sidebar a:hover, .sidebar a.active { background: #16213e; color: white; border-left: 4px solid #e94560; }
    .sidebar i { margin-right: 15px; font-size: 17px; }
    .sidebar .logout { position: absolute; bottom: 30px; width: 100%; color: #ff4d4d; border: none; }
</style>

<div class="sidebar">
    <a href="admin_dashboard.jsp" class="brand">🛡️ Tracker<span>Pro</span></a>
    
    <a href="admin_dashboard.jsp"><i class="fa fa-home"></i> Overview</a>
    <a href="all_users.jsp"><i class="fa fa-users"></i> Manage Users</a>
    <a href="all_transactions.jsp"><i class="fa fa-exchange-alt"></i> All Transactions</a>
    
    <hr style="opacity: 0.1;">
    <a href="${pageContext.request.contextPath}/LogoutServlet" class="logout"><i class="fa fa-power-off"></i> Logout</a>
</div>





