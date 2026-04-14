<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tracker.db.DBConnect, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard | Expense Tracker Pro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        body { background: #f4f7f6; font-family: 'Poppins', sans-serif; margin: 0; padding: 0; }
        .main-content { margin-left: 260px; padding: 30px; transition: all 0.3s; }
        
        /* Modern Card Styling */
        .stat-card { background: white; border-radius: 15px; border: none; padding: 25px; transition: 0.3s; position: relative; overflow: hidden; }
        .stat-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.1); }
        .stat-card h6 { color: #888; text-uppercase: true; font-size: 13px; font-weight: 600; }
        .stat-card h2 { color: #333; font-weight: 700; margin: 10px 0; }
        .icon-box { background: rgba(102, 126, 234, 0.1); color: #667eea; border-radius: 10px; padding: 10px; font-size: 20px; position: absolute; top: 20px; right: 20px; }
        
        /* Custom Colors for Cards */
        .users-card .icon-box { background: rgba(54, 162, 235, 0.1); color: #36a2eb; }
        .trans-card .icon-box { background: rgba(75, 192, 192, 0.1); color: #4bc0c0; }
        .cash-card .icon-box { background: rgba(255, 99, 132, 0.1); color: #ff6384; }
    </style>
</head>
<body>

    <%@ include file="admin_sidebar.jsp" %>

    <div class="main-content">
        <div class="d-flex justify-content-between align-items-center mb-5">
            <h3 class="fw-bold text-dark"><i class="fa fa-tachometer-alt me-2 text-primary"></i>System Analytics</h3>
        </div>
        
        <%
            // Fetch Dynamic Data
            int totalUsers = 0, totalEntries = 0;
            double totalCash = 0;
            try {
                Connection conn = DBConnect.getConn();
                ResultSet rs1 = conn.createStatement().executeQuery("SELECT COUNT(*) FROM users WHERE role=0");
                if(rs1.next()) totalUsers = rs1.getInt(1);
                
                ResultSet rs2 = conn.createStatement().executeQuery("SELECT COUNT(*), SUM(amount) FROM expenses");
                if(rs2.next()) {
                    totalEntries = rs2.getInt(1);
                    totalCash = rs2.getDouble(2);
                }
            } catch(Exception e) { e.printStackTrace(); }
        %>

        <div class="row">
            <div class="col-md-4 mb-4">
                <div class="stat-card shadow-sm users-card">
                    <div class="icon-box"><i class="fa fa-users"></i></div>
                    <h6>Active Users</h6>
                    <h2><%= totalUsers %></h2>
                    <p class="text-muted small mb-0"><%= totalUsers > 0 ? "+1%" : "No"%></p>
                </div>
            </div>
            
            <div class="col-md-4 mb-4">
                <div class="stat-card shadow-sm trans-card">
                    <div class="icon-box"><i class="fa fa-receipt"></i></div>
                    <h6>Total Entries</h6>
                    <h2><%= totalEntries %></h2>
                    <p class="text-muted small mb-0">Across all users</p>
                </div>
            </div>
            
            <div class="col-md-4 mb-4">
                <div class="stat-card shadow-sm cash-card">
                    <div class="icon-box"><i class="fa fa-wallet"></i></div>
                    <h6>Cash Flow</h6>
                    <h2>₹<%= String.format("%.2f", totalCash) %></h2>
                    <p class="text-muted small mb-0">Total system expense</p>
                </div>
            </div>
        </div>
    </div>

</body>
</html>