package com.musicplatform.servlet;

import com.musicplatform.dao.LikeDAO;
import com.musicplatform.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/like")
public class LikeServlet extends HttpServlet {
    private LikeDAO likeDAO;

    @Override
    public void init() {
        likeDAO = new LikeDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        User user = (User) session.getAttribute("user");
        String musicIdStr = request.getParameter("id");

        if (musicIdStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing music ID");
            return;
        }

        try {
            int musicId = Integer.parseInt(musicIdStr);
            int userId = user.getId();

            if (likeDAO.isLiked(userId, musicId)) {
                likeDAO.unlikeSong(userId, musicId);
            } else {
                likeDAO.likeSong(userId, musicId);
            }
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid music ID");
        } catch (SQLException e) {
            throw new ServletException("Database error while processing like action", e);
        }
    }
}
