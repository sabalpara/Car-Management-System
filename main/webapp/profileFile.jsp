<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="userdetail.css">
    <title>CARDX - User Detail</title>
</head>
<style>
.back-button a {
    text-decoration: none;
}

.back-button button {
    background-color: #C2D515; /* Button background */
    color: black; /* Text color */
    border: none;
    border-radius: 5px;
    padding: 10px 20px;
    font-size: 16px;
    cursor: pointer;
    transition: transform 0.2s, background-color 0.2s;
    margin-right:5%;
}

/* Hover Effect */
.back-button button:hover {
    background-color: #A4B410; /* Slightly darker green */
    transform: scale(1.05);
}

/* Centering the h1 */

/* Hover Effect */
.back-button button:hover {
    background-color: #A4B410; /* Slightly darker green */
    transform: scale(1.05);    /* Grows slightly */
}

/* Active Effect */
.back-button button:active {
    transform: scale(1);       /* Resets size when clicked */
}
    body {
        font-family: 'Poppins', sans-serif;
        margin: 0;
        padding: 0;
        background-color: #D6D6D6;
        color: #000000;
        line-height: 1.6;
    }

    header {
        display: flex;
        background-color: #000000;
        color: #C2D515;
        padding: 35px 0px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
        position: sticky;
        top: 0;
        z-index: 100;
        
       
       
       justify-content: space-between; /* Distribute space: button on right */
    align-items: center; /* Align content vertically */
    
    }

    header h1 {
     display: flex;
        margin: 0;
        font-size: 2.5rem;
        color: #FFFFFF;
        align-items: center;
        justify-content:center;
        margin-left:37%;
       
        
    }

    .user-card {
        background-color: #FFFFFF;
        color: #000000;
        border-radius: 20px;
        margin: 2rem auto;
        max-width: 1000px;
        padding: 2rem;
        display: flex;
        gap: 3rem;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
    }

    .user-photo {
        flex: 0 0 300px;
    }

    .user-photo img {
        width: 100%;
        height: 300px;
        object-fit: cover;
        border-radius: 15px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
    }

    .edit-button {
        margin-top: 1.5rem;
        padding: 0.8rem 1.5rem;
        background-color: #C2D515;
        color: #000000;
        border: none;
        border-radius: 25px;
        font-size: 1rem;
        cursor: pointer;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        width: 100%;
    }

    .edit-button:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(194, 213, 21, 0.4);
    }

    .user-details {
        flex: 1;
    }

    .user-details table {
        width: 100%;
        border-collapse: collapse;
    }

    .user-details td {
        padding: 1rem;
        border-bottom: 1px solid #D6D6D6;
    }

    .user-details td:first-child {
        font-weight: 600;
        color: #C2D515;
        width: 40%;
    }

    .bargain-requests {
        max-width: 1200px;
        margin: 2rem auto;
        padding: 0 1rem;
    }

    .bargain-reqtitle {
        background-color: #000000;
        padding: 1rem;
        border-radius: 10px;
        margin-bottom: 2rem;
        text-align: center;
    }

    .bargain-reqtitle h1 {
        margin: 0;
        font-size: 1.8rem;
        color: #FFFFFF;
    }

    .request {
        background-color: #FFFFFF;
        border-radius: 15px;
        padding: 1.5rem;
        margin-bottom: 1.5rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
    }

    .user-avatar {
        width: 80px;
        height: 80px;
        border-radius: 50%;
        object-fit: cover;
        border: 3px solid #C2D515;
    }

    .user-info h2 {
        margin: 0 0 0.5rem 0;
        color: #000000;
    }

    .reqstatus {
        background-color: #D6D6D6;
        padding: 0.8rem 1.5rem;
        border-radius: 25px;
        text-align: center;
    }

    .reqstatus h1 {
        margin: 0;
        font-size: 1.2rem;
        color: #000000;
    }

    .buttons button {
        padding: 0.8rem 1.5rem;
        margin: 0 0.5rem;
        border: none;
        border-radius: 25px;
        font-weight: 600;
        cursor: pointer;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .accept-button {
        background-color: #C2D515;
        color: #000000;
    }

    .reject-button {
        background-color: #D6D6D6;
        color: #000000;
    }

    .buttons button:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
    }

    .servicedetail {
        background-color: #FFFFFF;
        border-radius: 15px;
        padding: 1.5rem;
        margin: 1rem 0;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    }

    .image {
        background-color: #D6D6D6;
        padding: 1.5rem;
        border-radius: 15px;
        margin: 2rem auto;
        max-width: 500px;
        text-align: center;
    }

    .image input[type="file"] {
        background-color: #FFFFFF;
        padding: 0.8rem;
        border-radius: 25px;
        margin-right: 1rem;
    }

    .image input[type="submit"] {
        background-color: #C2D515;
        color: #000000;
        border: none;
        padding: 0.8rem 1.5rem;
        border-radius: 25px;
        cursor: pointer;
        transition: transform 0.3s ease;
    }

    .image input[type="submit"]:hover {
        transform: translateY(-2px);
    }
     .dialog-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                z-index: 1000;
                display: none;
                justify-content: center;
                align-items: center;
            }

            .dialog {
                background: white;
                padding: 20px;
                border-radius: 10px;
                text-align: center;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
                z-index: 1100;
            }

            .dialog button {
                margin: 10px;
                width: auto;
                padding: 10px 20px;
            }

            .blurred {
                filter: blur(5px);
                pointer-events: none; /* Disable interactions with blurred elements */
            }
            #confirmBtn{
            color:green;
             }
              #cancelBtn{
            color:red;
             }

