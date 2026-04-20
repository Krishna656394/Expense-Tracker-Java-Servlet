package com.tracker.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.tracker.db.DBConnect;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // JSP Form se data nikalna
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dob");
        String city = request.getParameter("city");
        String password = request.getParameter("password");

        // Session use kar rahe hain error messages dikhane ke liye
        HttpSession session = request.getSession();

        try {
            Connection conn = DBConnect.getConn();
            
            // Sabse Important: Connection check
            if (conn == null) {
                session.setAttribute("errorMsg", "Database Connection Failed! Check Cloud DB.");
                response.sendRedirect("register.jsp"); // Ya jo bhi aapka register page ka path hai
                return;
            }

            // Query logic
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
                session.setAttribute("succMsg", "Registration Successfully!");
                response.sendRedirect("login.jsp"); // Folder structure ke hisaab se path check karein
            } else {
                session.setAttribute("errorMsg", "Something went wrong on server!");
                response.sendRedirect("register.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "Exception: " + e.getMessage());
            response.sendRedirect("register.jsp");
        }
    }
}
