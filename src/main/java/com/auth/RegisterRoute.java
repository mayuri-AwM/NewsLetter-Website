package com.auth;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.db.DBConnection;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RegisterRoute
 */
@WebServlet("/register")
public class RegisterRoute extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * Default constructor
     */
    public RegisterRoute() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
        rd.forward(request, response);
    }


    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name").trim();
        String email = request.getParameter("email").trim();
        String password = request.getParameter("password").trim();

        // Validation checks
        String errorMessage = validateInputs(name, email, password);

        if (errorMessage != null) {
            request.setAttribute("error", errorMessage);
            RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
            rd.forward(request, response);
            return;
        }

        try (Connection conn = new DBConnection().connectToDb()) {
            PreparedStatement register = conn.prepareStatement("INSERT INTO users (name, email, password) VALUES (?, ?, ?)");
            register.setString(1, name);
            register.setString(2, email);
            register.setString(3, password);

            int result = register.executeUpdate();
            if (result > 0) {
                response.sendRedirect("login.jsp");
            } else {
                request.setAttribute("error", "Registration failed! Please try again.");
                RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
                rd.forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred during registration. Please try again.");
            RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
            rd.forward(request, response);
        }
    }

    /**
     * Validates user inputs.
     *
     * @param name     the name input
     * @param email    the email input
     * @param password the password input
     * @return an error message if validation fails, otherwise null
     */
    private String validateInputs(String name, String email, String password) {
        if (name.length() < 3) {
            return "Name must be at least 3 characters long.";
        }
        
        if (!name.matches("^[a-zA-Z ]+$")) {
        	return "Name should only contain letters and spaces.";
        }
        
        if (!email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
            return "Please enter a valid email address.";
        }

        if (password.length() < 6) {
            return "Password must be at least 6 characters long.";
        }

        return null;
    }
}
