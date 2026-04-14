<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tracker.db.DBConnect, java.sql.*, java.util.Date, java.text.SimpleDateFormat" %>
<%
    if (session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    int uid = (int) session.getAttribute("user_id");
    String userName = (String) session.getAttribute("user_name");
    
    String sdate = request.getParameter("sdate");
    String edate = request.getParameter("edate");

    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
    String reportGenTime = sdf.format(new Date());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Financial Report | <%= userName %></title>
    
    <link href="https://fonts.googleapis.com/css2?family=Public+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <style>
        body { 
            background-color: #f9fafb; 
            font-family: 'Public Sans', sans-serif;
            color: #1f2937;
        }

        /* Sidebar constraint - aapka sidebar 240px wide hai */
        .main { margin-left: 240px; padding: 40px; }

        /* Report Header Section */
        .report-header-ui { margin-bottom: 2rem; }
        .report-header-ui h2 { font-weight: 700; color: #111827; }

        /* Professional Cards */
        .ui-card {
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
            padding: 24px;
            margin-bottom: 24px;
        }

        /* Form Styling */
        .form-label { font-weight: 600; font-size: 0.8rem; color: #4b5563; text-transform: uppercase; letter-spacing: 0.025em; }
        .form-control { border-radius: 8px; border: 1px solid #d1d5db; padding: 10px; font-size: 0.95rem; }
        .form-control:focus { border-color: #6366f1; box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1); }

        .btn-submit {
            background-color: #111827;
            color: white;
            border-radius: 8px;
            font-weight: 600;
            padding: 10px;
            border: none;
            transition: 0.2s;
        }
        .btn-submit:hover { background-color: #374151; color: white; }

        /* Table Design */
        .table { margin-bottom: 0; }
        .table thead th {
            background-color: #f9fafb;
            color: #6b7280;
            font-weight: 600;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            padding: 16px 20px;
            border-bottom: 1px solid #e5e7eb;
        }
        .table tbody td { padding: 16px 20px; font-size: 0.95rem; border-bottom: 1px solid #f3f4f6; }
        
        .cat-pill {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 6px;
            font-size: 0.8rem;
            font-weight: 500;
            background: #f3f4f6;
            color: #374151;
            border: 1px solid #e5e7eb;
        }

        .total-box {
            background: #f8fafc;
            border-radius: 8px;
            padding: 16px 24px;
            margin-top: 16px;
            border-left: 4px solid #111827;
        }

        /* Print Settings */
        @media print {
            .sidebar, .no-print, .ui-card-filter { display: none !important; }
            .main { margin-left: 0 !important; padding: 0 !important; }
            .ui-card { border: none !important; box-shadow: none !important; }
        }
    </style>
</head>
<body>

    <%@ include file="sidebar.jsp" %>

    <div class="main">
        
        <div class="report-header-ui d-flex justify-content-between align-items-center no-print">
            <div>
                <h2 class="mb-0">Reports & Analytics</h2>
                <p class="text-muted small mb-0">Review your spending patterns over time.</p>
            </div>
            <% if(sdate != null && edate != null) { %>
                <button onclick="window.print()" class="btn btn-outline-dark btn-sm rounded-pill px-4">
                    <i class="fa fa-print me-2"></i> Export PDF
                </button>
            <% } %>
        </div>

        <div class="ui-card ui-card-filter no-print">
            <form action="report.jsp" method="get" class="row g-3 align-items-end">
                <div class="col-md-4">
                    <label class="form-label">Start Period</label>
                    <input type="date" name="sdate" class="form-control" value="<%= (sdate!=null)?sdate:"" %>" required>
                </div>
                <div class="col-md-4">
                    <label class="form-label">End Period</label>
                    <input type="date" name="edate" class="form-control" value="<%= (edate!=null)?edate:"" %>" required>
                </div>
                <div class="col-md-4">
                    <button type="submit" class="btn-submit w-100">Fetch Statement</button>
                </div>
            </form>
        </div>

        <div class="ui-card">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h5 class="fw-bold mb-0">Expense Details</h5>
                <span class="text-muted extra-small" style="font-size: 0.75rem;">Generated on: <%= reportGenTime %></span>
            </div>

            <% if(sdate != null && edate != null) { %>
                <div class="table-responsive">
                    <table class="table align-middle">
                        <thead>
                            <tr>
                                <th>Transaction Date</th>
                                <th>Category</th>
                                <th class="text-end">Amount</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                double total = 0;
                                try (Connection conn = DBConnect.getConn()) {
                                    String sql = "SELECT * FROM expenses WHERE user_id=? AND expense_date BETWEEN ? AND ? ORDER BY expense_date ASC";
                                    PreparedStatement ps = conn.prepareStatement(sql);
                                    ps.setInt(1, uid);
                                    ps.setString(2, sdate);
                                    ps.setString(3, edate);
                                    ResultSet rs = ps.executeQuery();
                                    boolean hasData = false;
                                    while(rs.next()) {
                                        hasData = true;
                                        total += rs.getDouble("amount");
                            %>
                                <tr>
                                    <td class="text-secondary"><%= rs.getString("expense_date") %></td>
                                    <td><span class="cat-pill"><%= rs.getString("category") %></span></td>
                                    <td class="text-end fw-bold">₹<%= String.format("%.2f", rs.getDouble("amount")) %></td>
                                </tr>
                            <% 
                                    } 
                                    if(hasData) {
                            %>
                                    </tbody>
                                </table>
                                <div class="total-box d-flex justify-content-between align-items-center mt-3">
                                    <span class="fw-bold text-muted small uppercase">Total Expenditure</span>
                                    <span class="h4 mb-0 fw-bold">₹<%= String.format("%.2f", total) %></span>
                                </div>
                            <%
                                    } else {
                            %>
                                <tr><td colspan="3" class="text-center py-5 text-muted small">No records found for selected period.</td></tr>
                                </tbody></table>
                            <%
                                    }
                                } catch(Exception e) { e.printStackTrace(); }
                            %>
                </div>
            <% } else { %>
                <div class="text-center py-5 no-print text-muted">
                    <i class="far fa-chart-bar fa-3x mb-3 opacity-25"></i>
                    <p class="small">Please select dates to generate your financial summary.</p>
                </div>
            <% } %>
        </div>
        
    </div>
</body>
</html>