package com.tracker.servlet;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.tracker.db.DBConnect;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        try {
            Connection conn = DBConnect.getConn();
            PreparedStatement ps = conn.prepareStatement("SELECT email FROM users WHERE email=?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                request.setAttribute("email", email);
                // Forwarding within the webapp
                request.getRequestDispatcher("jspfile/reset-password.jsp").forward(request, response);
            } else {
                response.sendRedirect("jspfile/forgot-password.jsp?msg=notfound");
            }
        } catch (Exception e) { e.printStackTrace(); }
    }
}