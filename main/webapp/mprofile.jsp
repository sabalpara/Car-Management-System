<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="mechanic.css">
    <title>CARDX - Mechanic Detail</title>
</head>
<style>
/* mechanicdetail.css */
/* General Styles */
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
    padding: 1.5rem 0;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
    position: sticky;
    top: 0;
    z-index: 100;
    align-items: center;
    justify-content: center;
    height:8%;
}

header h1 {
    margin: 0;
    font-size: 2.5rem;
    color: #FFFFFF;
    margin-left:35%;
margin-right:25%;
}

.back-button {
    background-color: #C2D515; /* Button background */
    color: #FFFFFF; /* Text color */
    border: none;
    border-radius: 5px;
    font-size: 16px;
    cursor: pointer;
    transition: transform 0.2s, background-color 0.2s;
    /* Aligns the button to the left */
    display: flex;
    align-items: center; /* Ensures proper alignment */
    z-index: 10; /* Keeps the button above other elements */
    position: relative;
    margin-left:7%;
}

.back-button button {
    padding: 10px 20px;
    background-color: #C2D515;
    border: none;
    border-radius: 5px;
    font-size: 16px;
    color: #FFFFFF;
    cursor: pointer;
    transition: transform 0.2s, background-color 0.2s;
     font-weight: bold;
}
.back-button a{
   display: inline-flex; /* Makes the anchor tag act as a block */
    align-items: center; /* Vertically centers text */
    justify-content: center; /* Horizontally centers text */
    height: 100%; /* Matches parent's height */
    width: 100%; /* Matches parent's width */
    text-decoration: none; /* Removes underline */
    color: white; /* Text color */
    font-weight: bold; /* Bold text */
    font-size: 18px; /* Adjust text size */
}

