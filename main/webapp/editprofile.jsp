<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>

<script>
function myFunction() {
	  var x = document.getElementById("password");
	  if (x.type === "password") {
	    x.type = "text";
	  } else {
	    x.type = "password";
	  }
	}
</script>
<style>
body {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
    background-color: #D6D6D6; /* Neutral gray background */
    font-family: Arial, sans-serif;
}

form {
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 30px;
    border: 2px solid #C2D515; /* Lime green border */
    border-radius: 15px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2); /* Modern shadow */
    width: 100%;
    max-width: 470px; /* Adjust for better scaling */
    background-color: #FFFFFF; /* White form background */
    animation: slide-in 1s ease-out; /* Smooth form entry animation */
}

label {
    font-weight: bold;
    margin-bottom: 5px;
    font-size: 14px;
    color: #000000; /* Black text */
}

input {
    padding: 10px;
    margin-bottom: 15px;
    width: 100%;
    border: 2px solid #C2D515; /* Lime green border */
    border-radius: 8px;
    font-size: 14px;
    transition: box-shadow 0.3s ease, transform 0.2s; /* Smooth interaction effects */
}

input:focus {
    border-color: #A9BD12; /* Darker lime green */
    outline: none;
    box-shadow: 0 0 8px rgba(194, 213, 21, 0.5); /* Glow effect */
    transform: scale(1.02); /* Subtle scale effect */
}

.login-button {
    background-color: #C2D515; /* Lime green */
    color: #000000; /* Black text */
    padding: 12px;
    border: none;
    border-radius: 8px;
    font-size: 16px;
    cursor: pointer;
    width: 100%;
    text-align: center;
    transition: background-color 0.3s, transform 0.2s; /* Hover effect */
}

.login-button:hover {
    background-color: #A9BD12; /* Darker lime green */
    transform: translateY(-2px); /* Slight elevation */
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3); /* Enhanced hover shadow */
}

.showpass {
    display: flex;
    align-items: center;
    font-size: 13px;
    color: #000000; /* Black text */
    margin-bottom: 15px;
}

.showpass input[type="checkbox"] {
    margin-right: 5px;
}

@keyframes slide-in {
    from {
        transform: translateY(-50px);
        opacity: 0;
    }
    to {
        transform: translateY(0);
        opacity: 1;
    }
}

@media (max-width: 480px) {
    form {
        width: 90%;
    }

    .login-button {
        font-size: 14px;
    }

    label {
        font-size: 13px;
    }
}


</style>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<% String fname=(String) session.getAttribute("first_name");
String lname=(String) session.getAttribute("last_name");
 String pin_code=(String) session.getAttribute("pin_code");
 String area1=(String) session.getAttribute("city");
 String pincode1=(String) session.getAttribute("pin_code");
 String mobile1=(String) session.getAttribute("mobile");
 String apt_name1=(String) session.getAttribute("apt_name");
 String area_name1=(String) session.getAttribute("area_name");
 String city1=(String) session.getAttribute("city");
 String state1=(String) session.getAttribute("state");
 String password=(String) session.getAttribute("password");
//String name=(String) session.getAttribute("name");%>


	<form onsubmit="return validateForm()" action="editprofile" method="post">
		<label for="first_name">First Name:</label>
            <input type="text" id="first_name" name="first_name" value="<%=fname %>" required><br><br>
            
        <label for="last_name">Last Name:</label>
            <input type="text" id="last_name" name="last_name" value="<%=lname %>" required><br><br>
            
         <label for="apt_name">Apt Name:</label>
            <input type="text" id="apt_name" name="apt_name" value="<%=apt_name1 %>" required><br><br>
            
          <label for="area_name">Area Name:</label>
            <input type="text" id="area_name" name="area_name" value="<%=area_name1 %>"required><br><br>
         
         <label for="city">City:</label>	
            <input type="text" id="city" name="city" value="<%=city1 %>" required><br><br>
            
         <label for="pin_code">PIN Code:</label>
            <input type="text" id="pin_code" name="pin_code" value="<%=pincode1 %>" required><br><br>
            
         <label for="Mobile_number">Mobile no:</label>
            <input type="text" id="Mobile_number" name="Mobile_number" value="<%=mobile1 %>" required><br><br>
            
         <label for="password">Password:</label>
            <input type="password" id="password" name="password"  value="<%=password %>" required>
           <div class="showpass"> <pre>Show Password<input type="checkbox" onclick="myFunction()"></pre><br><br></div>
            
         <input type="submit" value="Save Changes" class="login-button"><br><br>	
            
         
	</form>
	<script>
	document.addEventListener('DOMContentLoaded', () => {
    // Input focus animation
    const inputs = document.querySelectorAll('input');
    inputs.forEach(input => {
        input.addEventListener('focus', () => {
            input.style.transition = '0.3s';
            input.style.boxShadow = '0 0 8px rgba(194, 213, 21, 0.5)';
        });

        input.addEventListener('blur', () => {
            input.style.boxShadow = 'none';
        });
    });

    // Show/Hide Password
    const passwordInput = document.querySelector('input[type="password"]');
    const toggleCheckbox = document.querySelector('.showpass input');

    toggleCheckbox.addEventListener('change', () => {
        if (toggleCheckbox.checked) {
            passwordInput.type = 'text';
        } else {
            passwordInput.type = 'password';
        }
    });
});
	</script>
</body>
</html>