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

@WebServlet("/admin/action")
public class AdminServlet extends HttpServlet {
    private MusicDAO musicDAO;
    private UserDAO userDAO;

    @Override
    public void init() {
        musicDAO = new MusicDAO();
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");

        if (action == null || idStr == null) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            switch (action) {
                case "approveMusic":
                    Music musicToApprove = musicDAO.getMusicById(id);
                    if (musicToApprove != null) {
                        musicToApprove.setStatus("APPROVED");
                        musicDAO.updateMusic(musicToApprove);
                    }
                    break;
                case "rejectMusic":
                    Music musicToReject = musicDAO.getMusicById(id);
                    if (musicToReject != null) {
                        musicToReject.setStatus("REJECTED");
                        musicDAO.updateMusic(musicToReject);
                    }
                    break;
                case "deleteUser":
                    userDAO.deleteUser(id);
                    break;
            }
            response.sendRedirect(request.getContextPath() + "/dashboard");
        } catch (NumberFormatException | SQLException e) {
            throw new ServletException("Error processing admin action", e);
        }
    }
}
