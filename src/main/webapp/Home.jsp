<%@page import="java.util.List"%>
<%@page import="com.db.Article"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>


<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Home</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #004080;
            color: white;
            padding: 10px 20px;
        }
        nav {
            display: flex;
            justify-content: flex-end;
            background-color: #0066cc;
            padding: 10px;
        }
        nav a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
            font-weight: bold;
        }
        nav a:hover {
            text-decoration: underline;
        }
        main {
            padding: 20px;
        }
        
        footer {
    		background-color: #004080;
    		color: white;
    		padding: 20px 0;
    		text-align: left;
		}

		.footer-content {
   		 	display: flex;
   		 	flex-direction: column;
   		 	align-items: center;
   		 	max-width: 1200px;
   		 	margin: 0 auto;
    		gap: 15px;
		}

		.footer-text {
    		text-align: center;
    		max-width: 800px;
    		margin-bottom: 20px;
		}

		.footer-links {
		    display: flex;
		    flex-wrap: wrap;
		    justify-content: center;
		    gap: 15px;
		    margin: 10px 0;
		}
		
		.footer-links a {
		    color: white;
		    text-decoration: none;
 		    font-size: 14px;
		}

		.footer-links a:hover {
		    text-decoration: underline;
		}
		
		.footer-right {
		    text-align: center;
		}

		.social-icons {
		    display: flex;
		    justify-content: center;
		    gap: 10px;
		    margin: 10px 0;
		}
		
		.social-icons img {
		    width: 24px;
		    height: 24px;
		}
		
		main {
    padding: 20px;
    font-family: Arial, sans-serif;
}

h2 {
    font-size: 24px;
    color: #004080;
    margin-bottom: 20px;
}

.news-item {
    display: flex;
    flex-direction: column;
    gap: 10px;
    padding: 20px;
    margin-bottom: 20px;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    transition: transform 0.2s, box-shadow 0.2s;
    background-color: #f9f9f9;
}

.news-item:hover {
    transform: translateY(-5px);
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
}

.news-item strong {
    font-size: 12px;
    color: #666;
}

.news-item h3 {
    font-size: 18px;
    color: #004080;
    margin: 0;
}

.news-item h3 a {
    text-decoration: none;
    color: inherit;
    transition: color 0.2s;
}

.news-item h3 a:hover {
    color: #0066cc;
}

.news-item p {
    font-size: 14px;
    color: #333;
    line-height: 1.6;
}

.read-more {
    align-self: flex-start;
    text-decoration: none;
    color: #0066cc;
    font-weight: bold;
    font-size: 14px;
    padding: 5px 10px;
    border: 1px solid #0066cc;
    border-radius: 4px;
    transition: background-color 0.2s, color 0.2s;
}

.read-more:hover {
    background-color: #0066cc;
    color: white;
}

/* Styling for the Dashboard Button */
#btn-dashboard {
    background-color: #007bff; /* Blue color */
    color: white; /* White text */
    border: none; /* Remove default border */
    padding: 10px 20px; /* Add padding for a nice size */
    border-radius: 4px; /* Rounded corners */
    font-size: 16px; /* Adjust font size */
    cursor: pointer; /* Pointer cursor on hover */
    transition: background-color 0.3s ease, box-shadow 0.3s ease; /* Smooth transitions */
}

#btn-dashboard:hover {
    background-color: #0056b3; /* Darker blue on hover */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Add shadow on hover */
}

#btn-dashboard:active {
    background-color: #004085; /* Even darker blue when clicked */
    transform: scale(0.98); /* Slight scaling effect */
}

        
    </style>
</head>

<body>
    <header>
    <div style="display: flex; align-items: center;">
        <img src="images/Logo.png" alt="World Council Logo" style="height: 80px; margin-right: 15px;">
        <h1>Welcome to World Council,  <%= session.getAttribute("username") != null ? session.getAttribute("username") : "Guest" %></h1>

    </div>
</header>
   <nav>
    <% 
        String username = (String) session.getAttribute("username");
        if (username != null) { 
            // Check if the user is admin
            if ("administrator".equalsIgnoreCase(username)) { 
    %>
                <button type="submit" id="btn-admin-dashboard">
                    <a href="AdminDashboard.jsp">Admin Dashboard</a>
                </button>
    <% 
            } else { 
    %>
                <button type="submit" id="btn-dashboard">
                    <a href="dashboard.jsp">Dashboard</a>
                </button>
    <% 
            } 
        } else { 
    %>
        <a href="login.jsp">Login</a>
        <a href="register.jsp">Register</a>
    <% 
        } 
    %>
</nav>


    <main>
        <div class="news-item">
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
    </div>
    
   
        
        
    </main>
    <footer>
    <div class="footer-content">
        <div class="footer-text">
            <p>The World Council engages in advocacy, development, and education to champion and grow credit unions and cooperative finance worldwide.</p>
            <div class="footer-links">
                <a href="#">Member Services</a>
                <a href="#">Global Programs</a>
                <a href="#">Worldwide Foundation</a>
                <a href="#">Subscribe</a>
                <a href="#">Careers</a>
                <a href="#">Contact Us</a>
            </div>
            <div class="footer-links">
                <a href="#">Terms and Conditions</a>
                <a href="#">Privacy Policy</a>
                <a href="#">Anti-Trafficking Policy</a>
            </div>
        </div>
        <div class="footer-right">
            <div class="social-icons">
    			<img src="images/calendar-icon.png" alt="Calendar">
    			<img src="images/facebook-icon.jpg" alt="Facebook">
    			<img src="images/twitter-icon.png" alt="Twitter">
    			<img src="images/linkedin-icon.jpg" alt="LinkedIn">
    			<img src="images/cross-icon.jpg" alt="Cross">
    			<img src="images/instagram-icon.png" alt="Instagram">
    			<img src="images/youtube-icon.png" alt="YouTube">
			</div>
            
            <p>&copy; 2024 World Council of Credit Unions, Inc.<br>
            In partnership with Worldwide Foundation for Credit Unions,<br>
            a registered 501(c)(3). EIN: 39-6093210</p>
        </div>
    </div>
</footer>

</body>
</html>