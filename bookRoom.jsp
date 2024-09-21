<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Book Room</title>
</head>
<body>
    <h2>Book Room</h2>
    <%
        // Database connection details
        String dbURL = "jdbc:mysql://localhost:3306/hotel";
        String dbUser = "manasa";
        String dbPass = "manasaAkki@12";
        
        Connection conn = null;
        PreparedStatement pstmtBook = null;
        PreparedStatement pstmtVacate = null;
        
        // Get room ID from form submission
        String room_id_str = request.getParameter("room_id");
        
        if (room_id_str != null && !room_id_str.isEmpty()) {
            int roomId = Integer.parseInt(room_id_str);
            
            try {
                // Load the MySQL JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");
                
                // Establish connection to MySQL
                conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                
                // Perform booking logic (update room availability)
                String sqlBook = "UPDATE rooms SET availability = false WHERE id = ?";
                pstmtBook = conn.prepareStatement(sqlBook);
                pstmtBook.setInt(1, roomId);
                int rowsAffected = pstmtBook.executeUpdate();
                
                // Display success message
                out.println("<p>Room with ID " + roomId + " booked successfully. Rows affected: " + rowsAffected + "</p>");
                
            } catch (ClassNotFoundException | SQLException e) {
                out.println("<p>Error booking room: " + e.getMessage() + "</p>");
            } finally {
                // Close resources
                try { if (pstmtBook != null) pstmtBook.close(); } catch (SQLException e) { /* ignored */ }
                try { if (conn != null) conn.close(); } catch (SQLException e) { /* ignored */ }
            }
        } else {
            out.println("<p>Room ID parameter is missing or empty.</p>");
        }
    %>
    
    <p><a href="availability.jsp">Back to Availability</a></p>
    <p><a href="profile.jsp">Back to Profile</a></p>
    <p><a href="logout.jsp">Logout</a></p>
</body>
</html>
