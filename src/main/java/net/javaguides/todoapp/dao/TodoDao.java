package net.javaguides.todoapp.dao;

import java.sql.SQLException;
import java.util.List;

import net.javaguides.todoapp.model.Todo;

public interface TodoDao {
    void insertTodo(Todo todo) throws SQLException;

    Todo selectTodo(long todoId) throws SQLException;

    List<Todo> selectAllTodos() throws SQLException;

    List<Todo> selectTodosByUser(String username) throws SQLException;

    boolean deleteTodo(long id) throws SQLException;

    boolean updateTodo(Todo todo) throws SQLException;
}