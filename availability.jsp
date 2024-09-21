<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Room Availability</title>
    <style>
        .container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px; /* Adjust the gap between room cards */
        }
        .room-card {
            width: 300px; /* Adjust the width of each room card */
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        .book-button {
            background-color: green; /* Default color */
            color: white;
            padding: 10px;
            border: none;
            cursor: pointer;
            width: 100%; /* Full width button */
        }
        .book-button.booked {
            background-color: red !important;
        }
        .vacate-button {
            background-color: #ff6347; /* Coral color */
            color: white;
            padding: 10px;
            border: none;
            cursor: pointer;
            width: 100%; /* Full width button */
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Available Rooms</h2>
        <%
            // Database connection details
            String dbURL = "jdbc:mysql://localhost:3306/hotel";
            String dbUser = "manasa";
            String dbPass = "manasaAkki@12";
            
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            
            try {
                // Load the MySQL JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");
                
                // Establish connection to MySQL
                conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                
                // Query available rooms (distinct)
                String sqlSelect = "SELECT DISTINCT id, room_number, availability FROM rooms";
                pstmt = conn.prepareStatement(sqlSelect);
                rs = pstmt.executeQuery();
                
                // Display available rooms
                while (rs.next()) {
                    int roomId = rs.getInt("id");
                    String roomNumber = rs.getString("room_number");
                    boolean availability = rs.getBoolean("availability");
                    
                    // Start room card
                    out.println("<div class='room-card'>");
                    out.println("<p>Room Number: " + roomNumber + "</p>");
                    
                    // Display booking button or not available message
                    if (availability) {
                        out.println("<form action='bookRoom.jsp' method='post'>");
                        out.println("<input type='hidden' name='room_id' value='" + roomId + "'>");
                        out.println("<input type='submit' class='book-button' value='Book'>");
                        out.println("</form>");
                    } else {
                        out.println("<p>Room not available</p>");
                        // Vacate button to mark room as available
                        out.println("<form action='vacateRoom.jsp' method='post'>");
                        out.println("<input type='hidden' name='room_id' value='" + roomId + "'>");
                        out.println("<input type='submit' class='vacate-button' value='Vacate Room'>");
                        out.println("</form>");
                    }
                    
                    // End room card
                    out.println("</div>");
                }
                
                // If no rooms are available
                if (!rs.isBeforeFirst()) {
                    out.println("<p>No rooms available at the moment.</p>");
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
        
        <p><a href="profile.jsp">Back to Profile</a></p>
        <p><a href="logout.jsp">Logout</a></p>
    </div>
</body>
</html>