.blurred {
    filter: blur(5px);
    pointer-events: none; /* Disable interactions with blurred elements */
}
    

    @media (max-width: 768px) {
        .user-card {
            flex-direction: column;
            gap: 2rem;
        }
        
        .user-photo {
            flex: 0 0 auto;
        }
        
        .request {
            flex-direction: column;
            text-align: center;
        }
        
        .user-info {
            margin: 1rem 0;
        }
        
        .buttons {
            margin-top: 1rem;
        }
    }
</style>

<body>

<%   String email1=(String) session.getAttribute("email");
    String name = (String) session.getAttribute("first_name") + " " + (String) session.getAttribute("last_name");
    String pincode1 = (String) session.getAttribute("pin_code");
    String area1 = (String) session.getAttribute("city");
    String mobile1 = (String) session.getAttribute("mobile");
    String area = (String) session.getAttribute("apt_name") + ", " + (String) session.getAttribute("area_name") + ", " + (String) session.getAttribute("city") + ", " + (String) session.getAttribute("state");
    int totalnew1=0;
    int totalold1=0;
    int totalrent1=0;
    
    try{
    	Class.forName("org.postgresql.Driver");
        Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "postgres", "jay");
        PreparedStatement preparedStatement1 = connection.prepareStatement("select * from buy_newcar where customer_id=? ");
        preparedStatement1.setString(1, email1);
        PreparedStatement preparedStatement2 = connection.prepareStatement("select * from rent where customer_id=? ");
        preparedStatement2.setString(1, email1);
        PreparedStatement preparedStatement3 = connection.prepareStatement("select * from old_car where seller_id=? and buyer_id is not null");
        preparedStatement3.setString(1, email1);
        ResultSet totalnew=preparedStatement1.executeQuery();
        ResultSet totalrent=preparedStatement2.executeQuery();
        ResultSet totalold=preparedStatement3.executeQuery();
        String image1=(String) session.getAttribute("image");
        //System.out.println( image1+"jay2");
        
        
        while (totalold.next()) {
            // Retrieve the count value from the ResultSet
            totalold1++;
        //    totalold1 = totalold.getInt(1); // Assuming count(car_id) is the first (and only) column in the result
        }
        
        while (totalnew.next()) {
            // Retrieve the count value from the ResultSet
            totalnew1++; // Assuming count(car_id) is the first (and only) column in the result
        } 
        
        while (totalrent.next()) {
            // Retrieve the count value from the ResultSet
            totalrent1++;
            }
        
        totalnew.close();
        totalrent.close();
        totalold.close();
        connection.close();
        
    }

    catch (ClassNotFoundException e) {
        e.printStackTrace();
        System.out.println("PostgreSQL JDBC driver not found");
    } catch (SQLException e) {
    	//response.setContentType("text/html");
    	out.print("<h2 style='color:red'> "+e.getMessage() +"</h2>");
    	RequestDispatcher rd=request.getRequestDispatcher("/index.jsp");
    	rd.include(request, response);
    }
    
%>

