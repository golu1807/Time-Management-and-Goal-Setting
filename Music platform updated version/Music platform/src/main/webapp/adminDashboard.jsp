<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Admin Dashboard - Music Platform</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/modern.css">
</head>
<body>

<!-- Modern Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">
            <i class="bi bi-shield-check"></i> Music Platform - Admin
        </a>
        <div class="collapse navbar-collapse ms-auto" style="justify-content: flex-end;">
            <span style="color: var(--light); margin-right: 1.5rem;">
                <i class="bi bi-person-circle"></i> ${sessionScope.user.name}
            </span>
            <a href="logout" class="btn btn-danger" style="border-radius: 0.5rem;">
                <i class="bi bi-box-arrow-right"></i> Logout
            </a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <!-- Admin Header -->
    <div class="mb-5 animate-slideInUp">
        <h1 style="font-size: 2.5rem; margin-bottom: 0.5rem;">
            <i class="bi bi-speedometer2"></i> Admin Dashboard
        </h1>
        <p style="color: var(--gray); font-size: 1.1rem;">Manage users, content, and system settings</p>
    </div>

    <!-- User Management Card -->
    <div class="card mb-5 animate-slideInLeft">
        <div class="card-header">
            <h2><i class="bi bi-people"></i> User Management</h2>
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${not empty allUsers}">
                    <div style="overflow-x: auto;">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th><i class="bi bi-hash"></i> ID</th>
                                    <th><i class="bi bi-person"></i> Name</th>
                                    <th><i class="bi bi-envelope"></i> Email</th>
                                    <th><i class="bi bi-tag"></i> Role</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="user" items="${allUsers}">
                                    <tr>
                                        <td><strong>${user.id}</strong></td>
                                        <td>${user.name}</td>
                                        <td>${user.email}</td>
                                        <td>
                                            <span class="badge" style="background: var(--primary); color: var(--white);">
                                                <i class="bi bi-shield-check"></i> ${user.role}
                                            </span>
                                        </td>
                                        <td>
                                            <form action="admin/action" method="post" style="display: inline;" onsubmit="return confirm('Are you sure you want to delete this user?');">
                                                <input type="hidden" name="action" value="deleteUser">
                                                <input type="hidden" name="id" value="${user.id}">
                                                <button type="submit" class="btn btn-sm btn-outline-danger">
                                                    <i class="bi bi-trash"></i>
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="text-align: center; padding: 2rem; color: var(--gray);">
                        <i class="bi bi-inbox" style="font-size: 2rem; margin-bottom: 1rem; display: block;"></i>
                        <p>No users found.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Music Content Approval Card -->
    <div class="card mb-5 animate-slideInUp">
        <div class="card-header">
            <h2><i class="bi bi-music-note-beamed"></i> Music Content Approval</h2>
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${not empty pendingMusic}">
                    <div style="overflow-x: auto;">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th><i class="bi bi-music-note"></i> Title</th>
                                    <th><i class="bi bi-person"></i> Artist</th>
                                    <th><i class="bi bi-shield-check"></i> Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="song" items="${pendingMusic}">
                                    <tr>
                                        <td><strong>${song.title}</strong></td>
                                        <td>${song.artist}</td>
                                        <td>
                                            <span class="badge bg-warning text-dark">
                                                <i class="bi bi-hourglass-split"></i> PENDING
                                            </span>
                                        </td>
                                        <td>
                                            <form action="admin/action" method="post" style="display: inline;">
                                                <input type="hidden" name="action" value="approveMusic">
                                                <input type="hidden" name="id" value="${song.id}">
                                                <button type="submit" class="btn btn-sm btn-success">
                                                    <i class="bi bi-check-circle"></i> Approve
                                                </button>
                                            </form>
                                            <form action="admin/action" method="post" style="display: inline;" onsubmit="return confirm('Are you sure you want to reject this song?');">
                                                <input type="hidden" name="action" value="rejectMusic">
                                                <input type="hidden" name="id" value="${song.id}">
                                                <button type="submit" class="btn btn-sm btn-danger">
                                                    <i class="bi bi-x-circle"></i> Reject
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="text-align: center; padding: 2rem; color: var(--gray);">
                        <i class="bi bi-check-circle" style="font-size: 2rem; margin-bottom: 1rem; display: block; color: var(--success);"></i>
                        <p>All pending music has been reviewed!</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- System Settings Card -->
    <div class="card mb-5 animate-slideInRight">
        <div class="card-header">
            <h2><i class="bi bi-gear"></i> System Settings</h2>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6 mb-3">
                    <div style="padding: 1.5rem; border-left: 4px solid var(--primary); background: var(--light); border-radius: 0.5rem;">
                        <h6 style="color: var(--dark); margin-bottom: 0.5rem;">
                            <i class="bi bi-database"></i> Maintenance Mode
                        </h6>
                        <p style="color: var(--gray); margin: 0;">Enable or disable maintenance mode for system updates.</p>
                        <button class="btn btn-sm btn-primary mt-2">
                            <i class="bi bi-gear"></i> Configure
                        </button>
                    </div>
                </div>
                <div class="col-md-6 mb-3">
                    <div style="padding: 1.5rem; border-left: 4px solid var(--accent); background: var(--light); border-radius: 0.5rem;">
                        <h6 style="color: var(--dark); margin-bottom: 0.5rem;">
                            <i class="bi bi-shield-check"></i> Security Settings
                        </h6>
                        <p style="color: var(--gray); margin: 0;">Manage security policies and user permissions.</p>
                        <button class="btn btn-sm btn-primary mt-2">
                            <i class="bi bi-gear"></i> Configure
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
