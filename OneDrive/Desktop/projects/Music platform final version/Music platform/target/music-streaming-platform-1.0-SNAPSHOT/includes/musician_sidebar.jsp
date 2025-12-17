<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!-- Premium Sidebar -->
    <div class="sidebar-premium d-flex flex-column flex-shrink-0 text-white">
        <div class="sidebar-logo">
            <h3><i class="bi bi-soundwave"></i> CollabBeats</h3>
        </div>

        <div class="d-flex flex-column flex-grow-1 overflow-auto">
            <a href="${pageContext.request.contextPath}/dashboard"
                class="nav-item ${pageContext.request.requestURI.endsWith('/dashboard') ? 'active' : ''}">
                <i class="bi bi-speedometer2"></i>
                <span>Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/upload.jsp"
                class="nav-item ${pageContext.request.requestURI.endsWith('upload.jsp') ? 'active' : ''}">
                <i class="bi bi-cloud-arrow-up"></i>
                <span>Upload</span>
            </a>
            <a href="${pageContext.request.contextPath}/feed.jsp"
                class="nav-item ${pageContext.request.requestURI.endsWith('feed.jsp') ? 'active' : ''}">
                <i class="bi bi-rss"></i>
                <span>Social Feed</span>
            </a>
            <a href="${pageContext.request.contextPath}/projects"
                class="nav-item ${pageContext.request.requestURI.contains('project') ? 'active' : ''}">
                <i class="bi bi-kanban"></i>
                <span>Projects</span>
            </a>
            <a href="${pageContext.request.contextPath}/messages.jsp"
                class="nav-item ${pageContext.request.requestURI.endsWith('messages.jsp') ? 'active' : ''}">
                <i class="bi bi-chat-dots"></i>
                <span>Messages</span>
            </a>
            <a href="${pageContext.request.contextPath}/player.jsp"
                class="nav-item ${pageContext.request.requestURI.endsWith('player.jsp') ? 'active' : ''}">
                <i class="bi bi-headphones"></i>
                <span>Music Player</span>
            </a>
            <a href="${pageContext.request.contextPath}/albums"
                class="nav-item ${pageContext.request.requestURI.contains('album') ? 'active' : ''}">
                <i class="bi bi-disc"></i>
                <span>Portfolio</span>
            </a>
            <a href="${pageContext.request.contextPath}/notifications.jsp"
                class="nav-item ${pageContext.request.requestURI.endsWith('notifications.jsp') ? 'active' : ''}">
                <i class="bi bi-bell"></i>
                <span>Notifications</span>
                <span class="badge bg-danger rounded-pill ms-auto" style="font-size: 0.7rem;">3</span>
            </a>
            <a href="${pageContext.request.contextPath}/settings.jsp"
                class="nav-item ${pageContext.request.requestURI.endsWith('settings.jsp') ? 'active' : ''}">
                <i class="bi bi-gear"></i>
                <span>Settings</span>
            </a>
        </div>

        <div class="p-3 border-top border-secondary">
            <div class="dropdown">
                <a href="#" class="d-flex align-items-center text-white text-decoration-none dropdown-toggle"
                    id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
                    <div class="avatar-sm bg-primary text-white rounded-circle d-flex align-items-center justify-content-center me-2"
                        style="width:32px; height:32px; font-weight: bold;">
                        ${sessionScope.user.name.substring(0,1)}
                    </div>
                    <strong>${sessionScope.user.name}</strong>
                </a>
                <ul class="dropdown-menu dropdown-menu-dark text-small shadow" aria-labelledby="dropdownUser1">
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/albums">My Portfolio</a></li>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/settings.jsp">Settings</a>
                    </li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Sign out</a></li>
                </ul>
            </div>
        </div>
    </div>