<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Dashboard - CollabBeats</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/modern.css">
            <style>
                body {
                    padding-bottom: 0 !important;
                    /* Override standard padding for dashboard layout */
                }
            </style>
        </head>

        <body>

            <!-- Sidebar -->
            <jsp:include page="includes/musician_sidebar.jsp" />

            <!-- Top Bar -->
            <div class="topbar">
                <button class="btn btn-link text-white d-lg-none me-3" id="sidebarToggle">
                    <i class="bi bi-list fs-1"></i>
                </button>
                <div class="search-box-dashboard position-relative">
                    <i class="bi bi-search"></i>
                    <input type="text" placeholder="Search tracks, users, projects...">
                </div>
                <div class="topbar-actions">
                    <button class="notification-btn">
                        <i class="bi bi-bell"></i>
                        <span class="notification-badge">3</span>
                    </button>
                    <div class="user-profile">
                        <div class="user-avatar position-relative">
                            ${sessionScope.user.name.substring(0,1)}
                            <span class="status-dot"></span>
                        </div>
                        <div>
                            <div style="font-weight: 600;">${sessionScope.user.name}</div>
                            <small style="color: rgba(255,255,255,0.6);">Online</small>
                        </div>
                        <i class="bi bi-chevron-down"></i>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div class="dashboard-content">
                <!-- Stats Section -->
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-icon"><i class="bi bi-kanban"></i></div>
                        <div class="stat-value">3</div>
                        <div class="stat-label">Total Projects</div>
                        <div class="stat-trend"><i class="bi bi-arrow-up"></i> +2 this month</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon" style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);"><i
                                class="bi bi-music-note-list"></i></div>
                        <div class="stat-value">12</div>
                        <div class="stat-label">Total Uploaded Songs</div>
                        <div class="stat-trend"><i class="bi bi-arrow-up"></i> +5 this week</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon" style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);"><i
                                class="bi bi-people"></i></div>
                        <div class="stat-value">5</div>
                        <div class="stat-label">Active Collaborations</div>
                        <div class="stat-trend"><i class="bi bi-arrow-up"></i> +1 today</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon" style="background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);"><i
                                class="bi bi-envelope"></i></div>
                        <div class="stat-value">2</div>
                        <div class="stat-label">Pending Invites</div>
                        <div class="stat-trend down"><i class="bi bi-arrow-down"></i> -1 from last week</div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="section-header">
                    <h2 class="section-title"><i class="bi bi-lightning"></i> Quick Actions</h2>
                </div>
                <div class="cta-grid">
                    <a href="${pageContext.request.contextPath}/upload.jsp" class="cta-btn upload">
                        <div class="cta-icon"><i class="bi bi-cloud-arrow-up"></i></div>
                        <div class="cta-title">Upload Music</div>
                    </a>
                    <a href="${pageContext.request.contextPath}/projects?action=create" class="cta-btn project">
                        <div class="cta-icon"><i class="bi bi-plus-circle"></i></div>
                        <div class="cta-title">Create Project</div>
                    </a>
                    <a href="${pageContext.request.contextPath}/projects" class="cta-btn workspace">
                        <div class="cta-icon"><i class="bi bi-diagram-3"></i></div>
                        <div class="cta-title">Open Workspace</div>
                    </a>
                    <a href="${pageContext.request.contextPath}/feed.jsp" class="cta-btn feed">
                        <div class="cta-icon"><i class="bi bi-chat-heart"></i></div>
                        <div class="cta-title">View Social Feed</div>
                    </a>
                </div>

                <!-- Quick Upload -->
                <div class="quick-upload"
                    onclick="window.location.href='${pageContext.request.contextPath}/upload.jsp'">
                    <i class="bi bi-file-earmark-music"
                        style="font-size: 3rem; color: #00d4ff; margin-bottom: 1rem;"></i>
                    <h4>Quick Upload</h4>
                    <p style="color: rgba(255,255,255,0.6); margin: 0.5rem 0;">Drag & drop your audio file here or click
                        to browse</p>
                    <small style="color: rgba(255,255,255,0.4);">Supported: MP3, WAV, FLAC</small>
                </div>

                <!-- 2 Column Layout -->
                <div class="grid-2col">
                    <!-- Active Collaborations -->
                    <div>
                        <div class="section-header">
                            <h3 class="section-title" style="font-size: 1.25rem;"><i class="bi bi-people"></i> Active
                                Collaborations</h3>
                            <a href="${pageContext.request.contextPath}/projects" class="view-all-btn">View All</a>
                        </div>
                        <div class="content-card">
                            <div class="project-item">
                                <div>
                                    <h6 style="margin-bottom: 0.25rem;">Summer Vibes Album</h6>
                                    <small style="color: rgba(255,255,255,0.6);">Due: Dec 15, 2024</small>
                                </div>
                                <div class="d-flex align-items-center gap-2">
                                    <div class="collaborators">
                                        <div class="collaborator-avatar">JD</div>
                                        <div class="collaborator-avatar">AS</div>
                                    </div>
                                    <span class="badge bg-success">In Progress</span>
                                </div>
                            </div>
                            <div class="project-item">
                                <div>
                                    <h6 style="margin-bottom: 0.25rem;">Rock Revival</h6>
                                    <small style="color: rgba(255,255,255,0.6);">Due: Jan 1, 2025</small>
                                </div>
                                <div class="d-flex align-items-center gap-2">
                                    <div class="collaborators">
                                        <div class="collaborator-avatar">RK</div>
                                    </div>
                                    <span class="badge bg-warning">Planning</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Recent Files -->
                    <div>
                        <div class="section-header">
                            <h3 class="section-title" style="font-size: 1.25rem;"><i class="bi bi-folder"></i> Recent
                                Files</h3>
                            <a href="${pageContext.request.contextPath}/files" class="view-all-btn">View All</a>
                        </div>
                        <div class="content-card">
                            <div class="project-item">
                                <div>
                                    <h6 style="margin-bottom: 0.25rem;">Guitar_Solo_v3.wav</h6>
                                    <small style="color: rgba(255,255,255,0.6);">Edited 2 hours ago</small>
                                </div>
                                <div class="d-flex gap-2">
                                    <button class="btn btn-sm btn-outline-light"><i class="bi bi-play"></i></button>
                                    <button class="btn btn-sm btn-outline-light"><i class="bi bi-share"></i></button>
                                </div>
                            </div>
                            <div class="project-item">
                                <div>
                                    <h6 style="margin-bottom: 0.25rem;">Vocals_Final.mp3</h6>
                                    <small style="color: rgba(255,255,255,0.6);">Edited yesterday</small>
                                </div>
                                <div class="d-flex gap-2">
                                    <button class="btn btn-sm btn-outline-light"><i class="bi bi-play"></i></button>
                                    <button class="btn btn-sm btn-outline-light"><i class="bi bi-share"></i></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Social Feed Preview -->
                <div class="section-header mt-4">
                    <h3 class="section-title"><i class="bi bi-rss"></i> Social Feed</h3>
                    <a href="${pageContext.request.contextPath}/feed.jsp" class="view-all-btn">View All</a>
                </div>
                <div class="content-card">
                    <div class="project-item">
                        <div class="d-flex align-items-center gap-2">
                            <div class="user-avatar" style="width: 45px; height: 45px;">DJ</div>
                            <div>
                                <h6 style="margin-bottom: 0.25rem;">DJ Snake</h6>
                                <small style="color: rgba(255,255,255,0.6);">uploaded "Midnight City" • 2h ago</small>
                            </div>
                        </div>
                        <div class="d-flex gap-3">
                            <span><i class="bi bi-heart"></i> 124</span>
                            <span><i class="bi bi-chat"></i> 18</span>
                            <span><i class="bi bi-arrow-repeat"></i> 32</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Docked Player -->
            <div class="docked-player">
                <div class="player-track-info">
                    <div class="player-thumbnail">
                        <i class="bi bi-music-note-beamed"></i>
                    </div>
                    <div>
                        <div style="font-weight: 600; font-size: 0.95rem;">Summer Vibes Demo</div>
                        <small style="color: rgba(255,255,255,0.6);">John Doe</small>
                    </div>
                </div>
                <div class="player-controls-docked">
                    <div class="player-buttons">
                        <button class="player-btn"><i class="bi bi-skip-backward"></i></button>
                        <button class="player-btn play"><i class="bi bi-play-fill"></i></button>
                        <button class="player-btn"><i class="bi bi-skip-forward"></i></button>
                    </div>
                    <div class="d-flex align-items-center gap-3">
                        <small>0:00</small>
                        <div class="player-seek">
                            <div class="player-progress"></div>
                        </div>
                        <small>3:24</small>
                    </div>
                </div>
                <div class="player-extra">
                    <button class="player-btn" style="font-size: 1rem;"><i class="bi bi-chat-left-text"></i></button>
                    <div class="volume-control">
                        <button class="player-btn" style="font-size: 1rem;"><i class="bi bi-volume-up"></i></button>
                        <input type="range" min="0" max="100" value="80" style="width: 100px;">
                    </div>
                    <select class="form-select form-select-sm"
                        style="width: auto; background: rgba(255,255,255,0.1); border-color: rgba(255,255,255,0.2); color: #fff;">
                        <option>1x</option>
                        <option>1.25x</option>
                        <option>1.5x</option>
                        <option>2x</option>
                    </select>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                // Sidebar Toggle
                const sidebarToggle = document.getElementById('sidebarToggle');
                const sidebar = document.querySelector('.sidebar-premium');

                if (sidebarToggle && sidebar) {
                    sidebarToggle.addEventListener('click', () => {
                        sidebar.classList.toggle('active');
                    });
                }

                // Close sidebar when clicking outside on mobile
                document.addEventListener('click', (e) => {
                    if (window.innerWidth < 992) {
                        if (!sidebar.contains(e.target) && !sidebarToggle.contains(e.target) && sidebar.classList.contains('active')) {
                            sidebar.classList.remove('active');
                        }
                    }
                });
            </script>
        </body>

        </html>

        </head>

        <body>

            <!-- Sidebar -->
            <jsp:include page="includes/musician_sidebar.jsp" />

            <!-- Top Bar -->
            <div class="topbar">
                <div class="search-box position-relative">
                    <i class="bi bi-search"></i>
                    <input type="text" placeholder="Search tracks, users, projects...">
                </div>
                <div class="topbar-actions">
                    <button class="notification-btn">
                        <i class="bi bi-bell"></i>
                        <span class="notification-badge">3</span>
                    </button>
                    <div class="user-profile">
                        <div class="user-avatar position-relative">
                            ${sessionScope.user.name.substring(0,1)}
                            <span class="status-dot"></span>
                        </div>
                        <div>
                            <div style="font-weight: 600;">${sessionScope.user.name}</div>
                            <small style="color: rgba(255,255,255,0.6);">Online</small>
                        </div>
                        <i class="bi bi-chevron-down"></i>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div class="main-content">
                <!-- Stats Section -->
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-icon"><i class="bi bi-kanban"></i></div>
                        <div class="stat-value">3</div>
                        <div class="stat-label">Total Projects</div>
                        <div class="stat-trend"><i class="bi bi-arrow-up"></i> +2 this month</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon" style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);"><i
                                class="bi bi-music-note-list"></i></div>
                        <div class="stat-value">12</div>
                        <div class="stat-label">Total Uploaded Songs</div>
                        <div class="stat-trend"><i class="bi bi-arrow-up"></i> +5 this week</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon" style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);"><i
                                class="bi bi-people"></i></div>
                        <div class="stat-value">5</div>
                        <div class="stat-label">Active Collaborations</div>
                        <div class="stat-trend"><i class="bi bi-arrow-up"></i> +1 today</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon" style="background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);"><i
                                class="bi bi-envelope"></i></div>
                        <div class="stat-value">2</div>
                        <div class="stat-label">Pending Invites</div>
                        <div class="stat-trend down"><i class="bi bi-arrow-down"></i> -1 from last week</div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="section-header">
                    <h2 class="section-title"><i class="bi bi-lightning"></i> Quick Actions</h2>
                </div>
                <div class="cta-grid">
                    <a href="${pageContext.request.contextPath}/upload.jsp" class="cta-btn upload">
                        <div class="cta-icon"><i class="bi bi-cloud-arrow-up"></i></div>
                        <div class="cta-title">Upload Music</div>
                    </a>
                    <a href="${pageContext.request.contextPath}/projects?action=create" class="cta-btn project">
                        <div class="cta-icon"><i class="bi bi-plus-circle"></i></div>
                        <div class="cta-title">Create Project</div>
                    </a>
                    <a href="${pageContext.request.contextPath}/projects" class="cta-btn workspace">
                        <div class="cta-icon"><i class="bi bi-diagram-3"></i></div>
                        <div class="cta-title">Open Workspace</div>
                    </a>
                    <a href="${pageContext.request.contextPath}/feed.jsp" class="cta-btn feed">
                        <div class="cta-icon"><i class="bi bi-chat-heart"></i></div>
                        <div class="cta-title">View Social Feed</div>
                    </a>
                </div>

                <!-- Quick Upload -->
                <div class="quick-upload"
                    onclick="window.location.href='${pageContext.request.contextPath}/upload.jsp'">
                    <i class="bi bi-file-earmark-music"
                        style="font-size: 3rem; color: #00d4ff; margin-bottom: 1rem;"></i>
                    <h4>Quick Upload</h4>
                    <p style="color: rgba(255,255,255,0.6); margin: 0.5rem 0;">Drag & drop your audio file here or click
                        to browse</p>
                    <small style="color: rgba(255,255,255,0.4);">Supported: MP3, WAV, FLAC</small>
                </div>

                <!-- 2 Column Layout -->
                <div class="grid-2col">
                    <!-- Active Collaborations -->
                    <div>
                        <div class="section-header">
                            <h3 class="section-title" style="font-size: 1.25rem;"><i class="bi bi-people"></i> Active
                                Collaborations</h3>
                            <a href="${pageContext.request.contextPath}/projects" class="view-all-btn">View All</a>
                        </div>
                        <div class="content-card">
                            <div class="project-item">
                                <div>
                                    <h6 style="margin-bottom: 0.25rem;">Summer Vibes Album</h6>
                                    <small style="color: rgba(255,255,255,0.6);">Due: Dec 15, 2024</small>
                                </div>
                                <div class="d-flex align-items-center gap-2">
                                    <div class="collaborators">
                                        <div class="collaborator-avatar">JD</div>
                                        <div class="collaborator-avatar">AS</div>
                                    </div>
                                    <span class="badge bg-success">In Progress</span>
                                </div>
                            </div>
                            <div class="project-item">
                                <div>
                                    <h6 style="margin-bottom: 0.25rem;">Rock Revival</h6>
                                    <small style="color: rgba(255,255,255,0.6);">Due: Jan 1, 2025</small>
                                </div>
                                <div class="d-flex align-items-center gap-2">
                                    <div class="collaborators">
                                        <div class="collaborator-avatar">RK</div>
                                    </div>
                                    <span class="badge bg-warning">Planning</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Recent Files -->
                    <div>
                        <div class="section-header">
                            <h3 class="section-title" style="font-size: 1.25rem;"><i class="bi bi-folder"></i> Recent
                                Files</h3>
                            <a href="${pageContext.request.contextPath}/files" class="view-all-btn">View All</a>
                        </div>
                        <div class="content-card">
                            <div class="project-item">
                                <div>
                                    <h6 style="margin-bottom: 0.25rem;">Guitar_Solo_v3.wav</h6>
                                    <small style="color: rgba(255,255,255,0.6);">Edited 2 hours ago</small>
                                </div>
                                <div class="d-flex gap-2">
                                    <button class="btn btn-sm btn-outline-light"><i class="bi bi-play"></i></button>
                                    <button class="btn btn-sm btn-outline-light"><i class="bi bi-share"></i></button>
                                </div>
                            </div>
                            <div class="project-item">
                                <div>
                                    <h6 style="margin-bottom: 0.25rem;">Vocals_Final.mp3</h6>
                                    <small style="color: rgba(255,255,255,0.6);">Edited yesterday</small>
                                </div>
                                <div class="d-flex gap-2">
                                    <button class="btn btn-sm btn-outline-light"><i class="bi bi-play"></i></button>
                                    <button class="btn btn-sm btn-outline-light"><i class="bi bi-share"></i></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Social Feed Preview -->
                <div class="section-header mt-4">
                    <h3 class="section-title"><i class="bi bi-rss"></i> Social Feed</h3>
                    <a href="${pageContext.request.contextPath}/feed.jsp" class="view-all-btn">View All</a>
                </div>
                <div class="content-card">
                    <div class="project-item">
                        <div class="d-flex align-items-center gap-2">
                            <div class="user-avatar" style="width: 45px; height: 45px;">DJ</div>
                            <div>
                                <h6 style="margin-bottom: 0.25rem;">DJ Snake</h6>
                                <small style="color: rgba(255,255,255,0.6);">uploaded "Midnight City" • 2h ago</small>
                            </div>
                        </div>
                        <div class="d-flex gap-3">
                            <span><i class="bi bi-heart"></i> 124</span>
                            <span><i class="bi bi-chat"></i> 18</span>
                            <span><i class="bi bi-arrow-repeat"></i> 32</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Docked Player -->
            <div class="docked-player">
                <div class="player-track-info">
                    <div class="player-thumbnail">
                        <i class="bi bi-music-note-beamed"></i>
                    </div>
                    <div>
                        <div style="font-weight: 600; font-size: 0.95rem;">Summer Vibes Demo</div>
                        <small style="color: rgba(255,255,255,0.6);">John Doe</small>
                    </div>
                </div>
                <div class="player-controls">
                    <div class="player-buttons">
                        <button class="player-btn"><i class="bi bi-skip-backward"></i></button>
                        <button class="player-btn play"><i class="bi bi-play-fill"></i></button>
                        <button class="player-btn"><i class="bi bi-skip-forward"></i></button>
                    </div>
                    <div class="d-flex align-items-center gap-3">
                        <small>0:00</small>
                        <div class="player-seek">
                            <div class="player-progress"></div>
                        </div>
                        <small>3:24</small>
                    </div>
                </div>
                <div class="player-extra">
                    <button class="player-btn" style="font-size: 1rem;"><i class="bi bi-chat-left-text"></i></button>
                    <div class="volume-control">
                        <button class="player-btn" style="font-size: 1rem;"><i class="bi bi-volume-up"></i></button>
                        <input type="range" min="0" max="100" value="80" style="width: 100px;">
                    </div>
                    <select class="form-select form-select-sm"
                        style="width: auto; background: rgba(255,255,255,0.1); border-color: rgba(255,255,255,0.2); color: #fff;">
                        <option>1x</option>
                        <option>1.25x</option>
                        <option>1.5x</option>
                        <option>2x</option>
                    </select>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>