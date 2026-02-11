<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
    // Validate session at the very top
    HttpSession currentSession = request.getSession(false);
    if (currentSession == null || currentSession.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return; // Prevent further processing
    }
    String username = (String) currentSession.getAttribute("username");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <style type="text/css">
    /* General Styles */
/* General Styles */
body {
    margin: 0;
    font-family: 'Roboto', sans-serif;
    background-color: #f8f9fa;
    color: #343a40;
}

/* Header Styles */
.header {
    position: fixed; /* Make the header absolute */
    top: 0;
    left: 0;
    width: 100%; /* Full width of the viewport */
    background-color: #007bff;
    color: white;
    text-align: center;
    font-size: 10px; /* Reduced font size */
    font-weight: bold;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    z-index: 1000; /* Keep it on top of other elements */
}

/* Adjust content and sidebar to compensate for header */
.container {
    display: flex;
    min-height: calc(100vh - 50px); /* Adjust height to account for the header height */
    margin-top: 50px; /* Leave space for the header */
}

/* Sidebar Styles */
.sidebar {
    width: 250px;
    background-color: #343a40;
    height: calc(100vh - 50px); /* Adjust for header */
    padding-top: 20px;
    box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
    position: fixed;
    top: 50px; /* Positioned just below the header */
    overflow-y: auto;
}

.sidebar a {
    display: block;
    padding: 15px 20px;
    color: white;
    text-decoration: none;
    font-size: 16px;
    border-radius: 4px;
    transition: background-color 0.3s, color 0.3s;
    margin: 5px 10px;
}

.sidebar a:hover {
    background-color: #495057;
    color: #f8f9fa;
}

.sidebar a.active {
    background-color: #007bff;
    color: white;
    font-weight: bold;
}

/* Content Styles */
.content {
    margin-left: 270px; /* Adjust for sidebar width */
    padding: 30px;
    flex: 1;
    background-color: white;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
}

.content h2 {
    color: #343a40;
    font-size: 24px;
    margin-bottom: 20px;
}

.content p {
    font-size: 16px;
    line-height: 1.6;
    color: #6c757d;
}

form {
    display: flex;
    flex-direction: column;
    max-width: 600px;
    margin: 0 auto;
    background: #f4f4f4;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

label {
    font-size: 16px;
    color: #555;
    margin-bottom: 8px;
}

input, select, textarea {
    padding: 12px;
    margin-bottom: 20px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 14px;
}

textarea {
    resize: vertical;
}

button {
    padding: 12px;
    background-color: #4CAF50;
    color: white;
    font-size: 16px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

button:hover {
    background-color: #45a049;
}

/* News Box Layout */
.news-container {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    padding: 20px;
    justify-content: center;
    background-color: #f8f9fa;
}

.news-box {
    background-color: #ffffff;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    padding: 20px;
    width: 300px;
    box-sizing: border-box;
    transition: transform 0.2s, box-shadow 0.2s;
}

.news-box:hover {
    transform: scale(1.05);
    box-shadow: 0 6px 10px rgba(0, 0, 0, 0.15);
}

.news-box h4 {
    font-size: 1.2em;
    color: #343a40;
    margin-bottom: 10px;
}

.news-box p {
    font-size: 1em;
    color: #555;
    margin: 5px 0;
}

.news-box div {
    font-size: 0.9em;
    color: #777;
    margin: 5px 0;
}

    
    </style>
</head>
<body>
    <!-- Header -->
    <div class="header">
      <h1>Welcome <%= session.getAttribute("username") != null ? session.getAttribute("username") :"guest"%></h1>
    </div>

    <!-- Container -->
    <div class="container">
        <!-- Sidebar -->
        <div class="sidebar">
            <a href="Home.jsp" class="active">Home</a>
            <a href="createNews.jsp">Create News</a>
            <a href="editNews.jsp">Edit News</a>
            <a href="viewNews">View News</a>
            <a href="LogOutServlet">Logout</a>
        </div>

        <!-- Content Area -->
        <div class="content">
            <h2>Create News</h2>
            <% if (error != null && !error.isEmpty()) { %>
			<div style="color: red;"><%= error %></div>
			<% } %>
	    <form action="insertNews" enctype="multipart/form-data" id="NewsForm">
        <label for="title">News Title</label>
        <input type="text" id="title" name="title" placeholder="Enter the news title" required>

        <label for="category">Category</label>
        <select id="category" name="category" required>
                <option value="Politics">Politics</option>
                <option value="Sports">Sports</option>
                <option value="Technology">Technology</option>
                <option value="Entertainment">Entertainment</option>
                <option value="Health">Health</option>
                <option value="Business">Business</option>
        </select>

        <label for="content">Content</label>
        <textarea id="content" name="content" rows="6" placeholder="Enter the news content" required></textarea>
		
        <button type="submit">Create News</button>
        
        <h2>
    	<%
        	String message = (String) request.getAttribute("message");
        	if (message != null && message.equals("pass")) {
            out.println("News article has been added successfully.");
        	}
        	else if(message != null && message.equals("fail")){
        	out.println("Failed to add News article.");
        	}
    	%>
		</h2>

	    </form>
        </div>
    </div>
</body>
