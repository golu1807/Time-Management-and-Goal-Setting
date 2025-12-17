package com.musicplatform.servlet;

import com.musicplatform.dao.FollowDAO;
import com.musicplatform.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/follow")
public class FollowServlet extends HttpServlet {
    private FollowDAO followDAO;

    @Override
    public void init() {
        followDAO = new FollowDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        User user = (User) session.getAttribute("user");
        String artistIdStr = request.getParameter("artistId");

        if (artistIdStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing artist ID");
            return;
        }

        try {
            int artistId = Integer.parseInt(artistIdStr);
            int listenerId = user.getId();

            if (followDAO.isFollowing(listenerId, artistId)) {
                followDAO.unfollowArtist(listenerId, artistId);
            } else {
                followDAO.followArtist(listenerId, artistId);
            }
            response.sendRedirect(request.getHeader("Referer")); // Redirect back to the previous page
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid artist ID");
        } catch (SQLException e) {
            throw new ServletException("Database error while processing follow action", e);
        }
    }
}
