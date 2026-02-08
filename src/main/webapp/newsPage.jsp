<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.db.Article" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title}</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 text-gray-800">
    <div class="container mx-auto py-8 px-4">
        <h1 class="text-4xl font-bold mb-6 text-center text-blue-600">Latest News</h1>

        <%
            List<Article> articles = (List<Article>) request.getAttribute("articles");
            if (articles != null && !articles.isEmpty()) {
                for (Article article : articles) {
        %>
        <div class="news-item bg-white shadow-md rounded-lg p-6 mb-4">
            <p class="text-sm text-gray-500"><%= article.getNewsdate() %></p>
            <h3 class="text-2xl font-semibold text-blue-500 hover:text-blue-700">
                <a href="?id=<%= article.getId() %>"><%= article.getTitle() %></a>
            </h3>
            <p class="mt-2 text-gray-700"><%= article.getContent() %></p>
        </div>
        <%
                }
            } else {
        %>
        <p class="text-center text-gray-500">No news articles are available at the moment.</p>
        <%
            }
        %>
    </div>
</body>
</html>
