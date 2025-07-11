<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>


<style>
  /* Root Variables for Colors and Typography */
:root {
  --primary-color: #C2D515; /* First color in your palette */
  --primary-dark: #A7B812;  /* Slightly darker shade of primary */
  --primary-light: #D5E426; /* Slightly lighter shade of primary */
  --secondary-color: #D6D6D6; /* Second color */
  --accent-color: #000000; /* Third color */
  --text-primary: #000000; /* Third color */
  --text-secondary: #FFFFFF; /* Fourth color (white) */
  --success-color: #10b981;
  --warning-color: #f59e0b;
  --error-color: #ef4444;
  --background-light: #FFFFFF; /* Fourth color (white) */
  --background-dark: #D6D6D6; /* Second color */
  --card-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
  --transition-speed: 0.3s;

  /* Typography */
  --font-primary: 'Inter', system-ui, -apple-system, sans-serif;
  --font-size-sm: 0.875rem;
  --font-size-base: 1rem;
  --font-size-lg: 1.125rem;
  --font-size-xl: 1.25rem;
  --font-size-2xl: 1.5rem;
}

/* Base Styles */
body {
  font-family: var(--font-primary);
  color: var(--text-primary);
  margin: 0;
  padding: 0;
  background: linear-gradient(135deg, var(--background-light) 0%, var(--background-dark) 100%);
}

header {
  background-color: #333333;
  color: var(--text-secondary);
  text-align: center;
  padding: 10px 0;
  display:flex;
}

.logo {
  font-size: 24px;
  font-weight: bold;
}

