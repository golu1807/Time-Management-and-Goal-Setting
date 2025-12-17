<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Listener Dashboard - Music Platform</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/modern.css">
            <style>
                body {
                    padding-bottom: 0 !important;
                }
            </style>
        </head>

        <body>

            <!-- Sidebar -->
            <div class="sidebar">
                <div class="sidebar-logo">
                    <h3><i class="bi bi-soundwave"></i> MusicApp</h3>
                </div>
                <nav class="nav flex-column">
                    <a class="nav-item active" href="listenerDashboard.jsp"><i class="bi bi-grid"></i> Dashboard</a>
                    <a class="nav-item" href="${pageContext.request.contextPath}/upload.jsp"><i
                            class="bi bi-cloud-arrow-up"></i> Upload</a>
                    <a class="nav-item" href="${pageContext.request.contextPath}/feed.jsp"><i class="bi bi-rss"></i>
                        Social Feed</a>
                    <a class="nav-item" href="${pageContext.request.contextPath}/collab.jsp"><i
                            class="bi bi-kanban"></i> Projects <span class="badge bg-primary ms-2"
                            style="font-size: 0.6rem;">NEW</span></a>
                    <a class="nav-item" href="messages.jsp"><i class="bi bi-chat-dots"></i> Messages</a>
                    <a class="nav-item" href="#player"><i class="bi bi-headphones"></i> Music Player</a>
                    <a class="nav-item" href="${pageContext.request.contextPath}/library"><i class="bi bi-disc"></i>
                        Portfolio</a>
                    <a class="nav-item" href="notifications.jsp"><i class="bi bi-bell"></i> Notifications</a>
                    <a class="nav-item mt-5" href="logout"><i class="bi bi-box-arrow-right"></i> Logout</a>
                </nav>
            </div>

            <!-- Top Bar -->
            <div class="topbar">
                <button class="btn btn-link text-white d-lg-none me-3" id="sidebarToggle">
                    <i class="bi bi-list fs-1"></i>
                </button>
                <div class="search-box-dashboard position-relative">
                    <i class="bi bi-search"></i>
                    <input type="text" placeholder="Search songs, artists, albums...">
                </div>
                <div class="topbar-actions">
                    <button class="notification-btn">
                        <i class="bi bi-bell"></i>
                        <c:if test="${not empty notifications}">
                            <span class="notification-badge">${notifications.size()}</span>
                        </c:if>
                    </button>
                    <div class="user-profile">
                        <div class="user-avatar position-relative">
                            ${sessionScope.user.name.substring(0,1)}
                            <span class="status-dot"></span>
                        </div>
                        <div>
                            <div style="font-weight: 600;">${sessionScope.user.name}</div>
                            <small style="color: rgba(255,255,255,0.6);">Listener</small>
                        </div>
                        <i class="bi bi-chevron-down"></i>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div class="dashboard-content">

                <!-- Personalized Greeting -->
                <% java.util.Calendar cal=java.util.Calendar.getInstance(); int
                    hour=cal.get(java.util.Calendar.HOUR_OF_DAY); String greeting="Good Morning" ; if(hour>= 12 && hour
                    < 17) greeting="Good Afternoon" ; else if(hour>= 17) greeting = "Good Evening";
                        %>
                        <div class="mb-4 fade-in">
                            <h2
                                style="font-weight: 700; background: linear-gradient(90deg, #fff, #a1a1aa); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">
                                <%= greeting %>, ${sessionScope.user.name}
                            </h2>
                            <p style="color: rgba(255,255,255,0.6);">Here's what's happening in your music world today.
                            </p>
                        </div>

                        <!-- Listener Stats / Quick View -->
                        <div class="stats-grid">
                            <div class="stat-card">
                                <div class="stat-icon"><i class="bi bi-clock-history"></i></div>
                                <div class="stat-value">24</div>
                                <div class="stat-label">Hours Listened</div>
                                <div class="stat-trend"><i class="bi bi-arrow-up"></i> +4h this week</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-icon"
                                    style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);"><i
                                        class="bi bi-heart-fill"></i></div>
                                <div class="stat-value">150</div>
                                <div class="stat-label">Liked Songs</div>
                                <div class="stat-trend"><i class="bi bi-arrow-up"></i> +12 recently</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-icon"
                                    style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);"><i
                                        class="bi bi-collection"></i></div>
                                <div class="stat-value">8</div>
                                <div class="stat-label">Playlists</div>
                                <div class="stat-trend">Created by you</div>
                            </div>
                        </div>

                        <!-- Discover Section with Trending (Horizontal) and New Releases (Grid) -->
                        <div class="mb-5">
                            <div class="section-header">
                                <h3 class="section-title"><i class="bi bi-fire"></i> Trending Now</h3>
                                <a href="#" class="view-all-btn">View Chart</a>
                            </div>
                            <!-- Horizontal Scroll Container -->
                            <div class="horizontal-scroll">
                                <c:choose>
                                    <c:when test="${not empty allMusic}">
                                        <c:forEach var="song" items="${allMusic}" begin="0" end="4">
                                            <div class="trending-card">
                                                <div class="trending-img">
                                                    <i class="bi bi-music-note-beamed"></i>
                                                </div>
                                                <h6
                                                    style="font-weight: 600; margin-bottom: 0.2rem; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                                    ${song.title}</h6>
                                                <small style="color: rgba(255,255,255,0.6);">${song.artist}</small>
                                                <div class="mt-2">
                                                    <button class="btn btn-sm btn-primary rounded-circle"
                                                        onclick="playTrack(${song.id}, '${song.title}', '${song.artist}')"><i
                                                            class="bi bi-play-fill"></i></button>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <p style="color: rgba(255,255,255,0.5);">No trending songs.</p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <!-- Section: Active Projects (Unified Integration) -->
                        <div class="mb-5">
                            <div class="section-header">
                                <h3 class="section-title"><i class="bi bi-kanban"></i> Your Projects</h3>
                                <a href="${pageContext.request.contextPath}/collab.jsp" class="view-all-btn">Go to
                                    Room</a>
                            </div>
                            <div class="row g-3">
                                <c:choose>
                                    <c:when test="${not empty userProjects}">
                                        <c:forEach var="project" items="${userProjects}">
                                            <div class="col-md-4">
                                                <div class="project-item h-100 d-flex flex-column justify-content-between p-3"
                                                    style="background: rgba(255,255,255,0.05); border-radius: 12px;">
                                                    <div>
                                                        <div
                                                            class="d-flex justify-content-between align-items-center mb-2">
                                                            <h6 class="mb-0 text-white">${project.title}</h6>
                                                            <span class="badge bg-primary text-white"
                                                                style="font-size: 0.6rem;">ACTIVE</span>
                                                        </div>
                                                        <p class="text-white-50 small mb-2">${project.description}</p>
                                                    </div>
                                                    <div class="d-flex justify-content-between align-items-center mt-3">
                                                        <small class="text-secondary"><i class="bi bi-clock"></i> Due:
                                                            ${project.deadline}</small>
                                                        <a href="collab.jsp?projectId=${project.id}"
                                                            class="btn btn-sm btn-outline-light rounded-pill">Open</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Mock Projects if list empty for demo -->
                                        <div class="col-md-4">
                                            <div class="project-item p-3"
                                                style="background: rgba(255,255,255,0.05); border-radius: 12px;">
                                                <h6 class="text-white mb-1">Summer Vibes Demo</h6>
                                                <small class="text-white-50">Last active: 2h ago</small>
                                                <a href="collab.jsp" class="btn btn-sm btn-primary w-100 mt-3">Open
                                                    Studio</a>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="project-item p-3 d-flex align-items-center justify-content-center"
                                                style="border: 2px dashed rgba(255,255,255,0.1); border-radius: 12px; height: 100%;">
                                                <a href="${pageContext.request.contextPath}/projects?action=create"
                                                    class="text-white text-decoration-none">
                                                    <i class="bi bi-plus-lg me-2"></i> New Project
                                                </a>
                                            </div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <!-- Section: Social Feed (Integrated Grid) -->
                        <div class="mb-5">
                            <div class="section-header">
                                <h3 class="section-title"><i class="bi bi-rss"></i> Community Feed</h3>
                                <a href="${pageContext.request.contextPath}/feed.jsp" class="view-all-btn">View All</a>
                            </div>
                            <!-- Reusing the 2-col grid but with card styling -->
                            <div class="row g-4">
                                <c:choose>
                                    <c:when test="${not empty allMusic}">
                                        <c:forEach var="song" items="${allMusic}" begin="0" end="5">
                                            <div class="col-6 col-md-4 col-lg-3">
                                                <div class="feed-card position-relative"
                                                    style="background: rgba(255,255,255,0.05); border-radius: 12px; overflow: hidden;">
                                                    <div
                                                        style="height: 150px; background: #333; display: flex; align-items: center; justify-content: center;">
                                                        <i class="bi bi-music-note-beamed text-white-50 fs-1"></i>
                                                    </div>
                                                    <div class="play-overlay"
                                                        onclick="playTrack(${song.id}, '${song.title}', '${song.artist}')"
                                                        style="position: absolute; top: 130px; right: 10px; width: 40px; height: 40px; background: var(--primary-color); border-radius: 50%; display: flex; align-items: center; justify-content: center; cursor: pointer;">
                                                        <i class="bi bi-play-fill text-dark fs-5"></i>
                                                    </div>
                                                    <div class="p-3">
                                                        <h6 class="text-white text-truncate mb-1">${song.title}</h6>
                                                        <small class="text-white-50">${song.artist}</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="text-muted">No community posts yet.</p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <!-- Listening History -->
                        <div>
                            <div class="section-header">
                                <h3 class="section-title"><i class="bi bi-clock-history"></i> Recently Played
                                </h3>
                            </div>
                            <div class="content-card">
                                <c:choose>
                                    <c:when test="${not empty listeningHistory}">
                                        <div style="max-height: 400px; overflow-y: auto;">
                                            <c:forEach var="historySong" items="${listeningHistory}">
                                                <div class="project-item">
                                                    <div>
                                                        <h6 style="margin-bottom: 0.25rem;">${historySong.title}
                                                        </h6>
                                                        <small
                                                            style="color: rgba(255,255,255,0.6);">${historySong.artist}</small>
                                                    </div>
                                                    <button class="btn btn-sm btn-outline-light rounded-circle"
                                                        style="width: 32px; height: 32px; padding: 0;"
                                                        onclick="playTrack(${historySong.id}, '${historySong.title}', '${historySong.artist}')">
                                                        <i class="bi bi-play-fill"></i>
                                                    </button>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div style="text-align: center; padding: 2rem; color: rgba(255,255,255,0.5);">
                                            <p>Start listening to build your history!</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <!-- My Playlists -->
                            <div class="section-header mt-4">
                                <h3 class="section-title"><i class="bi bi-collection"></i> My
                                    Playlists</h3>
                                <button class="view-all-btn" data-bs-toggle="modal"
                                    data-bs-target="#createPlaylistModal">New</button>
                            </div>
                            <div class="content-card">
                                <c:choose>
                                    <c:when test="${not empty userPlaylists}">
                                        <c:forEach var="playlist" items="${userPlaylists}">
                                            <div class="project-item">
                                                <h6 style="margin-bottom: 0;">${playlist.title}</h6>
                                                <a href="${pageContext.request.contextPath}/playlist?id=${playlist.id}"
                                                    class="btn btn-sm btn-outline-light"><i
                                                        class="bi bi-arrow-right"></i></a>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div style="text-align: center; padding: 1rem; color: rgba(255,255,255,0.5);">
                                            <p>No playlists yet.</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
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
                        <div id="currentTrackTitle" style="font-weight: 600; font-size: 0.95rem;">Select
                            a song</div>
                        <small id="currentTrackArtist" style="color: rgba(255,255,255,0.6);">...</small>
                    </div>
                </div>
                <div class="player-controls-docked">
                    <div class="player-buttons">
                        <button class="player-btn"><i class="bi bi-skip-backward"></i></button>
                        <button class="player-btn play" id="playPauseBtn"><i class="bi bi-play-fill"></i></button>
                        <button class="player-btn"><i class="bi bi-skip-forward"></i></button>
                    </div>
                    <div class="d-flex align-items-center gap-3" style="width: 100%;">
                        <small id="currentTime">0:00</small>
                        <div class="player-seek">
                            <div class="player-progress" id="progressBar"></div>
                            <!-- Waveform Animation Placeholder -->
                            <div class="waveform-container"
                                style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; pointer-events: none; opacity: 0.3;">
                                <div class="waveform-bar" style="animation-delay: 0.1s;"></div>
                                <div class="waveform-bar" style="animation-delay: 0.2s;"></div>
                                <div class="waveform-bar" style="animation-delay: 0.5s;"></div>
                                <div class="waveform-bar" style="animation-delay: 0.3s;"></div>
                                <div class="waveform-bar" style="animation-delay: 0.7s;"></div>
                                <div class="waveform-bar" style="animation-delay: 0.4s;"></div>
                                <div class="waveform-bar" style="animation-delay: 0.1s;"></div>
                                <div class="waveform-bar" style="animation-delay: 0.2s;"></div>
                                <div class="waveform-bar" style="animation-delay: 0.5s;"></div>
                                <div class="waveform-bar" style="animation-delay: 0.3s;"></div>
                            </div>
                            <input type="range" id="seekSlider" min="0" max="100" value="0"
                                style="position: absolute; width: 100%; height: 100%; opacity: 0; cursor: pointer; top:0;">
                        </div>
                        <small id="duration">0:00</small>
                    </div>
                </div>
                <div class="player-extra">
                    <div class="player-controls-extra me-3">
                        <button class="player-btn-small" title="Lyrics"><i class="bi bi-mic"></i></button>
                        <button class="player-btn-small" title="Queue"><i class="bi bi-list-ul"></i></button>
                    </div>
                    <button class="player-btn-small" id="likeBtn"><i class="bi bi-heart"></i></button>
                    <div class="volume-control">
                        <button class="player-btn" style="font-size: 1rem;"><i class="bi bi-volume-up"></i></button>
                        <input type="range" min="0" max="100" value="80" style="width: 100px;">
                    </div>
                </div>
            </div>

            <!-- Create Playlist Modal -->
            <div class="modal fade" id="createPlaylistModal" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content card-glass">
                        <div class="modal-header border-0">
                            <h5 class="modal-title">New Playlist</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <form action="${pageContext.request.contextPath}/playlist" method="post">
                            <div class="modal-body">
                                <input type="hidden" name="action" value="create">
                                <div class="mb-3">
                                    <label class="form-label">Playlist Name</label>
                                    <input type="text" class="form-control" name="title" required
                                        placeholder="My Awesome Playlist"
                                        style="background: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.2); color: white;">
                                </div>
                            </div>
                            <div class="modal-footer border-0">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-primary">Create</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Add to Playlist Modal -->
            <div class="modal fade" id="addToPlaylistModal" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content card-glass">
                        <div class="modal-header border-0">
                            <h5 class="modal-title">Add to Playlist</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <form id="addToPlaylistForm" action="${pageContext.request.contextPath}/playlist" method="post">
                            <div class="modal-body">
                                <input type="hidden" name="action" value="addSong">
                                <input type="hidden" id="musicIdToAdd" name="musicId">
                                <label class="form-label">Select Playlist</label>
                                <select class="form-select" name="playlistId" required
                                    style="background: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.2); color: white;">
                                    <option value="" style="color: black;">Choose...</option>
                                    <c:forEach var="playlist" items="${userPlaylists}">
                                        <option value="${playlist.id}" style="color: black;">
                                            ${playlist.title}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="modal-footer border-0">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-primary">Add</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                // Sidebar Toggle
                const sidebarToggle = document.getElementById('sidebarToggle');
                const sidebar = document.querySelector('.sidebar');

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

                // Player Logic
                let currentTrack = null;
                let audio = new Audio();
                const playPauseBtn = document.getElementById('playPauseBtn');
                const progressBar = document.getElementById('progressBar');
                const seekSlider = document.getElementById('seekSlider');
                const playIcon = '<i class="bi bi-play-fill"></i>';
                const pauseIcon = '<i class="bi bi-pause-fill"></i>';

                function playTrack(id, title, artist) {
                    currentTrack = { id, title, artist };
                    audio.src = '${pageContext.request.contextPath}/stream?id=' + id;
                    audio.play();
                    document.getElementById('currentTrackTitle').textContent = title;
                    document.getElementById('currentTrackArtist').textContent = artist;
                    playPauseBtn.innerHTML = pauseIcon;
                }

                playPauseBtn.addEventListener('click', function () {
                    if (audio.paused && audio.src) {
                        audio.play();
                        this.innerHTML = pauseIcon;
                    } else if (audio.src) {
                        audio.pause();
                        this.innerHTML = playIcon;
                    }
                });

                audio.addEventListener('timeupdate', function () {
                    if (audio.duration) {
                        const progress = (audio.currentTime / audio.duration) * 100;
                        progressBar.style.width = progress + '%';
                        seekSlider.value = progress;
                        document.getElementById('currentTime').textContent = formatTime(audio.currentTime);
                        document.getElementById('duration').textContent = formatTime(audio.duration);
                    }
                });

                seekSlider.addEventListener('input', function () {
                    if (audio.duration) {
                        const seekTime = (this.value / 100) * audio.duration;
                        audio.currentTime = seekTime;
                    }
                });

                function formatTime(seconds) {
                    const mins = Math.floor(seconds / 60);
                    const secs = Math.floor(seconds % 60);
                    return mins + ':' + (secs < 10 ? '0' : '') + secs;
                }

                document.getElementById('likeBtn').addEventListener('click', function () {
                    if (currentTrack) {
                        fetch('${pageContext.request.contextPath}/like?id=' + currentTrack.id, { method: 'POST' })
                            .then(response => {
                                if (response.ok) {
                                    const heartIcon = this.querySelector('i');
                                    heartIcon.classList.toggle('bi-heart');
                                    heartIcon.classList.toggle('bi-heart-fill');
                                    this.style.color = heartIcon.classList.contains('bi-heart-fill') ? '#ec4899' : 'white';
                                }
                            });
                    }
                });

                // Add to Playlist
                const addToPlaylistModal = new bootstrap.Modal(document.getElementById('addToPlaylistModal'));
                function addToPlaylist(musicId) {
                    document.getElementById('musicIdToAdd').value = musicId;
                    addToPlaylistModal.show();
                }
            </script>
        </body>

        </html>