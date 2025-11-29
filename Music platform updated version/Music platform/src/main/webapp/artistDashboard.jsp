<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Artist Dashboard - Music Platform</title>
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
        <a class="navbar-brand" href="#">
            <i class="bi bi-music-note-beamed"></i> Music Platform - Artist
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
    <!-- Stats Overview -->
    <div class="row mb-5">
        <div class="col-md-6 col-lg-3 mb-3">
            <div class="card animate-slideInUp" style="border-top: 4px solid var(--primary);">
                <div class="card-body text-center">
                    <div style="font-size: 2.5rem; color: var(--primary); margin-bottom: 0.5rem;">
                        <i class="bi bi-play-circle"></i>
                    </div>
                    <h6 style="color: var(--gray); margin-bottom: 0.5rem;">Total Streams</h6>
                    <h2 style="background: none; -webkit-text-fill-color: var(--primary); margin: 0;">
                        ${totalStreams != null ? totalStreams : 0}
                    </h2>
                </div>
            </div>
        </div>
        
        <div class="col-md-6 col-lg-3 mb-3">
            <div class="card animate-slideInUp" style="border-top: 4px solid var(--accent); animation-delay: 0.1s;">
                <div class="card-body text-center">
                    <div style="font-size: 2.5rem; color: var(--accent); margin-bottom: 0.5rem;">
                        <i class="bi bi-heart-fill"></i>
                    </div>
                    <h6 style="color: var(--gray); margin-bottom: 0.5rem;">Total Likes</h6>
                    <h2 style="background: none; -webkit-text-fill-color: var(--accent); margin: 0;">
                        ${totalLikes != null ? totalLikes : 0}
                    </h2>
                </div>
            </div>
        </div>
        
        <div class="col-md-6 col-lg-3 mb-3">
            <div class="card animate-slideInUp" style="border-top: 4px solid var(--success); animation-delay: 0.2s;">
                <div class="card-body text-center">
                    <div style="font-size: 2.5rem; color: var(--success); margin-bottom: 0.5rem;">
                        <i class="bi bi-people-fill"></i>
                    </div>
                    <h6 style="color: var(--gray); margin-bottom: 0.5rem;">Followers</h6>
                    <h2 style="background: none; -webkit-text-fill-color: var(--success); margin: 0;">
                        ${followerCount != null ? followerCount : 0}
                    </h2>
                </div>
            </div>
        </div>
        
        <div class="col-md-6 col-lg-3 mb-3">
            <div class="card animate-slideInUp" style="border-top: 4px solid var(--warning); animation-delay: 0.3s;">
                <div class="card-body text-center">
                    <div style="font-size: 2.5rem; color: var(--warning); margin-bottom: 0.5rem;">
                        <i class="bi bi-music-note-beamed"></i>
                    </div>
                    <h6 style="color: var(--gray); margin-bottom: 0.5rem;">Uploaded Songs</h6>
                    <h2 style="background: none; -webkit-text-fill-color: var(--warning); margin: 0;">
                        ${uploadedSongs != null ? uploadedSongs : 0}
                    </h2>
                </div>
            </div>
        </div>
    </div>

    <!-- Upload Music Card -->
    <div class="card mb-5 animate-slideInLeft">
        <div class="card-header">
            <h2><i class="bi bi-cloud-arrow-up"></i> Upload New Music</h2>
        </div>
        <div class="card-body">
            <form action="upload" method="post" enctype="multipart/form-data">
                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="title" class="form-label">
                                <i class="bi bi-music-note-list"></i> Song Title
                            </label>
                            <input type="text" class="form-control" id="title" name="title" required placeholder="Enter song title">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="album" class="form-label">
                                <i class="bi bi-disc"></i> Album
                            </label>
                            <input type="text" class="form-control" id="album" name="album" placeholder="Enter album name">
                        </div>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="genre" class="form-label">
                                <i class="bi bi-tag"></i> Genre
                            </label>
                            <select class="form-select" id="genre" name="genre" required>
                                <option value="">Select Genre</option>
                                <option value="Pop">Pop</option>
                                <option value="Rock">Rock</option>
                                <option value="Hip-Hop">Hip-Hop</option>
                                <option value="Jazz">Jazz</option>
                                <option value="Classical">Classical</option>
                                <option value="Electronic">Electronic</option>
                                <option value="R&B">R&B</option>
                                <option value="Country">Country</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="audioFile" class="form-label">
                                <i class="bi bi-file-music"></i> Audio File
                            </label>
                            <input type="file" class="form-control" id="audioFile" name="audioFile" accept="audio/*" required>
                        </div>
                    </div>
                </div>
                
                <div class="mb-3">
                    <label for="description" class="form-label">
                        <i class="bi bi-chat-left-text"></i> Description (Optional)
                    </label>
                    <textarea class="form-control" id="description" name="description" rows="4" placeholder="Tell us about your song..."></textarea>
                </div>
                
                <button type="submit" class="btn btn-primary btn-lg">
                    <i class="bi bi-cloud-arrow-up"></i> Upload Music
                </button>
            </form>
        </div>
    </div>

    <!-- Upload History Card -->
    <div class="card mb-5 animate-slideInRight">
        <div class="card-header">
            <h2><i class="bi bi-clock-history"></i> Upload History</h2>
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${not empty uploadedSongsList}">
                    <div style="overflow-x: auto;">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th><i class="bi bi-music-note"></i> Title</th>
                                    <th><i class="bi bi-disc"></i> Album</th>
                                    <th><i class="bi bi-tag"></i> Genre</th>
                                    <th><i class="bi bi-shield-check"></i> Status</th>
                                    <th><i class="bi bi-play-circle"></i> Streams</th>
                                    <th><i class="bi bi-heart"></i> Likes</th>
                                    <th><i class="bi bi-calendar-event"></i> Date</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="song" items="${uploadedSongsList}">
                                    <tr>
                                        <td><strong>${song.title}</strong></td>
                                        <td>${song.album}</td>
                                        <td>${song.genre}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${song.status == 'PENDING'}">
                                                    <span class="badge bg-warning text-dark">
                                                        <i class="bi bi-hourglass-split"></i> PENDING
                                                    </span>
                                                </c:when>
                                                <c:when test="${song.status == 'APPROVED'}">
                                                    <span class="badge bg-success">
                                                        <i class="bi bi-check-circle"></i> APPROVED
                                                    </span>
                                                </c:when>
                                                <c:when test="${song.status == 'REJECTED'}">
                                                    <span class="badge bg-danger">
                                                        <i class="bi bi-x-circle"></i> REJECTED
                                                    </span>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                        <td><strong>${song.streamCount != null ? song.streamCount : 0}</strong></td>
                                        <td><strong>${song.likeCount != null ? song.likeCount : 0}</strong></td>
                                        <td>${song.uploadDate}</td>
                                        <td>
                                            <a href="editSong?id=${song.id}" class="btn btn-sm btn-outline-primary" title="Edit">
                                                <i class="bi bi-pencil"></i>
                                            </a>
                                            <a href="deleteSong?id=${song.id}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Are you sure you want to delete this song?');" title="Delete">
                                                <i class="bi bi-trash"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="text-align: center; padding: 2rem; color: var(--gray);">
                        <i class="bi bi-inbox" style="font-size: 2.5rem; margin-bottom: 1rem; display: block;"></i>
                        <p>No songs uploaded yet. Start by uploading your first track!</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Fan Messages Card -->
    <div class="card mb-5 animate-slideInUp">
        <div class="card-header">
            <h2><i class="bi bi-chat-dots"></i> Fan Messages</h2>
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${not empty fanMessages}">
                    <c:forEach var="message" items="${fanMessages}">
                        <div style="border-left: 4px solid var(--primary); padding: 1rem; margin-bottom: 1rem; border-radius: 0.5rem; background: var(--light); transition: all 0.3s;" class="hover-card">
                            <div style="display: flex; justify-content: space-between; align-items: start; margin-bottom: 0.5rem;">
                                <strong style="color: var(--dark);">
                                    <i class="bi bi-person-circle"></i> ${message.senderName}
                                </strong>
                                <small style="color: var(--gray);">
                                    <i class="bi bi-calendar-event"></i> ${message.sentAt}
                                </small>
                            </div>
                            <p style="color: var(--dark); margin: 0.5rem 0 0 0;">${message.content}</p>
                            <div style="margin-top: 0.75rem;">
                                <a href="reply?id=${message.id}" class="btn btn-sm btn-outline-primary">
                                    <i class="bi bi-reply"></i> Reply
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div style="text-align: center; padding: 2rem; color: var(--gray);">
                        <i class="bi bi-chat-left" style="font-size: 2.5rem; margin-bottom: 1rem; display: block;"></i>
                        <p>No messages yet. Your fans will send you messages here!</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<!-- Modern Music Player Footer -->
<footer class="player-footer fixed-bottom">
    <div class="container-fluid">
        <div style="display: flex; align-items: center; gap: 1.5rem;">
            <div style="flex: 1; min-width: 0;">
                <div id="currentTrack" style="color: var(--white); font-weight: 500; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                    <i class="bi bi-music-note-beamed"></i> No track selected
                </div>
            </div>
            
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
            
            <div style="flex: 1; display: flex; align-items: center; gap: 1rem;">
                <span id="currentTime" style="color: var(--light); font-size: 0.875rem; min-width: 40px;">0:00</span>
                <input type="range" id="progressBar" class="form-range" min="0" max="100" value="0" style="flex: 1;">
            </div>
        </div>
    </div>
</footer>

<style>
    .hover-card:hover {
        box-shadow: var(--shadow-md);
        transform: translateX(2px);
    }
</style>

<script>
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
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
