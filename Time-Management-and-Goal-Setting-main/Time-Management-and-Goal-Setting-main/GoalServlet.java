package com.timemanagement.controller;

import com.timemanagement.dao.GoalDAO;
import com.timemanagement.model.Goal;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/goals")
public class GoalServlet extends HttpServlet {
    private GoalDAO goalDAO;

    @Override
    public void init() throws ServletException {
        goalDAO = new GoalDAO(); // Initialize DAO
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Goal> goals = goalDAO.getAllGoals();
        request.setAttribute("goals", goals);
        request.getRequestDispatcher("/WEB-INF/jsp/goals.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String description = request.getParameter("description");
        boolean isCompleted = Boolean.parseBoolean(request.getParameter("isCompleted"));
        goalDAO.addGoal(new Goal(0, description, isCompleted));
        response.sendRedirect("/goals");
    }
}
