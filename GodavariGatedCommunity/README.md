# 🏘️ Godavari Gated Community - Complaint Tracker System

## 📌 Problem Statement
Managing complaints in apartment complexes is often inefficient, with complaints getting lost or unresolved due to a lack of proper tracking. This system allows residents to log complaints, track their status, and receive updates from the apartment administration team in a streamlined way.

---

## 🛠 Tech Stack

| Layer      | Technology                       |
|------------|---------------------------------|
| Backend    | Java Servlets, JSP               |
| Database   | MySQL                            |
| ORM        | Hibernate 5.6                    |
| Server     | Apache Tomcat 10+                |
| Frontend   | HTML, CSS                        |

---

## 🚀 Features

### 👤 Resident Functionalities
- ✅ **Register & Login** – Residents can sign up and log in to the system
- ✅ **Submit Complaints** – Raise complaints for issues like water supply, electricity, maintenance, etc.
- ✅ **View Complaint Status** – Check if complaints are pending, in progress, or resolved
- ✅ **Update Complaints** – Modify pending complaints if needed
- ✅ **Delete Complaints** – Cancel pending complaints
- ✅ **Complaint History** – View past complaints and their resolution
- ✅ **Logout** – Secure session management

### 👨‍💼 Admin Functionalities
- ✅ **Admin Registration** – Register as admin with secret key
- ✅ **View All Complaints** – Admin can see complaints submitted by all residents
- ✅ **Update Complaint Status** – Change status from "Pending" → "In Progress" → "Resolved"
- ✅ **View All Residents** – See all registered users in the system
- ✅ **Dashboard** – Centralized admin control panel
- ✅ **Logout** – Secure session management

---

## ⚙️ Setup & Installation

### Prerequisites
- **Java JDK 11+** installed
- **Apache Tomcat 10+** installed
- **MySQL 8.0+** installed and running
- **Maven** installed

### Step 1: Clone the Repository
```bash
git clone https://github.com/harioggu/GodavariGatedCommunity-ComplaintTrackerSystem.git
cd GodavariGatedCommunity-ComplaintTrackerSystem
```

### Step 2: Configure Database
1. **Start MySQL Server**
2. **Update Database Credentials** (if needed)
   - Open `src/main/resources/hibernate.cfg.xml`
   - Update username/password if your MySQL credentials are different:
   ```xml
   <property name="hibernate.connection.username">root</property>
   <property name="hibernate.connection.password">root</property>
   ```

3. **Database will be created automatically** by Hibernate when you run the application!
   - Database name: `godavari_gated_community_db`
   - Tables will be auto-generated

### Step 3: Build the Project
```bash
mvn clean install
```

### Step 4: Deploy to Tomcat
1. Copy the generated WAR file from `target/GodavariGatedCommunity-0.0.1-SNAPSHOT.war`
2. Paste it into Tomcat's `webapps` folder
3. Start Tomcat server
4. Access the application at: `http://localhost:8080/GodavariGatedCommunity-0.0.1-SNAPSHOT/`

---

## 🔐 Default Credentials

### Admin Registration
- Go to **Admin Signup** page
- Use Secret Key: `GODAVARI2025`
- Create your admin account

### User Registration
- Go to **Signup** page
- Register as a regular user (no secret key needed)

---

## 📊 Workflow

1. **Resident Registration/Login**
   - User signs up and logs in

2. **Complaint Submission**
   - Users submit complaints via a web form (category, description, urgency)

3. **Admin Panel**
   - Admin logs in and manages complaints

4. **Complaint Status Updates**
   - Admin marks complaints as "In Progress" or "Resolved"

5. **Notification & Tracking**
   - Residents check the real-time status of complaints

---

## 📁 Project Structure

