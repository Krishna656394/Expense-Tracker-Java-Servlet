<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tracker.db.DBConnect, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Users | Expense Tracker Pro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    
    <style>
        body { background: #f8f9fa; font-family: 'Poppins', sans-serif; }
        .main-content { margin-left: 260px; padding: 40px; }
        
        /* Table Card Styling */
        .user-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            padding: 30px;
            border: none;
        }

        .table { vertical-align: middle; }
        .table thead { background: #fdfdfd; }
        .table thead th { 
            border: none; 
            color: #adb5bd; 
            font-weight: 600; 
            text-transform: uppercase; 
            font-size: 12px;
            letter-spacing: 0.5px;
            padding: 20px;
        }

        .user-info h6 { margin-bottom: 0; font-weight: 600; color: #333; }
        .user-info p { margin-bottom: 0; font-size: 13px; color: #888; }
        
        /* Avatar Placeholder */
        .avatar {
            width: 45px;
            height: 45px;
            background: #eee;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            color: #667eea;
            margin-right: 15px;
        }

        /* Status Badge */
        .status-badge {
            background: rgba(40, 167, 69, 0.1);
            color: #28a745;
            padding: 5px 12px;
            border-radius: 8px;
            font-size: 12px;
            font-weight: 500;
        }

        .btn-delete {
            background: rgba(220, 53, 69, 0.1);
            color: #dc3545;
            border: none;
            padding: 8px 15px;
            border-radius: 10px;
            transition: 0.3s;
        }
        .btn-delete:hover {
            background: #dc3545;
            color: white;
        }
    </style>
</head>
<body>

    <%@ include file="admin_sidebar.jsp" %>

    <div class="main-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h3 class="fw-bold mb-1 text-dark">User Management</h3>
                <p class="text-muted small">Manage all registered system users and their accounts.</p>
            </div>
        </div>

        <div class="user-container shadow-sm">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>User Details</th>
                            <th>Location</th>
                            <th>Status</th>
                            <th class="text-center">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                Connection conn = DBConnect.getConn();
                                ResultSet rs = conn.createStatement().executeQuery("SELECT * FROM users WHERE role=0");
                                while(rs.next()) {
                                    String name = rs.getString("name");
                                    String initial = name.substring(0,1).toUpperCase();
                        %>
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="avatar"><%= initial %></div>
                                            <div class="user-info">
                                                <h6><%= name %></h6>
                                                <p><%= rs.getString("email") %></p>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="text-dark"><%= rs.getString("city") %></span><br>
                                        <small class="text-muted"><%= rs.getString("mobile") %></small>
                                    </td>
                                    <td><span class="status-badge">Active</span></td>
                                    <td class="text-center">
                                        <a href="${pageContext.request.contextPath}/DeleteUserServlet?id=<%= rs.getInt("id") %>" 
                                           class="btn-delete text-decoration-none" 
                                           onclick="return confirm('Pakka is user ko delete karna hai?')">
                                            <i class="fa fa-trash-alt"></i>
                                        </a>
                                    </td>
                                </tr>
                        <%      }
                            } catch(Exception e) { e.printStackTrace(); }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</body>
</html>