package com.musicplatform.servlet;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.musicplatform.dao.UserDAO;
import com.musicplatform.model.User;
import com.musicplatform.util.JwtUtil;
import at.favre.lib.crypto.bcrypt.BCrypt;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/auth/*")
public class AuthServlet extends HttpServlet {

    private UserDAO userDAO;
    private ObjectMapper objectMapper;

    @Override
    public void init() {
        userDAO = new UserDAO();
        objectMapper = new ObjectMapper();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        try {
            if ("/login".equals(path)) {
                handleLogin(req, resp);
            } else if ("/signup".equals(path)) {
                handleSignup(req, resp);
            } else {
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            e.printStackTrace();
            sendError(resp, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error: " + e.getMessage());
        }
    }

    private void handleLogin(HttpServletRequest req, HttpServletResponse resp) throws IOException, SQLException {
        LoginRequest loginReq = objectMapper.readValue(req.getReader(), LoginRequest.class);

        // Simple check: try by email first (assuming usernameOrEmail is passed)
        User user = userDAO.getUserByEmail(loginReq.usernameOrEmail); // Fallback to username check if needed in future

        if (user != null && BCrypt.verifyer().verify(loginReq.password.toCharArray(), user.getPassword()).verified) {
            String token = JwtUtil.generateToken(user.getEmail(), user.getRole(), user.getId());

            Map<String, Object> responseData = new HashMap<>();
            responseData.put("token", token);
            responseData.put("user", user);
            responseData.put("redirect", "dashboard"); // Frontend can use this

            objectMapper.writeValue(resp.getWriter(), responseData);
        } else {
            sendError(resp, HttpServletResponse.SC_UNAUTHORIZED, "Invalid credentials");
        }
    }

    private void handleSignup(HttpServletRequest req, HttpServletResponse resp) throws IOException, SQLException {
        SignupRequest signupReq = objectMapper.readValue(req.getReader(), SignupRequest.class);

        if (userDAO.getUserByEmail(signupReq.email) != null) {
            sendError(resp, HttpServletResponse.SC_CONFLICT, "Email already in use");
            return;
        }

        User newUser = new User();
        newUser.setName(signupReq.username);
        newUser.setEmail(signupReq.email);
        newUser.setRole(signupReq.role != null ? signupReq.role : "LISTENER");
        newUser.setPassword(BCrypt.withDefaults().hashToString(12, signupReq.password.toCharArray()));

        userDAO.createUser(newUser);

        // Auto-login after signup
        String token = JwtUtil.generateToken(newUser.getEmail(), newUser.getRole(), newUser.getId()); // ID might be
                                                                                                      // missing if not
                                                                                                      // returned by
                                                                                                      // createUser, but
                                                                                                      // ignoring for
                                                                                                      // now or fetching
                                                                                                      // back

        Map<String, Object> responseData = new HashMap<>();
        responseData.put("message", "User created successfully");
        responseData.put("token", token); // Optional: auto-login

        objectMapper.writeValue(resp.getWriter(), responseData);
    }

    private void sendError(HttpServletResponse resp, int status, String message) throws IOException {
        resp.setStatus(status);
        Map<String, String> error = new HashMap<>();
        error.put("error", message);
        objectMapper.writeValue(resp.getWriter(), error);
    }

    // DTOs
    private static class LoginRequest {
        public String usernameOrEmail;
        public String password;
    }

    private static class SignupRequest {
        public String username;
        public String email;
        public String password;
        public String role;
    }
}
