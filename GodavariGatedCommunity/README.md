# 🏡 Godavari Gated Community Complaint Management System

A Java-based web application developed to simplify complaint management in a gated community. The system enables residents to register, log in, submit complaints, and track their complaint status, while administrators can manage complaints and update their progress through an admin dashboard.

---
## 🎯 Project Objectives

- Provide an easy way for residents to submit complaints.
- Help administrators manage and resolve complaints efficiently.
- Maintain complaint history with status tracking.
- Reduce manual complaint handling within the community.

---

## 📌 Features

### Resident
- User Registration
- User Login
- Submit Complaints
- View Submitted Complaints
- Track Complaint Status
- Logout

### Administrator
- Admin Registration
- Admin Login
- View All Complaints
- Update Complaint Status
- Manage Resident Complaints
- Logout

---

## 🛠️ Technologies Used

### Backend
- Java
- Jakarta Servlet
- Hibernate ORM
- Maven

### Frontend
- JSP
- HTML5
- CSS3

### Database
- MySQL

### Server
- Apache Tomcat 10.1

### Tools
- Eclipse IDE
- Git
- GitHub
- MySQL Workbench

---

## 📂 Project Structure

```
GodavariGatedCommunity/
│
├── src/main/java
│   ├── dao
│   ├── model
│   ├── servlet
│   └── util
│
├── src/main/resources
│   └── hibernate.cfg.xml
│
├── src/main/webapp
│   ├── *.jsp
│   ├── css
│   └── images
│
├── pom.xml
└── README.md
```

---

## ⚙️ Setup Instructions

### Clone the Repository

```bash
git clone https://github.com/anilreddy2217/GodavariGatedCommunity.git
```

### Import into Eclipse

- Open Eclipse
- Import → Existing Maven Project
- Select the project folder
- Finish

### Configure Apache Tomcat

- Install Apache Tomcat 10.1
- Add the server in Eclipse
- Configure the project runtime

### Configure MySQL

Create a database:

```sql
CREATE DATABASE godavari_gated_community_db;
```

Update the database credentials in:

```
hibernate.cfg.xml
```

Example:

```xml
<property name="hibernate.connection.username">root</property>
<property name="hibernate.connection.password">YOUR_PASSWORD</property>
```

### Run the Project

Deploy the project on Apache Tomcat and open:

```
http://localhost:8080/GodavariGatedCommunity/
```

---

## 📸 Modules

- Resident Registration
- Resident Login
- Complaint Submission
- Complaint Tracking
- Admin Registration
- Admin Dashboard
- Complaint Management

---

## 📚 Learning Outcomes

This project demonstrates:

- Java Web Application Development
- MVC Architecture
- Hibernate ORM
- CRUD Operations
- Session Management
- Database Integration
- Maven Project Management
- Git Version Control

---

## 🚀 Future Enhancements

- Email Notifications
- Complaint Priority Levels
- Dashboard Analytics
- Resident Profile Management
- File Attachments for Complaints
- Search and Filter Functionality
- Role-Based Access Control

---

## 👨‍💻 Author

**K. Anil Reddy**

- GitHub: https://github.com/anilreddy2217
- LinkedIn: https://www.linkedin.com/in/kancham-reddy-anil-reddy-b81868413/

---

## 📄 License

This project is developed for educational and learning purposes.