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

@WebServlet("/AddExpenseServlet")
public class AddExpenseServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 1. Form se data nikalna
        double amount = Double.parseDouble(request.getParameter("amount"));
        String category = request.getParameter("category");
        String date = request.getParameter("expense_date");

        // 2. Session se User ID nikalna (Sabse important step)
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("user_id");

        try {
            Connection conn = DBConnect.getConn();
            
            // 3. Query likhna (Aapki expenses table ke columns ke hisaab se)
            String sql = "INSERT INTO expenses(user_id, amount, category, expense_date) VALUES(?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setDouble(2, amount);
            ps.setString(3, category);
            ps.setString(4, date);

            int i = ps.executeUpdate();

            if (i == 1) {
                // Success: Wapas expense page par bhej do success message ke saath
                response.sendRedirect("jspfile/expense.jsp?msg=added");
            } else {
                System.out.println("Error saving expense");
                response.sendRedirect("jspfile/expense.jsp?msg=failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}