package com.musicplatform.servlet;

import com.musicplatform.dao.MusicDAO;
import com.musicplatform.dao.UserDAO;
import com.musicplatform.model.Music;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet({ "/admin/action", "/admin/users", "/admin/moderation" })
public class AdminServlet extends HttpServlet {
    private MusicDAO musicDAO;
    private UserDAO userDAO;

    @Override
    public void init() {
        musicDAO = new MusicDAO();
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();

        try {
            if (path.equals("/admin/users")) {
                // Fetch users with optional filtering (simple implementation for now)
                request.setAttribute("allUsers", userDAO.getAllUsers());
                request.getRequestDispatcher("/admin/users.jsp").forward(request, response);
            } else if (path.equals("/admin/moderation")) {
                String status = request.getParameter("status");
                if (status == null)
                    status = "PENDING";

                // Note: Real implementation would use a DAO method with filter.
                // For now, filtering in memory or fetching all.
                // Let's assume getAllMusic returns everything and we filter in JSP or here.
                // Better to filter here.
                java.util.List<Music> allMusic = musicDAO.getAllMusic();
                java.util.List<Music> filteredMusic = new java.util.ArrayList<>();
                for (Music m : allMusic) {
                    if (m.getStatus().equals(status)) {
                        filteredMusic.add(m);
                    }
                }
                request.setAttribute("pendingMusic", filteredMusic);
                request.getRequestDispatcher("/admin/moderation.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/dashboard");
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");

        try {
            if ("createUser".equals(action)) {
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String role = request.getParameter("role");

                // Hash password
                String hashedPassword = at.favre.lib.crypto.bcrypt.BCrypt.withDefaults().hashToString(12,
                        password.toCharArray());

                com.musicplatform.model.User newUser = new com.musicplatform.model.User();
                newUser.setName(name);
                newUser.setEmail(email);
                newUser.setPassword(hashedPassword);
                newUser.setRole(role);

                userDAO.createUser(newUser);
                response.sendRedirect("users?success=created");
                return;
            }

            if (idStr != null) {
                int id = Integer.parseInt(idStr);
                switch (action) {
                    case "approveMusic":
                        Music musicToApprove = musicDAO.getMusicById(id);
                        if (musicToApprove != null) {
                            musicToApprove.setStatus("APPROVED");
                            musicDAO.updateMusic(musicToApprove);
                        }
                        response.sendRedirect("moderation?status=PENDING");
                        break;
                    case "rejectMusic":
                        Music musicToReject = musicDAO.getMusicById(id);
                        if (musicToReject != null) {
                            musicToReject.setStatus("REJECTED");
                            musicDAO.updateMusic(musicToReject);
                        }
                        response.sendRedirect("moderation?status=PENDING");
                        break;
                    case "deleteUser":
                        userDAO.deleteUser(id);
                        response.sendRedirect("users?success=deleted");
                        break;
                    default:
                        response.sendRedirect(request.getContextPath() + "/dashboard");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/dashboard");
            }
        } catch (NumberFormatException | SQLException e) {
            throw new ServletException("Error processing admin action", e);
        }
    }
}
