package com.db;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet implementation class ApprovedNews
 */
@WebServlet("/approvedNews")
public class ApprovedNews extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ApprovedNews() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<News> approvedNewsList = new ArrayList<>();

        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    	response.setHeader("Pragma", "no-cache");
    	response.setDateHeader("Expires", 0);
    	HttpSession session = request.getSession(false);
        if (session == null) {
            session.invalidate();
            response.sendRedirect("login.jsp");
            return;
        }
        
        
        
        try {
            // Establish database connection
            DBConnection db = new DBConnection();
            Connection conn = db.connectToDb();

            // SQL query to fetch approved news
            String query = "SELECT id, title, category, content, author, status FROM news WHERE status = 'approved'";
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            // Process the result set and populate the list
            while (rs.next()) {
                News news = new News();
                news.setId(rs.getInt("id"));
                news.setTitle(rs.getString("title"));
                news.setCategory(rs.getString("category"));
                news.setContent(rs.getString("content"));
                news.setAuthor(rs.getString("author"));
                news.setStatus(rs.getString("status"));
                approvedNewsList.add(news);
            }

            rs.close();
            ps.close();
            conn.close();

            // Set the approved news list as a request attribute
            request.setAttribute("approvedNewsList", approvedNewsList);

            // Forward to ApprovedNews.jsp
            request.getRequestDispatcher("ApprovedNews.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().append("Error: Unable to fetch approved news.");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().append("Unexpected error occurred.");
        }
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
