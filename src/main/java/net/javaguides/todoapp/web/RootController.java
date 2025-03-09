package net.javaguides.todoapp.web;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("")
public class RootController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            // Not authenticated, redirect to login
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            // User is authenticated, forward to todos list or index
            response.sendRedirect(request.getContextPath() + "/todos/todo-list");
        }
    }
}