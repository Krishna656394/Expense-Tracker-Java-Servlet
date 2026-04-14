package com.tracker.servlet;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.tracker.db.DBConnect;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");

        try {
            Connection conn = DBConnect.getConn();
            PreparedStatement ps = conn.prepareStatement("UPDATE users SET password=? WHERE email=?");
            ps.setString(1, newPassword);
            ps.setString(2, email);

            int i = ps.executeUpdate();
            if (i == 1) {
                // Redirect back to login in the folder
                response.sendRedirect("jspfile/login.jsp?msg=updated");
            } else {
                response.sendRedirect("jspfile/forgot-password.jsp?msg=failed");
            }
        } catch (Exception e) { e.printStackTrace(); }
    }
}