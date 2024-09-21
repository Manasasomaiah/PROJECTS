<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <h2>User Registration</h2>
        <%
            // Database connection details
            String dbURL = "jdbc:mysql://localhost:3306/hotel";
            String dbUser = "manasa";
            String dbPass = "manasaAkki@12";
            
            Connection conn = null;
            PreparedStatement pstmt = null;
            
            // Process form submission (if data is posted)
            if (request.getMethod().equalsIgnoreCase("post")) {
                String username = request.getParameter("username");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                
                try {
                    // Load the MySQL JDBC driver
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    
                    // Establish connection to MySQL
                    conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                    
                    // Insert data into the users table
                    String sqlInsert = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";
                    pstmt = conn.prepareStatement(sqlInsert);
                    pstmt.setString(1, username);
                    pstmt.setString(2, email);
                    pstmt.setString(3, password);
                    
                    // Execute the insert statement
                    int rowsAffected = pstmt.executeUpdate();
                    
                    // Redirect to login page after successful registration
                    response.sendRedirect("login.html");
                    return; // Stop further execution
                } catch (ClassNotFoundException | SQLException e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                } finally {
                    // Close resources
                    try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { /* ignored */ }
                    try { if (conn != null) conn.close(); } catch (SQLException e) { /* ignored */ }
                }
            }
        %>
        
        <form action="register.jsp" method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required><br><br>
            
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required><br><br>
            
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required><br><br>
            
            <input type="submit" value="Register">
        </form>
        <p>Already have an account? <a href="login.html">Login here</a></p>
    </div>
</body>
</html>
