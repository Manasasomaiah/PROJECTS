<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Login</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <h2>User Login</h2>
        <%
            // Database connection details
            String dbURL = "jdbc:mysql://localhost:3306/hotel";
            String dbUser = "manasa";
            String dbPass = "manasaAkki@12";
            
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            
            // Process form submission (if data is posted)
            if (request.getMethod().equalsIgnoreCase("post")) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                
                try {
                    // Load the MySQL JDBC driver
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    
                    // Establish connection to MySQL
                    conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                    
                    // Check if user exists with given username and password
                    String sqlSelect = "SELECT * FROM users WHERE username=? AND password=?";
                    pstmt = conn.prepareStatement(sqlSelect);
                    pstmt.setString(1, username);
                    pstmt.setString(2, password);
                    
                    // Execute the query
                    rs = pstmt.executeQuery();
                    
                    // If user exists, redirect to room availability page
                    if (rs.next()) {
                        response.sendRedirect("availability.jsp");
                        return; // Stop further execution
                    } else {
                        out.println("<p>Invalid username or password. Please <a href='login.html'>try again</a>.</p>");
                    }
                } catch (ClassNotFoundException | SQLException e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                } finally {
                    // Close resources
                    try { if (rs != null) rs.close(); } catch (SQLException e) { /* ignored */ }
                    try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { /* ignored */ }
                    try { if (conn != null) conn.close(); } catch (SQLException e) { /* ignored */ }
                }
            }
        %>
        
        <form action="login.jsp" method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required><br><br>
            
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required><br><br>
            
            <input type="submit" value="Login">
        </form>
        <p>New user? <a href="register.html">Register here</a></p>
    </div>
</body>
</html>
