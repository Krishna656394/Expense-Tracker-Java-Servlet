package com.tracker.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnect {
    public static Connection getConn() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Database naam 'expense_tracker' hona chahiye (pichle log mein '_db' extra tha)
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/expense_tracker", "root", "Krishna@2004");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}