<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tracker.db.DBConnect, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All System Transactions | Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    
    <style>
        body { background: #f4f7f6; font-family: 'Poppins', sans-serif; }
        .main-content { margin-left: 260px; padding: 30px; }
        .table-card { background: white; border-radius: 15px; border: none; padding: 20px; }
        .table { vertical-align: middle; }
        .table thead th { background: #f8f9fa; color: #888; border: none; font-size: 13px; text-uppercase: true; }
        .table tbody td { border-bottom: 1px solid #eee; padding: 15px; color: #555; }
        .badge { font-weight: 500; padding: 6px 10px; border-radius: 10px; }
    </style>
</head>
<body>

    <%@ include file="admin_sidebar.jsp" %>

    <div class="main-content">
        <h3 class="mb-5 fw-bold"><i class="fa fa-exchange-alt me-2 text-info"></i>Global Transaction Log</h3>
        
        <div class="table-card shadow-sm">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>User</th>
                        <th>Category</th>
                        <th>Amount</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    try {
                        Connection conn = DBConnect.getConn();
                        // Joins user names with expenses for a professional view
                        String sql = "SELECT e.*, u.name as user_name FROM expenses e JOIN users u ON e.user_id = u.id ORDER BY expense_date DESC";
                        ResultSet rs = conn.createStatement().executeQuery(sql);
                        
                        while(rs.next()) {
                %>
                        <tr>
                            <td><%= rs.getString("expense_date") %></td>
                            <td class="fw-medium"><%= rs.getString("user_name") %></td>
                            <td><span class="badge bg-light text-dark border"><%= rs.getString("category") %></span></td>
                            <td class="fw-bold text-danger">₹<%= rs.getDouble("amount") %></td>
                        </tr>
                <%      
                        }
                    } catch(Exception e) { e.printStackTrace(); }
                %>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>