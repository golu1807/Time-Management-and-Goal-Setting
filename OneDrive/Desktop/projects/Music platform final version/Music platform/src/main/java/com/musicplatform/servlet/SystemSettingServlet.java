package com.musicplatform.servlet;

import com.musicplatform.dao.SystemSettingDAO;
import com.musicplatform.model.SystemSetting;
import com.musicplatform.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/settings")
public class SystemSettingServlet extends HttpServlet {
    private SystemSettingDAO settingDAO;

    @Override
    public void init() throws ServletException {
        settingDAO = new SystemSettingDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect("../login.jsp");
            return;
        }

        try {
            List<SystemSetting> settings = settingDAO.getAllSettings();
            request.setAttribute("settings", settings);
            request.getRequestDispatcher("/admin/settings.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error retrieving settings", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect("../login.jsp");
            return;
        }

        String key = request.getParameter("key");
        String value = request.getParameter("value");

        try {
            settingDAO.updateSetting(key, value);
            response.sendRedirect("settings?success=updated");
        } catch (SQLException e) {
            throw new ServletException("Error updating setting", e);
        }
    }
}
