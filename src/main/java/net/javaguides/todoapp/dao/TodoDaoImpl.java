package net.javaguides.todoapp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import net.javaguides.todoapp.model.Todo;
import net.javaguides.todoapp.utils.JDBCUtils;

public class TodoDaoImpl implements TodoDao {
    private static final String INSERT_TODO_SQL =
            "INSERT INTO todos (title, username, description, target_date, is_done) VALUES (?, ?, ?, ?, ?)";
    private static final String SELECT_TODO_BY_ID =
            "SELECT id, title, username, description, target_date, is_done FROM todos WHERE id = ?";
    private static final String SELECT_ALL_TODOS =
            "SELECT * FROM todos";
    private static final String SELECT_TODOS_BY_USER =
            "SELECT * FROM todos WHERE username = ?";
    private static final String DELETE_TODO =
            "DELETE FROM todos WHERE id = ?";
    private static final String UPDATE_TODO =
            "UPDATE todos SET title = ?, description = ?, target_date = ?, is_done = ? WHERE id = ?";

    @Override
    public void insertTodo(Todo todo) throws SQLException {
        try (Connection connection = JDBCUtils.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_TODO_SQL)) {

            preparedStatement.setString(1, todo.getTitle());
            preparedStatement.setString(2, todo.getUsername());
            preparedStatement.setString(3, todo.getDescription());
            preparedStatement.setDate(4, JDBCUtils.getSQLDate(todo.getTargetDate()));
            preparedStatement.setBoolean(5, todo.getStatus());

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            JDBCUtils.printSQLException(e);
            throw e;
        }
    }

    @Override
    public Todo selectTodo(long todoId) throws SQLException {
        Todo todo = null;

        try (Connection connection = JDBCUtils.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_TODO_BY_ID)) {

            preparedStatement.setLong(1, todoId);

            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    todo = extractTodoFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            JDBCUtils.printSQLException(e);
            throw e;
        }

        return todo;
    }

    @Override
    public List<Todo> selectAllTodos() throws SQLException {
        List<Todo> todos = new ArrayList<>();

        try (Connection connection = JDBCUtils.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_TODOS);
             ResultSet rs = preparedStatement.executeQuery()) {

            while (rs.next()) {
                todos.add(extractTodoFromResultSet(rs));
            }
        } catch (SQLException e) {
            JDBCUtils.printSQLException(e);
            throw e;
        }

        return todos;
    }

    @Override
    public List<Todo> selectTodosByUser(String username) throws SQLException {
        List<Todo> todos = new ArrayList<>();

        try (Connection connection = JDBCUtils.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_TODOS_BY_USER)) {

            preparedStatement.setString(1, username);

            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    todos.add(extractTodoFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            JDBCUtils.printSQLException(e);
            throw e;
        }

        return todos;
    }

    @Override
    public boolean deleteTodo(long id) throws SQLException {
        boolean rowDeleted = false;

        try (Connection connection = JDBCUtils.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_TODO)) {

            preparedStatement.setLong(1, id);
            rowDeleted = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            JDBCUtils.printSQLException(e);
            throw e;
        }

        return rowDeleted;
    }

    @Override
    public boolean updateTodo(Todo todo) throws SQLException {
        boolean rowUpdated = false;

        try (Connection connection = JDBCUtils.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_TODO)) {

            preparedStatement.setString(1, todo.getTitle());
            preparedStatement.setString(2, todo.getDescription());
            preparedStatement.setDate(3, JDBCUtils.getSQLDate(todo.getTargetDate()));
            preparedStatement.setBoolean(4, todo.getStatus());
            preparedStatement.setLong(5, todo.getId());

            rowUpdated = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            JDBCUtils.printSQLException(e);
            throw e;
        }

        return rowUpdated;
    }

    private Todo extractTodoFromResultSet(ResultSet rs) throws SQLException {
        long id = rs.getLong("id");
        String title = rs.getString("title");
        String username = rs.getString("username");
        String description = rs.getString("description");
        LocalDate targetDate = JDBCUtils.getUtilDate(rs.getDate("target_date"));
        boolean isDone = rs.getBoolean("is_done");

        return new Todo(id, title, username, description, targetDate, isDone);
    }
}