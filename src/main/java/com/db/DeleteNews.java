package com.db;


import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class DeleteNews extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DBConnection dbObj = new DBConnection();
        Connection con = null;
        PreparedStatement preparedStatement = null;

        try {
            String title = request.getParameter("title");

            con = dbObj.connectToDb();

            
            String deleteQuery = "DELETE FROM news WHERE title = ?";

            preparedStatement = con.prepareStatement(deleteQuery);

            preparedStatement.setString(1, title);

            int rowsDeleted = preparedStatement.executeUpdate();

            if (rowsDeleted > 0) {
                response.sendRedirect("viewNews"); 
            } else {
                response.getWriter().println("Error: No records were deleted. Please check the entered data.");
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
