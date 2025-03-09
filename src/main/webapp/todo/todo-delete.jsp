<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Todo | Todo Management App</title>

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
            <div class="card shadow-lg border-danger">
                <div class="card-header bg-danger text-white p-3">
                    <h4 class="mb-0">
                        <i class="fa-solid fa-trash me-2"></i> Delete Todo
                    </h4>
                </div>
                <div class="card-body p-4">
                    <h5 class="card-title mb-4">Are you sure you want to delete this todo?</h5>

                    <div class="alert alert-secondary mb-4">
                        <div class="mb-2"><strong>Title:</strong> ${todo.title}</div>
                        <div class="mb-2"><strong>Description:</strong>
                            <c:choose>
                                <c:when test="${empty todo.description}">
                                    <span class="text-muted fst-italic">No description</span>
                                </c:when>
                                <c:otherwise>
                                    ${todo.description}
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="mb-2"><strong>Target Date:</strong> ${todo.targetDate}</div>
                        <div><strong>Status:</strong>
                            <c:choose>
                                <c:when test="${todo.status}">
                                    <span class="badge rounded-pill bg-success">
                                        <i class="fa-solid fa-check me-1"></i>Complete
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge rounded-pill bg-warning text-dark">
                                        <i class="fa-solid fa-clock me-1"></i>In Progress
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <p class="text-danger mb-4">This action cannot be undone.</p>

                    <form action="${pageContext.request.contextPath}/todos/delete" method="post">
                        <input type="hidden" name="id" value="${todo.id}" />

                        <div class="d-flex justify-content-between">
                            <a href="${pageContext.request.contextPath}/todos/list" class="btn btn-secondary">
                                <i class="fa-solid fa-arrow-left me-2"></i>Cancel
                            </a>
                            <button type="submit" class="btn btn-danger">
                                <i class="fa-solid fa-trash me-2"></i>Delete
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>