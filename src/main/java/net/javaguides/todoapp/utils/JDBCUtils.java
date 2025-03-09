package net.javaguides.todoapp.utils;

import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;

import org.apache.commons.dbcp2.BasicDataSource;

public class JDBCUtils {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/todo_management";
    private static final String JDBC_USERNAME = "todoapp";
    private static final String JDBC_PASSWORD = "Admin@123";

    private static BasicDataSource dataSource;

    static {
        // Initialize connection pool
        dataSource = new BasicDataSource();
        dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
        dataSource.setUrl(JDBC_URL);
        dataSource.setUsername(JDBC_USERNAME);
        dataSource.setPassword(JDBC_PASSWORD);

        // Connection pool configuration
        dataSource.setInitialSize(5);           // Initial connections
        dataSource.setMaxTotal(20);             // Maximum total connections
        dataSource.setMaxIdle(10);              // Maximum idle connections
        dataSource.setMinIdle(5);               // Minimum idle connections
        dataSource.setMaxWaitMillis(10000);     // Maximum wait time in milliseconds
        dataSource.setValidationQuery("SELECT 1");
        dataSource.setTestOnBorrow(true);       // Validate connections on borrow
    }

    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }

    public static void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }

    public static Date getSQLDate(LocalDate date) {
        return date != null ? java.sql.Date.valueOf(date) : null;
    }

    public static LocalDate getUtilDate(Date sqlDate) {
        return sqlDate != null ? sqlDate.toLocalDate() : null;
    }

    // Method to safely close the data source
    public static void closeDataSource() throws SQLException {
        if (dataSource != null) {
            dataSource.close();
        }
    }
}