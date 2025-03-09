# Todo List Web Application

## Overview
This web application provides a simple and intuitive todo list management system with user authentication. It allows users to register, login, create, manage, and organize their personal todo lists. The application was developed as part of an assignment for the Software System Construction class.

![Screenshot 2025-03-07 125137](https://github.com/user-attachments/assets/83a722b2-01c3-4f0f-9a4c-7d87f8ec9bb6)
![Screenshot 2025-03-07 125204](https://github.com/user-attachments/assets/46599005-cd28-40de-ab50-6d5a6faf216d)

## Features
- User registration and authentication system
- Secure login/logout functionality
- Create, read, update, and delete todo lists
- Add, edit, mark as complete, and remove individual todo items
- Persistent data storage using MySQL database
- Responsive web interface

## Technologies Used
- Java (Servlets & JSP)
- Maven for dependency management and build automation
- Jetty as the embedded web server
- MySQL for database storage
- JDBC for database connectivity
- Session management for user authentication

## Prerequisites
Before running this application, make sure you have the following installed:
- Java Development Kit (JDK) 11 or higher
- Maven 3.6 or higher
- MySQL Server 5.7 or higher

## Database Setup

1. Create a new MySQL database:
   ```sql
   CREATE DATABASE todo_management;
   ```

2. Create a user with appropriate permissions (or use an existing one):
   ```sql
   CREATE USER 'todouser'@'localhost' IDENTIFIED BY 'password';
   GRANT ALL PRIVILEGES ON todo_management.* TO 'todouser'@'localhost';
   FLUSH PRIVILEGES;
   ```

3. The application will automatically create the necessary tables on first run, or you can manually run the SQL scripts located in the `src/main/resources/` directory.

## Installation

1. Clone the repository:
   ```
   git clone https://github.com/BothBosu/TodoLists-Java-WebAPP.git
   cd TodoLists-Java-WebAPP
   ```
   
2. Build the application:
   ```
   mvn clean install
   ```

## Running the Application

### Using Maven Jetty Plugin

Run the application locally using the Maven Jetty plugin:

```
mvn jetty:run
```

After running this command, you can access the application at:
- http://localhost:8080
