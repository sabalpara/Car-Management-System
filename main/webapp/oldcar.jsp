<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>CARDX - Old Cars</title>
  <style>
    .card-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(420px, 1fr));
      gap: 20px;
      justify-items: center;
      padding: 0 20px;
    }
    .card {
      opacity: 0;
      transform: translateY(30px);
      transition: all 0.6s ease-out;
      width: 100%;
      max-width: 480px;
      background-color: #fff;
      border: 1px solid #ddd;
      border-radius: 8px;
      overflow: hidden;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    .card img {
      width: 100%;
      max-height: 250px;
      object-fit: cover;
    }
    .card-details {
      padding: 15px;
    }
  </style>
</head>

<body style="font-family: Arial, sans-serif; margin: 0; padding: 0;">

<%! 
  public String isChecked(String value, jakarta.servlet.http.HttpServletRequest request) {
    String[] selectedValues = request.getParameterValues("priceRange");
    if (selectedValues != null) {
        for (String v : selectedValues) {
            if (v.equals(value)) return "checked";
        }
    }
    return "";
  } 
%>

<header style="background-color: #C2D515; padding: 10px 20px;">
  <div style="display: flex; justify-content: space-between; align-items: center;">
    <div style="font-size: 24px; font-weight: bold;">CARDX</div>
    <a href="homepage.jsp" style="text-decoration: none;">
      <button style="padding: 10px 20px; background-color: #FFFFFF; color: black; border: none; border-radius: 5px; font-weight: bold; cursor: pointer;">
        Home
      </button>
    </a>
  </div>
</header>

<form action="oldsortform" method="get" id="filterForm" style="padding: 20px;">
  <div style="display: flex; justify-content: center; gap: 10px; margin-bottom: 20px; flex-wrap: wrap;">
    <input type="text" name="search" id="search" 
  placeholder="Search for cars..."
  value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>"
  style="padding: 14px 20px; border-radius: 25px; border: 2px solid #C2D515; width: 400px; font-size: 16px;">

    <input type="submit" value="Search"  style="padding: 14px 28px; background-color: #C2D515; border: none; border-radius: 25px; font-weight: bold; cursor: pointer; font-size: 16px;">
  </div>

  <div style="display: flex; flex-wrap: wrap; justify-content: center; gap: 10px;">
    <% 
      String[] priceLabels = {"2 lakh and less", "2 lakh to 5 lakh", "5 lakh to 10 lakh", "10 lakh to 20 lakh", "20 lakh to 30 lakh", "30 lakh to 50 lakh", "50 lakh to 80 lakh", "80 lakh and above"};
      for (int i = 1; i <= 8; i++) {
    %>
    <label style="background-color: #D6D6D6; border: 2px solid #C2D515; border-radius: 25px; padding: 10px 20px; font-weight: bold; font-size: 14px; color: #000000; cursor: pointer;">
      <input type="checkbox" name="priceRange" value="<%= i %>" <%= isChecked(String.valueOf(i), request) %> style="margin-right: 8px;">
      <%= priceLabels[i - 1] %>
    </label>
    <% } %>
  </div>
</form>

<section class="card-grid" style="padding: 20px;">
<%
  try {
    Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "postgres", "jay");
    PreparedStatement ps = con.prepareStatement(
    	    "SELECT * FROM old_car_model " +
    	    "WHERE NOT EXISTS (" +
    	    "  SELECT 1 FROM bargain_request " +
    	    "  WHERE bargain_request.accept_time IS NOT NULL " +
    	    "  AND old_car_model.car_id = bargain_request.car_id" +
    	    ") AND old_car_model.seller_id != ? " +  // Add space at the end
    	    "ORDER BY car_id DESC"
    	);

    ps.setString(1, (String) session.getAttribute("email"));
    ResultSet rs = ps.executeQuery();

    ResultSet name = (ResultSet) session.getAttribute("resultsetoldcar");
    if (name != null) {
    	//System.out.println("hi my name is lakhan");
      rs = name;
      session.removeAttribute("resultsetoldcar");
    }else{
    	//System.out.println("hi my name is not lakhan"+(String) session.getAttribute("email"));
    	
    }

    while (rs.next()) {
      String car_id = rs.getString("car_id");
      String image1 = rs.getString("image");
%>
  <div class="card">
    <img src="<%= image1 %>" onerror="this.src='download.jpeg'">
    <div class="card-details">
      <h2><%= rs.getString("company_name") %> - <%= rs.getString("model") %></h2>
      <p><strong>Price:</strong> ₹<%= rs.getString("price") %></p>
      <p><strong>Fuel:</strong> <%= rs.getString("fuel_type") %> | <strong>Color:</strong> <%= rs.getString("colour") %></p>

      <form action="oldbuyform" method="post">
        <input type="hidden" name="car_id" value="<%= car_id %>">
        <input type="hidden" name="price" value="<%= rs.getString("price") %>">
        <input type="hidden" name="seller_id" value="<%= rs.getString("seller_id") %>">
        <button id="submitRentalCarBtn" type="submit" style="width: 100%; padding: 10px; background-color: #C2D515; color: black; font-weight: bold; border: none; border-radius: 5px; margin-top: 10px;">Buy Now</button>
      </form>

      <form action="bargainform" method="post" class="send-barg-req" style="margin-top: 15px; display: flex; align-items: center; gap: 10px;">
        <input type="hidden" name="car_id" value="<%= car_id %>">
        <input type="hidden" name="seller_id" value="<%= rs.getString("seller_id") %>">
        <input type="text" name="amount" placeholder="Enter Amount" style="flex: 1; padding: 10px; border-radius: 25px; border: 2px solid #000; font-size: 14px;">
        <button type="submit" id="sendButton" style="background-color: #C2D515; color: black; border: none; border-radius: 50%; width: 45px; height: 45px; font-size: 20px; cursor: pointer;">&#10148;</button>
      </form>
    </div>
  </div>
<%
    }
    rs.close();
    ps.close();
    con.close();
  } catch (Exception e) {
    out.println("<p style='color:red;'>" + e.getMessage() + "</p>");
  }
