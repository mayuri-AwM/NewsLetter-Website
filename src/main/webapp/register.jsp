<% String error = (String) request.getAttribute("error"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Java Crud Application</title>
<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet" type="text/css" href="global.css">
</head>
<body>  
	<nav class="w-full bg-white h-28 shadow-md">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-16">
            <div class="flex justify-between items-center h-16">
                <!-- Logo Placeholder -->
                <div>
                    <a href="#" class="text-blue-500 text-xl font-bold">
                    	<img alt="logo" src="images/Logo.png" class="h-16 w-20 mt-7">
                    </a>
                    <h1 class="mx-24 -mt-12 poppins-semibold text-xl">World council</h1>
                </div>
                <!-- Navigation Links -->
                <div class="md:flex text-lg mt-12 poppins-medium space-x-4">
                    <a href="Home.jsp" class="text-gray-600 hover:text-blue-500 font-medium">Home</a>
                    <a href="login.jsp" class="text-gray-600 hover:text-blue-500 font-medium">Login</a>
                </div>
            </div>
        </div>
    </nav>
	<div class="flex flex-col items-center mt-[5vw]">
		<h1 class="text-2xl poppins-medium text-blue-500">Java CRUD
			Application</h1>
		<h1 class="text-xl poppins-bold font-bold mt-3">Register</h1>
		<form action="${pageContext.request.contextPath}/register">
			<input type="text" required="required"
				class="border border-zinc-600 rounded-md px-3 py-2 mt-[2vw] w-80"
				placeholder="Enter your name" name="name" /> <br> <input
				type="email" required="required"
				class="border border-zinc-600 rounded-md px-3 py-2 mt-[2vw] w-80"
				placeholder="Enter your email" name="email" /> <br> <input
				 required="required"
				class="border border-zinc-600 rounded-md px-3 py-2 mt-[2vw] w-80"
				placeholder="Enter your password" type="password" name="password" /> <br> <input
				type="submit" class="border rounded-md border-zinc-600 bg-blue-500 text-white font-medium px-3 py-2 mt-[2vw] mx-[1vw] w-72" value="Register">
		</form>
		<% if (error != null && !error.isEmpty()) { %>
			<div class="text-red-500 text-sm mt-4"><%= error %></div>
		<% } %>
		<p class="mt-4 text-gray-600 text-sm">
			Already have an account? <a href="login.jsp"
				class="text-blue-500 font-medium">Login</a>
		</p>
	</div>
</body>
</html>
