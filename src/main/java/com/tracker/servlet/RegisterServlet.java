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

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // JSP Form se data nikalna (name attributes match hone chahiye)
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dob");
        String city = request.getParameter("city");
        String password = request.getParameter("password");

        try {
            Connection conn = DBConnect.getConn();
            // Query match kar rahi hai aapki nayi 'users' table se
            String sql = "INSERT INTO users(name, email, mobile, gender, dob, city, password) VALUES(?,?,?,?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, mobile);
            ps.setString(4, gender);
            ps.setString(5, dob);
            ps.setString(6, city);
            ps.setString(7, password);

            int i = ps.executeUpdate();

            if (i == 1) {
                // Register hone ke baad seedha login page par bhej rahe hain
                response.sendRedirect("jspfile/login.jsp");
            } else {
                System.out.println("Registration failed!");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}