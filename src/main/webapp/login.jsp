<!DOCTYPE html>
<% String error = (String) request.getAttribute("error"); %>
<% 
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0); 
%>
<html lang="en">
<head>
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="0">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login Page</title>
<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet" type="text/css" href="global.css">
</head>

<body class="bg-gray-100 flex flex-col items-center h-screen">

    <!-- Navbar -->
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
                    <a href="/ggg/" class="text-gray-600 hover:text-blue-500 font-medium">Home</a>
                    <a href="register.jsp" class="text-gray-600 hover:text-blue-500 font-medium">Register</a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="flex flex-col items-center mt-8">
        <h1 class="text-2xl poppins-medium text-blue-500">Java CRUD Application</h1>
        <h1 class="text-xl poppins-bold font-bold mt-3">Login</h1>
        <form name="loginForm" action="${pageContext.request.contextPath}/login" class="w-full max-w-sm mt-4">
            <div class="mb-4">
                <input 
                    type="email" 
                    required 
                    class="border border-zinc-600 rounded-md px-3 py-2 w-full"
                    placeholder="Enter your email" 
                    name="email" 
                />
                <p id="emailError" class="text-red-500 text-sm mt-1"></p>
            </div>
            <div class="mb-4">
                <input 
                    type="password" 
                    required 
                    class="border border-zinc-600 rounded-md px-3 py-2 w-full"
                    placeholder="Enter your password" 
                    name="password" 
                />
                <p id="passwordError" class="text-red-500 text-sm mt-1"></p>
            </div>
            <input 
                type="submit"
                class="border rounded-md border-zinc-600 bg-blue-500 text-white font-medium px-3 py-2 w-full"
                value="Login"
            >
        </form>
        <% if (error != null && !error.isEmpty()) { %>
            <p class="text-red-500 mt-4"><%= error %></p>
        <% } %>
        <p class="mt-4 text-gray-600 text-sm">
            Don't have an account? <a href="register.jsp" class="text-blue-500 font-medium">Register here</a>
        </p>
    </div>
</body>
</html>
