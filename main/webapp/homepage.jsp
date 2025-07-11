<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Car Expo</title>
  <link rel="stylesheet" href="homepage.css">
</head>
<script>
  function redirectToPage1() {
      // Use the window.location.href property to set the URL you want to redirect to.
      window.location.href = 'Newcar.jsp';
      //document.getElementById("logoutForm").submit();
  }
  function redirectToPage0() {
      // Use the window.location.href property to set the URL you want to redirect to.
      window.location.href = 'profileFile.jsp';
      //document.getElementById("logoutForm").submit();
  }
  function redirectToPage2() {
      // Use the window.location.href property to set the URL you want to redirect to.
      window.location.href = 'sell_car.jsp';
      //document.getElementById("logoutForm").submit();
  }
  function redirectToPage3() {
      // Use the window.location.href property to set the URL you want to redirect to.
      window.location.href = 'oldcar.jsp';
      //document.getElementById("logoutForm").submit();
  }
  function redirectToPage4() {
      // Use the window.location.href property to set the URL you want to redirect to.
      window.location.href = 'Rentcar.jsp';
      //document.getElementById("logoutForm").submit();
  }
  function redirectToPage5() {
      // Use the window.location.href property to set the URL you want to redirect to.
      window.location.href = 'mlogin.jsp';
      //document.getElementById("logoutForm").submit();
  }
</script>
<body>
<% String name=(String) session.getAttribute("name");%>
  <header class="navbar">
    <div class="logo">
      <h1>CARDX</h1>
    </div>
    <nav>
      <ul>
       
        <li><a href="Newcar.jsp">Buy Car</a></li>
        <li><a href="sell_car.jsp">Sell your Car</a></li>
        <li><a href="Rentcar.jsp">Rent Car</a></li>
        <li><a href="profileFile.jsp">profile</a></li>
        <li><a href="#about">About Us</a></li>
        <li>
          <a href="#" onclick="document.getElementById('logoutForm').submit();">Logout</a>
          <form action="logout" method="post" id="logoutForm" style="display: none;"></form>
        </li>
      </ul>
    </nav>
  </header>

  <section class="hero">
    <div class="hero-text">
      <h1>Welcome <%=name %>  to CARDX</h1>
      <p>Discover the easiest way to buy or rent a car! Explore a wide range of vehicles, compare prices, and find flexible rental options tailored to your needs.</p>
    </div>
    <div class="hero-image">
      <img src="vehicle.png.webp" alt="Car Image">
    </div>
  </section>

  <section class="categories">
    <h2>Popular Categories</h2>
    <div class="category-buttons">
      <button>SUV</button>
      <button>Hybrid</button>
      <button>Petrol</button>
      <button onclick="redirectToPage3()">Used Car</button>
      <button>Electric</button>
      <button>Sedan</button>
      <button>Convertible</button>
      <button>Diesel</button>
    </div>
    <div class="car-grid">
      <!-- Repeat this block for each car -->
      <div class="car-card">
      <img src="navigation.png
        " alt="Mercedes Benz">
        <h3>Mercedes Benz</h3>
        <p>CLA Coupe</p>
        <p>$250.00</p>
        <button class="buy-now">Buy Now</button>
      </div>
      <div class="car-card">
        <img src="navigation.png
          " alt="Mercedes Benz">
          <h3>Mercedes Benz</h3>
          <p>CLA Coupe</p>
          <p>$250.00</p>
          <button class="buy-now">Buy Now</button>
        </div>
        <div class="car-card">
            <img src="navigation.png
              " alt="Mercedes Benz">
              <h3>Mercedes Benz</h3>
              <p>CLA Coupe</p>
              <p>$250.00</p>
              <button class="buy-now">Buy Now</button>
            </div>
            <div class="car-card">
                <img src="navigation.png
                  " alt="Mercedes Benz">
                  <h3>Mercedes Benz</h3>
                  <p>CLA Coupe</p>
                  <p>$250.00</p>
                  <button class="buy-now">Buy Now</button>
                </div>
                <div class="car-card">
                    <img src="navigation.png
                      " alt="Mercedes Benz">
                      <h3>Mercedes Benz</h3>
                      <p>CLA Coupe</p>
                      <p>$250.00</p>
                      <button class="buy-now">Buy Now</button>
                    </div>
      <!-- Add more car cards here -->
    </div>
  </section>

  <section class="car-service">
    <h2>Need your Car Service?</h2>
    <p>In today's fast-paced world, maintaining your car should be as smooth as the drive itself. A one-stop destination for all your car servicing needs.</p>
    <img class="rea" src="5-Reasons-to-Choose-Car-Service-at-Your-Doorstep.jpg" alt="reason">
    <form class="uparle" method="post" action="sent-serv-req">
      <input id="hi" type="text"    name="description" placeholder="Enter Description Here">
      <button id="hey" type="submit">Send Service Request</button>
    </form>
  </section>

  <section class="feedback">
    <h2>Feedback Form</h2>
    <p>We appreciate your Feedback</p>
    <img class="rea" src="feedback.jpg" alt="feed">
    <form class="uparle" method="post" action="feedback-form">
      <input id="hi" type="text" name="description" placeholder="Enter Description Here">
      <button id="hey" type="submit">Submit the Form</button>
    </form>
  </section>

  <footer id="about">
    <h2 class="op" >Contact Us</h2>
    <p>Email: car.expo@gmail.com</p>
    <p>Mobile Number: +91 999-111-000</p>
    <p>Address: Beltane Circle, Kudasan, Gandhinagar</p>
  </footer>
</body>
</html>
