package net.javaguides.todoapp.web;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/error-404")
public class NotFoundErrorHandler extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processError(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processError(request, response);
    }

    private void processError(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("username") != null) {
            // User is authenticated, redirect to their todo list
            response.sendRedirect(request.getContextPath() + "/todos/list");
        } else {
            // User is not authenticated, show the general error page
            request.setAttribute("errorMessage", "The page you requested could not be found.");
            request.getRequestDispatcher("/Error.jsp").forward(request, response);
        }
    }
}