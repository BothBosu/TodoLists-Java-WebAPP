<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="<%=request.getContextPath()%>/index">
                <i class="fa-solid fa-check-circle me-2"></i>Todo App
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarNav" aria-controls="navbarNav"
                    aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <% if(session.getAttribute("username") == null) { %>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/login">
                            <i class="fa-solid fa-sign-in-alt me-1"></i> Login
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/register">
                            <i class="fa-solid fa-user-plus me-1"></i> Register
                        </a>
                    </li>
                    <% } else { %>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/todos/list">
                            <i class="fa-solid fa-list-check me-1"></i> My Todos
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/logout">
                            <i class="fa-solid fa-sign-out-alt me-1"></i> Logout
                        </a>
                    </li>
                    <li class="nav-item">
                            <span class="nav-link">
                                <i class="fa-solid fa-user me-1"></i> <%= session.getAttribute("username") %>
                            </span>
                    </li>
                    <% } %>
                </ul>
            </div>
        </div>
    </nav>
</header>