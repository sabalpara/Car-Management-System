<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - CARDX</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
        }

        body {
            min-height: 100vh;
            background: #000000;
        }

        .split-container {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .left-panel {
            background: linear-gradient(45deg, #C2D515, #b1c213);
            padding: 2rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .left-panel::before {
            content: '';
            position: absolute;
            width: 200%;
            height: 200%;
            background: linear-gradient(
                45deg,
                rgba(255,255,255,0.1) 0%,
                rgba(255,255,255,0.05) 100%
            );
            animation: wave 8s infinite linear;
            top: -50%;
            left: -50%;
        }

        @keyframes wave {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .brand-content {
            position: relative;
            z-index: 1;
            color: #000000;
            padding: 1rem;
        }

        .brand-content h2 {
            font-size: clamp(1.5rem, 4vw, 2.5rem);
            margin-bottom: 0.5rem;
        }

        .brand-content p {
            font-size: clamp(0.9rem, 2vw, 1.1rem);
            opacity: 0.9;
            max-width: 600px;
            margin: 0 auto;
        }

        .right-panel {
            flex: 1;
            background: #ffffff;
            padding: clamp(1rem, 4vw, 3rem);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-container {
            width: 100%;
            max-width: 400px;
            padding: clamp(1.5rem, 4vw, 2.5rem);
        }

        .logo {
            text-align: center;
            margin-bottom: clamp(2rem, 6vw, 3rem);
        }

        .logo h1 {
            font-size: clamp(2rem, 6vw, 2.5rem);
            color: #000000;
            font-weight: 700;
        }

        .form-group {
            position: relative;
            margin-bottom: 1.5rem;
        }

        .form-group label {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #666666;
            font-size: 0.9rem;
            transition: all 0.2s ease;
            pointer-events: none;
            background: #ffffff;
            padding: 0 0.25rem;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: clamp(0.8rem, 2vw, 1rem) 1rem;
            border: 2px solid #D6D6D6;
            border-radius: clamp(8px, 2vw, 12px);
            font-size: clamp(0.9rem, 2vw, 1rem);
            transition: all 0.3s ease;
            background: transparent;
            color: #000000;
        }

        .form-group input:focus, .form-group select:focus {
            border-color: #C2D515;
            box-shadow: 0 0 0 4px rgba(194, 213, 21, 0.1);
        }

        .form-group input:focus + label,
        .form-group input:not(:placeholder-shown) + label,
        .form-group select:focus + label {
            transform: translateY(-170%) scale(0.9);
            color: #C2D515;
            font-weight: 500;
        }

        .login-btn {
            width: 100%;
            padding: clamp(0.8rem, 2vw, 1rem);
            background-color: #C2D515;
            color: #000000;
            border: none;
            border-radius: clamp(8px, 2vw, 12px);
            font-size: clamp(0.9rem, 2vw, 1rem);
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: clamp(1.5rem, 4vw, 2rem);
        }

        .login-btn:hover {
            background-color: #b1c213;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(194, 213, 21, 0.2);
        }

        .login-btn:active {
            transform: translateY(0);
        }

        .create-account {
            text-align: center;
            margin-top: clamp(1rem, 3vw, 1.5rem);
            color: #666666;
            font-size: clamp(0.8rem, 2vw, 0.9rem);
        }

        .create-account a {
            color: #C2D515;
            text-decoration: none;
            font-weight: 500;
            margin-left: 4px;
        }

        .create-account a:hover {
            text-decoration: underline;
        }

        @media (min-width: 768px) {
            .split-container {
                flex-direction: row;
            }

            .left-panel {
                width: 40%;
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                text-align: left;
            }

            .right-panel {
                width: 60%;
                min-height: 100vh;
            }
        }

        @media (max-width: 767px) {
            .left-panel {
                padding: clamp(1rem, 4vw, 2rem);
            }

            .brand-content {
                padding: 0.5rem;
            }
        }

        @media (max-height: 500px) and (orientation: landscape) {
            .split-container {
                flex-direction: column;
            }

            .left-panel {
                padding: 1rem;
            }

            .brand-content {
                max-width: 600px;
                margin: 0 auto;
            }
        }
    </style>
</head>
<body>
    <div class="split-container">
        <div class="left-panel">
            <div class="brand-content">
                <h2>Welcome to CARDX</h2>
                <p>Sign in to access your account as a mechanic or customer and manage your vehicle needs.</p>
            </div>
        </div>
        <div class="right-panel">
            <div class="login-container">
                <div class="logo">
                    <h1>CARDX</h1>
                </div>
                <form class="login-form" action="loginform" method="post">
                    <div class="form-group">
                        <select id="role" name="role" required>
                            <option value="" disabled selected>Choose your role</option>
                            <option value="mechanic">Mechanic</option>
                            <option value="customer">Customer</option>
                            <option value="admin">Admin</option>
                        </select>
                       
                    </div>
                    <div class="form-group">
                        <input type="text" id="username" name="username" placeholder=" " required>
                        <label for="username">Username</label>
                    </div>
                    <div class="form-group">
                        <input type="password" id="password"  name="password" placeholder=" " required>
                        <label for="password">Password</label>
                    </div>
                    <button type="submit" class="login-btn">Login</button>
                    <div class="create-account">
                        New user? <a href="register.jsp">Create a new account</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
