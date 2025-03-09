<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome | Todo Management App</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
          crossorigin="anonymous">

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
          integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
          crossorigin="anonymous"
          referrerpolicy="no-referrer">

    <style>
        .hero-section {
            background-color: #f8f9fa;
            padding: 5rem 0;
        }
        .feature-card {
            transition: transform 0.3s ease;
        }
        .feature-card:hover {
            transform: translateY(-5px);
        }
        .feature-icon {
            font-size: 2.5rem;
            margin-bottom: 1.5rem;
            color: #0d6efd;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">
<jsp:include page="/common/header.jsp"></jsp:include>

<!-- Hero Section -->
<section class="hero-section">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-6 mb-5 mb-lg-0">
                <h1 class="display-4 fw-bold mb-3">Organize Your Tasks with Ease</h1>
                <p class="lead mb-4">A simple and intuitive todo management application to keep track of your tasks and boost your productivity.</p>
                <div class="d-grid gap-2 d-md-flex justify-content-md-start">
                    <c:choose>
                        <c:when test="${sessionScope.username != null}">
                            <a href="${pageContext.request.contextPath}/todos/list" class="btn btn-primary btn-lg px-4">
                                <i class="fa-solid fa-list-check me-2"></i>My Todo List
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-primary btn-lg px-4 me-md-2">
                                <i class="fa-solid fa-sign-in-alt me-2"></i>Sign In
                            </a>
                            <a href="${pageContext.request.contextPath}/register" class="btn btn-outline-secondary btn-lg px-4">
                                <i class="fa-solid fa-user-plus me-2"></i>Register
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
<%--            <div class="col-lg-6">--%>
<%--                <img src="https://via.placeholder.com/600x400" class="img-fluid rounded shadow-lg" alt="Todo App Dashboard">--%>
<%--            </div>--%>
        </div>
    </div>
</section>

<!-- Features Section -->
<section class="py-5">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="fw-bold">App Features</h2>
            <p class="lead text-muted">Everything you need to stay organized and productive</p>
        </div>

        <div class="row g-4">
            <div class="col-md-4">
                <div class="card h-100 border-0 shadow-sm feature-card">
                    <div class="card-body text-center p-4">
                        <i class="fa-solid fa-check-circle feature-icon"></i>
                        <h4 class="card-title mb-3">Task Management</h4>
                        <p class="card-text">Create, update, and delete tasks with ease. Set deadlines and priorities to stay on track.</p>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card h-100 border-0 shadow-sm feature-card">
                    <div class="card-body text-center p-4">
                        <i class="fa-solid fa-user-shield feature-icon"></i>
                        <h4 class="card-title mb-3">Secure Access</h4>
                        <p class="card-text">Your todo list is private and secure. Login with your credentials to access your tasks.</p>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card h-100 border-0 shadow-sm feature-card">
                    <div class="card-body text-center p-4">
                        <i class="fa-solid fa-mobile-alt feature-icon"></i>
                        <h4 class="card-title mb-3">Responsive Design</h4>
                        <p class="card-text">Access your todos from any device - desktop, tablet, or mobile. Stay productive on the go.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="/common/footer.jsp"></jsp:include>
</body>
</html>