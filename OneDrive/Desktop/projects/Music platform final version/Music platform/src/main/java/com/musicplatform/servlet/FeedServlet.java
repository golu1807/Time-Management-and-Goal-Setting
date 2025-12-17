package com.musicplatform.servlet;

import com.musicplatform.dao.MusicDAO;
import com.musicplatform.model.Music;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/feed")
public class FeedServlet extends HttpServlet {

    private MusicDAO musicDAO;

    @Override
    public void init() {
        musicDAO = new MusicDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Music> feedMusic = musicDAO.getAllMusic(); // Using getAllMusic which filters by APPROVED
            request.setAttribute("feedMusic", feedMusic);
            request.getRequestDispatcher("feed.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading feed.");
        }
    }
}
