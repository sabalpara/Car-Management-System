<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>CARDX - New Cars</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
      background: linear-gradient(135deg, #D6D6D6, #FFFFFF);
      color: #000;
    }
    header {
      background-color: #C2D515;
      padding: 10px 20px;
    }
    .logo {
      font-size: 24px;
      font-weight: bold;
      text-align: center;
    }
    .back-button {
      position: absolute;
      top: 10px;
      right: 20px;
    }
    .back-button a button {
      padding: 10px 20px;
      background-color: #FFFFFF;
      color: black;
      border: none;
      border-radius: 5px;
      font-weight: bold;
      cursor: pointer;
    }
    .newcar-form {
      padding: 20px;
    }
    .search-bar {
      display: flex;
      justify-content: center;
      gap: 10px;
      flex-wrap: wrap;
      margin-bottom: 20px;
    }
    .search-bar input[type="text"] {
      padding: 14px 20px;
      border-radius: 25px;
      border: 2px solid #C2D515;
      width: 400px;
      font-size: 16px;
    }
    .search-button {
      padding: 14px 28px;
      background-color: #C2D515;
      border: none;
      border-radius: 25px;
      font-weight: bold;
      cursor: pointer;
      font-size: 16px;
    }
    .filter-buttons {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      gap: 10px;
      margin-top: 10px;
    }
    .filter-button {
      background-color: #D6D6D6;
      color: #000;
      border: 2px solid #C2D515;
      border-radius: 25px;
      padding: 10px 20px;
      font-weight: bold;
      font-size: 14px;
      cursor: pointer;
    }
    .car-cards {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      gap: 20px;
      padding: 30px 50px;
    }
    .card {
      width: 22%;
      background-color: #fff;
      border: 1px solid #ddd;
      border-radius: 8px;
      overflow: hidden;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
      text-align: center;
      display: flex;
      flex-direction: column;
    }
    .card img {
      width: 100%;
      height: 200px;
      object-fit: cover;
    }
    .card-details {
      padding: 15px;
      text-align: left;
      flex-grow: 1;
    }
    .price {
      font-weight: bold;
      font-size: 1.2rem;
      margin-bottom: 0.5rem;
    }
    .buy-button {
      width: 90%;
      margin: 10px auto 20px auto;
      padding: 10px;
      background-color: #C2D515;
      color: black;
      font-weight: bold;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }
    .buy-button:hover {
      background-color: #A7B812;
      color: #fff;
    }

    /* Dialog Box */
    .dialog-overlay {
      display: none;
      position: fixed;
      top: 0; left: 0;
      width: 100%; height: 100%;
      background: rgba(0, 0, 0, 0.4);
      justify-content: center;
      align-items: center;
      z-index: 9999;
    }

    .dialog {
      background: #fff;
      padding: 25px 40px;
      border-radius: 15px;
      box-shadow: 0 5px 20px rgba(0, 0, 0, 0.3);
      text-align: center;
    }

    /* Blur effect for background */
    .blurred {
      filter: blur(5px);
      pointer-events: none;
      user-select: none;
    }
  </style>