%>
</section>

<div class="dialog-overlay" id="dialogOverlay" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5); justify-content:center; align-items:center; z-index: 1000;">
  <div class="dialog" style="background:white; padding:25px 30px; border-radius:12px; box-shadow: 0 0 15px rgba(0,0,0,0.3); max-width: 400px; text-align: center;">
    <p style="font-size: 18px; font-weight: bold; margin-bottom: 20px;">Are you sure you want to buy this car?</p>
    <div style="display: flex; justify-content: center; gap: 15px;">
      <button id="confirmBtn" style="background-color: #4CAF50; color: white; padding: 10px 20px; border: none; border-radius: 8px; font-weight: bold; cursor: pointer;">Yes</button>
      <button id="cancelBtn" style="background-color: #f44336; color: white; padding: 10px 20px; border: none; border-radius: 8px; font-weight: bold; cursor: pointer;">No</button>
    </div>
  </div>
</div>

<script>
  // Fade in animation for cards
  const cards = document.querySelectorAll('.card');
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.style.opacity = '1';
        entry.target.style.transform = 'translateY(0)';
      }
    });
  }, { threshold: 0.1 });
  cards.forEach(card => observer.observe(card));

  // Bargain validation
  const bargainForms = document.querySelectorAll('.send-barg-req');
  bargainForms.forEach(form => {
    const input = form.querySelector('input[type="text"]');
    const button = form.querySelector('#sendButton');
    input.addEventListener('input', (e) => {
      const value = e.target.value;
      if (value && !isNaN(value) && parseInt(value) > 0) {
        button.style.transform = 'scale(1.05)';
        button.style.opacity = '1';
      } else {
        button.style.transform = 'scale(1)';
        button.style.opacity = '0.8';
      }
    });
    form.addEventListener('submit', (e) => {
      const value = input.value;
      if (!value || isNaN(value) || parseInt(value) <= 0) {
        e.preventDefault();
        input.style.borderColor = '#ef4444';
        input.style.animation = 'shake 0.5s ease-in-out';
        setTimeout(() => { input.style.animation = ''; }, 500);
      }
    });
  });

  // Shake animation
  const style = document.createElement('style');
  style.textContent = `@keyframes shake { 0%, 100% { transform: translateX(0); } 25% { transform: translateX(-10px); } 75% { transform: translateX(10px); } }`;
  document.head.appendChild(style);

  // Buy Now confirmation
  const dialogOverlay = document.getElementById("dialogOverlay");
  const confirmBtn = document.getElementById("confirmBtn");
  const cancelBtn = document.getElementById("cancelBtn");
  let activeForm = null;
  document.querySelectorAll("#submitRentalCarBtn").forEach((button) => {
    button.addEventListener("click", (event) => {
      event.preventDefault();
      activeForm = button.closest("form");
      dialogOverlay.style.display = "flex";
    });
  });
  confirmBtn.addEventListener("click", () => {
    dialogOverlay.style.display = "none";
    if (activeForm) activeForm.submit();
  });
  cancelBtn.addEventListener("click", () => {
    dialogOverlay.style.display = "none";
  });

  // Debounced search and filter auto-submit
  
 
document.addEventListener("DOMContentLoaded", () => {
  const form = document.getElementById("filterForm");
  const searchInput = document.getElementById("search");
  const checkboxes = form.querySelectorAll("input[type='checkbox']");

  // Submit form after debounce
  let debounceTimer;
  searchInput.addEventListener("input", () => {
    clearTimeout(debounceTimer);
    debounceTimer = setTimeout(() => {
      form.submit();
    }, 600);
  });

  // Checkbox change auto submit
  checkboxes.forEach((checkbox) => {
    checkbox.addEventListener("change", () => {
      form.submit();
    });
  });

  // Restore cursor position (at end or saved position)
  const savedCursorPos = localStorage.getItem("cursorPos");
  if (savedCursorPos !== null) {
    const pos = parseInt(savedCursorPos);
    setTimeout(() => {
      searchInput.focus();
      searchInput.setSelectionRange(pos, pos);
      localStorage.removeItem("cursorPos");
    }, 50);
  } else {
    setTimeout(() => {
      searchInput.focus();
      searchInput.setSelectionRange(searchInput.value.length, searchInput.value.length); // Place cursor at end
    }, 50);
  }

  // Save cursor before submit
  form.addEventListener("submit", () => {
    localStorage.setItem("cursorPos", searchInput.selectionStart);
  });
});

</script>




    


</body>
</html>
