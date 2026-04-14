package com.tracker.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.tracker.db.DBConnect;

@WebServlet("/AdminRegisterServlet")
public class AdminRegisterServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Form se data nikalna
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String pass = request.getParameter("password");
        String secretKey = request.getParameter("secret_key");

        // 2. Secret Key Check (Ise aap apni marzi se badal sakte hain)
        String systemKey = "KRISHNA@123"; 

        if (secretKey != null && secretKey.equals(systemKey)) {
            try {
                Connection conn = DBConnect.getConn();
                
                // Query: role column mein '1' (Admin) insert ho raha hai
             // Query mein 'mobile' column add karein
                String sql = "INSERT INTO users(name, email, password, mobile, role) VALUES(?,?,?,?,?)";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, pass);
                ps.setString(4, "0000000000"); // Dummy mobile number for Admin
                ps.setInt(5, 1); // Role 1 for Admin

                int i = ps.executeUpdate();

                if (i == 1) {
                    // Success: Login page par bhejo message ke saath
                    response.sendRedirect("jspfile/login.jsp?msg=admin_success");
                } else {
                    // Fail: Wapas signup page par
                    response.sendRedirect("jspfile/admin_signup.jsp?msg=failed");
                }

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("jspfile/admin_signup.jsp?msg=error");
            }
        } else {
            // Agar Secret Key galat hai
            response.sendRedirect("jspfile/admin_signup.jsp?msg=invalid_key");
        }
    }
}
