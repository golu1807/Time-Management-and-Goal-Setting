<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <div class="sidebar d-flex flex-column flex-shrink-0 p-3 text-white bg-dark"
        style="width: 280px; height: 100vh; position: fixed; top: 0; left: 0; z-index: 1000;">
        <a href="${pageContext.request.contextPath}/dashboard"
            class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
            <i class="bi bi-soundwave fs-4 me-2 text-danger"></i>
            <span class="fs-4 fw-bold">CollabBeats</span>
        </a>
        <hr>
        <ul class="nav nav-pills flex-column mb-auto">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/dashboard"
                    class="nav-link text-white ${pageContext.request.requestURI.endsWith('/dashboard') ? 'active bg-danger' : ''}"
                    aria-current="page">
                    <i class="bi bi-speedometer2 me-2"></i>
                    Dashboard
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/users"
                    class="nav-link text-white ${pageContext.request.requestURI.endsWith('/users') ? 'active bg-danger' : ''}">
                    <i class="bi bi-people me-2"></i>
                    User Management
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/moderation"
                    class="nav-link text-white ${pageContext.request.requestURI.endsWith('/moderation') ? 'active bg-danger' : ''}">
                    <i class="bi bi-shield-check me-2"></i>
                    Content Moderation
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/settings"
                    class="nav-link text-white ${pageContext.request.requestURI.endsWith('/settings') ? 'active bg-danger' : ''}">
                    <i class="bi bi-gear me-2"></i>
                    System Settings
                </a>
            </li>
        </ul>
        <hr>
        <div class="dropdown">
            <a href="#" class="d-flex align-items-center text-white text-decoration-none dropdown-toggle"
                id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
                <img src="https://github.com/mdo.png" alt="" width="32" height="32" class="rounded-circle me-2">
                <strong>${sessionScope.user.name}</strong>
            </a>
            <ul class="dropdown-menu dropdown-menu-dark text-small shadow" aria-labelledby="dropdownUser1">
                <li><a class="dropdown-item" href="#">Profile</a></li>
                <li>
                    <hr class="dropdown-divider">
                </li>
                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Sign out</a></li>
            </ul>
        </div>
    </div>