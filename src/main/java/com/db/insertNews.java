package com.db;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@MultipartConfig
public class insertNews extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);
		
		DBConnection dbObj = new DBConnection();
		Connection con = null;
		PreparedStatement state = null;
		String successMsg = null;
		try {

			HttpSession currentSession = request.getSession(false);
			String author;
			if (currentSession == null || currentSession.getAttribute("username") == null) {
				response.sendRedirect("login.jsp");
				return;
			} else {
				author = (String) currentSession.getAttribute("username");
			}
			con = dbObj.connectToDb();
			String Title = request.getParameter("title");
			String Category = request.getParameter("category");
			String Content = request.getParameter("content");

			if (Content.startsWith(" ")) {
				request.setAttribute("error", "Content should not start with space");
				RequestDispatcher req = request.getRequestDispatcher("createNews.jsp");
				req.forward(request, response);
			}
			if (Title.startsWith(" ")) {
				request.setAttribute("error", "Title should not start with space");
				RequestDispatcher req = request.getRequestDispatcher("createNews.jsp");
				req.forward(request, response);
			}

			state = con.prepareStatement(
					"INSERT INTO news (title, category, content, newsdate, author, status) VALUES (?, ?, ?, SYSDATE, ?,'pending')");
			state.setString(1, Title);
			state.setString(2, Category);
			state.setString(3, Content);
			state.setString(4, author);
			int result = state.executeUpdate();
			if (result > 0) {
				successMsg = "pass";
			} else {
				successMsg = "fail";
			}

			request.setAttribute("message", successMsg);

			RequestDispatcher req = request.getRequestDispatcher("createNews.jsp");
			req.forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace(); // Log or handle appropriately
		} finally {
			try {
				if (con != null)
					con.close();
				if (state != null)
					state.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

}
