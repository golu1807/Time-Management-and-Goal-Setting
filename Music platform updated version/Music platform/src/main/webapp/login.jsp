<%@ include file="header.jsp" %>

<div style="min-height: 60vh; display: flex; align-items: center; padding: 2rem 0;">
    <div class="row justify-content-center w-100">
        <div class="col-md-5">
            <div class="card card-glass animate-slideInUp" style="border-radius: 1.5rem; box-shadow: 0 8px 32px rgba(99, 102, 241, 0.2);">
                <div class="card-header" style="text-align: center; background: var(--gradient-primary); color: var(--white); border-radius: 1.5rem 1.5rem 0 0;">
                    <h3 style="margin: 0; background: none; -webkit-text-fill-color: var(--white);">
                        <i class="bi bi-box-arrow-in-right"></i> Welcome Back
                    </h3>
                    <p style="margin: 0.5rem 0 0 0; color: rgba(255,255,255,0.9); font-size: 0.95rem;">Sign in to your account</p>
                </div>
                <div class="card-body">
                    <form action="login" method="post">
                        <div class="mb-4">
                            <label for="email" class="form-label">
                                <i class="bi bi-envelope"></i> Email Address
                            </label>
                            <input type="email" class="form-control" id="email" name="email" required placeholder="Enter your email">
                        </div>
                        <div class="mb-4">
                            <label for="password" class="form-label">
                                <i class="bi bi-lock"></i> Password
                            </label>
                            <input type="password" class="form-control" id="password" name="password" required placeholder="Enter your password">
                        </div>
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe">
                            <label class="form-check-label" for="rememberMe">
                                Remember me
                            </label>
                        </div>
                        <button type="submit" class="btn btn-primary w-100 btn-lg" style="font-size: 1rem; font-weight: 600;">
                            <i class="bi bi-box-arrow-in-right"></i> Sign In
                        </button>
                    </form>
                </div>
                <div class="card-footer" style="text-align: center; background: var(--light);">
                    <p style="margin: 0; color: var(--gray);">
                        Don't have an account? 
                        <a href="register.jsp" style="color: var(--primary); font-weight: 600;">
                            <i class="bi bi-person-plus"></i> Sign up here
                        </a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>
