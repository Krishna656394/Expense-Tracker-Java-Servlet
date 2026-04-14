package com.tracker.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.tracker.db.DBConnect;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Connection conn = DBConnect.getConn();
            String sql = "SELECT * FROM users WHERE email=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // 1. Session create karein
                HttpSession session = request.getSession();
                
                // 2. Role check karein (0 ya 1)
                int role = rs.getInt("role"); 

                // 3. User ki details session mein save karein
                session.setAttribute("user_id", rs.getInt("id"));
                session.setAttribute("user_name", rs.getString("name"));
                session.setAttribute("user_email", rs.getString("email"));
                session.setAttribute("user_role", role); // Role save karna zaroori hai
                
                // 4. Conditional Redirect
                if (role == 1) {
                    // Agar Admin hai toh Admin Dashboard
                    response.sendRedirect("jspfile/admin_dashboard.jsp");
                } else {
                    // Agar Normal User hai toh Dashboard
                    response.sendRedirect("jspfile/dashboard.jsp");
                }
            } else {
                // Galat login: Wapas login page par bhejo
                response.sendRedirect("jspfile/login.jsp?msg=invalid");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}