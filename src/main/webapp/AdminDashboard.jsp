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
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="0">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard</title>
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap"
	rel="stylesheet">
<style>
/* General Styles */
body {
	margin: 0;
	font-family: 'Roboto', sans-serif;
	background-color: #f4f6f9;
	color: #343a40;
}

/* Header Styles */
.header {
	background-color: #1f2937;
	color: #ffffff;
	padding: 20px;
	position: fixed;
	width: 100%;
	text-align: center;
	font-size: 24px;
	font-weight: bold;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	z-index: 1000;
}

/* Sidebar Styles */
.sidebar {
	width: 250px;
	background-color: #111827;
	color: #d1d5db;
	height: 100vh;
	padding-top: 60px;
	position: fixed;
	top: 0;
	left: 0;
	overflow-y: auto;
	z-index: 999;
	box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
}

.sidebar a {
	display: block;
	padding: 15px 20px;
	color: #d1d5db;
	text-decoration: none;
	font-size: 16px;
	font-weight: 500;
	border-left: 4px solid transparent;
	transition: all 0.3s ease-in-out;
}

.sidebar a.active, .sidebar a:hover {
	background-color: #374151;
	color: #ffffff;
	border-left: 4px solid #3b82f6;
}

/* Content Area */
.content {
	margin-left: 250px;
	padding: 80px 30px 30px;
	background-color: #f9fafb;
	min-height: 100vh;
	box-shadow: 0 -1px 5px rgba(0, 0, 0, 0.1);
}

.content h2 {
	font-size: 28px;
	font-weight: bold;
	color: #1f2937;
	margin-bottom: 20px;
}

.content p {
	font-size: 16px;
	color: #6b7280;
	line-height: 1.6;
}

.dashboard-cards {
	display: flex;
	gap: 20px;
	flex-wrap: wrap;
	margin-top: 20px;
}

.dashboard-card {
	background-color: #ffffff;
	border: 1px solid #e5e7eb;
	border-radius: 8px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
	flex: 1;
	min-width: 250px;
	padding: 20px;
	text-align: center;
	transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
}

.dashboard-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
}

.dashboard-card h3 {
	font-size: 20px;
	color: #1f2937;
	margin-bottom: 10px;
}

.dashboard-card p {
	font-size: 14px;
	color: #6b7280;
}

/* Footer Styles */
.footer {
	text-align: center;
	padding: 15px;
	background-color: #1f2937;
	color: #d1d5db;
	position: fixed;
	bottom: 0;
	width: 100%;
}
</style>
</head>
<body>
	<!-- Header -->
	<div class="header">Admin Dashboard</div>

	<!-- Sidebar -->
	<div class="sidebar">
		<a href="Home.jsp" class="active">Home</a> <a href="pendingnews">Pending
			News</a> <a href="approvednews">Approved News</a> <a
			href="rejectednews">Rejected News</a> <a href="LogOutServlet">Logout</a>
	</div>

	<!-- Content -->
	<div class="content">
		<h2>Welcome to the Admin Dashboard</h2>
		<p>
			Hello,
			<%=username != null ? username : "Please log in to access your dashboard."%></p>

		<div class="dashboard-cards">
			<div class="dashboard-card">
				<h3>Pending Requests</h3>
				<p>Review and approve pending news requests.</p>
			</div>
			<div class="dashboard-card">
				<h3>All News</h3>
				<p>View and manage all news articles.</p>
			</div>
			<div class="dashboard-card">
				<h3>User Management</h3>
				<p>Manage user accounts and roles.</p>
			</div>
			<div class="dashboard-card">
				<h3>Settings</h3>
				<p>Adjust dashboard preferences and configurations.</p>
			</div>
		</div>
	</div>

	<!-- Footer -->
	<div class="footer">&copy; 2025 World Council. All Rights
		Reserved.</div>
</body>
</html>
