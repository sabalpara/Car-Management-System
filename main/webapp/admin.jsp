<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>Admin Dashboard</title>
        <style>
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

            body {
                font-family: "Arial", sans-serif;
                margin: 0;
                padding: 0;
                background-color: #D6D6D6;
                color: #000000;
            }

            header {
                background: linear-gradient(135deg,  black,  black);
                color: #000000;
                text-align: center;
                padding: 20px 0;
                font-size: 28px;
                font-weight: bold;
                animation: fadeIn 0.8s ease-out;
                display:flex;
            }
           
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
            

            .container {
                margin: 20px;
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
            }

            .box {
                background-color: #FFFFFF;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                flex: 1;
                max-width: 45%;
            }

            label {
                font-weight: bold;
            }

            input,
            button {
                width: 100%;
                padding: 10px;
                margin-top: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            button {
                background-color: #C2D515;
                color: #000000;
                font-weight: bold;
                cursor: pointer;
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
            #confirmBtn{
            background:#10b981;
            color:white;
            }
            #cancelBtn{
             background:#C2D515;
             color:white;
            }

            .dialog button {
                margin: 10px;
                width: auto;
                padding: 10px 20px;
            }
                h3{
                margin :0}
            .blurred {
                filter: blur(5px);
                pointer-events: none; /* Disable interactions with blurred elements */
            }
        </style>
    </head>
    <body>
        <header>
        <h3 style="margin-left:38%; margin-right:35%; color:white;">CARDX Admin Dashboard</h3>
        <div class="back-button">
         <a href="#" onclick="document.getElementById('logoutForm').submit();"><button style="color:black;"> Logout</button></a>
          <form action="logout" method="post" id="logoutForm" style="display: none;"></form>
        
        </div>
        </header>

        <div class="container">
            <div class="box">
                <h3>View all Transactions</h3>
                <div class="centered-button">
                    <button type="submit" onclick="redirectToPage5()">View Transactions</button>
                </div>
                <h3>View Feedbacks</h3>
                <div class="centered-button">
                    <button type="submit" onclick="redirectToPage()">View Feedbacks</button>
                </div>
            </div>

            <div class="box">
                <h3>Make Admin</h3>
                <form method="post" action="make_admin">
                    <label for="newadmin">Email id:</label>
                    <input type="text" id="newadmin" name="newadmin" required />
                    <div class="centered-button">
                        <button type="submit">Give Access</button>
                    </div>
                </form>
            </div>
        </div>

        <div class="container">
            <div class="box">
                <h3>Add New Car</h3>
                <form id="addNewCarForm" method="post" action="add-newcar" enctype="multipart/form-data">
                    <label for="Model">Model:</label>
                    <input type="text" id="Model" name="Model" required />

                    <label for="company">Company:</label>
                    <input type="text" id="company" name="company" required />

                    <label for="Price">Price:</label>
                    <input type="text" id="Price" name="Price" required />

                    <label for="colour">Colour:</label>
                    <input type="text" id="colour" name="colour" required />

                    <label for="fuel">Fuel type:</label>
                    <input type="text" id="fuel" name="fuel" required />

                    <label for="safety">Safety Ratings (0-5):</label>
                    <input type="number" id="safety" name="safety" min="0" max="5" step="0.1" required />

                    <label for="transmission">Transmission type:</label>
                    <input type="text" id="transmission" name="transmission" required />

                    <label for="warranty">Warranty (years):</label>
                    <input type="text" id="warranty" name="warranty" required />

                    <label for="image">Add Image:</label>
                    <input type="file" id="image" name="image" required />

                    <div class="centered-button">
                        <button type="button" id="submitNewCarBtn">Add Car</button>
                    </div>
                </form>
            </div>

            <div class="box">
                <h3>Add Rental Car</h3>
                <form id="addRentalCarForm" method="post" action="add-rentcar" enctype="multipart/form-data">
                    <label for="Model">Model:</label>
                    <input type="text" id="Model" name="Model" required />

                    <label for="company">Company:</label>
                    <input type="text" id="company" name="company" required />

                    <label for="Price">Price per day:</label>
                    <input type="text" id="Price" name="Price" required />

                    <label for="colour">Colour:</label>
                    <input type="text" id="colour" name="colour" required />

                    <label for="fuel">Fuel type:</label>
                    <input type="text" id="fuel" name="fuel" required />

                    <label for="image">Add Image:</label>
                    <input type="file" id="image" name="image" required />

                    <div class="centered-button">
                        <button type="button" id="submitRentalCarBtn">Add Car</button>
                    </div>
                </form>
            </div>
        </div>

        <div class="dialog-overlay" id="dialogOverlay">
            <div class="dialog">
                <p>Are you sure you want to add this car?</p>
                <button id="confirmBtn">Yes</button>
                <button id="cancelBtn">No</button>
            </div>
        </div>

        <script>
            const dialogOverlay = document.getElementById("dialogOverlay");
            const confirmBtn = document.getElementById("confirmBtn");
            const cancelBtn = document.getElementById("cancelBtn");

            const newCarForm = document.getElementById("addNewCarForm");
            const rentalCarForm = document.getElementById("addRentalCarForm");

            const newCarBtn = document.getElementById("submitNewCarBtn");
            const rentalCarBtn = document.getElementById("submitRentalCarBtn");

            let activeForm = null;

            newCarBtn.addEventListener("click", () => {
                activeForm = newCarForm;
                showDialog();
            });

            rentalCarBtn.addEventListener("click", () => {
                activeForm = rentalCarForm;
                showDialog();
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

            function redirectToPage5() {
                window.location.href = "viewtransection.jsp";
            }

            function redirectToPage() {
                window.location.href = "viewfeedback.jsp";
            }
        </script>
    </body>
</html>
