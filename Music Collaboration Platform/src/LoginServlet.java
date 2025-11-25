// src/LoginServlet.java
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        User user = UserDAO.validate(email, password);
        if(user != null) {
            req.getSession().setAttribute("user", user);
            res.sendRedirect("dashboard");
        } else {
            res.sendRedirect("login.html?error=1");
        }
    }
}
