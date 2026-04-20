package com.tracker.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class DBConnect {
    public static Connection getConn() {
        Connection conn = null;
        try {
            String host = "bldljwy8nuxdhla5azw2-mysql.services.clever-cloud.com";
            String dbName = "bldljwy8nuxdhla5azw2";
            String u = "umxacjpeylofccnr"; 
            String p = "1uUC6x1cihFvxSmgUyEZ"; 

            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://" + host + ":3306/" + dbName + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

            conn = DriverManager.getConnection(url, u, p);
            
            if (conn != null) {
                System.out.println("Cloud DB Connected!");
                createTables(conn); // Yahan se table banenge
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }

    private static void createTables(Connection conn) {
        try {
            Statement st = conn.createStatement();
            
            // 1. Users Table
            st.executeUpdate("CREATE TABLE IF NOT EXISTS users ("
                + "id INT AUTO_INCREMENT PRIMARY KEY, "
                + "name VARCHAR(255), email VARCHAR(255), mobile VARCHAR(15), "
                + "gender VARCHAR(10), dob DATE, city VARCHAR(100), "
                + "password VARCHAR(255), role INT DEFAULT 0, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)");

            // 2. Expenses Table
            st.executeUpdate("CREATE TABLE IF NOT EXISTS expenses ("
                + "id INT AUTO_INCREMENT PRIMARY KEY, user_id INT, amount DOUBLE, "
                + "category VARCHAR(100), expense_date DATE, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)");

            // 3. Budget Table
            st.executeUpdate("CREATE TABLE IF NOT EXISTS budget ("
                + "id INT AUTO_INCREMENT PRIMARY KEY, user_id INT, total_budget DOUBLE, "
                + "month INT, year INT)");

            System.out.println("All Tables Verified/Created Successfully!");
        } catch (Exception e) {
            System.out.println("Table creation failed, maybe they already exist.");
        }
    }
}
