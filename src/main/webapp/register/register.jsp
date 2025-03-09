<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | Todo Management App</title>

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
</head>
<body class="d-flex flex-column min-vh-100">
<jsp:include page="../common/header.jsp"></jsp:include>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-6 col-md-8">
            <div class="card shadow-lg">
                <div class="card-header bg-primary text-white p-3">
                    <h4 class="mb-0">
                        <i class="fa-solid fa-user-plus me-2"></i> Register
                    </h4>
                </div>
                <div class="card-body p-4">
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger mb-4" role="alert">
                            <i class="fa-solid fa-circle-exclamation me-2"></i>${errorMessage}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/register" method="post">
                        <div class="row mb-3">
                            <div class="col-md-6 mb-3 mb-md-0">
                                <label for="firstName" class="form-label">First Name</label>
                                <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fa-solid fa-user"></i>
                                        </span>
                                    <input type="text" class="form-control" id="firstName" name="firstName"
                                           placeholder="Enter your first name" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label for="lastName" class="form-label">Last Name</label>
                                <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fa-solid fa-user"></i>
                                        </span>
                                    <input type="text" class="form-control" id="lastName" name="lastName"
                                           placeholder="Enter your last name" required>
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="username" class="form-label">Username</label>
                            <div class="input-group">
                                    <span class="input-group-text bg-light">
                                        <i class="fa-solid fa-at"></i>
                                    </span>
                                <input type="text" class="form-control" id="username" name="username"
                                       placeholder="Choose a username" required>
                            </div>
                            <div class="form-text">Username must be unique and will be used for login.</div>
                        </div>

                        <div class="mb-4">
                            <label for="password" class="form-label">Password</label>
                            <div class="input-group">
                                    <span class="input-group-text bg-light">
                                        <i class="fa-solid fa-lock"></i>
                                    </span>
                                <input type="password" class="form-control" id="password" name="password"
                                       placeholder="Choose a password" required
                                       pattern=".{6,}" title="Password must be at least 6 characters">
                            </div>
                            <div class="form-text">Password must be at least 6 characters long.</div>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary btn-lg">
                                <i class="fa-solid fa-user-plus me-2"></i>Register
                            </button>
                        </div>
                    </form>
                </div>
                <div class="card-footer bg-light text-center p-3">
                    <p class="mb-0">
                        Already have an account?
                        <a href="${pageContext.request.contextPath}/login" class="text-decoration-none">
                            Log in here
                        </a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>