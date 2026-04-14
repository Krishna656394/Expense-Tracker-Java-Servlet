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

@WebServlet("/DeleteExpenseServlet")
public class DeleteExpenseServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // URL se 'id' nikalna (e.g., DeleteExpenseServlet?id=5)
        int id = Integer.parseInt(request.getParameter("id"));

        try {
            Connection conn = DBConnect.getConn();
            String sql = "DELETE FROM expenses WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            int i = ps.executeUpdate();

            if (i == 1) {
                // Delete hone ke baad wapas wahi bhej do
                response.sendRedirect("jspfile/expense.jsp?msg=deleted");
            } else {
                response.sendRedirect("jspfile/expense.jsp?msg=error");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

