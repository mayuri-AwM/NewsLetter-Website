<%@ page import="java.util.List"%>
<%@ page import="com.db.News"%>

<%
    // Validate session at the very top
    HttpSession currentSession = request.getSession(false);
    if (currentSession == null || currentSession.getAttribute("username") == null) {
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
        response.sendRedirect("login.jsp");
    }
    String username = (String) currentSession.getAttribute("username");

    List<News> newsList = (List<News>) request.getAttribute("newsList");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Pending News</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        /* General Styles */
        body, h1, h2, nav, table, form {
            margin: 0;
            padding: 0;
            font-family: 'Roboto', Arial, sans-serif;
        }

        body {
            background-color: #f4f4f9;
            display: flex;
            height: 100vh;
            overflow: hidden;
        }

        .sidebar {
            width: 250px;
            background-color: #333;
            color: #fff;
            display: flex;
            flex-direction: column;
            padding: 20px;
        }

        .sidebar h2 {
            margin-bottom: 20px;
            font-size: 22px;
            text-align: center;
        }

        .sidebar a {
            color: #fff;
            text-decoration: none;
            margin: 10px 0;
            padding: 10px;
            border-radius: 5px;
            display: block;
        }

        .sidebar a:hover {
            background-color: #575757;
        }

        .main-content {
            flex-grow: 1;
            background-color: #fff;
            overflow-y: auto;
        }

        .dashboard-container {
            margin: 20px;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 10px;
            text-align: left;
            font-size: 14px;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        form {
            display: flex;
            align-items: center;
        }

        select {
            padding: 5px 10px;
            margin-right: 10px;
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        button {
            padding: 8px 15px;
            background-color: #4CAF50;
            border: none;
            color: white;
            font-size: 14px;
            cursor: pointer;
            border-radius: 4px;
        }

        button:hover {
            background-color: #45a049;
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
            }

            .main-content {
                margin-top: 20px;
            }

            table {
                font-size: 12px;
            }

            h1 {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>

    <div class="sidebar">
        <h2>Admin Dashboard</h2>
        <a href="home">Home</a>
        <a href="pendingnews">Pending News</a>
        <a href="approvednews">Approved News</a>
        <a href="rejectednews">Rejected News</a>
        <a href="LogOutServlet">Logout</a>
    </div>

    <div class="main-content">
        <div class="dashboard-container">
            <h1>Pending News Dashboard</h1>

            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Category</th>
                        <th>Content</th>
                        <th>Author</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    if (newsList != null && !newsList.isEmpty()) {
                        for (News news : newsList) {
                    %>
                    <tr>
                        <td><%= news.getId() %></td>
                        <td><%= news.getTitle() %></td>
                        <td><%= news.getCategory() %></td>
                        <td><%= news.getContent() %></td>
                        <td><%= news.getAuthor() %></td>
                        <td><%= news.getStatus() %></td>
                        <td>
                            <form action="pendingnews">
                                <input type="hidden" name="newsId" value="<%= news.getId() %>">
                                <select name="status">
                                    <option value="approved" <%= news.getStatus().equals("approved") ? "selected" : "" %>>Approve</option>
                                    <option value="rejected" <%= news.getStatus().equals("rejected") ? "selected" : "" %>>Reject</option>
                                </select>
                                <button type="submit">Update</button>
                            </form>
                        </td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="7" style="text-align:center;">No pending news found.</td>
                    </tr>
                    <%
                    }
                    %>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>