<header>
    <h1>CARDX - User Detail</h1>
    <div class="back-button" style="background-color: #C2D515; /* Button background */
    color: black; /* Text color */
    border: none;
    border-radius: 5px;
    padding: 10px 20px;
    font-size: 16px;
    cursor: pointer;
    transition: transform 0.2s, background-color 0.2s;
    margin-right:3%;">
        <a href="homepage.jsp">
            <button style="color:black"> Home</button>
        </a>
    </div>
</header>

 
<div class="user-card">
    <div class="user-photo">
    <% String image2=(String) session.getAttribute("image");
         // System.out.println(image2+"hiiii");%>
        <img src="<%=image2 %>" onerror="this.onerror=null; this.src='alt.jpg';">
        <form action="addimage" method="post" enctype="multipart/form-data">
        <div  class="image">    add image : <input type="file" name="image">
           <input type="submit"> </div>
           </form>
    </div>
    <div class="user-details">
        <table>
            <tr>
                <td>Name:</td>
                <td><%=name %></td>
            </tr>
            <tr>
                <td>Address:</td>
                <td><%=area %></td>
            </tr>
            <tr>
                <td>City:</td>
                <td><%=area1 %> </td>
            </tr>

            <tr>
                <td>Pincode:</td>
                <td><%=pincode1 %></td>
            </tr>
            <tr>
                <td>Phone Number:</td>
                <td><%=mobile1 %></td>
            </tr>
            <tr>
                <td>New Cars Bought:</td>
                <td><%=totalnew1 %></td>
            </tr>
            <tr>
                <td>Cars Sold:</td>
                <td><%=totalold1 %></td>
            </tr>
            <tr>
                <td>Cars Rented:</td>
                <td><%=totalrent1 %></td>
            </tr>
        </table>
    </div>
    
</div>

    <div class="image">
       <a href="editprofile.jsp"><button class="edit-button">Edit-Profile</button></a>
        </div>
        

