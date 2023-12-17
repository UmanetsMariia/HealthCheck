# HealthCheck


HealthCheck is a web application designed for health diagnostics, offering tools for diabetes diagnostic (classification) and brain MRI diagnostic (classification).

## Features

- User authentication (login and registration)
- Diabetes diagnostic test
- Brain MRI upload and diagnostic test
- Recommendations for medical specialists based on diagnostic results

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

What things you need to install the software:

- Python 3.8 or higher
- Flask
- XGBoost
- PostgreSQL
- Other dependencies listed in `requirements.txt`

### Installing

A step by step series of examples that tell you how to get a development environment running:

1. Clone the repository:
   ```bash
   git clone https://github.com/UmanetsMariia/HealthCheck.git
2. Navigate to the project directory:
    ```bash
    cd HealthCheck
    
3. Install required packages:
    ```bash
    pip install -r requirements.txt
    
4. Set up your PostgreSQL database and update the database connection details in database_connection.py.

5. Run the Flask application:
    ```bash
    python app.py
    
The application should now be running on localhost on the port specified in app.py.

### Usage
- Open the application in a web browser.
- Register a new user account or log in with existing credentials.
- Choose the desired health test from the test selection menu.
- For the diabetes test, enter the required health parameters and submit.
- For the brain MRI test, upload an MRI image in JPG format.
- View your diagnostic results and recommended specialists if applicable.
