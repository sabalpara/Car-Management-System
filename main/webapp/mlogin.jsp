<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="login.css">
    <title>CARDX Login</title>
</head>
<style>
login css 

body {
    display: flex;
    justify-content: center;
    align-items: center;
    /* width: 160vw; */
    height: 100vh;
    margin: 0;
    background-image: url(https://wallpaperaccess.com/full/740013.jpg);
    background-size: cover;
    background-color: #D6D6D6;
    font-family: Cambria, Cochin, Georgia, Times, 'Times New Roman', serif;
    text-align: center; /* Center align text within the body */
    overflow: hidden; /* Hide horizontal overflow to prevent scrollbars */
}

.container {
    text-align: center;
    border: 2px solid #101010;
    border-radius: 10px;
    padding: 20px;
    /* background-color: rgba(255, 255, 255, 0.8); */
}
.container h1{
    position: relative;
    text-shadow: 2px 2px 2px red;
    text-rendering: optimizeSpeed;
    animation: bounce 2s infinite;
}
.text {
    width: 500px;
    color: rgb(7, 7, 7);
    text-shadow:2px 1px #e20909;
    font-weight: 1000;
    margin-top: 20px;
}

.logo {
    width: 400px;
    height: 200px;
    object-fit: contain;
    margin-bottom: 20px;
    /* position: absolute; */
   
   
  
    animation: moveCar 4s ease-in-out infinite;
}

.login-form {
    display: flex;
    flex-direction: column;
    align-items: center;
}

label,
input,
select {
    margin-bottom: 10px;
}

.login-button {
    background-color: green;
    color: white;
    border: red solid 2px;
    border-radius: 10px;
    padding: 10px 20px;
    cursor: pointer;
    transition: transform 0.3s ease;
    margin-top: 10px;
}

.login-button:hover {
    transform: scale(1.1);
}
@keyframes bounce {
    0% {
        transform: translateY(0) scale(1); /* Start position with normal size */
    }
    50% {
        transform: translateY(-20px) scale(1.2); /* Bounce up with increased size */
    }
    100% {
        transform: translateY(0) scale(1); /* Back to the original position with normal size */
    }
}
</style>
<body>
    <div class="container">
        <div>
            <img src="http://www.picshunger.com/wp-content/uploads/2015/01/WWCruisers-Car-Logo-no-background.gif" class="logo">
        </div>
           <div>
            <h1>C  A  R  D   X</h1>
           </div>
        <div class="text">

            <form class="login-form" action="mloginform" method="post" id="loginForm">
                
                <p>Username: <input type="text" id="username" name="username" placeholder="Enter your Username" required></p>
                <p>Password: <input type="password" id="password" name="password" placeholder="Enter Your Password" required></p>
                <p> not a Mechanic yet? <a href=""> register for Mechanic </a> </p>
                <button type="submit" class="login-button">Login</button>
            </form>
        </div>
    </div>

    <script src="login.js"></script>
</body>

</html>