<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - CollabBeats</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <style>
            body {
                background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
                color: #fff;
                height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                overflow: hidden;
            }

            .bg-waveform {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-image: url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAxNDQwIDMyMCI+PHBhdGggZmlsbD0iIzBmMzQ2MCIgZmlsbC1vcGFjaXR5PSIwLjEiIGQ9Ik0wLDE5Mkw0OCwxOTdDOTYsMjAyLDE5MiwyMTMsMjg4LDIyOUMzODQsMjQ1LDQ4MCwyNjcsNTc2LDI1MC43QzY3MiwyMzUsNzY4LDE4MSw4NjQsMTYwQzk2MCwxMzksMTA1NiwxNDksMTE1MiwxNjBDMTI0OCwxNzEsMTM0NCwxODEsMTM5MiwxODZMMTQ0MCwxOTJMMTQ0MCwzMjBMMTM5MiwzMjBDMTM0NCwzMjAsMTI0OCwzMjAsMTE1MiwzMjBDMTA1NiwzMjAsOTYwLDMyMCw4NjQsMzIwQzc2OCwzMjAsNjcyLDMyMCw1NzYsMzIwQzQ4MCwzMjAsMzg0LDMyMCwyODgsMzIwQzE5MiwzMjAsOTYsMzIwLDQ4LDMyMEwwLDMyMFoiPjwvcGF0aD48L3N2Zz4=');
                background-repeat: no-repeat;
                background-position: bottom;
                background-size: cover;
                z-index: -1;
            }

            .login-card {
                background: rgba(255, 255, 255, 0.05);
                backdrop-filter: blur(10px);
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 15px;
                padding: 2.5rem;
                width: 100%;
                max-width: 400px;
                box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37);
            }

            .app-logo {
                font-size: 2rem;
                font-weight: bold;
                color: #e94560;
                text-align: center;
                margin-bottom: 1.5rem;
                text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
            }

            .form-control {
                background: rgba(255, 255, 255, 0.1);
                border: 1px solid rgba(255, 255, 255, 0.2);
                color: #fff;
                border-radius: 8px;
            }

            .form-control:focus {
                background: rgba(255, 255, 255, 0.15);
                border-color: #e94560;
                color: #fff;
                box-shadow: 0 0 0 0.25rem rgba(233, 69, 96, 0.25);
            }

            .btn-login {
                background: #e94560;
                border: none;
                border-radius: 8px;
                padding: 0.75rem;
                font-weight: 600;
                width: 100%;
                margin-top: 1rem;
                transition: all 0.3s ease;
            }

            .btn-login:hover {
                background: #ff5e78;
                transform: translateY(-2px);
            }

            .signup-link {
                text-align: center;
                margin-top: 1.5rem;
                font-size: 0.9rem;
                color: rgba(255, 255, 255, 0.7);
            }

            .signup-link a {
                color: #e94560;
                text-decoration: none;
                font-weight: 600;
            }

            .signup-link a:hover {
                text-decoration: underline;
            }

            .tagline {
                text-align: center;
                color: rgba(255, 255, 255, 0.6);
                font-size: 0.9rem;
                margin-bottom: 2rem;
            }
        </style>
    </head>

    <body>

        <div class="bg-waveform"></div>

        <div class="container">
            <div class="login-card animate-slideInUp">
                <div class="app-logo">
                    <i class="bi bi-soundwave"></i> CollabBeats
                </div>
                <p class="tagline">Collaborate on music projects in real time.</p>

                <form action="login" method="post">
                    <div class="mb-3">
                        <label for="email" class="form-label">Email Address</label>
                        <input type="email" class="form-control" id="email" name="email" placeholder="name@example.com"
                            required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" class="form-control" id="password" name="password"
                            placeholder="Enter your password" required>
                    </div>

                    <!-- Role Selector (Optional as per prompt, but good for clarity if backend needs it, though backend usually detects) -->
                    <!-- We'll rely on backend detection for smoother UX as per "auto-detected role" option in prompt -->

                    <button type="submit" class="btn btn-primary btn-login">Login</button>
                </form>

                <div class="signup-link">
                    New here? <a href="signup.jsp">Sign up as a Musician</a>
                </div>
            </div>
        </div>

    </body>

    </html>