<%@ include file="header.jsp" %>

<div style="min-height: 60vh; display: flex; align-items: center; padding: 2rem 0;">
    <div class="row justify-content-center w-100">
        <div class="col-md-5">
            <div class="card card-glass animate-slideInUp" style="border-radius: 1.5rem; box-shadow: 0 8px 32px rgba(236, 72, 153, 0.2);">
                <div class="card-header" style="text-align: center; background: linear-gradient(135deg, #f43f5e 0%, #ec4899 100%); color: var(--white); border-radius: 1.5rem 1.5rem 0 0;">
                    <h3 style="margin: 0; background: none; -webkit-text-fill-color: var(--white);">
                        <i class="bi bi-person-plus"></i> Create Account
                    </h3>
                    <p style="margin: 0.5rem 0 0 0; color: rgba(255,255,255,0.9); font-size: 0.95rem;">Join our music community today</p>
                </div>
                <div class="card-body">
                    <form action="register" method="post">
                        <div class="mb-3">
                            <label for="name" class="form-label">
                                <i class="bi bi-person"></i> Full Name
                            </label>
                            <input type="text" class="form-control" id="name" name="name" required placeholder="Enter your full name">
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">
                                <i class="bi bi-envelope"></i> Email Address
                            </label>
                            <input type="email" class="form-control" id="email" name="email" required placeholder="Enter your email">
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">
                                <i class="bi bi-lock"></i> Password
                            </label>
                            <input type="password" class="form-control" id="password" name="password" required placeholder="Create a strong password">
                        </div>
                        <div class="mb-4">
                            <label class="form-label">
                                <i class="bi bi-music-note-beamed"></i> Register as:
                            </label>
                            <div style="display: flex; gap: 1rem;">
                                <div class="form-check flex-grow-1">
                                    <input class="form-check-input" type="radio" name="role" id="listener" value="listener" checked>
                                    <label class="form-check-label" for="listener" style="width: 100%; padding: 0.75rem; border: 2px solid var(--gray-light); border-radius: 0.5rem; cursor: pointer; transition: all 0.3s;">
                                        <i class="bi bi-headphones"></i> Listener
                                    </label>
                                </div>
                                <div class="form-check flex-grow-1">
                                    <input class="form-check-input" type="radio" name="role" id="artist" value="artist">
                                    <label class="form-check-label" for="artist" style="width: 100%; padding: 0.75rem; border: 2px solid var(--gray-light); border-radius: 0.5rem; cursor: pointer; transition: all 0.3s;">
                                        <i class="bi bi-mic"></i> Artist
                                    </label>
                                </div>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary w-100 btn-lg" style="font-size: 1rem; font-weight: 600;">
                            <i class="bi bi-person-plus"></i> Create Account
                        </button>
                    </form>
                </div>
                <div class="card-footer" style="text-align: center; background: var(--light);">
                    <p style="margin: 0; color: var(--gray);">
                        Already have an account? 
                        <a href="login.jsp" style="color: var(--primary); font-weight: 600;">
                            <i class="bi bi-box-arrow-in-right"></i> Sign in here
                        </a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    #listener:checked ~ label,
    #artist:checked ~ label {
        border-color: var(--primary) !important;
        background: rgba(99, 102, 241, 0.05) !important;
    }
</style>

<%@ include file="footer.jsp" %>
