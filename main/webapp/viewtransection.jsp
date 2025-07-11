<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Transaction Records</title>
<style>
    /* General Styles */
    body {
        font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #000000;
        color: #FFFFFF;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        min-height: 100vh;
    }

    h1 {
        margin-bottom: 1.5rem;
        font-size: 2rem;
        color: #C2D515;
        text-align: center;
    }

    /* Table Styles */
    table {
        width: 90%;
        max-width: 1200px;
        border-collapse: collapse;
        background-color: #FFFFFF;
        margin: 20px auto;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        border-radius: 8px;
        overflow: hidden;
    }

    th, td {
        padding: 12px 20px;
        text-align: left;
    }

    th {
        background-color: #C2D515;
        color: #000000;
        font-size: 1rem;
        font-weight: bold;
    }

    tr:nth-child(even) {
        background-color: #D6D6D6;
    }

    tr:nth-child(odd) {
        background-color: #FFFFFF;
    }

    tr:hover {
        background-color: #C2D515;
        color: #000000;
        transform: scale(1.01);
        transition: all 0.2s ease-in-out;
    }

    td {
        font-size: 0.9rem;
        color: #000000;
    }

    /* Add animation for hover effect */
    table {
        animation: fadeIn 1s ease;
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

    /* Responsive Design */
    @media (max-width: 768px) {
        table {
            width: 100%;
        }

        th, td {
            padding: 10px 15px;
            font-size: 0.8rem;
        }
    }
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
    <h1>Transaction Records</h1>
    <%
        try {
            response.setContentType("text/html");
            Class.forName("org.postgresql.Driver");
            String url = "jdbc:postgresql://localhost:5432/postgres";
            String username = "postgres";
            String password2 = "jay";
            
            Connection con = DriverManager.getConnection(url, username, password2);
            
            PreparedStatement ps = con.prepareStatement("select * from transaction");
            
            ResultSet rs=ps.executeQuery();
    %>
    
    <table>
        <tr>
            <th>Transaction ID</th>
            <th>Amount</th>
            <th>Buyer ID</th>
            <th>Seller ID</th>
            <th>Date</th>
            <th>Car Type</th>
            <th>Car ID</th>
        </tr>
        <%
            while(rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("transaction_id") %></td>
            <td><%= rs.getInt("amount") %></td>
            <td><%= rs.getString("buyer_id") %></td>
            <td><%= rs.getString("seller_id") %></td>
            <td><%= rs.getDate("date") %></td>
            <td><%= rs.getString("car_type") %></td>
            <td><%= rs.getInt("car_id") %></td>
        </tr>
        <%
            }
        %>
    </table>
    <div class="back-link">
        <a href="admin.jsp">Go Back</a>
    </div>
    <%
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            System.out.println("PostgreSQL JDBC driver not found");
        } catch (SQLException e) {
            response.setContentType("text/html");
            out.print("<h2 style='color:red'> "+e.getMessage() +"</h2>");
            RequestDispatcher rd=request.getRequestDispatcher("/admin.jsp");
            rd.include(request, response);
        }
    %>
</body>
</html>
