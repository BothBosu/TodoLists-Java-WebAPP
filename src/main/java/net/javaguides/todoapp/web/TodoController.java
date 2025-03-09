package net.javaguides.todoapp.web;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import net.javaguides.todoapp.dao.TodoDao;
import net.javaguides.todoapp.dao.TodoDaoImpl;
import net.javaguides.todoapp.model.Todo;

@WebServlet("/todos/*")
public class TodoController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TodoDao todoDAO;

    public void init() {
        todoDAO = new TodoDaoImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String pathInfo = request.getPathInfo();
        String action = pathInfo != null ? pathInfo : "/list";

        try {
            switch (action) {
                case "/insert":
                    insertTodo(request, response);
                    break;
                case "/update":
                    updateTodo(request, response);
                    break;
                case "/delete":
                    deleteTodo(request, response);
                    break;
                case "/toggle-status":
                    toggleTodoStatus(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/todos/list");
                    break;
            }
        } catch (SQLException ex) {
            request.setAttribute("errorMessage", "Database error: " + ex.getMessage());
            request.getRequestDispatcher("/Error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String pathInfo = request.getPathInfo();
        String action = pathInfo != null ? pathInfo : "/list";

        try {
            switch (action) {
                case "/new":
                    showNewForm(request, response);
                    break;
                case "/edit":
                    showEditForm(request, response);
                    break;
                case "/delete-confirm":
                    showDeleteForm(request, response);
                    break;
                case "/list":
                    listTodos(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/todos/list");
                    break;
            }
        } catch (SQLException ex) {
            request.setAttribute("errorMessage", "Database error: " + ex.getMessage());
            request.getRequestDispatcher("/Error.jsp").forward(request, response);
        }
    }

    private void listTodos(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        List<Todo> listTodo = todoDAO.selectTodosByUser(username);
        request.setAttribute("listTodo", listTodo);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/todo/todo-list.jsp");
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/todo/todo-form.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        // Get the todo ID
        long id = Long.parseLong(request.getParameter("id"));

        // Get the todo
        Todo existingTodo = todoDAO.selectTodo(id);

        // Security check - users can only edit their own todos
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (existingTodo == null || !existingTodo.getUsername().equals(username)) {
            // Either todo doesn't exist or doesn't belong to this user
            response.sendRedirect(request.getContextPath() + "/todos/list");
            return;
        }

        // Set todo in request and forward to form
        request.setAttribute("todo", existingTodo);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/todo/todo-form.jsp");
        dispatcher.forward(request, response);
    }

    private void showDeleteForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        // Get the todo ID
        long id = Long.parseLong(request.getParameter("id"));

        // Get the todo
        Todo existingTodo = todoDAO.selectTodo(id);

        // Security check - users can only delete their own todos
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (existingTodo == null || !existingTodo.getUsername().equals(username)) {
            // Either todo doesn't exist or doesn't belong to this user
            response.sendRedirect(request.getContextPath() + "/todos/list");
            return;
        }

        // Set todo in request and forward to delete confirmation form
        request.setAttribute("todo", existingTodo);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/todo/todo-delete.jsp");
        dispatcher.forward(request, response);
    }

    private void insertTodo(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        // Get current user
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        // Get form data
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        LocalDate targetDate = LocalDate.parse(request.getParameter("targetDate"));
        boolean isDone = "true".equals(request.getParameter("isDone"));

        // Create new todo
        Todo newTodo = new Todo(title, username, description, targetDate, isDone);
        todoDAO.insertTodo(newTodo);

        // Redirect to list
        response.sendRedirect(request.getContextPath() + "/todos/list");
    }

    private void updateTodo(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        // Get todo ID
        long id = Long.parseLong(request.getParameter("id"));

        // Get current user
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        // Get current todo
        Todo existingTodo = todoDAO.selectTodo(id);

        // Security check - users can only update their own todos
        if (existingTodo == null || !existingTodo.getUsername().equals(username)) {
            response.sendRedirect(request.getContextPath() + "/todos/list");
            return;
        }

        // Get form data
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        LocalDate targetDate = LocalDate.parse(request.getParameter("targetDate"));
        boolean isDone = "true".equals(request.getParameter("isDone"));

        // Update todo
        existingTodo.setTitle(title);
        existingTodo.setDescription(description);
        existingTodo.setTargetDate(targetDate);
        existingTodo.setStatus(isDone);

        todoDAO.updateTodo(existingTodo);

        // Redirect to list
        response.sendRedirect(request.getContextPath() + "/todos/list");
    }

    private void deleteTodo(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        // Get todo ID
        long id = Long.parseLong(request.getParameter("id"));

        // Get current user
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        // Get todo
        Todo existingTodo = todoDAO.selectTodo(id);

        // Security check - users can only delete their own todos
        if (existingTodo != null && existingTodo.getUsername().equals(username)) {
            todoDAO.deleteTodo(id);
        }

        // Redirect to list
        response.sendRedirect(request.getContextPath() + "/todos/list");
    }

    private void toggleTodoStatus(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        // Get todo ID
        long id = Long.parseLong(request.getParameter("id"));

        // Get current user
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        // Get todo
        Todo existingTodo = todoDAO.selectTodo(id);

        // Security check - users can only update their own todos
        if (existingTodo != null && existingTodo.getUsername().equals(username)) {
            // Toggle the status
            existingTodo.setStatus(!existingTodo.getStatus());
            todoDAO.updateTodo(existingTodo);
        }

        // Redirect to list
        response.sendRedirect(request.getContextPath() + "/todos/list");
    }
}