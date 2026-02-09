<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Edit News</title>
  <style>
  /* General Styles */
body {
    margin: 0;
    font-family: 'Roboto', sans-serif;
    background-color: #f8f9fa;
    color: #343a40;
}

/* Header Styles */
.header {
    background-color: #007bff;
    color: white;
    padding: 15px;
    text-align: center;
    font-size: 20px;
    font-weight: bold;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

/* Container Layout */
.container {
    display: flex;
    min-height: 90vh;
}

.para{
	margin-left:37vw;
}

/* Sidebar Styles */
.sidebar {
    width: 250px;
    background-color: #343a40;
    height: 100vh;
    padding-top: 20px;
    box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
    position: fixed;
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
/*
        #NewsForm {
            max-width: 500px;
            margin: auto;
            background: #f4f4f4;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        #NewsForm input, textarea {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        #NewsForm button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        #NewsForm button:hover {
            background-color: #0056b3;
        }*/
        
  .content {
    width: 60%;
    margin: 0 auto;
    background-color: #fff;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

h2 {
    text-align: center;
    margin-bottom: 30px;
    color: #333;
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

/* Placeholder styling */
input::placeholder, textarea::placeholder {
    color: #aaa;
}

/* Input field focus styling */
input:focus, select:focus, textarea:focus {
    outline: none;
    border-color: #4CAF50;
}

.news-container {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    padding: 20px;
    justify-content: center;
    background-color: #f8f9fa;
}

.news-box {
	margin-left:255px;
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
  <h2>Edit News</h2>
  <form action="EditNews">
    <label for="title">Title : </label>
    <input type="text" id="title" name="newTitle" value="<%= request.getParameter("title") %>" required><br><br>

    <label for="newsDate">Date:</label>
    <input type="date" id="newsDate" name="newDate" value="<%= request.getParameter("newsDate") %>" required><br><br>

    <label for="content">Content:</label>
    <textarea id="content" name="newContent"><%= request.getParameter("content") %></textarea><br><br>

    <input type="hidden" name="oldTitle" value="<%= request.getParameter("title") %>">
    <input type="hidden" name="oldDate" value="<%= request.getParameter("newsDate") %>">
    <button type="submit">Update</button>
  </form>
</body>
</html>