.mechanic-card {
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

.mechanic-photo {
    flex: 0 0 300px;
}

.mechanic-photo img {
    width: 100%;
    height: 300px;
    object-fit: cover;
    border-radius: 15px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
}

.mechanic-details {
    flex: 1;
}

.mechanic-details table {
    width: 100%;
    border-collapse: collapse;
}

.mechanic-details td {
    padding: 1rem;
    border-bottom: 1px solid #D6D6D6;
}

.mechanic-details td:first-child {
    font-weight: 600;
    color: #C2D515;
    width: 40%;
}

.service-requests {
    max-width: 1200px;
    margin: 2rem auto;
    padding: 0 1rem;
}

.service-reqtitle {
    background-color: #000000;
    padding: 1rem;
    border-radius: 10px;
    margin-bottom: 2rem;
    text-align: center;
}

.service-reqtitle h1 {
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

.servicedetail {
    background-color: #FFFFFF;
    border-radius: 15px;
    padding: 1.5rem;
    margin: 1rem 0;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
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

.fade-in {
    opacity: 0;
    animation: fadeIn 1s forwards;
}

@keyframes fadeIn {
    to {
        opacity: 1;
    }
}

@media (max-width: 768px) {
    .mechanic-card {
        flex-direction: column;
        gap: 2rem;
    }

    .mechanic-photo {
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
<% String name=(String) session.getAttribute("name");
String email=(String) session.getAttribute("email");
String mobile=(String)session.getAttribute("mobile");
String area=(String) session.getAttribute("apt_name")+" "+ (String) session.getAttribute("area_name")+" "+(String) session.getAttribute("city")+" "+(String) session.getAttribute("pin_code")+" "+(String) session.getAttribute("state");
String image1=(String) session.getAttribute("image");
System.out.println(area);

System.out.println("hiiiii");
%>
    <header>
        <h1>CARDX - Mechanic Detail</h1>
        <div class="back-button">
         <a href="#" onclick="document.getElementById('logoutForm').submit();"><button style="color:black"> Logout</button></a>
          <form action="logout" method="post" id="logoutForm" style="display: none;"></form>
        
    </div>
        
    </header>

    <div class="mechanic-card">
        <div class="mechanic-photo">
            <img src="<%=image1 %>" alt="Mechanic Photo">
        </div>
        <div class="mechanic-details">
            <table>
                <tr>
                    <td>Name:</td>
                    <td><%=name%></td>
                </tr>
                <tr>
                    <td>Mechanic ID:</td>
                    <td><%=email%></td>
                </tr>
                <tr>
                    <td>Specialization:</td>
                    <td>Auto Repair</td>
                </tr>
                <tr>
                    <td>Address:</td>
                    <td><%=area%></td>
                </tr>
                <tr>
                    <td>Phone Number:</td>
                    <td><%=mobile%></td>
                </tr>
            </table>
        </div>
    </div>

    <!-- Service Requests section -->
    <section class="service-requests">
        <div class="service-reqtitle"><h1>Service Requests</h1></div>
        <!-- Example service request 1 -->
        
                
        <!-- Add more service requests as needed -->
        
        <%
        
        Class.forName("org.postgresql.Driver");

        String url = "jdbc:postgresql://localhost:5432/postgres";
        String username = "postgres";
        String password2 = "jay";
        
        Connection con = DriverManager.getConnection(url, username, password2);

       
        PreparedStatement ps = con.prepareStatement("select * from service_request where (customer_id,request_time) not in (select customer_id,request_time from service_accept)");
        //ps.setString(1, email);
        ResultSet rs=ps.executeQuery();
        
        
    	// Assuming you have a List of service requests from your database
    	//List<ServiceRequest> serviceRequests = fetchServiceRequestsFromDatabase();
	
	    // Iterate over the service requests and generate HTML dynamically
	    while (rs.next()) {
	    	
	    	ps = con.prepareStatement("select * from customer where \"Email_id\"=?");
	        ps.setString(1, rs.getString(1));
	        ResultSet rs2=ps.executeQuery();
	        rs2.next();
	        
	        ps = con.prepareStatement("select * from address where pincode=?");
            ps.setInt(1, rs2.getInt("pincode"));  // Assuming pincode is an integer
            ResultSet rs3 = ps.executeQuery();
            rs3.next();
	        
            ps=con.prepareStatement("select * from phone_no where Email_id =?");
            ps.setString(1, rs.getString(1));
            ResultSet rs4=ps.executeQuery();
            rs4.next();
            
	    	String a_name=rs2.getString("first_name");
	    	String a_area=rs3.getString("city")+" "+rs3.getString("state");
	    	String a_des=rs.getString("description_about_service");
	    	String a_mobile=rs4.getString("mobile_no");
	    	String image=rs2.getString("image");
	    	
	    	//System.out.println(System.currentTimeMillis());
	    	//System.out.println(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSSSSS").format(new java.sql.Timestamp(System.currentTimeMillis())));
		%>
    	<!-- Dynamic service request -->
    	<div class="request">
	        <div class="user-details">
            	<img src="<%=image %>" alt="User Avatar"
            	class="user-avatar">
            	<div class="user-info">
	                <h2><%= a_name %></h2>
                	<p>Mobile no. : <%=a_mobile%></p>
                	<p>Location:<%= a_area %> </p>
            	</div>
        	</div>
        	<div class="servicedetail">
	            <p>Service Description: <%= a_des %></p>
        	</div>
        	<form action="req_accept" method="post">
    			<div class="buttons">
        		<%
            		java.sql.Timestamp currentTimestamp = new java.sql.Timestamp(System.currentTimeMillis());
            		//System.out.println("Current Timestamp: " + currentTimestamp); // Debug statement
            		String formattedTimestamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSSSSS").format(currentTimestamp);
            		//System.out.println("Formatted Timestamp: " + formattedTimestamp); // Debug statement
        		%>
        			<input type="hidden" name="customer_id" value="<%= rs.getString("customer_id") %>">
        			<input type="hidden" name="req_time" value="<%= rs.getString("request_time") %>">
        			<input type="hidden" name="acc_time" value="<%= formattedTimestamp %>">
        			<button class="accept-button">Accept</button>
        			
    			</div>
			</form>

        	
        	
    	</div>
	<%
	    }
	%>
        
        
    </section>

    
<script>
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        document.querySelector(this.getAttribute('href')).scrollIntoView({
            behavior: 'smooth'
        });
    });
});
    document.querySelectorAll('.request').forEach(request => {
    request.addEventListener('mouseover', () => {
        request.style.transform = 'scale(1.05)';
        request.style.transition = 'transform 0.3s ease';
    });

    request.addEventListener('mouseout', () => {
        request.style.transform = 'scale(1)';
    });
});
    .mechanic-photo img {
    transition: transform 0.3s ease;
}

.mechanic-photo:hover img {
    transform: scale(1.1);
}
    
    const mechanicImages = document.querySelectorAll('.mechanic-photo img');
mechanicImages.forEach(img => {
    img.addEventListener('mouseover', () => {
        img.style.transform = 'scale(1.1)';
        img.style.transition = 'transform 0.3s ease';
    });

    img.addEventListener('mouseout', () => {
        img.style.transform = 'scale(1)';
    });
});
window.addEventListener('DOMContentLoaded', () => {
    const requests = document.querySelectorAll('.request');
    requests.forEach((request, index) => {
        setTimeout(() => {
            request.classList.add('fade-in');
        }, index * 300); // Delay each request fade-in
    });
});
document.addEventListener('DOMContentLoaded', () => {
    const loadingSpinner = document.getElementById('loading-spinner');
    loadingSpinner.style.display = 'block';
    
    setTimeout(() => { // Simulating data loading
        loadingSpinner.style.display = 'none';
    }, 2000);
});
document.querySelectorAll('.request').forEach(request => {
    const serviceDetail = request.querySelector('.servicedetail');
    const toggleButton = document.createElement('button');
    toggleButton.textContent = 'Show Details';
    toggleButton.classList.add('toggle-details');
    request.appendChild(toggleButton);

    toggleButton.addEventListener('click', () => {
        const isVisible = serviceDetail.style.display === 'block';
        serviceDetail.style.display = isVisible ? 'none' : 'block';
        toggleButton.textContent = isVisible ? 'Show Details' : 'Hide Details';
    });
});

</script>
</body>

</html>