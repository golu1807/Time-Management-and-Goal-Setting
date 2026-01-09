# Time Management and Goal Setting Application

A comprehensive full-stack application designed to help users effectively manage their time, set goals, and track their progress. This project features a robust Spring Boot backend and a modern, responsive React frontend.

## 🚀 Features

- **User Authentication**: Secure signup and login functionality using JWT (JSON Web Tokens).
- **Goal Management**: Create, read, update, and delete goals.
- **Time Tracking**: Track time spent on various tasks and goals.
- **Analytics Dashboard**: Visual insights into productivity and goal progress using charts.
- **Responsive Design**: Modern UI built with Tailwind CSS, ensuring a great experience on all devices.

## 🛠 Tech Stack

### Backend (`backend-boot`)
- **Language**: Java 17
- **Framework**: Spring Boot 3.2.3
- **Security**: Spring Security, JWT
- **Database**: MySQL, Spring Data JPA
- **Build Tool**: Maven

### Frontend (`frontend-react`)
- **Framework**: React 19
- **Build Tool**: Vite
- **Styling**: Tailwind CSS 3.4
- **Routing**: React Router DOM
- **Charts**: Recharts
- **Icons**: Lucide React
- **HTTP Client**: Axios

## 📋 Prerequisites

Ensure you have the following installed on your local machine:
- **Java JDK 17** or higher
- **Node.js** (v18+ recommended) & **npm**
- **MySQL Server**

## ⚙️ Installation & Setup

### 1. Database Setup
1.  Install and start your MySQL server.
2.  The application is configured to automatically create the database `timetrack_db` if it doesn't exist.
3.  By default, it connects to `localhost:3306` with username `root` and password `Sakshi@123`.
    *   *Note: You can update these credentials in `backend-boot/src/main/resources/application.properties` or via environment variables.*

### 2. Backend Setup
1.  Navigate to the backend directory:
    ```bash
    cd backend-boot
    ```
2.  Build the project and install dependencies:
    ```bash
    mvn clean install
    ```
3.  Run the application:
    ```bash
    mvn spring-boot:run
    ```
    The backend server will start at `http://localhost:8080`.

### 3. Frontend Setup
1.  Open a new terminal and navigate to the frontend directory:
    ```bash
    cd frontend-react
    ```
2.  Install dependencies:
    ```bash
    npm install
    ```
3.  Start the development server:
    ```bash
    npm run dev
    ```
    The frontend application will run at `http://localhost:5173` (or the port shown in your terminal).

## 🔧 Configuration

### Backend Configuration
You can configure the backend settings in `backend-boot/src/main/resources/application.properties`. Key configurations include:

-   `spring.datasource.url`: MySQL database URL.
-   `spring.datasource.username`: Database username.
-   `spring.datasource.password`: Database password.
-   `jwt.secret`: Secret key for signing JWT tokens.
-   `jwt.expiration`: Token expiration time in milliseconds.

### Frontend Configuration
Frontend API base URL is typically configured in the Axios setup or environment variables (e.g., `.env` file). Ensure it points to your running backend server (default: `http://localhost:8080`).

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License.
