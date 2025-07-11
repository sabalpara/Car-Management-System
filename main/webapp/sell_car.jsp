<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CARDX - Sell Your Car</title>
    <style>
       * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Inter', 'Segoe UI', sans-serif;
}

:root {
    --primary: #C2D515;
    --primary-dark: #A2B012;
    --secondary: #D6D6D6;
    --accent: #A3A3A3;
    --text: #000000;
    --success: #10b981;
}

body {
    background: linear-gradient(135deg, #f1f5f9 0%, #e2e8f0 100%);
    min-height: 100vh;
    color: var(--text);
    line-height: 1.6;
}

.header {
    background: linear-gradient(to right, var( --text),var( --text));
    color: white;
    padding: 1.5rem;
    text-align: center;
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
    position: relative;
    overflow: hidden;
    display:flex;
}
.header h1{
margin-left:40%;
margin-right:45%;

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



.header::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(45deg, transparent 48%, rgba(255,255,255,0.1) 50%, transparent 52%);
    background-size: 200% 200%;
    animation: shine 3s linear infinite;
}

@keyframes shine {
    0% { background-position: 200% 0; }
    100% { background-position: -200% 0; }
}

.container {
    max-width: 1200px;
    margin: 2rem auto;
    padding: 0 1.5rem;
}

.sell-car-form {
    background: white;
    padding: 2rem;
    border-radius: 1rem;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 2rem;
    transform: translateY(0);
    transition: transform 0.3s ease;
}

.sell-car-form:hover {
    transform: translateY(-5px);
}

.image-upload-section {
    grid-column: 1;
    grid-row: 1 / span 3;
    border: 2px dashed var(--primary);
    border-radius: 1rem;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    min-height: 300px;
    padding: 2rem;
    background-color: var(--secondary);
    transition: all 0.3s ease;
}

.image-upload-section:hover {
    border-color: var(--primary-dark);
    background-color: #f1f5f9;
}

.upload-icon {
    stroke: var(--primary);
    width: 64px;
    height: 64px;
    margin-bottom: 1rem;
    transition: transform 0.3s ease;
}

.image-upload-section:hover .upload-icon {
    transform: scale(1.1);
}

.image-upload-section label {
    cursor: pointer;
    padding: 0.75rem 1.5rem;
    background-color: var(--primary);
    color: black;
    border-radius: 0.5rem;
    font-weight: 500;
    transition: all 0.3s ease;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
}

.image-upload-section label:hover {
    background-color: var(--primary-dark);
    transform: translateY(-2px);
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
}

.uploaded-images {
    margin-top: 1.5rem;
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(80px, 1fr));
    gap: 0.75rem;
    width: 100%;
}

.uploaded-images img {
    width: 100%;
    aspect-ratio: 1;
    object-fit: cover;
    border-radius: 0.5rem;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease;
}

.uploaded-images img:hover {
    transform: scale(1.05);
}

.form-group {
    position: relative;
    margin-bottom: 1.5rem;
}

.form-group label {
    display: block;
    margin-bottom: 0.5rem;
    color: var(--text);
    font-weight: 500;
    transition: color 0.3s ease;
}

.form-group input,
.form-group textarea {
    width: 100%;
    padding: 0.75rem 1rem;
    border: 2px solid var(--accent);
    border-radius: 0.5rem;
    font-size: 1rem;
    transition: all 0.3s ease;
    background-color: var(--secondary);
}

.form-group input:focus,
.form-group textarea:focus {
    border-color: var(--primary);
    outline: none;
    background-color: white;
    box-shadow: 0 0 0 4px rgba(194, 213, 21, 0.1);
}

.form-group input:focus + label,
.form-group textarea:focus + label {
    color: var(--primary);
}

