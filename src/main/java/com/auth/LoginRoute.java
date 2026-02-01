package com.auth;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.db.DBConnection;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginRoute
 */
@WebServlet("/login")
public class LoginRoute extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginRoute() {
        super();
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Email is required.");
            forwardToLogin(request, response);
            return;
        }

        if (password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Password is required.");
            forwardToLogin(request, response);
            return;
        }

        try {
            DBConnection db = new DBConnection();
            Connection conn = db.connectToDb();

            PreparedStatement login = conn.prepareStatement("SELECT password, name FROM users WHERE email=?");
            login.setString(1, email);
            System.out.println("Executing query with email: " + email); // Debug log
            ResultSet rs = login.executeQuery();

            if (rs.next()) {
                String dbPassword = rs.getString("password");
                String name = rs.getString("name");

                if (dbPassword.equals(password)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("username", name);
                    session.setAttribute("useremail", email);

                    if ("administrator".equalsIgnoreCase(name)) {
                        response.sendRedirect("AdminDashboard.jsp");
                    } else {
                        response.sendRedirect("dashboard.jsp");
                    }
                } else {
                    request.setAttribute("error", "Invalid password.");
                    forwardToLogin(request, response);
                }
            } else {
                request.setAttribute("error", "Email not found.");
                forwardToLogin(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Internal server error. Please try again later.");
            forwardToLogin(request, response);
        }
    }

    private void forwardToLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
        rd.forward(request, response);
    }
}
