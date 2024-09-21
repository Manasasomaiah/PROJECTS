<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Vacate Room</title>
    <meta http-equiv="refresh" content="3;url=availability.jsp">
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <h2>Vacate Room</h2>
        <%
            // Database connection details
            String dbURL = "jdbc:mysql://localhost:3306/hotel";
            String dbUser = "manasa";
            String dbPass = "manasaAkki@12";
            
            Connection conn = null;
            PreparedStatement pstmt = null;
            
            // Get room ID from form submission
            int roomId = Integer.parseInt(request.getParameter("room_id"));
            
            try {
                // Load the MySQL JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");
                
                // Establish connection to MySQL
                conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                
                // Update room availability to true (vacate)
                String sqlUpdate = "UPDATE rooms SET availability = true WHERE id = ?";
                pstmt = conn.prepareStatement(sqlUpdate);
                pstmt.setInt(1, roomId);
                
                // Execute the update
                int rowsAffected = pstmt.executeUpdate();
                
                // Display vacancy confirmation
                if (rowsAffected > 0) {
                    out.println("<p>Room vacated successfully!</p>");
                } else {
                    out.println("<p>Failed to vacate the room. Please try again.</p>");
                }
                
            } catch (ClassNotFoundException | SQLException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                // Close resources
                try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { /* ignored */ }
                try { if (conn != null) conn.close(); } catch (SQLException e) { /* ignored */ }
            }
        %>
        
        <p>Redirecting back to availability page...</p>
    </div>
</body>
</html>
