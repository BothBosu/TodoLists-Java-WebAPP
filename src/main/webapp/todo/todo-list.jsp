<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Todos | Todo Management App</title>

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

    <!-- Custom styles -->
    <style>
        .todo-complete {
            text-decoration: line-through;
            color: #6c757d;
        }
        .badge-status {
            font-size: 0.9rem;
        }
        .btn-action-group {
            display: flex;
            gap: 0.25rem;
        }
        .form-inline {
            display: inline;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">
<jsp:include page="../common/header.jsp"></jsp:include>

<div class="container py-5">
    <div class="row mb-4">
        <div class="col-md-8">
            <h2><i class="fa-solid fa-list-check me-2"></i>My Todo List</h2>
            <p class="text-muted">Manage your tasks and stay organized</p>
        </div>
        <div class="col-md-4 text-md-end d-flex align-items-center justify-content-md-end mt-3 mt-md-0">
            <a href="${pageContext.request.contextPath}/todos/new" class="btn btn-primary">
                <i class="fa-solid fa-plus me-2"></i>Add New Todo
            </a>
        </div>
    </div>

    <div class="card shadow-sm">
        <div class="card-body p-0">
            <c:choose>
                <c:when test="${empty listTodo}">
                    <div class="text-center py-5">
                        <i class="fa-solid fa-clipboard-check text-muted mb-3" style="font-size: 3rem;"></i>
                        <h4 class="text-muted">You don't have any todos yet</h4>
                        <p>Click the "Add New Todo" button to create your first task.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead class="table-light">
                            <tr>
                                <th scope="col">Title</th>
                                <th scope="col">Description</th>
                                <th scope="col">Target Date</th>
                                <th scope="col">Status</th>
                                <th scope="col" class="text-center">Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="todo" items="${listTodo}">
                                <tr>
                                    <td class="${todo.status ? 'todo-complete' : ''}">${todo.title}</td>
                                    <td class="${todo.status ? 'todo-complete' : ''}">
                                        <c:choose>
                                            <c:when test="${empty todo.description}">
                                                <span class="text-muted fst-italic">No description</span>
                                            </c:when>
                                            <c:otherwise>
                                                ${todo.description}
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${todo.targetDate}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${todo.status}">
                                                <span class="badge rounded-pill bg-success badge-status">
                                                    <i class="fa-solid fa-check me-1"></i>Complete
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge rounded-pill bg-warning text-dark badge-status">
                                                    <i class="fa-solid fa-clock me-1"></i>In Progress
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <div class="btn-action-group">
                                            <!-- Mark/Unmark as completed form -->
                                            <form action="${pageContext.request.contextPath}/todos/toggle-status" method="post" class="form-inline">
                                                <input type="hidden" name="id" value="${todo.id}">
                                                <c:choose>
                                                    <c:when test="${todo.status}">
                                                        <button type="submit" class="btn btn-sm btn-outline-warning">
                                                            <i class="fa-solid fa-clock me-1"></i> Mark as In Progress
                                                        </button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button type="submit" class="btn btn-sm btn-outline-success">
                                                            <i class="fa-solid fa-check me-1"></i> Mark as Completed
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </form>

                                            <!-- Edit button -->
                                            <a href="${pageContext.request.contextPath}/todos/edit?id=${todo.id}" class="btn btn-sm btn-primary">
                                                <i class="fa-solid fa-edit"></i> Edit
                                            </a>

                                            <!-- Delete button -->
                                            <a href="${pageContext.request.contextPath}/todos/delete-confirm?id=${todo.id}" class="btn btn-sm btn-danger">
                                                <i class="fa-solid fa-trash"></i> Delete
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>