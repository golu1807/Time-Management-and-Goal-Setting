<%@ include file="header.jsp" %>

<!-- Hero Section -->
<section class="hero animate-slideInUp">
    <div class="hero-content">
        <h1><i class="bi bi-vinyl"></i> Music Streaming Platform</h1>
        <p class="lead">Discover, Stream, and Share Your Favorite Music</p>
        <p style="font-size: 1.1rem; color: rgba(255,255,255,0.9); margin-bottom: 2.5rem;">
            Connect with millions of listeners and artists worldwide. Create playlists, discover new music, and become part of our vibrant music community.
        </p>
        <div style="display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap;">
            <a href="login.jsp" class="btn btn-primary btn-lg" style="background: var(--white); color: var(--primary);">
                <i class="bi bi-box-arrow-in-right"></i> Login Now
            </a>
            <a href="register.jsp" class="btn btn-lg" style="border: 2px solid var(--white); color: var(--white);">
                <i class="bi bi-person-plus"></i> Create Account
            </a>
        </div>
    </div>
</section>

<!-- Features Section -->
<div class="container my-5">
    <h2 class="text-center mb-5">Why Choose Our Platform?</h2>
    <div class="row">
        <div class="col-md-4 mb-4">
            <div class="card animate-slideInLeft">
                <div class="card-body text-center">
                    <i class="bi bi-music-note-beamed" style="font-size: 2.5rem; color: var(--primary); margin-bottom: 1rem; display: block;"></i>
                    <h5>Unlimited Music</h5>
                    <p>Stream millions of songs from artists around the world.</p>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-4">
            <div class="card animate-slideInUp">
                <div class="card-body text-center">
                    <i class="bi bi-collection" style="font-size: 2.5rem; color: var(--accent); margin-bottom: 1rem; display: block;"></i>
                    <h5>Smart Playlists</h5>
                    <p>Organize and share your favorite tracks in custom playlists.</p>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-4">
            <div class="card animate-slideInRight">
                <div class="card-body text-center">
                    <i class="bi bi-people" style="font-size: 2.5rem; color: var(--success); margin-bottom: 1rem; display: block;"></i>
                    <h5>Connect & Share</h5>
                    <p>Follow artists and connect with music lovers globally.</p>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>
