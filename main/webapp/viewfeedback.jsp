<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Feedback Data</title>
    <style>
        /* Global Styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #D6D6D6;
            color: #000000;
            margin: 0;
            padding: 0;
        }
        
        h2 {
            text-align: center;
            color: #C2D515;
            margin-top: 20px;
        }
        
        table {
            width: 80%;
            margin: 30px auto;
            border-collapse: collapse;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background-color: #FFFFFF;
        }

        table th, table td {
            padding: 12px;
            text-align: left;
            border: 1px solid #C2D515;
        }

        table th {
            background-color: #C2D515;
            color: #FFFFFF;
        }

        table tr:nth-child(even) {
            background-color: #F4F4F4;
        }

        table tr:hover {
            background-color: #D6D6D6;
            transition: background-color 0.3s ease;
        }

        /* Animation for table rows */
        table tr {
            animation: fadeIn 1s ease-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Styling for error message */
        h2.error {
            color: red;
            text-align: center;
        }

        /* Button and link styling */
        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            font-size: 16px;
        }

        .back-link a {
            color: #C2D515;
            text-decoration: none;
            font-weight: bold;
        }

        .back-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <%
        try {
            response.setContentType("text/html");
            Class.forName("org.postgresql.Driver");
            String url = "jdbc:postgresql://localhost:5432/postgres";
            String username = "postgres";
            String password2 = "jay";

            Connection con = DriverManager.getConnection(url, username, password2);
            PreparedStatement ps = con.prepareStatement("select * from feedback");
            ResultSet rs = ps.executeQuery();
    %>

    <h2 style="color:black;">Feedback Data</h2>
    
    <table>
        <thead>
            <tr>
                <th>Email Id</th>
                <th>Feedback Time</th>
                <th>Description</th>
            </tr>
        </thead>
        <tbody>
            <%
                while(rs.next()) {
            %>
                <tr>
                    <td><%= rs.getString("email_id") %></td>
                    <td><%= rs.getTimestamp("time") %></td>
                    <td><%= rs.getString("description") %></td>
                </tr>
            <%
                }
            %>
        </tbody>
    </table>

    <div class="back-link">
        <a style="color:black;" href="admin.jsp">Go Back</a>
    </div>

    <%
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            System.out.println("PostgreSQL JDBC driver not found");
        } catch (SQLException e) {
            response.setContentType("text/html");
            out.print("<h2 class='error'>" + e.getMessage() + "</h2>");
            RequestDispatcher rd = request.getRequestDispatcher("/admin.jsp");
            rd.include(request, response);
        }
    %>
</body>
</html>
