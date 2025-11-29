<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Listener Dashboard - Music Platform</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/modern.css">
</head>
<body style="padding-bottom: 100px;">

<!-- Modern Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="dashboard">
            <i class="bi bi-music-note-beamed"></i> Music Platform
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <span style="color: var(--light); margin-right: 1.5rem;">
                        <i class="bi bi-person-circle"></i> ${sessionScope.user.name}
                    </span>
                </li>
                <li class="nav-item">
                    <a href="logout" class="btn btn-danger" style="border-radius: 0.5rem;">
                        <i class="bi bi-box-arrow-right"></i> Logout
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <div class="row">
        <!-- Main Content Area -->
        <div class="col-lg-8">
            <!-- Music Discovery Card -->
            <div class="card mb-4 animate-slideInLeft">
                <div class="card-header">
                    <h2><i class="bi bi-compass"></i> Discover Music</h2>
                </div>
                <div class="card-body">
                    <form action="search" method="get" class="search-box mb-4">
                        <input class="form-control" type="search" name="query" placeholder="Search songs, artists, albums..." required>
                        <button class="btn btn-primary" type="submit">
                            <i class="bi bi-search"></i> Search
                        </button>
                    </form>
                    
                    <!-- Song List -->
                    <div style="max-height: 500px; overflow-y: auto;">
                        <c:choose>
                            <c:when test="${not empty allMusic}">
                                <c:forEach var="song" items="${allMusic}" varStatus="status">
                                    <div class="list-group-item mb-2" style="display: flex; justify-content: space-between; align-items: center; padding: 1rem; border-radius: 0.5rem; background: var(--light); transition: all 0.3s;">
                                        <div style="flex: 1;">
                                            <h6 class="mb-0" style="color: var(--dark); font-weight: 600;">
                                                <i class="bi bi-music-note"></i> ${song.title}
                                            </h6>
                                            <small style="color: var(--gray);">
                                                <i class="bi bi-person"></i> ${song.artist} • <i class="bi bi-disc"></i> ${song.album}
                                            </small>
                                        </div>
                                        <div style="display: flex; gap: 0.5rem;">
                                            <button class="btn btn-sm btn-primary" onclick="playTrack(${song.id}, '${song.title}', '${song.artist}')" title="Play">
                                                <i class="bi bi-play-fill"></i>
                                            </button>
                                            <button class="btn btn-sm btn-outline-primary" onclick="addToPlaylist(${song.id})" title="Add to Playlist">
                                                <i class="bi bi-plus-lg"></i>
                                            </button>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div style="text-align: center; padding: 2rem; color: var(--gray);">
                                    <i class="bi bi-music-note-beamed" style="font-size: 2rem; margin-bottom: 1rem; display: block;"></i>
                                    <p>No songs available. Check back soon!</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- Listening History Card -->
            <div class="card mb-4 animate-slideInUp">
                <div class="card-header">
                    <h2><i class="bi bi-clock-history"></i> Recently Played</h2>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${not empty listeningHistory}">
                            <c:forEach var="historySong" items="${listeningHistory}">
                                <div class="list-group-item mb-2" style="display: flex; justify-content: space-between; align-items: center; padding: 1rem; border-radius: 0.5rem; background: var(--light);">
                                    <div>
                                        <h6 class="mb-0" style="color: var(--dark); font-weight: 600;">
                                            <i class="bi bi-music-note"></i> ${historySong.title}
                                        </h6>
                                        <small style="color: var(--gray);">
                                            <i class="bi bi-person"></i> ${historySong.artist}
                                        </small>
                                    </div>
                                    <button class="btn btn-sm btn-primary" onclick="playTrack(${historySong.id}, '${historySong.title}', '${historySong.artist}')">
                                        <i class="bi bi-play-fill"></i> Play
                                    </button>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div style="text-align: center; padding: 2rem; color: var(--gray);">
                                <p>No listening history yet. Start playing songs!</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- Sidebar -->
        <div class="col-lg-4">
            <!-- Playlists Card -->
            <div class="card mb-4 animate-slideInRight">
                <div class="card-header">
                    <h2><i class="bi bi-collection"></i> My Playlists</h2>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${not empty userPlaylists}">
                            <div style="max-height: 300px; overflow-y: auto;">
                                <c:forEach var="playlist" items="${userPlaylists}">
                                    <div class="list-group-item mb-2" style="display: flex; justify-content: space-between; align-items: center;">
                                        <div style="flex: 1;">
                                            <strong style="color: var(--dark);">
                                                <i class="bi bi-collection"></i> ${playlist.title}
                                            </strong>
                                        </div>
                                        <a href="playlist?id=${playlist.id}" class="btn btn-sm btn-outline-primary">
                                            <i class="bi bi-arrow-right"></i>
                                        </a>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div style="text-align: center; padding: 1rem; color: var(--gray);">
                                <p style="margin-bottom: 1rem;">No playlists yet. Create your first one!</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <button class="btn btn-primary w-100 mt-3" data-bs-toggle="modal" data-bs-target="#createPlaylistModal" style="border-radius: 0.5rem;">
                        <i class="bi bi-plus-lg"></i> New Playlist
                    </button>
                </div>
            </div>

            <!-- Followed Artists Card -->
            <div class="card mb-4 animate-slideInRight" style="animation-delay: 0.1s;">
                <div class="card-header">
                    <h2><i class="bi bi-people"></i> Following</h2>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${not empty followedArtists}">
                            <div style="max-height: 300px; overflow-y: auto;">
                                <c:forEach var="artist" items="${followedArtists}">
                                    <div class="list-group-item mb-2">
                                        <strong style="color: var(--dark);">
                                            <i class="bi bi-mic"></i> ${artist.name}
                                        </strong>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div style="text-align: center; padding: 1rem; color: var(--gray);">
                                <p>You're not following any artists yet.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modern Music Player Footer -->
