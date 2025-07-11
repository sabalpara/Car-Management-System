<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to CARDX</title>
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
            overflow-y: auto;
        }

        .form-container {
            max-width: 480px;
            margin: 0 auto;
            width: 100%;
        }

        .form-header {
            margin-bottom: clamp(1.5rem, 4vw, 2.5rem);
            text-align: center;
        }

        .form-header h1 {
            font-size: clamp(1.5rem, 3vw, 2rem);
            color: #000000;
            margin-bottom: 0.5rem;
        }

        .form-header p {
            color: #666666;
            font-size: clamp(0.9rem, 2vw, 1rem);
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: clamp(0.75rem, 2vw, 1.25rem);
        }

        .form-group {
            position: relative;
            margin-bottom: 0.5rem;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
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

        .form-group input {
            width: 100%;
            padding: clamp(0.6rem, 2vw, 0.8rem) 1rem;
            border: 2px solid #D6D6D6;
            border-radius: clamp(8px, 2vw, 12px);
            font-size: clamp(0.9rem, 2vw, 1rem);
            transition: all 0.3s ease;
            background: transparent;
            color: #000000;
        }

        .form-group input:focus {
            border-color: #C2D515;
            box-shadow: 0 0 0 4px rgba(194, 213, 21, 0.1);
        }

        .form-group input:focus + label,
        .form-group input:not(:placeholder-shown) + label {
            transform: translateY(-170%) scale(0.9);
            color: #C2D515;
            font-weight: 500;
        }

        .submit-btn {
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

        .submit-btn:hover {
            background-color: #b1c213;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(194, 213, 21, 0.2);
        }

        .submit-btn:active {
            transform: translateY(0);
        }

        .login-link {
            text-align: center;
            margin-top: clamp(1rem, 3vw, 1.5rem);
            color: #666666;
            font-size: clamp(0.8rem, 2vw, 0.9rem);
        }

        .login-link a {
            color: #C2D515;
            text-decoration: none;
            font-weight: 500;
            margin-left: 4px;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .steps {
            display: flex;
            justify-content: space-between;
            margin-bottom: clamp(1rem, 3vw, 2rem);
            padding: 0 clamp(0.5rem, 2vw, 1rem);
        }

        .step {
            display: flex;
            align-items: center;
            color: #666666;
            font-size: clamp(0.8rem, 2vw, 0.9rem);
        }

        .step.active {
            color: #C2D515;
            font-weight: 500;
        }

        .step-number {
            width: clamp(20px, 4vw, 24px);
            height: clamp(20px, 4vw, 24px);
            border-radius: 50%;
            border: 2px solid currentColor;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 8px;
            font-size: clamp(0.7rem, 1.5vw, 0.8rem);
        }

        /* Responsive Breakpoints */
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

            .step span {
                display: none;
            }

            .step-number {
                margin-right: 0;
            }
        }

        @media (max-width: 480px) {
            .form-grid {
                grid-template-columns: 1fr;
            }

            .form-group {
                margin-bottom: 1rem;
            }
        }

        /* Fix for mobile devices in landscape mode */
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
                <p>Join our community and experience the future of automotive services. Register now to get started.</p>
            </div>
        </div>
        <div class="right-panel">
            <div class="form-container">
                <div class="form-header">
                    <h1>Create Account</h1>
                    <p>Fill in your details to get started</p>
                </div>
                
                
                <form  action="regform" method="post" class="login-form">
                    <div class="form-grid">
                        <div class="form-group">
                            <input type="email" id="email" name="customer_id" placeholder=" " required>
                            <label for="email">Email-ID</label>
                        </div>
                        <div class="form-group">
                            <input type="password" id="password" name="password" placeholder=" " required>
                            <label for="password">Password</label>
                        </div>
                        <div class="form-group">
                            <input type="text" id="firstName"name="first_name" placeholder=" " required>
                            <label for="firstName">First Name</label>
                        </div>
                        <div class="form-group">
                            <input type="text" id="lastName" name="last_name"  placeholder=" " required>
                            <label for="lastName">Last Name</label>
                        </div>
                        <div class="form-group">
                            <input type="text" id="aptName" name="apt_name" placeholder=" " required>
                            <label for="aptName">Apt Name</label>
                        </div>
                        <div class="form-group">
                            <input type="text" id="areaName" name="area_name"placeholder=" " required>
                            <label for="areaName">Area Name</label>
                        </div>
                        <div class="form-group">
                            <input type="text" id="aptNumber" name="apt_number"  placeholder=" " required>
                            <label for="aptNumber">Apartment Number</label>
                        </div>
                        <div class="form-group">
                            <input type="text" id="city" name="city" placeholder=" " required>
                            <label for="city">City</label>
                        </div>
                        <div class="form-group">
                            <input type="text" id="state" name="state"  placeholder=" " required>
                            <label for="state">State</label>
                        </div>
                        <div class="form-group">
                            <input type="text" id="pinCode" name="pin_code"  placeholder=" " required>
                            <label for="pinCode">PIN Code</label>
                        </div>
                        <div class="form-group full-width">
                            <input type="tel" id="mobile" name="Mobile_number" placeholder=" " required>
                            <label for="mobile">Mobile no</label>
                        </div>
                    </div>
                    <button type="submit" class="submit-btn">Create Account</button>
                    <div class="login-link">
                        Already have an account? <a href="index.jsp">Log in</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>