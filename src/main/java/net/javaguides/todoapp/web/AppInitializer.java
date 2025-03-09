package net.javaguides.todoapp.utils;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.sql.Connection;
import java.sql.SQLException;

@WebListener
public class AppInitializer implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("Todo Management Application starting up...");
        try {
            // Test the connection pool by getting and releasing a connection
            Connection conn = JDBCUtils.getConnection();
            conn.close();
            System.out.println("Database connection pool initialized successfully");
        } catch (SQLException e) {
            System.err.println("ERROR: Failed to initialize database connection: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("Todo Management Application shutting down...");
        try {
            JDBCUtils.closeDataSource();
            System.out.println("Database connection pool closed successfully");
        } catch (SQLException e) {
            System.err.println("ERROR: Failed to close database connection pool: " + e.getMessage());
            e.printStackTrace();
        }
    }
}