package com.bugcheck.util;

import java.sql.Connection;
import java.sql.SQLException;
import com.bugcheck.config.DatabaseConfig;

public class TestDatabaseConnection {
    public static void main(String[] args) {
        try (Connection conn = DatabaseConfig.getConnection()) {
            if (conn != null) {
                System.out.println("Success: Database Connection Successful!");
            } else {
                System.out.println("Error: Database Connection Failed!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