```
GodavariGatedCommunity/
├── src/main/java/
│   ├── dao/                    # Data Access Objects
│   │   ├── ComplaintDAO.java
│   │   └── ResidentDAO.java
│   ├── model/                  # Entity Classes
│   │   ├── Complaint.java
│   │   └── Resident.java
│   ├── servlet/                # Servlets
│   │   ├── LoginServlet.java
│   │   ├── SignupServlet.java
│   │   ├── AdminSignupServlet.java
│   │   ├── SubmitComplaintServlet.java
│   │   ├── UserEditComplaintServlet.java
│   │   ├── UserDeleteComplaintServlet.java
│   │   ├── ownerViewServlet.java
│   │   ├── ownerEditServlet.java
│   │   ├── AdminViewResidentsServlet.java
│   │   └── LogoutServlet.java
│   └── util/
│       └── HibernateUtil.java  # Hibernate Configuration
├── src/main/resources/
│   └── hibernate.cfg.xml       # Hibernate Config
├── src/main/webapp/
│   ├── index.jsp               # Login Page
│   ├── signup.jsp              # User Registration
│   ├── adminSignup.jsp         # Admin Registration
│   ├── userdashboard.jsp       # User Dashboard
│   ├── ownerdashboard.jsp      # Admin Dashboard
│   ├── submitComplaint.jsp     # Submit Complaint Form
│   ├── viewComplaints.jsp      # View User Complaints
│   ├── userEditComplaint.jsp   # Edit Complaint
│   ├── solvedComplaints.jsp    # Resolved Complaints
│   ├── ownerViewComplaints.jsp # Admin View All Complaints
│   ├── ownerEditComplaint.jsp  # Admin Edit Status
│   └── adminViewResidents.jsp  # Admin View Residents
└── pom.xml                     # Maven Dependencies
```

---

## 🎨 Features Highlights

### User Features
- **Modern UI Design** with gradient backgrounds and smooth animations
- **Edit/Delete Complaints** (only for pending complaints)
- **View Complaint History** with status tracking
- **Secure Session Management** with logout functionality

### Admin Features
- **Centralized Dashboard** for managing all complaints
- **View All Residents** registered in the system
- **Update Complaint Status** with easy-to-use interface
- **Secure Admin Registration** with secret key validation

---

## 🔧 Technologies Used

- **Jakarta Servlet API 5.0** (for Tomcat 10+)
- **Hibernate 5.6** (ORM for database operations)
- **MySQL Connector 8.0** (JDBC driver)
- **Maven** (dependency management)
- **JSP** (dynamic web pages)
- **HTML5 & CSS3** (modern UI design)

---

## 📝 Database Schema

### Residents Table
- `id` (Primary Key)
- `username` (Unique)
- `password`
- `email` (Unique)
- `full_name`
- `role` (user/owner)
- `phone`
- `created_at`
- `updated_at`

### Complaints Table
- `complaint_id` (Primary Key)
- `user_id` (Foreign Key → residents.id)
- `category`
- `subject`
- `description`
- `status` (Pending/In Progress/Resolved)
- `created_at`

---

## 🚨 Important Notes

1. **Hibernate Auto-Creates Tables**: No need to run SQL scripts manually
2. **Admin Secret Key**: `GODAVARI2025` (change in `AdminSignupServlet.java` for production)
3. **Session Management**: Users are automatically logged out when closing browser
4. **Edit/Delete**: Only pending complaints can be edited or deleted by users
5. **Database**: Automatically created on first run

---

## 📌 Expected Outcomes

✔️ Efficient tracking of apartment complaints  
✔️ Quick resolution by maintenance teams  
✔️ Centralized record of complaints for analytics  
✔️ User-friendly interface for both residents and admins  
✔️ Secure authentication and authorization  
✔️ Real-time status updates  

---

## 👨‍💻 Developer

**Hari Oggu**  
GitHub: [@harioggu](https://github.com/harioggu)

---

## 📄 License

This project is open-source and available for educational purposes.

---

## 🤝 Contributing

Feel free to fork this repository and submit pull requests for improvements!

---

## 📞 Support

For any issues or questions, please create an issue in the GitHub repository.
