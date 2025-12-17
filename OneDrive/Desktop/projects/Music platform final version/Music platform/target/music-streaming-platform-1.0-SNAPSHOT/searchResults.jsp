<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Search Results - Music Platform</title>
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
        <a class="navbar-brand" href="dashboard">
            <i class="bi bi-music-note-beamed"></i> Music Platform
        </a>
        <form class="d-flex ms-auto" action="search" method="get" style="width: 400px;">
            <input class="form-control" type="search" name="query" placeholder="Search..." value="${searchQuery}" required>
            <button class="btn btn-primary ms-2" type="submit">
                <i class="bi bi-search"></i>
            </button>
        </form>
    </div>
</nav>

<div class="container mt-5">
    <!-- Search Header -->
    <div class="mb-5 animate-slideInUp">
        <h1 style="font-size: 2rem; margin-bottom: 0.5rem;">
            <i class="bi bi-search"></i> Search Results
        </h1>
        <p style="color: var(--gray); font-size: 1.1rem;">
            Results for "<strong style="color: var(--primary);">${searchQuery}</strong>"
        </p>
    </div>

    <!-- Song Results Section -->
    <div class="card mb-5 animate-slideInLeft">
        <div class="card-header">
            <h2><i class="bi bi-music-note-list"></i> Songs</h2>
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${not empty musicResults}">
                    <c:forEach var="song" items="${musicResults}">
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
                        <p>No songs found matching your query.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Artist Results Section -->
    <div class="card mb-5 animate-slideInRight">
        <div class="card-header">
            <h2><i class="bi bi-mic"></i> Artists</h2>
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${not empty artistResults}">
                    <div class="row">
                        <c:forEach var="artist" items="${artistResults}">
                            <div class="col-md-6 mb-3">
                                <div class="card h-100">
                                    <div class="card-body">
                                        <h5 class="card-title">
                                            <i class="bi bi-person-circle"></i> ${artist.name}
                                        </h5>
                                        <form action="follow" method="post">
                                            <input type="hidden" name="artistId" value="${artist.id}">
                                            <button type="submit" class="btn btn-primary w-100">
                                                <i class="bi bi-person-plus"></i> Follow
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="text-align: center; padding: 2rem; color: var(--gray);">
                        <i class="bi bi-mic" style="font-size: 2rem; margin-bottom: 1rem; display: block;"></i>
                        <p>No artists found matching your query.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>

<script>
    function playTrack(id, title, artist) {
        console.log('Playing: ' + title + ' by ' + artist);
    }
    
    function addToPlaylist(musicId) {
        console.log('Adding song ' + musicId + ' to playlist');
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
