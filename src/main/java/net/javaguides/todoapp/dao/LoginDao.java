package net.javaguides.todoapp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.mindrot.jbcrypt.BCrypt;

import net.javaguides.todoapp.model.LoginBean;
import net.javaguides.todoapp.utils.JDBCUtils;

public class LoginDao {
    private static final String SELECT_USER_SQL = "SELECT password FROM users WHERE username = ?";

    public boolean validate(LoginBean loginBean) throws SQLException {
        boolean status = false;

        try (Connection connection = JDBCUtils.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_USER_SQL)) {

            preparedStatement.setString(1, loginBean.getUsername());

            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    // Get stored hashed password
                    String storedHash = rs.getString("password");

                    // Verify password with BCrypt
                    status = BCrypt.checkpw(loginBean.getPassword(), storedHash);
                }
            }
        } catch (SQLException e) {
            JDBCUtils.printSQLException(e);
            throw e;
        }
        return status;
    }
}