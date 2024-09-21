<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <h2>User Profile</h2>
        <%
            // Database connection details
            String dbURL = "jdbc:mysql://localhost:3306/hotel";
            String dbUser = "manasa";
            String dbPass = "manasaAkki@12";
            
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            
            // Get username from session or request parameter (ensure user is logged in)
            String username = (String) session.getAttribute("username");
            if (username == null) {
                response.sendRedirect("login.html");
                return;
            }
            
            try {
                // Load the MySQL JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");
                
                // Establish connection to MySQL
                conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                
                // Query user details based on username
                String sqlSelect = "SELECT * FROM users WHERE username=?";
                pstmt = conn.prepareStatement(sqlSelect);
                pstmt.setString(1, username);
                
                // Execute the query
                rs = pstmt.executeQuery();
                
                // Display user profile information
                if (rs.next()) {
                    out.println("<p><strong>Username:</strong> " + rs.getString("username") + "</p>");
                    out.println("<p><strong>Email:</strong> " + rs.getString("email") + "</p>");
                    // Add more profile information as needed
                } else {
                    out.println("<p>User not found.</p>");
                }
            } catch (ClassNotFoundException | SQLException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                // Close resources
                try { if (rs != null) rs.close(); } catch (SQLException e) { /* ignored */ }
                try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { /* ignored */ }
                try { if (conn != null) conn.close(); } catch (SQLException e) { /* ignored */ }
            }
        %>
        
        <p><a href="availability.jsp">Back to Room Availability</a></p>
        <p><a href="logout.jsp">Logout</a></p>
    </div>
</body>
</html>
