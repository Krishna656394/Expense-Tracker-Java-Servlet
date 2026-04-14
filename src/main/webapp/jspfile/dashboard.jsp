<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tracker.db.DBConnect, java.sql.*, java.text.SimpleDateFormat" %>
<%
    // Session Check
    if (session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    int uid = (int) session.getAttribute("user_id");
    String userName = (String) session.getAttribute("user_name");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Smart Dashboard | Expense Tracker</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <style>
        :root {
            --primary: #4f46e5;
            --success: #10b981;
            --warning: #f59e0b;
            --dark: #1e293b;
        }

        body { 
            font-family: 'Inter', sans-serif; 
            background: #f8fafc; 
            color: #1e293b; 
        }

        /* Sidebar ki width ke hisaab se margin adjust kiya hai */
        .main { margin-left: 240px; padding: 40px; transition: 0.3s; }

        .stat-card { 
            background: white; 
            border: 1px solid #e2e8f0; 
            border-radius: 20px; 
            padding: 24px;
            transition: all 0.3s ease;
            height: 100%;
        }
        .stat-card:hover { transform: translateY(-5px); box-shadow: 0 10px 25px -5px rgba(0,0,0,0.05); }

        .icon-circle { 
            width: 48px; height: 48px; border-radius: 12px; 
            display: flex; align-items: center; justify-content: center; 
            font-size: 1.25rem; margin-bottom: 20px;
        }

        .bg-indigo-soft { background: #eef2ff; color: var(--primary); }
        .bg-emerald-soft { background: #ecfdf5; color: var(--success); }
        .bg-amber-soft { background: #fffbeb; color: var(--warning); }

        .content-box { 
            background: white; border: 1px solid #e2e8f0; 
            border-radius: 20px; padding: 28px; height: 100%;
        }

        .tip-card {
            background: linear-gradient(135deg, #1e293b 0%, #334155 100%);
            border-radius: 20px;
            padding: 30px;
            color: white;
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            min-height: 250px;
        }

        .category-item { padding: 12px 0; border-bottom: 1px solid #f1f5f9; }
        .category-item:last-child { border-bottom: none; }

        .btn-action { border-radius: 10px; font-weight: 600; padding: 10px 20px; }

        @media (max-width: 992px) { .main { margin-left: 0; padding: 20px; } }
    </style>
</head>
<body>
    
    <%@ include file="sidebar.jsp" %>

    <div class="main">
        <div class="d-flex justify-content-between align-items-center mb-5">
            <div>
                <h2 class="fw-bold mb-1">Welcome back, <%= userName %>!</h2>
                <p class="text-muted small mb-0">Track your finances and stay on top of your goals.</p>
            </div>
            <div class="text-end d-none d-md-block">
                <span class="badge bg-white text-dark border p-2 rounded-3">
                    <i class="fa fa-calendar-alt text-primary me-2"></i>
                    <%= new SimpleDateFormat("EEEE, dd MMM yyyy").format(new java.util.Date()) %>
                </span>
            </div>
        </div>

        <%
            double total = 0, monthTotal = 0;
            try (Connection conn = DBConnect.getConn()) {
                // Total
                PreparedStatement ps1 = conn.prepareStatement("SELECT SUM(amount) FROM expenses WHERE user_id=?");
                ps1.setInt(1, uid);
                ResultSet rs1 = ps1.executeQuery();
                if(rs1.next()) total = rs1.getDouble(1);

                // Monthly
                PreparedStatement ps2 = conn.prepareStatement("SELECT SUM(amount) FROM expenses WHERE user_id=? AND MONTH(expense_date) = MONTH(CURRENT_DATE()) AND YEAR(expense_date) = YEAR(CURRENT_DATE())");
                ps2.setInt(1, uid);
                ResultSet rs2 = ps2.executeQuery();
                if(rs2.next()) monthTotal = rs2.getDouble(1);
            } catch(Exception e) { e.printStackTrace(); }
        %>

        <div class="row g-4">
            <div class="col-md-4">
                <div class="stat-card shadow-sm">
                    <div class="icon-circle bg-indigo-soft"><i class="fa fa-wallet"></i></div>
                    <h6 class="text-muted small fw-bold text-uppercase mb-2">Total Expenses</h6>
                    <h3 class="fw-bold mb-0">₹ <%= String.format("%.2f", total) %></h3>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card shadow-sm">
                    <div class="icon-circle bg-emerald-soft"><i class="fa fa-receipt"></i></div>
                    <h6 class="text-muted small fw-bold text-uppercase mb-2">This Month</h6>
                    <h3 class="fw-bold mb-0">₹ <%= String.format("%.2f", monthTotal) %></h3>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card d-flex flex-column align-items-center justify-content-center border-dashed" style="border: 2px dashed #cbd5e1; background: #f1f5f9;">
                    <div class="icon-circle bg-amber-soft"><i class="fa fa-plus"></i></div>
                    <a href="expense.jsp" class="btn btn-dark w-100 rounded-pill btn-action">Add New Expense</a>
                </div>
            </div>
        </div>

        <div class="row mt-5 g-4">
            <div class="col-md-6">
                <div class="content-box shadow-sm">
                    <h5 class="fw-bold mb-4">Top Categories</h5>
                    <div class="category-list">
                    <%
                        try (Connection conn = DBConnect.getConn()){
                            PreparedStatement ps3 = conn.prepareStatement("SELECT category, SUM(amount) FROM expenses WHERE user_id=? GROUP BY category ORDER BY SUM(amount) DESC LIMIT 5");
                            ps3.setInt(1, uid);
                            ResultSet rs3 = ps3.executeQuery();
                            boolean dataFound = false;
                            while(rs3.next()){
                                dataFound = true;
                    %>
                                <div class="d-flex justify-content-between align-items-center category-item">
                                    <span class="fw-medium"><i class="fa fa-circle me-2" style="font-size: 8px; color: #4f46e5;"></i> <%= rs3.getString(1) %></span>
                                    <span class="fw-bold">₹ <%= String.format("%.2f", rs3.getDouble(2)) %></span>
                                </div>
                    <%
                            }
                            if(!dataFound) { out.println("<p class='text-muted py-4'>No data yet.</p>"); }
                        } catch(Exception e){ e.printStackTrace(); }
                    %>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="tip-card shadow-lg">
                    <div>
                        <span class="badge bg-primary mb-3 px-3 py-2 rounded-pill">Insight</span>
                        <h4 class="fw-bold">Pro Tip 💡</h4>
                        <p class="mt-4 fs-5" style="opacity: 0.9; line-height: 1.6;">
                            "Track every small expense to understand where your money flows. Small spends add up fast!"
                        </p>
                    </div>
                    <div class="mt-4 pt-3 border-top border-secondary text-end">
                        <a href="report.jsp" class="text-white text-decoration-none fw-bold">Full Report <i class="fa fa-arrow-right ms-2"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>