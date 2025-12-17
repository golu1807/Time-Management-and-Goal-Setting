package com.musicplatform.servlet;

import com.musicplatform.service.ModerationService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.musicplatform.model.User;

import java.io.IOException;

@WebServlet("/report")
public class ReportContentServlet extends HttpServlet {
    private ModerationService moderationService;

    @Override
    public void init() {
        moderationService = new ModerationService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        // Get form parameters
        String contentType = request.getParameter("contentType");
        String contentIdStr = request.getParameter("contentId");
        String reason = request.getParameter("reason");
        String description = request.getParameter("description");

        try {
            int contentId = Integer.parseInt(contentIdStr);

            boolean success = moderationService.reportContent(
                    contentType, contentId, user.getId(), reason, description);

            if (success) {
                session.setAttribute("message", "Report submitted successfully. Our team will review it.");
                session.setAttribute("messageType", "success");
            } else {
                session.setAttribute("message", "You have already reported this content or an error occurred.");
                session.setAttribute("messageType", "warning");
            }

        } catch (NumberFormatException e) {
            session.setAttribute("message", "Invalid content ID.");
            session.setAttribute("messageType", "error");
        }

        // Redirect back to referring page
        String referer = request.getHeader("Referer");
        if (referer != null) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect(request.getContextPath() + "/dashboard");
        }
    }
}
