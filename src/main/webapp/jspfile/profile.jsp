<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tracker.db.DBConnect, java.sql.*" %>
<%
    // 1. Session Check (Security)
    if (session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    int uid = (int) session.getAttribute("user_id");
    
    // 2. Database se Fresh Data nikalna
    String name="", email="", mobile="", gender="", dob="", city="";
    try {
        Connection conn = DBConnect.getConn();
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM users WHERE id=?");
        ps.setInt(1, uid);
        ResultSet rs = ps.executeQuery();
        if(rs.next()) {
            name = rs.getString("name");
            email = rs.getString("email");
            mobile = rs.getString("mobile");
            gender = rs.getString("gender");
            dob = rs.getString("dob");
            city = rs.getString("city");
        }
    } catch(Exception e) { 
        e.printStackTrace(); 
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Profile | Expense Tracker</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    
    <style>
        body { background: #f4f6f9;; font-family: 'Poppins', sans-serif; margin: 0; }
        .main { margin-left: 220px; padding: 40px; }
        .profile-card { background: white; border-radius: 20px; border: none; overflow: hidden; }
        .profile-header { background: linear-gradient(135deg, #667eea, #764ba2); height: 150px; }
        .profile-img-container { text-align: center; margin-top: -75px; }
        .profile-img { width: 150px; height: 150px; border-radius: 50%; border: 6px solid white; background: #fff; display: inline-flex; align-items: center; justify-content: center; font-size: 60px; color: #764ba2; }
        .form-label { font-weight: 600; color: #555; font-size: 0.9rem; }
        .form-control { border-radius: 10px; padding: 10px 15px; border: 1px solid #ddd; }
        .form-control:focus { box-shadow: 0 0 10px rgba(102, 126, 234, 0.2); border-color: #667eea; }
        .btn-update { background: linear-gradient(135deg, #667eea, #764ba2); border: none; color: white; padding: 12px 40px; border-radius: 30px; font-weight: 600; transition: 0.3s; }
        .btn-update:hover { transform: translateY(-3px); box-shadow: 0 5px 15px rgba(0,0,0,0.2); color: white; }
    </style>
</head>
<body>

    <%@ include file="sidebar.jsp" %>

    <div class="main">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-9 col-lg-7">
                    
                    <div class="card profile-card shadow">
                        <div class="profile-header"></div>
                        
                        <div class="profile-img-container">
                            <div class="profile-img shadow-sm">
                                <i class="fa fa-user-circle"></i>
                            </div>
                        </div>

                        <div class="card-body p-5">
                            <h3 class="text-center fw-bold mb-2"><%= name %></h3>
                            <p class="text-center text-muted mb-4"><%= email %></p>

                            <% if("success".equals(request.getParameter("msg"))) { %>
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <i class="fa fa-check-circle me-2"></i> Profile updated successfully!
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                            <% } %>

                            <form action="${pageContext.request.contextPath}/UpdateProfileServlet" method="post">
                                <div class="row g-4">
                                    <div class="col-md-6">
                                        <label class="form-label">Full Name</label>
                                        <input type="text" name="name" value="<%= name %>" class="form-control" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Mobile Number</label>
                                        <input type="text" name="mobile" value="<%= mobile %>" class="form-control" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">City</label>
                                        <input type="text" name="city" value="<%= city %>" class="form-control" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Email ID (Fixed)</label>
                                        <input type="email" value="<%= email %>" class="form-control text-muted" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Gender</label>
                                        <input type="text" value="<%= gender %>" class="form-control text-muted" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Date of Birth</label>
                                        <input type="text" value="<%= dob %>" class="form-control text-muted" readonly>
                                    </div>
                                </div>

                                <div class="text-center mt-5">
                                    <button type="submit" class="btn btn-update">
                                        <i class="fa fa-save me-2"></i> Save Changes
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>