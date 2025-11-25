// src/DashboardServlet.java
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
public class DashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if(user == null) { res.sendRedirect("login.html"); return; }
        req.setAttribute("user", user);
        req.getRequestDispatcher("dashboard.jsp").forward(req, res);
    }
}
