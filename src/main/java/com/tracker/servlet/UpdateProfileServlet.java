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

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String mobile = request.getParameter("mobile");
        String city = request.getParameter("city");

        HttpSession session = request.getSession();
        int uid = (int) session.getAttribute("user_id");

        try {
            Connection conn = DBConnect.getConn();
            String sql = "UPDATE users SET name=?, mobile=?, city=? WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, mobile);
            ps.setString(3, city);
            ps.setInt(4, uid);

            int i = ps.executeUpdate();
            if(i == 1) {
                // Session mein bhi name update kar dete hain taaki Dashboard pe naya naam dikhe
                session.setAttribute("user_name", name);
                response.sendRedirect("jspfile/profile.jsp?msg=success");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
