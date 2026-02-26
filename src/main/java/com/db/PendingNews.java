package com.db;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/pendingnews")
public class PendingNews extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PendingNews() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
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

			// Fetch all news with 'pending' status
			String query = "SELECT id, title, content, status, author,category,newsdate FROM news WHERE status = ?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, "pending");
			ResultSet rs = ps.executeQuery();

			// List to store pending news
			List<News> newsList = new ArrayList<>();

			while (rs.next()) {
				int id = rs.getInt("id");
				String title = rs.getString("title");
				String content = rs.getString("content");
				String category = rs.getString("category");
				String author = rs.getString("author");
				String newsdate = rs.getString("newsdate");
				String status = rs.getString("status");

				// Create a News object and add it to the list
				newsList.add(new News(id, title, author, category, content, newsdate, status));
			}

			// Set newsList as a request attribute to forward to the JSP
			request.setAttribute("newsList", newsList);

			// Forward to the pending news JSP
			request.getRequestDispatcher("PendingNews.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().println("Error fetching pending news: " + e.getMessage());
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			// Get news ID and updated status from the request
			int newsId = Integer.parseInt(request.getParameter("newsId"));
			String newStatus = request.getParameter("status");

			// Establish database connection
			DBConnection db = new DBConnection();
			Connection conn = db.connectToDb();

			// Update the status of the news item
			String updateQuery = "UPDATE news SET status = ? WHERE id = ?";
			PreparedStatement ps = conn.prepareStatement(updateQuery);
			ps.setString(1, newStatus);
			ps.setInt(2, newsId);

			int rowsUpdated = ps.executeUpdate();
			if (rowsUpdated > 0) {
				response.getWriter().println("News status updated successfully!");
			} else {
				response.getWriter().println("Failed to update news status.");
			}

			// Redirect back to the pending news page
			response.sendRedirect("pendingnews");

		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().println("Error updating news status: " + e.getMessage());
		}
	}
}