.submit-button {
    grid-column: 1 / -1;
    padding: 1rem 2rem;
    background-color: var(--primary);
    color: black;
    border: none;
    border-radius: 0.5rem;
    font-size: 1rem;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    width: auto;
    margin: 1rem auto 0;
    min-width: 200px;
    position: relative;
    overflow: hidden;
}

.submit-button::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(
        120deg,
        transparent,
        rgba(255, 255, 255, 0.2),
        transparent
    );
    transition: 0.5s;
}

.submit-button:hover::before {
    left: 100%;
}

.submit-button:hover {
    background-color: var(--primary-dark);
    transform: translateY(-2px);
    box-shadow: 0 4px 6px rgba(194, 213, 21, 0.2);
}

@media (max-width: 768px) {
    .sell-car-form {
        grid-template-columns: 1fr;
        gap: 1.5rem;
        padding: 1.5rem;
    }

    .image-upload-section {
        grid-column: 1;
        grid-row: auto;
        margin-bottom: 1.5rem;
    }

    .container {
        padding: 1rem;
        margin: 1rem auto;
    }
}

.success-message {
    display: none;
    position: fixed;
    top: 20px;
    right: 20px;
    background-color: var(--success);
    color: white;
    padding: 1rem 2rem;
    border-radius: 0.5rem;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    animation: slideIn 0.5s ease-out;
}
.blur-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(5px);
            z-index: 9998;
            display: none;
        }

        /* Dialog box styling */
        .dialog-box {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 2rem;
            border-radius: 1rem;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            z-index: 9999;
            display: none;
            text-align: center;
            width: 90%;
            max-width: 400px;
        }

        .dialog-box button {
            margin: 0.5rem;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 0.5rem;
            cursor: pointer;
            font-size: 1rem;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .dialog-box .confirm {
            background-color: var(--success);
            color: white;
        }

        .dialog-box .confirm:hover {
            background-color: #0a9d63;
        }

        .dialog-box .cancel {
            background-color: var(--primary);
            color: white;
        }

        .dialog-box .cancel:hover {
            background-color: var(--primary-dark);
        }
        

@keyframes slideIn {
    from {
        transform: translateX(100%);
        opacity: 0;
    }
    to {
        transform: translateX(0);
        opacity: 1;
    }
}
    </style>
</head>

<body>
    <header class="header">
    
        <h1>Sell Your Car</h1>
        <div class="back-button">
        <a href="homepage.jsp">
            <button style="color:black"> Home</button>
        </a>
    </div>
    </header>

    <div class="container">
     
        <form  action="sellcar" method="post" enctype="multipart/form-data" class="sell-car-form" id="carForm">
            <div class="image-upload-section">
                <svg class="upload-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-7"/>
                    <polyline points="17 8 12 3 7 8"/>
                    <line x1="12" y1="3" x2="12" y2="15"/>
                </svg>
                <p style="margin: 15px 0; color: #666;">Drop your car images here or click to upload</p>
                <label for="car-image">Choose Images</label>
                <input type="file" id="car-image"  name="image"accept="image/*" multiple style="display: none;">
                <div class="uploaded-images" id="uploaded-images"></div>
            </div>

            <div class="form-group">
                <label for="model">Car Model</label>
                <input type="text" id="model" name="model" required placeholder="e.g., Toyota Camry">
            </div>

            <div class="form-group">
                <label for="company">Manufacturer</label>
                <input type="text" id="company" name="company" required placeholder="e.g., Toyota">
            </div>

            <div class="form-group">
                <label for="price">Price</label>
                <input type="number" id="price" name="price" required placeholder="Enter amount">
            </div>

            <div class="form-group">
                <label for="year">Manufacturing Year</label>
                <input type="number" id="year" name="year" required placeholder="e.g., 2020">
            </div>

            <div class="form-group">
                <label for="fuel-type">Fuel Type</label>
                <input type="text" id="fuel-type" name="fuel_type" required placeholder="e.g., Petrol, Diesel, Electric">
            </div>

            <div class="form-group">
                <label for="kilometer">Mileage (km)</label>
                <input type="number" id="kilometer" name="kilometer" required placeholder="e.g., 50000">
            </div>

            <div class="form-group">
                <label for="colour">Color</label>
                <input type="text" id="colour" name="colour" required placeholder="e.g., Midnight Blue">
            </div>

            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" required placeholder="Tell us about your car's condition, features, and history"></textarea>
            </div>

            <button type="button" class="submit-button" id="submitBtn">List Car for Sale</button>
        </form>
    </div>
       <div class="blur-overlay" id="blurOverlay"></div>

    <div class="dialog-box" id="confirmationDialog">
        <p>Are you sure you want to list this car for sale?</p>
        <button class="confirm" id="confirmBtn">Yes</button>
        <button class="cancel" id="cancelBtn">No</button>
    </div>
      
    <div class="success-message" id="successMessage">
        Car listed successfully!
    </div>

    <script>
        // Image upload handling
        const dropZone = document.querySelector('.image-upload-section');
        const fileInput = document.getElementById('car-image');
        const uploadedImagesContainer = document.getElementById('uploaded-images');

        // Drag and drop functionality
        ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
            dropZone.addEventListener(eventName, preventDefaults, false);
        });

        function preventDefaults(e) {
            e.preventDefault();
            e.stopPropagation();
        }

        ['dragenter', 'dragover'].forEach(eventName => {
            dropZone.addEventListener(eventName, highlight, false);
        });

        ['dragleave', 'drop'].forEach(eventName => {
            dropZone.addEventListener(eventName, unhighlight, false);
        });

        function highlight(e) {
            dropZone.style.borderColor = '#1d4ed8';
            dropZone.style.backgroundColor = '#f1f5f9';
        }

        function unhighlight(e) {
            dropZone.style.borderColor = '#2563eb';
            dropZone.style.backgroundColor = '#f8fafc';
        }

        dropZone.addEventListener('drop', handleDrop, false);

        function handleDrop(e) {
            const dt = e.dataTransfer;
            const files = dt.files;
            handleFiles(files);
        }

        fileInput.addEventListener('change', function(e) {
            handleFiles(this.files);
        });

        function handleFiles(files) {
            uploadedImagesContainer.innerHTML = '';
            Array.from(files).forEach(file => {
                if (file.type.startsWith('image/')) {
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        const img = document.createElement('img');
                        img.src = e.target.result;
                        img.setAttribute('alt', 'Car image');
                        uploadedImagesContainer.appendChild(img);
                    };
                    reader.readAsDataURL(file);
                }
            });
        }

        // Form submission
        
        // Input animation
        document.querySelectorAll('input, textarea').forEach(element => {
            element.addEventListener('focus', function() {
                this.parentElement.querySelector('label').style.color = '#2563eb';
            });

            element.addEventListener('blur', function() {
                this.parentElement.querySelector('label').style.color = '#334155';
            });
        });
        const submitButton = document.getElementById('submitBtn');
        const blurOverlay = document.getElementById('blurOverlay');
        const confirmationDialog = document.getElementById('confirmationDialog');
        const confirmButton = document.getElementById('confirmBtn');
        const cancelButton = document.getElementById('cancelBtn');
        const form = document.getElementById('carForm');

        // Show dialog and blur effect on button click
        submitButton.addEventListener('click', (e) => {
            e.preventDefault(); // Prevent default form submission
            blurOverlay.style.display = 'block';
            confirmationDialog.style.display = 'block';
        });

        // Confirm action
        confirmButton.addEventListener('click', () => {
            blurOverlay.style.display = 'none';
            confirmationDialog.style.display = 'none';
            form.submit(); // Submit the form, action="sellcar" will be triggered
        });

        // Cancel action
        cancelButton.addEventListener('click', () => {
            blurOverlay.style.display = 'none';
            confirmationDialog.style.display = 'none';
        });
        </script>
</body>
</html>