<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="refresh" content="3;url=login.html">
    <title>Logout</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <h2>Logout</h2>
        <%
            // Invalidate session to logout user
            session.invalidate();
        %>
        <p>You have been logged out successfully.</p>
        <p>Redirecting to login page...</p>
    </div>
</body>
</html>