<footer class="player-footer fixed-bottom">
    <div class="container-fluid">
        <div style="display: flex; align-items: center; gap: 1.5rem;">
            <!-- Current Track Info -->
            <div style="flex: 1; min-width: 0;">
                <div id="currentTrack" style="color: var(--white); font-weight: 500; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                    <i class="bi bi-music-note-beamed"></i> No track selected
                </div>
            </div>
            
            <!-- Player Controls -->
            <div class="player-controls">
                <button id="prevBtn" class="btn btn-link text-white" title="Previous">
                    <i class="bi bi-skip-backward-fill"></i>
                </button>
                <button id="playPauseBtn" class="btn btn-link text-white" title="Play/Pause">
                    <i class="bi bi-play-fill"></i>
                </button>
                <button id="nextBtn" class="btn btn-link text-white" title="Next">
                    <i class="bi bi-skip-forward-fill"></i>
                </button>
                <button id="likeBtn" class="btn btn-link text-white" title="Like">
                    <i class="bi bi-heart"></i>
                </button>
            </div>
            
            <!-- Progress and Time -->
            <div style="flex: 1; display: flex; align-items: center; gap: 1rem;">
                <span id="currentTime" style="color: var(--light); font-size: 0.875rem; min-width: 40px;">0:00</span>
                <input type="range" id="progressBar" class="form-range" min="0" max="100" value="0" style="flex: 1;">
            </div>
        </div>
    </div>
</footer>

<!-- Create Playlist Modal -->
<div class="modal fade" id="createPlaylistModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header" style="background: var(--gradient-primary); color: var(--white); border: none;">
                <h5 class="modal-title">
                    <i class="bi bi-collection"></i> Create New Playlist
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" style="filter: brightness(0) invert(1);"></button>
            </div>
            <form action="playlist" method="post">
                <div class="modal-body">
                    <input type="hidden" name="action" value="create">
                    <div class="mb-3">
                        <label for="playlistTitle" class="form-label">Playlist Name</label>
                        <input type="text" class="form-control" id="playlistTitle" name="title" required placeholder="Enter playlist name">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-plus-lg"></i> Create
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Add to Playlist Modal -->
<div class="modal fade" id="addToPlaylistModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header" style="background: var(--gradient-accent); color: var(--white); border: none;">
                <h5 class="modal-title">
                    <i class="bi bi-plus-lg"></i> Add to Playlist
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" style="filter: brightness(0) invert(1);"></button>
            </div>
            <form id="addToPlaylistForm" action="playlist" method="post">
                <div class="modal-body">
                    <input type="hidden" name="action" value="addSong">
                    <input type="hidden" id="musicIdToAdd" name="musicId">
                    <label class="form-label">Select a Playlist:</label>
                    <select class="form-select" name="playlistId" required>
                        <option value="">Choose a playlist...</option>
                        <c:forEach var="playlist" items="${userPlaylists}">
                            <option value="${playlist.id}">
                                <i class="bi bi-collection"></i> ${playlist.title}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-plus-lg"></i> Add Song
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // Player controls
    let currentTrack = null;
    let audio = new Audio();
    const playPauseBtn = document.getElementById('playPauseBtn');
    const playIcon = '<i class="bi bi-play-fill"></i>';
    const pauseIcon = '<i class="bi bi-pause-fill"></i>';

    function playTrack(id, title, artist) {
        currentTrack = { id, title, artist };
        audio.src = 'stream?id=' + id;
        audio.play();
        document.getElementById('currentTrack').innerHTML = '<i class="bi bi-music-note-beamed"></i> ' + title + ' - ' + artist;
        playPauseBtn.innerHTML = pauseIcon;
    }

    playPauseBtn.addEventListener('click', function() {
        if (audio.paused) {
            if(currentTrack) {
                audio.play();
                this.innerHTML = pauseIcon;
            }
        } else {
            audio.pause();
            this.innerHTML = playIcon;
        }
    });

    document.getElementById('progressBar').addEventListener('input', function() {
        if(audio.duration) {
            audio.currentTime = (this.value / 100) * audio.duration;
        }
    });

    audio.addEventListener('timeupdate', function() {
        if(audio.duration) {
            const progress = (audio.currentTime / audio.duration) * 100;
            document.getElementById('progressBar').value = progress;
            document.getElementById('currentTime').textContent = formatTime(audio.currentTime);
        }
    });
    
    audio.addEventListener('ended', function(){
        playPauseBtn.innerHTML = playIcon;
        document.getElementById('progressBar').value = 0;
    });

    function formatTime(seconds) {
        const mins = Math.floor(seconds / 60);
        const secs = Math.floor(seconds % 60);
        return mins + ':' + (secs < 10 ? '0' : '') + secs;
    }

    document.getElementById('likeBtn').addEventListener('click', function() {
        if (currentTrack) {
            fetch('like?id=' + currentTrack.id, { method: 'POST' })
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

    // Add to playlist
    const addToPlaylistModal = new bootstrap.Modal(document.getElementById('addToPlaylistModal'));
    function addToPlaylist(musicId) {
        document.getElementById('musicIdToAdd').value = musicId;
        addToPlaylistModal.show();
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
