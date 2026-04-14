<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tracker.db.DBConnect, java.sql.*" %>
<%
    if (session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    int uid = (int) session.getAttribute("user_id");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Expenses</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../cssfile/style.css">
    <link rel="stylesheet" href="../cssfile/sidebar.css">
    
    <style>
    /* 1. Pure Gradient Background (No Image, High Contrast) */
    body { 
        margin: 0; 
        font-family: 'Poppins', sans-serif; 
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); 
        background-attachment: fixed;
        min-height: 100vh;
    }

    .main { margin-left: 240px; padding: 30px; }

    /* 2. Super Clean Glass Cards */
    .card { 
        background: rgba(255, 255, 255, 0.95) !important; /* Almost solid white for clarity */
        border-radius: 15px !important; 
        border: none !important; 
        padding: 25px; 
        margin-bottom: 25px; 
        box-shadow: 0 10px 30px rgba(0,0,0,0.1) !important;
    }

    /* 3. Text Visibility Fix */
    h3, h5 { 
        color: #ffffff !important; 
        font-weight: 600 !important; 
        margin-bottom: 20px;
    }

    .card h5 { color: #333 !important; } /* Card ke andar ka text dark rahega */

    .form-label { 
        color: #555 !important; 
        font-weight: 500; 
        margin-bottom: 8px;
    }

    /* 4. Table Design (Professional & Sharp) */
    .table-responsive { 
        border-radius: 12px; 
        overflow: hidden; 
    }

    .table thead th { 
        background: #1e1e2f !important; 
        color: #00d2ff !important; 
        padding: 15px !important; 
        font-size: 14px;
        border: none;
    }

    .table tbody td { 
        padding: 12px !important; 
        color: #444 !important; 
        background: #ffffff !important;
        border-bottom: 1px solid #f0f0f0;
        font-weight: 500;
    }

    /* 5. Custom Buttons */
    .btn-save {
        background: #007bff !important;
        color: white !important;
        border-radius: 10px !important;
        padding: 10px;
        transition: 0.3s;
    }

    .btn-save:hover { background: #0056b3 !important; }
</style>
</head>
<body>

<%@ include file="sidebar.jsp" %>

<div class="main">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>💸 Expense Management</h3>
        <% String msg = request.getParameter("msg"); 
           if("added".equals(msg)) { %>
               <span class="badge bg-success p-2">Expense Saved Successfully!</span>
        <% } %>
    </div>

    <div class="card shadow">
        <h5 class="mb-3"><i class="fa fa-plus-circle me-2"></i>Add New Transaction</h5>
        <form action="../AddExpenseServlet" method="post" class="row g-3">
            <div class="col-md-3">
                <label class="form-label">Amount (₹)</label>
                <input type="number" name="amount" placeholder="0.00" class="form-control" required>
            </div>
            <div class="col-md-3">
                <label class="form-label">Category</label>
                <select name="category" class="form-select" required>
                    <option value="">Choose...</option>
                    <option value="Food">🍔 Food</option>
                    <option value="Rent">🏠 Rent</option>
                    <option value="Shopping">🛍️ Shopping</option>
                    <option value="Travel">🚗 Travel</option>
                    <option value="Bills">💡 Bills</option>
                    <option value="Health">🏥 Health</option>
                    <option value="Other">✨ Other</option>
                </select>
            </div>
            <div class="col-md-3">
                <label class="form-label">Date</label>
                <input type="date" name="expense_date" class="form-control" required>
            </div>
            <div class="col-md-3 d-flex align-items-end">
                <button type="submit" class="btn btn-light w-100 fw-bold" style="border-radius: 10px;">Save Now</button>
            </div>
        </form>
    </div>

    <div class="card shadow">
        <h5 class="mb-3"><i class="fa fa-list-ul me-2"></i>History for <%= session.getAttribute("user_name") %></h5>
        <div class="table-responsive">
            <table class="table table-hover text-center shadow-sm">
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Category</th>
                        <th>Amount</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            Connection conn = DBConnect.getConn();
                            // Latest kharche sabse upar dikhenge
                            String sql = "SELECT * FROM expenses WHERE user_id=? ORDER BY expense_date DESC";
                            PreparedStatement ps = conn.prepareStatement(sql);
                            ps.setInt(1, uid);
                            ResultSet rs = ps.executeQuery();
                            
                            boolean hasData = false;
                            while(rs.next()) {
                                hasData = true;
                    %>
                                <tr>
                                    <td class="fw-bold"><%= rs.getString("expense_date") %></td>
                                    <td><span class="badge bg-secondary px-3"><%= rs.getString("category") %></span></td>
                                    <td class="text-success fw-bold">₹<%= rs.getDouble("amount") %></td>
                                    <td>
									    <a href="${pageContext.request.contextPath}/DeleteExpenseServlet?id=<%= rs.getInt("id") %>" 
									       class="btn-delete" 
									       onclick="return confirm('Are you sure you want to delete this record?')">
									        <i class="fa fa-trash-alt"></i>
									    </a>
									</td>
                                </tr>
                    <%
                            }
                            if(!hasData) {
                    %>
                                <tr><td colspan="4" class="text-muted">No expenses found. Start adding!</td></tr>
                    <%
                            }
                        } catch(Exception e) { e.printStackTrace(); }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>