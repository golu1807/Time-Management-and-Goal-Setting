<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>${playlist.title} - Music Platform</title>
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
    </div>
</nav>

<div class="container mt-5">
    <!-- Playlist Header -->
    <div class="row mb-5 animate-slideInUp">
        <div class="col-md-8">
            <h1 style="font-size: 2.5rem; margin-bottom: 1rem;">
                <i class="bi bi-collection"></i> ${playlist.title}
            </h1>
            <p style="color: var(--gray); font-size: 1.1rem;">
                <c:choose>
                    <c:when test="${not empty playlist.songs}">
                        <i class="bi bi-music-note"></i> ${fn:length(playlist.songs)} songs
                    </c:when>
                    <c:otherwise>
                        <i class="bi bi-inbox"></i> No songs in this playlist yet
                    </c:otherwise>
                </c:choose>
            </p>
        </div>
        <div class="col-md-4" style="display: flex; align-items: flex-end; justify-content: flex-end;">
            <form action="playlist" method="post" onsubmit="return confirm('Are you sure you want to delete this playlist?');">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="playlistId" value="${playlist.id}">
                <button type="submit" class="btn btn-danger btn-lg">
                    <i class="bi bi-trash"></i> Delete Playlist
                </button>
            </form>
        </div>
    </div>

    <!-- Songs List -->
    <div class="card mb-5 animate-slideInUp">
        <div class="card-header">
            <h2><i class="bi bi-music-note-list"></i> Playlist Songs</h2>
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${not empty playlist.songs}">
                    <c:forEach var="song" items="${playlist.songs}" varStatus="status">
                        <div class="list-group-item mb-2" style="display: flex; justify-content: space-between; align-items: center; padding: 1rem; border-radius: 0.5rem; background: var(--light); transition: all 0.3s;">
                            <div style="flex: 1;">
                                <h6 class="mb-0" style="color: var(--dark); font-weight: 600;">
                                    <span style="color: var(--gray); margin-right: 0.5rem;">${status.count}</span>
                                    <i class="bi bi-music-note"></i> ${song.title}
                                </h6>
                                <small style="color: var(--gray);">
                                    <i class="bi bi-person"></i> ${song.artist}
                                </small>
                            </div>
                            <div style="display: flex; gap: 0.5rem;">
                                <button class="btn btn-sm btn-primary" onclick="playTrack(${song.id}, '${song.title}', '${song.artist}')" title="Play">
                                    <i class="bi bi-play-fill"></i>
                                </button>
                                <form action="playlist" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="removeSong">
                                    <input type="hidden" name="playlistId" value="${playlist.id}">
                                    <input type="hidden" name="musicId" value="${song.id}">
                                    <button type="submit" class="btn btn-sm btn-outline-danger" title="Remove from playlist" onclick="return confirm('Remove this song from playlist?');">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div style="text-align: center; padding: 3rem; color: var(--gray);">
                        <i class="bi bi-inbox" style="font-size: 3rem; margin-bottom: 1rem; display: block;"></i>
                        <p style="font-size: 1.1rem;">This playlist is empty. Add some songs to get started!</p>
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
</script>

</body>
</html>