<!-- Bargain Requests section -->
<section class="bargain-requests">
    <!-- Example bargain request 1 -->
    <div class="bargain-reqtitle">
        <h1>Sent - Bargain Requests</h1>
    </div>

    <%
        try {
        	 
            int a = 100;
            int b = 101;
            Class.forName("org.postgresql.Driver");
            Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "postgres", "jay");

            PreparedStatement preparedStatement = connection.prepareStatement(
            	    "SELECT * FROM bargain_request WHERE customer_id = ? " +
            	    	    "ORDER BY request_time DESC"
            	    	);
            preparedStatement.setString(1, (String) session.getAttribute("email"));
            //System.out.println( (String) session.getAttribute("email")+" my name is jay ");
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                a++;
                
                String  carId = resultSet.getString("car_id");
                System.out.println( (String) session.getAttribute("email")+"  "+carId);
                String query = "SELECT * FROM public.old_car_model WHERE car_id = ?";
                
                try (PreparedStatement oldCarPreparedStatement = connection.prepareStatement(query)) {
                    oldCarPreparedStatement.setInt(1, Integer.parseInt(carId));
                    try (ResultSet oldCarResultSet = oldCarPreparedStatement.executeQuery()) {
                        if (oldCarResultSet.next()) {
                        	String image=oldCarResultSet.getString("image");
                        	String name1=oldCarResultSet.getString("seller_id");
                        	 Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "postgres", "jay");
                        	 PreparedStatement ps = con.prepareStatement("select * from customer where  \"Email_id\" = ?");
                             ps.setString(1, name1);
                             ResultSet rs=ps.executeQuery();
                             rs.next();
                             String name2=rs.getString("first_name")+" "+rs.getString("last_name");
                
    %>
                <div class="request">
                    <div class="user-details">
                        <img src="<%=image %>" onerror="this.onerror=null; this.src='alt.jpg';" class="user-avatar">
                        <div class="user-info">
                            <h2><%=name2 %></h2>
                            <p>Car Model: <%= oldCarResultSet.getString("model") %></p>
                            <p>Car Company: <%= oldCarResultSet.getString("company_name") %></p>
                            <p>Price: <%= resultSet.getString("price") %></p>
                            <p>Request_time: <%= resultSet.getString("request_time") %></p>
                        </div>
                    </div>
                    <div class="reqstatus">
                        <h1>
                            <%            
                                            String buyerId = oldCarResultSet.getString("buyer_id");
                                            if (buyerId == null) {
                            %>
                                                Pending
                            <%
                                            } else if (buyerId.equals(session.getAttribute("email")) && resultSet.getString("price").equals(oldCarResultSet.getString("price")) ) {
                            %>
                                               Accepted

                            <%
                                            } else {
                            %>                   
                                                Rejected
                            <%
                                            }
                                        }
                                    }
                                }
                            %>
                        </h1>
                    </div>
                </div>
            <%
                }
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
            }
        %>

    <div class="bargain-reqtitle">
        <h1>Received - Bargain Requests</h1>
    </div>

    <!-- Example bargain request 2 -->
    <%
    String carId="";
        String model = "";
        String company = "";
        try {
            Class.forName("org.postgresql.Driver");
            Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "postgres", "jay");

            // Get customer ID from the session
            String customerId = (String) session.getAttribute("email");

            // Query to get old_car information for the customer
            String oldCarQuery = "SELECT * FROM old_car WHERE seller_id = ? and buyer_id is null";
            try (PreparedStatement oldCarStatement = connection.prepareStatement(oldCarQuery)) {
            	
                oldCarStatement.setString(1, customerId);
                try (ResultSet oldCarResultSet = oldCarStatement.executeQuery()) {
                    while (oldCarResultSet.next()) {
                    	
                         carId = oldCarResultSet.getString("car_id");
                         String image=oldCarResultSet.getString("image");
                        String carDetailsQuery = "SELECT * FROM old_car_model WHERE car_id = ?";
                        
                        PreparedStatement car_statement = connection.prepareStatement(carDetailsQuery);
                        car_statement.setInt(1, Integer.parseInt(carId));

                        try (ResultSet carResultSet = car_statement.executeQuery()) {
                            if (carResultSet.next()) {
                                model = carResultSet.getString("model");
                                company = carResultSet.getString("company_name");
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }

                        String bargainRequestQuery = "SELECT * FROM bargain_request WHERE car_id = ? and accept_time  is null";
                        

                        try (PreparedStatement bargainRequestStatement = connection.prepareStatement(bargainRequestQuery)) {
                            bargainRequestStatement.setInt(1, Integer.parseInt(carId));
                            try (ResultSet bargainRequestResultSet = bargainRequestStatement.executeQuery()) {
                                while (bargainRequestResultSet.next()) {
                                    // Get customer ID from the bargain request
                                   // out.println("hi");
                                    String customerEmail = bargainRequestResultSet.getString("customer_id");

                                    // Query to get customer information
                                    String customerQuery = "SELECT * FROM customer WHERE \"Email_id\" = ?";
                                    try (PreparedStatement customerStatement = connection.prepareStatement(customerQuery)) {
                                        customerStatement.setString(1, customerEmail);
                                        try (ResultSet customerResultSet = customerStatement.executeQuery()) {
                                            if (customerResultSet.next()) {
                                                // Display information for each received bargain request
    %>
                                                <div class="request">
                                                    <div class="user-details">
                                                        <img src="<%=image %>" onerror="this.onerror=null; this.src='download.jpeg';" class="user-avatar">
                                                        <div class="user-info">
                                                            <h2>Model: <%= model %>  Company name: <%= company %>  </h2>
                                                            <h2><%= customerResultSet.getString("first_name") %> <%= customerResultSet.getString("last_name") %></h2>
                                                            <p>Email: <%= customerResultSet.getString(1) %></p>
                                                            <p> price: <%= bargainRequestResultSet.getString(3) %> </p>
                                                                                                     
                                                            <!-- Add other customer information as needed -->
                                                        </div>
                                                    </div>
                                                    <div class="buttons">
                                                    <form action="request" method="post">
                                                    <input type="hidden" name="car_id" id="car_id" value="<%=oldCarResultSet.getString("car_id") %>">
                                                    <input type="hidden" name="price" id="price" value="<%=bargainRequestResultSet.getString(3)  %>">
                                                     <input type="hidden" name="buyer" id="buyer" value="<%=customerResultSet.getString(1)  %>">
                                                     <input type="hidden" name="seller" id="seller" value="<%=customerId%>">
                                                        <button class="accept-button"  name =1 value="Accept" id="submitRentalCarBtn">Accept</button>
                                                        <button class="reject-button" name =2 value="Reject">Reject</button>
                                                        </form>
                                                    </div>
                                                </div>

                                                <!-- Query to get car details from old_car_model view -->
                                               
    <%
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    %>
    
    <!-- Add more requests as needed -->
    <div class="bargain-reqtitle">
        <h1>send - Service Requests</h1>
    </div>
    
    <%
            
            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "postgres", "jay");

            //PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM service_request WHERE customer_id = ?");
            //preparedStatement.setString(1, (String) session.getAttribute("email"));
            PreparedStatement ps = con.prepareStatement("select * from service_request where (customer_id,request_time) not in (select customer_id,request_time from service_accept) and customer_id= ?");
            ps.setString(1, (String) session.getAttribute("email"));
            ResultSet rs=ps.executeQuery();
            //ResultSet resultSet = preparedStatement.executeQuery();

            while (rs.next()) {
                
            	String Address = area1+" "+(String) session.getAttribute("state");
                String des = rs.getString("description_about_service");
                       
                
    %>
    
    
    <div class="request">
        <div class="user-details">
            <img src="https://source.unsplash.com/random/150x150?person" onerror="this.onerror=null; this.src='alt.jpg';" class="user-avatar">
            <div class="user-info">
                <h2>Your request will be accepted soon</h2>
                <p> xx-xxxx-xxxx</p>
                <p>Location:<%=  Address %></p>         
            </div>
        </div>
        <div class="servicedetail">
	            <p>Service Description:<%= des  %></p>
        	</div>
        <div class="reqstatus">
           <h1>Pending</h1>
        </div>
    </div>
    <%
            }
    
    %>
    <%
            
    
            //PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM service_request WHERE customer_id = ?");
            //preparedStatement.setString(1, (String) session.getAttribute("email"));
            PreparedStatement pss;
            PreparedStatement pss1;
            PreparedStatement pss2;
            PreparedStatement ps1 = con.prepareStatement("select * from service_accept where customer_id = ?");
            ps1.setString(1, (String) session.getAttribute("email"));
            //PreparedStatement ps2 = con.prepareStatement("select * from service_request where (customer_id,request_time) in (select customer_id,request_time from service_accept) and customer_id= ?");
            //ps2.setString(1, (String) session.getAttribute("email"));
            ResultSet rs1=ps1.executeQuery();
           // ResultSet rs2=ps2.executeQuery();
            //ResultSet resultSet = preparedStatement.executeQuery();

            while (rs1.next() ) {
            	

                
                String Address = area1+" "+(String) session.getAttribute("state");
                
                pss = con.prepareStatement("select * from service_request where customer_id = ? and request_time=?::timestamp");
                pss.setString(1,(String)session.getAttribute("email"));
                pss.setTimestamp(2,rs1.getTimestamp("request_time"));
                ResultSet rss=pss.executeQuery();
                rss.next();
                
                pss1 = con.prepareStatement("select * from customer where \"Email_id\"= ? ");
                pss1.setString(1,rs1.getString("mechanic_id"));
                ResultSet rss1=pss1.executeQuery();
                rss1.next();
                
                pss2 = con.prepareStatement("select * from phone_no where email_id = ? ");
                pss2.setString(1,rs1.getString("mechanic_id"));
                ResultSet rss2=pss2.executeQuery();
                rss2.next();
                
              
                String image=rss1.getString("image");
                String mname = rss1.getString("first_name")+" "+rss1.getString("last_name");
                String mmob = rss2.getString("mobile_no");
                String des = rss.getString("description_about_service");
                     
                
    %>
    
    
    <div class="request">
        <div class="user-details">
            <img src="<%=image %>" onerror="this.onerror=null; this.src='alt.jpg';" class="user-avatar">
            <div class="user-info">
                <h2><%= mname %></h2>
                <p> <%= mmob %></p>
                <p>Location:<%=  Address %></p>         
            </div>
        </div>
        <div class="servicedetail">
	            <p>Service Description:<%= des  %></p>
        	</div>
        <div class="reqstatus">
           <h1>Accepted</h1>
        </div>
    </div>
    <%
            }
    
    %>
    
    <!-- Add more requests as needed -->
</section>
 
<script >
function goBack() {
    // Check if there's a previous page in the browser history
    if (document.referrer) {
        window.history.back(); // Go back to the previous page
    } else {
        window.location.href = 'homepage.jsp'; // Fallback to homepage.jsp
    }
}
</script>
</body>

</html>
