<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Collaboration Room - Music Platform</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/modern.css">
        </head>

        <body>

            <!-- Sidebar -->
            <div class="sidebar">
                <div class="sidebar-logo">
                    <h3><i class="bi bi-soundwave"></i> MusicApp</h3>
                </div>
                <nav class="nav flex-column">
                    <a class="nav-item" href="dashboard"><i class="bi bi-grid"></i> Dashboard</a>
                    <a class="nav-item" href="${pageContext.request.contextPath}/search"><i class="bi bi-compass"></i>
                        Discover</a>
                    <a class="nav-item" href="${pageContext.request.contextPath}/library"><i
                            class="bi bi-collection-play"></i> Your Library</a>
                    <a class="nav-item" href="${pageContext.request.contextPath}/favorites"><i class="bi bi-heart"></i>
                        Favorites</a>
                    <a class="nav-item active" href="${pageContext.request.contextPath}/collab.jsp"><i
                            class="bi bi-people-fill"></i> Collab Room</a>
                    <a class="nav-item" href="${pageContext.request.contextPath}/feed.jsp"><i
                            class="bi bi-chat-square-text"></i> Community</a>
                    <a class="nav-item" href="${pageContext.request.contextPath}/settings.jsp"><i
                            class="bi bi-gear"></i> Settings</a>
                    <a class="nav-item mt-5" href="logout"><i class="bi bi-box-arrow-right"></i> Logout</a>
                </nav>
            </div>

            <!-- Top Bar -->
            <div class="topbar">
                <div class="search-box-dashboard position-relative">
                    <i class="bi bi-search"></i>
                    <input type="text" placeholder="Search projects, stems, collaborators...">
                </div>
                <div class="topbar-actions">
                    <!-- Reuse topbar content -->
                    <button class="notification-btn"><i class="bi bi-bell"></i></button>
                    <div class="user-profile">
                        <div class="user-avatar">${sessionScope.user.name.substring(0,1)}</div>
                        <div>
                            <div style="font-weight: 600;">${sessionScope.user.name}</div>
                            <small>Collab Mode</small>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div class="dashboard-content position-relative" style="overflow: hidden; height: 100vh;">
                <!-- Cursor Render Layer -->
                <div class="cursor-layer"></div>

                <div class="mb-3">
                    <h2 style="font-weight: 700; color: #fff;">Collab Room <span
                            style="font-size: 0.5em; vertical-align: middle;" class="badge bg-success">LIVE</span></h2>
                </div>

                <div class="collab-grid position-relative">
                    <!-- Left: Active Projects -->
                    <div class="collab-panel">
                        <div class="panel-header">
                            Active Projects <i class="bi bi-plus-circle" style="cursor: pointer;"></i>
                        </div>
                        <div class="panel-body">
                            <div class="project-item"
                                style="cursor: pointer; background: rgba(0, 212, 255, 0.1); border-left: 3px solid #00d4ff;">
                                <div>
                                    <h6 class="mb-0">Neon Nights</h6>
                                    <small class="text-white-50">Last active: 2m ago</small>
                                </div>
                            </div>
                            <div class="project-item" style="cursor: pointer;">
                                <div>
                                    <h6 class="mb-0">Summer Vibe</h6>
                                    <small class="text-white-50">Last active: 1h ago</small>
                                </div>
                            </div>
                            <div class="project-item" style="cursor: pointer;">
                                <div>
                                    <h6 class="mb-0">Lo-Fi Study</h6>
                                    <small class="text-white-50">Created yesterday</small>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Middle: Workspace / Visualizer -->
                    <div class="collab-panel">
                        <div class="panel-header">
                            <span><i class="bi bi-soundwave"></i> Workspace: Neon Nights</span>
                            <div>
                                <button class="btn btn-sm btn-outline-light me-2"><i class="bi bi-cloud-upload"></i>
                                    Stems</button>
                                <button class="btn btn-sm btn-primary"><i class="bi bi-play-fill"></i> Preview</button>
                            </div>
                        </div>
                        <div class="panel-body d-flex flex-column justify-content-center align-items-center"
                            style="background: rgba(0,0,0,0.3);">
                            <!-- Mock DAW UI -->
                            <div style="width: 100%; height: 60px; background: rgba(255,255,255,0.05); margin-bottom: 10px; border-radius: 5px; position: relative;"
                                onclick="window.collabClient.requestLock(101)">
                                <span
                                    style="position: absolute; left: 10px; top: 20px; font-size: 0.8rem; color: #aaa;">Drums</span>
                                <div
                                    style="position: absolute; left: 80px; top: 10px; height: 40px; width: 60%; background: #ff4b4b; opacity: 0.6; border-radius: 4px;">
                                </div>
                            </div>
                            <div
                                style="width: 100%; height: 60px; background: rgba(255,255,255,0.05); margin-bottom: 10px; border-radius: 5px; position: relative;">
                                <span
                                    style="position: absolute; left: 10px; top: 20px; font-size: 0.8rem; color: #aaa;">Bass</span>
                                <div
                                    style="position: absolute; left: 80px; top: 10px; height: 40px; width: 70%; background: #4bffa5; opacity: 0.6; border-radius: 4px;">
                                </div>
                            </div>
                            <div
                                style="width: 100%; height: 60px; background: rgba(255,255,255,0.05); margin-bottom: 10px; border-radius: 5px; position: relative;">
                                <span
                                    style="position: absolute; left: 10px; top: 20px; font-size: 0.8rem; color: #aaa;">Synth</span>
                                <div
                                    style="position: absolute; left: 200px; top: 10px; height: 40px; width: 40%; background: #4b9fff; opacity: 0.6; border-radius: 4px;">
                                </div>
                            </div>

                            <p class="mt-4 text-white-50"><i class="bi bi-info-circle"></i> Click tracks to simulate
                                Lock Request</p>
                        </div>
                    </div>

                    <!-- Right: Team Chat -->
                    <div class="collab-panel">
                        <div class="panel-header">
                            Team Chat <i class="bi bi-people"></i>
                        </div>
                        <div class="panel-body">
                            <!-- Chat messages injected by JS -->
                        </div>
                        <div class="chat-input-area">
                            <input type="text" class="form-control bg-dark text-white border-secondary"
                                placeholder="Type a message...">
                            <button class="btn btn-primary"><i class="bi bi-send"></i></button>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script src="${pageContext.request.contextPath}/assets/js/collab-client.js"></script>
            <script>
                document.addEventListener('DOMContentLoaded', () => {
                    // Initialize Client
                    const projectId = 101;
                    const userId = ${ sessionScope.user.id };
                    const username = "${sessionScope.user.name}";
                    console.log("Initializing CollabClient for", username);

                    const client = new CollabClient(projectId, userId, username);
                    window.collabClient = client; // Expose for onclick handlers

                    // Connect with dummy token
                    client.connect("valid-token-123");

                    // Hook up Chat Input
                    const chatInput = document.querySelector('.chat-input-area input');
                    const sendBtn = document.querySelector('.chat-input-area button');

                    function sendChat() {
                        const text = chatInput.value.trim();
                        if (text) {
                            client.sendMessage("CHAT", { message: text });
                            chatInput.value = '';
                        }
                    }

                    sendBtn.addEventListener('click', sendChat);
                    chatInput.addEventListener('keypress', (e) => {
                        if (e.key === 'Enter') sendChat();
                    });
                });
            </script>
        </body>

        </html>