</head>
<body>
  <header>
    <div class="logo">CARDX</div>
    <div class="back-button">
      <a href="homepage.jsp">
        <button>Home</button>
      </a>
    </div>
  </header>

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

  <form action="newsortform" method="get" class="newcar-form" id="filterForm">
    <div class="search-bar">
      <input type="text" placeholder="Search for cars..." id="search" name="search" value=<%=request.getParameter("search")!=null ? request.getParameter("search"):""%>>
      <button class="search-button">🔍 Search</button>
    </div>
    <div class="filter-buttons">
      <% for (int i = 1; i <= 8; i++) { %>
        <label class="filter-button">
          <input type="checkbox" name="priceRange" value="<%= i %>" <%= isChecked(String.valueOf(i), request) %>>
          <%= 
            (i == 1) ? "1–2 lakh" :
            (i == 2) ? "2–5 lakh" :
            (i == 3) ? "5–10 lakh" :
            (i == 4) ? "10–20 lakh" :
            (i == 5) ? "20–30 lakh" :
            (i == 6) ? "30–50 lakh" :
            (i == 7) ? "50–80 lakh" :
            "80+ lakh"
          %>
        </label>
      <% } %>
    </div>
  </form>

  <section class="car-cards">
    <%
      try {
        Class.forName("org.postgresql.Driver");
        Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "postgres", "jay");
        PreparedStatement ps = connection.prepareStatement("SELECT * FROM new_car_model WHERE NOT EXISTS (SELECT 1 FROM buy_newcar WHERE new_car_model.car_id = buy_newcar.car_id) "+
        	    "ORDER BY car_id DESC");
        ResultSet rs = ps.executeQuery();
        ResultSet name = (ResultSet) session.getAttribute("resultset");
        if (name != null) {
          rs = name;
          session.removeAttribute("resultset");
        }
        while (rs.next()) {
          String image = rs.getString("image");
    %>
    <div class="card">
      <img src="<%= image %>" onerror="this.src='download.jpeg';">
      <div class="card-details">
        <h2 style="margin-bottom:10px;"><%= rs.getString("company_name") %> - <%= rs.getString("model") %></h2>
        <p class="price">Price: ₹<%= rs.getString("price") %></p>
        <p><strong>Fuel:</strong> <%= rs.getString("fuel_type") %> | <strong>Color:</strong> <%= rs.getString("colour") %></p>
      </div>
      <form action="buyform" method="post">
        <input type="hidden" name="car_id" value="<%= rs.getString("car_id") %>">
        <input type="hidden" name="price" value="<%= rs.getString("price") %>">
        <button class="buy-button" type="submit" data-confirm="buy">Buy Now</button>
      </form>
    </div>
    <% 
        }
        rs.close();
        ps.close();
        connection.close();
      } catch (SQLException e) {
        e.printStackTrace();
      }
    %>
  </section>

  <!-- Confirmation Dialog -->
  <div class="dialog-overlay" id="dialogOverlay">
    <div class="dialog">
      <p>Are you sure you want to buy this car?</p>
      <button id="confirmBtn">Yes</button>
      <button id="cancelBtn">No</button>
    </div>
  </div>

  <script>
    document.addEventListener("DOMContentLoaded", () => {
      const dialogOverlay = document.getElementById("dialogOverlay");
      const confirmBtn = document.getElementById("confirmBtn");
      const cancelBtn = document.getElementById("cancelBtn");
      let activeForm = null;

      document.querySelectorAll('button[data-confirm="buy"]').forEach(button => {
        button.addEventListener("click", event => {
          event.preventDefault();
          activeForm = button.closest("form");
          showDialog();
        });
      });

      function showDialog() {
        dialogOverlay.style.display = "flex";
        Array.from(document.body.children).forEach((child) => {
          if (child !== dialogOverlay) {
            child.classList.add("blurred");
          }
        });
      }

      function hideDialog() {
        dialogOverlay.style.display = "none";
        Array.from(document.body.children).forEach((child) => {
          child.classList.remove("blurred");
        });
      }

      confirmBtn.addEventListener("click", () => {
        hideDialog();
        if (activeForm) activeForm.submit();
      });

      cancelBtn.addEventListener("click", () => {
        hideDialog();
      });

      // Debounce search + auto-submit
      const form = document.getElementById("filterForm");
      const searchInput = document.getElementById("search");
      const checkboxes = form.querySelectorAll("input[type='checkbox']");
      let debounceTimer;

      searchInput.addEventListener("input", () => {
        clearTimeout(debounceTimer);
        debounceTimer = setTimeout(() => form.submit(), 600);
      });

      checkboxes.forEach(cb => {
        cb.addEventListener("change", () => form.submit());
      });

      // Cursor restore
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
          searchInput.setSelectionRange(searchInput.value.length, searchInput.value.length);
        }, 50);
      }

      form.addEventListener("submit", () => {
        localStorage.setItem("cursorPos", searchInput.selectionStart);
      });
    });
  </script>
</body>
</html>
