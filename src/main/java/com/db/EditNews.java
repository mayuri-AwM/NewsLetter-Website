package com.db;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class EditNews extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);
    	DBConnection dbObj = new DBConnection();
        Connection con = null;
        PreparedStatement preparedStatement = null;
        HttpSession currentSession = request.getSession(false);
        if (currentSession == null || currentSession.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return; // Prevent further processing
        }
        try {
            String newTitle = request.getParameter("newTitle");
            String newDate = request.getParameter("newDate");
            String newContent = request.getParameter("newContent");
            String oldTitle = request.getParameter("oldTitle");
            String oldDate = request.getParameter("oldDate");
            
            con = dbObj.connectToDb();

            String updateQuery = "UPDATE news SET title = ?, newsDate = ?, content = ? WHERE title = ? AND TRUNC(newsDate) = ?";
            preparedStatement = con.prepareStatement(updateQuery);

            preparedStatement.setString(1, newTitle);
            preparedStatement.setDate(2, Date.valueOf(newDate));
            preparedStatement.setString(3, newContent);
            preparedStatement.setString(4, oldTitle);
            preparedStatement.setDate(5, Date.valueOf(oldDate));
            System.out.println("oldTitle: " + oldTitle);
            System.out.println("oldDate: " + oldDate);
            System.out.println("newTitle: " + newTitle);
            System.out.println("newDate: " + newDate);
            System.out.println("newContent: " + newContent);

            int rowsUpdated = preparedStatement.executeUpdate();

            if (rowsUpdated > 0) {
                response.sendRedirect("viewNews");
            } else {
                response.getWriter().println("Error: No records were updated. Please check the entered data.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try {
                if (preparedStatement != null) preparedStatement.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
