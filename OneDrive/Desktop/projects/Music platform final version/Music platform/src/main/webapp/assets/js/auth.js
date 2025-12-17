const API_BASE = '/Music_platform/auth'; // Context path might vary, ensure match

const Auth = {
    togglePassword: function (inputId, iconId) {
        const input = document.getElementById(inputId);
        const icon = document.getElementById(iconId);
        if (input.type === 'password') {
            input.type = 'text';
            icon.classList.remove('bi-eye');
            icon.classList.add('bi-eye-slash');
        } else {
            input.type = 'password';
            icon.classList.add('bi-eye');
            icon.classList.remove('bi-eye-slash');
        }
    },

    showError: function (message) {
        const errorDiv = document.getElementById('error-alert');
        errorDiv.style.display = 'flex';
        errorDiv.innerHTML = `<i class="bi bi-exclamation-circle-fill"></i> ${message}`;
    },

    clearError: function () {
        const errorDiv = document.getElementById('error-alert');
        errorDiv.style.display = 'none';
        errorDiv.textContent = '';
    },

    setLoading: function (isLoading, btnId, originalText) {
        const btn = document.getElementById(btnId);
        if (isLoading) {
            btn.disabled = true;
            btn.innerHTML = '<span class="spinner"></span> Processing...';
        } else {
            btn.disabled = false;
            btn.innerHTML = originalText;
        }
    },

    login: async function (e) {
        e.preventDefault();
        this.clearError();

        const emailInput = document.getElementById('email').value;
        const passwordInput = document.getElementById('password').value;

        if (!emailInput || !passwordInput) {
            this.showError('Please fill in all fields.');
            return;
        }

        this.setLoading(true, 'loginBtn', 'Log In');

        try {
            const response = await fetch(`${API_BASE}/login`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ usernameOrEmail: emailInput, password: passwordInput })
            });

            const data = await response.json();

            if (response.ok) {
                // Success
                localStorage.setItem('jwt_token', data.token);
                localStorage.setItem('user_info', JSON.stringify(data.user));
                window.location.href = data.redirect || 'dashboard'; // server returns redirect path
            } else {
                this.showError(data.error || 'Login failed.');
            }
        } catch (err) {
            this.showError('Connection error. Please try again.');
            console.error(err);
        } finally {
            this.setLoading(false, 'loginBtn', 'Log In');
        }
    },

    signup: async function (e) {
        e.preventDefault();
        this.clearError();

        const username = document.getElementById('username').value;
        const email = document.getElementById('email').value;
        const password = document.getElementById('password').value;
        const confirmPass = document.getElementById('confirmPassword').value;
        const role = document.getElementById('role').value;
        const agree = document.getElementById('terms').checked;

        if (!username || !email || !password || !confirmPass) {
            this.showError('All fields are required.');
            return;
        }

        if (password !== confirmPass) {
            this.showError('Passwords do not match.');
            return;
        }

        if (!agree) {
            this.showError('You must agree to the Terms & Privacy.');
            return;
        }

        this.setLoading(true, 'signupBtn', 'Sign Up');

        try {
            const response = await fetch(`${API_BASE}/signup`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    username: username,
                    email: email,
                    password: password,
                    role: role
                })
            });

            const data = await response.json();

            if (response.ok) {
                // Success - Auto login
                localStorage.setItem('jwt_token', data.token);
                window.location.href = 'dashboard';
            } else {
                this.showError(data.error || 'Registration failed.');
            }
        } catch (err) {
            this.showError('Connection error. Please try again.');
        } finally {
            this.setLoading(false, 'signupBtn', 'Sign Up');
        }
    }
};

// Expose Auth globally
window.Auth = Auth;
