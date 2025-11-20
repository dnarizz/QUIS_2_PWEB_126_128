package com.library.web;

import com.library.dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null)
            action = "";

        switch (action) {
            case "login":
                processLogin(request, response);
                break;
            case "register":
                processRegister(request, response);
                break;
            default:
                response.sendRedirect("login.jsp");
                break;
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("logout".equals(action)) {
            processLogout(request, response);
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    private void processLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (userDAO.validate(email, password)) {
            HttpSession session = request.getSession();
            int userId = userDAO.getUserId(email);
            session.setAttribute("userId", userId);
            session.setAttribute("userEmail", email);
            response.sendRedirect("books?action=list"); // Redirect ke Dashboard
        } else {
            // Sebaiknya pakai Request Dispatcher untuk kirim pesan error
            response.sendRedirect("login.jsp?error=invalid");
        }
    }

    private void processRegister(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        userDAO.register(name, email, password);
        response.sendRedirect("login.jsp?success=registered");
    }

    private void processLogout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate(); // Hapus semua session
        }
        response.sendRedirect("index.jsp");
    }
}