.back-button a {
    text-decoration: none;
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
}
.logo{
margin-left:45%;
margin-right:45%;

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
/* Button Styles */
.buy-button {
  display: inline-block;
  padding: 10px 20px;
  font-size: 16px;
  font-weight: bold;
  text-align: center;
  text-decoration: none;
  background-color: var(--primary-color);
  
  border: none;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color var(--transition-speed);
}

.buy-button:hover {
  background-color: var(--primary-light);
}

/* Search Section */
.search-section {
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 1.5rem;
    background-color: #F0F0F0;
}

.search-bar {
    display: flex;
    gap: 0.5rem;
    width: 100%;
    max-width: 600px;
    margin-bottom: 1.5rem;
}

.search-bar input[type="text"] {
    flex: 1;
    padding: 0.75rem 1rem;
    border: 1px solid #C2D515;
    border-radius: 5px;
    font-size: 1rem;
}

.search-button {
    background-color: #C2D515;
    color: #000000;
    border: none;
    border-radius: 5px;
    padding: 0.75rem 1rem;
    cursor: pointer;
    font-size: 1rem;
}

.search-button:hover {
    background-color: #A7B812;
}

/* Filter Buttons */
.filter-buttons {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
    justify-content: center;
}

.filter-button {
    background-color: #D6D6D6;
    color: #000000;
    border: 1px solid #C2D515;
    border-radius: 20px;
    padding: 0.5rem 1rem;
    cursor: pointer;
    font-size: 0.9rem;
}

.filter-button:hover {
    background-color: #C2D515;
    color: #FFFFFF;
}

/* Car Cards Grid */
.car-cards {
    display: grid;
    grid-template-columns: repeat(4, 1fr); /* Four columns */
    gap: 20px;
    max-width: 1200px;
    margin: 2rem auto;
    padding: 0 1.5rem;
}

/* Responsive Design */
@media (max-width: 1024px) {
    .car-cards {
        grid-template-columns: repeat(2, 1fr); /* Two columns on medium screens */
    }
}

@media (max-width: 768px) {
    .car-cards {
        grid-template-columns: 1fr; /* Single column on small screens */
    }
}
.card {
  background-color: var(--background-light);
  border-radius: 1rem;
  box-shadow: var(--card-shadow);
  overflow: hidden;
  transition: transform var(--transition-speed) ease;
  animation: fadeIn 0.5s ease-out forwards;
}

.card:hover {
  transform: translateY(-4px);
}

.card-head {
  background-color: var(--secondary-color);
  color: var(--text-secondary);
  padding: 1.25rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.card img {
  width: 100%;
  height: auto;
  max-height: 200px;
  object-fit: cover;
  aspect-ratio: 16/9; /* Ensures consistent aspect ratio */
  transition: transform var(--transition-speed) ease;
}

.card:hover img {
  transform: scale(1.05);
}

.card-details {
  padding: 1.5rem;
}

.price {
  font-size: var(--font-size-2xl);
  font-weight: 600;
  
  margin-bottom: 1rem;
}

.card-details h2 {
  margin-top: 10px;
  margin-bottom: 5px;
  color: var(--accent-color);
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

/* Responsive Design */
@media (max-width: 1200px) {
  .car-cards {
    grid-template-columns: repeat(2, 1fr); /* Two cards per row on medium screens */
  }
}

@media (max-width: 768px) {
  .car-cards {
    grid-template-columns: 1fr; /* One card per row on small screens */
  }

  .search-bar {
    flex-direction: column;
  }

  .search-bar input[type="text"] {
    width: 100%;
  }
}


</style>

</head>
<body>
		    <header>
        <div class="logo">CARDX</div>
         <div class="back-button">
        <a href="homepage.jsp">
            <button style="color:black"> Home</button>
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
    <form action="rentsortform" method="get"  id="filterForm"class="newcar-form">
        <section class="search-section">
            <div class="search-bar">
                <input type="text" placeholder="Search for cars..." id="search" name="search" value="<%=request.getParameter("search")!=null ? request.getParameter("search"):"" %>">
                <button class="search-button">&#128269; Search</button>
            </div>
            <div class="filter-buttons">
                <table>
                    <tr>
                        <td> <label class="filter-button"><input type="checkbox" name ="priceRange"  id="1" value="1" <%= isChecked("1", request) %> > 1-5 thousand/day</label></td>
                        <td> <label class="filter-button"><input type="checkbox" name ="priceRange"  id="2" value="2"  <%= isChecked("2", request) %>> 5-10 thousand/day</label></td>
                        <td> <label class="filter-button"><input type="checkbox" name ="priceRange"  id="3" value="3" <%= isChecked("3", request) %> > 10-20 thousand/day</label></td>
                        <td> <label class="filter-button"><input type="checkbox" name ="priceRange"  id="4" value="4" <%= isChecked("4", request) %>> 20 and above thousand/day</label></td>
                    </tr>
                </table>
            </div>
        </section>
    </form>
    
    <section class="car-cards">
    
    
    	<% try {
            int a=259;
            Class.forName("org.postgresql.Driver");
            Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "postgres", "jay");
            PreparedStatement preparedStatement2 = connection.prepareStatement("update rental_car set availability='Y' where rental_car_id IN (select distinct car_id from rent where due_date = current_date - INTERVAL '1 day')   ");
            preparedStatement2.executeUpdate();
            
            PreparedStatement preparedStatement0 = connection.prepareStatement("REFRESH MATERIALIZED VIEW rent_car_model");
            preparedStatement0.executeUpdate();
            //Statement statement = connection.createStatement();
            //String refreshCommand = "REFRESH MATERIALIZED VIEW rent_car_model";
            //statement.executeUpdate(refreshCommand);//
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM rent_car_model "+
            	    "ORDER BY car_id DESC");
            ResultSet resultSet = preparedStatement.executeQuery();
            
            ResultSet  name=(ResultSet) session.getAttribute("resultset");
            if(name!=null){
            	resultSet=name;
            	session.removeAttribute("resultset");
            }

            while (resultSet.next()) {
                a++;
                String image=resultSet.getString("image");
        %>
        
        <div class="card">
                    <img src="<%= image %>"onerror="this.onerror=null; this.src='download.jpeg';">
                    <div class="card-details">
                        <span class="price">&#8377;<%= resultSet.getString("price") %>/day</span>
                        <h1> <%= resultSet.getString("company_name") %> </h1>
                        <h2><%= resultSet.getString("model") %></h2><br>
                        <form onsubmit="return validateForm()" action="buyrentform" method="post" class="newcar-form"> 
                    	<label for="rentdays">Rentdays:</label>
                    	<input type="number" id="rentdays" name="rentdays" min="1" step="1" required>
                   		<input type="hidden" name="car_id" id="car_id_input" value="<%= resultSet.getString("car_id") %>">
                   		<input type="hidden" name="price" id="price" value="<%= resultSet.getString("price")  %>">
                   		<br><br>
                  		<button type="submit" class="buy-button" id="submitRentalCarBtn" >Rent Now</button>
                  	    </form>                    
                    </div>
                    
                   

                    
                </div>
        <%
            }

            resultSet.close();
            preparedStatement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        %>
        
    	
    </section>
    <div class="dialog-overlay" id="dialogOverlay">
    <div class="dialog">
        <p>Are you sure you want to rent this car?</p>
        <button id="confirmBtn">Yes</button>
        <button id="cancelBtn">No</button>
    </div>
</div>
    <script >
    document.addEventListener("DOMContentLoaded", () => {
        const dialogOverlay = document.getElementById("dialogOverlay");
        const confirmBtn = document.getElementById("confirmBtn");
        const cancelBtn = document.getElementById("cancelBtn");
        let activeForm = null;

        // Select all buttons with ID `submitRentalCarBtn`
        document.querySelectorAll("#submitRentalCarBtn").forEach((button) => {
            button.addEventListener("click", (event) => {
                event.preventDefault(); // Prevent default behavior
                activeForm = button.closest("form"); // Get the associated form
                showDialog(); // Show the dialog box
            });
        });

        // Show dialog box
        function showDialog() {
            dialogOverlay.style.display = "flex";
            Array.from(document.body.children).forEach((child) => {
                if (child !== dialogOverlay) {
                    child.classList.add("blurred");
                }
            });
        }

        // Hide dialog box
        function hideDialog() {
            dialogOverlay.style.display = "none";
            Array.from(document.body.children).forEach((child) => {
                child.classList.remove("blurred");
            });
        }

        // On confirmation, submit the form
        confirmBtn.addEventListener("click", () => {
            hideDialog();
            if (activeForm) activeForm.submit();
        });

        // On cancellation, just close the dialog
        cancelBtn.addEventListener("click", () => {
            hideDialog();
        });
    });

    
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