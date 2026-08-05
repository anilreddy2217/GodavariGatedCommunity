# 🔄 Godavari Gated Community - Complete Application Flow

## 📋 Table of Contents
1. [Application Start Flow](#application-start-flow)
2. [User Registration & Login Flow](#user-registration--login-flow)
3. [Resident Workflow](#resident-workflow)
4. [Admin Workflow](#admin-workflow)
5. [Database Schema & Logic](#database-schema--logic)
6. [Session Management Flow](#session-management-flow)

---

## 🚀 Application Start Flow

```
1. Tomcat Server Starts
   ↓
2. Load hibernate.cfg.xml
   ↓
3. HibernateUtil.getConnection() called
   ↓
4. Connect to MySQL Database
   ↓
5. Hibernate auto-creates tables (residents & complaints)
   ↓
6. Application Ready → User sees index.jsp (Login Page)
```

**Entry Point:** `http://localhost:8080/GodavariGatedCommunity-0.0.1-SNAPSHOT/`

---

## 👤 User Registration & Login Flow

### 1️⃣ NEW USER REGISTRATION (Resident)

```
START: index.jsp
   ↓
User clicks "Signup" link
   ↓
→ signup.jsp (Registration Form)
   ↓
User fills form:
   - Username
   - Password
   - Email
   - Full Name
   - Phone
   ↓
Submit button clicked
   ↓
→ SignupServlet (/signup) [POST]
   ↓
Check if email already exists
   ├─ YES → Show error "Email already registered"
   │         Redirect back to signup.jsp
   └─ NO → Continue
       ↓
   Create new Resident object
       - role = "user" (automatically set)
       ↓
   ResidentDAO.saveResident()
       ↓
   Save to residents table in MySQL
       ↓
   Show success message on index.jsp
       ↓
   User can now LOGIN
```

**Code Flow:**
```
signup.jsp → SignupServlet.java → ResidentDAO.java → Resident.java → MySQL
```

---

### 2️⃣ ADMIN REGISTRATION

```
START: index.jsp
   ↓
User clicks "Admin Signup" link
   ↓
→ adminSignup.jsp (Admin Registration Form)
   ↓
User fills form:
   - Username
   - Password
   - Email
   - Full Name
   - Phone
   - Secret Key (GODAVARI2025)
   ↓
Submit button clicked
   ↓
→ AdminSignupServlet (/adminSignup) [POST]
   ↓
Validate Secret Key
   ├─ WRONG → Show error "Invalid secret key"
   │          Redirect back to adminSignup.jsp
   └─ CORRECT → Continue
       ↓
   Check if email already exists
       ├─ YES → Show error
       └─ NO → Continue
           ↓
   Create new Resident object
       - role = "owner" (admin role)
       ↓
   ResidentDAO.saveResident()
       ↓
   Save to residents table
       ↓
   Show success on index.jsp
       ↓
   Admin can now LOGIN
```

**Code Flow:**
```
adminSignup.jsp → AdminSignupServlet.java → ResidentDAO.java → Resident.java → MySQL
```

---

### 3️⃣ USER LOGIN

```
START: index.jsp (Login Page)
   ↓
User enters:
   - Username
   - Password
   ↓
Click "Sign in" button
   ↓
→ LoginServlet (/login) [POST]
   ↓
ResidentDAO.isValid(username, password)
   ↓
Query: "SELECT * FROM residents WHERE username=? AND password=?"
   ↓
User found?
   ├─ NO → Show error "Invalid credentials"
   │        Redirect back to index.jsp
   └─ YES → Continue
       ↓
   Create HTTP Session
       ↓
   Store in session:
       - username
       - userId
       - email
       - fullName
       - role (user/owner)
       - phone
       ↓
   Check role:
       ├─ role = "owner" → Redirect to ownerdashboard.jsp
       └─ role = "user" → Redirect to userdashboard.jsp
```

**Code Flow:**
```
index.jsp → LoginServlet.java → ResidentDAO.isValid() → Check role → Dashboard
```

---

## 🏠 Resident Workflow (role = "user")

### DASHBOARD VIEW

```
User logs in → userdashboard.jsp
   ↓
Dashboard shows 3 options:
   1. Submit a Complaint
   2. View Complaints
   3. Solved Complaints
```

---

### 1️⃣ SUBMIT COMPLAINT FLOW

```
userdashboard.jsp
   ↓
User clicks "Submit a Complaint"
   ↓
→ submitComplaint.jsp (Form)
   ↓
Form pre-filled from session:
   - Full Name (readonly)
   - Email (readonly)
   - Phone (readonly)
   ↓
User fills:
   - Category (Service/Billing/Technical/Other)
   - Subject
   - Description
   ↓
Click "Submit Complaint"
   ↓
→ SubmitComplaintServlet (/submitComplaintServlet) [POST]
   ↓
Check session (user logged in?)
   ├─ NO → Redirect to index.jsp
   └─ YES → Continue
       ↓
   Get resident by email
       ↓
   Create Complaint object:
       - userId = resident.getId()
       - category = form input
       - subject = form input
       - description = form input
       - status = "Pending" (default)
       - createdAt = current timestamp
       ↓
   ComplaintDAO.saveComplaint()
       ↓
   INSERT INTO complaints
       ↓
   Redirect to userdashboard.jsp
       ↓
   SUCCESS: Complaint submitted
```

**Code Flow:**
```
userdashboard.jsp → submitComplaint.jsp → SubmitComplaintServlet.java 
→ ComplaintDAO.saveComplaint() → Complaint.java → MySQL complaints table
```

---

### 2️⃣ VIEW COMPLAINTS FLOW

```
userdashboard.jsp
   ↓
User clicks "View Complaints"
   ↓
→ userViewServlet (/viewServlet) [GET/POST]
   ↓
Check session
   ├─ NO → Redirect to index.jsp
   └─ YES → Continue
       ↓
   Get userId from session
       ↓
   ComplaintDAO.getComplaints(userId, "Pending")
       ↓
   Query: SELECT * FROM complaints WHERE userId=? AND status='Pending'
       ↓
   ComplaintDAO.getComplaints(userId, "In Progress")
       ↓
   Query: SELECT * FROM complaints WHERE userId=? AND status='In Progress'
       ↓
   Merge both lists
       ↓
   Set list as request attribute
       ↓
   Forward to → viewComplaints.jsp
       ↓
   Display complaints in table with columns:
       - Complaint ID
       - Category
       - Subject
       - Description
       - Status (color chip)
       - Created At
       - Actions (Edit/Delete buttons)
           ↓
   User can:
       ├─ EDIT (if status = "Pending")
       │    ↓
       │  → userEditComplaint.jsp
       │    ↓
       │  User modifies:
       │    - Category
       │    - Subject
       │    - Description
       │    ↓
       │  → UserEditComplaintServlet (/userEditComplaint) [POST]
       │    ↓
       │  ComplaintDAO.updateComplaint()
       │    ↓
       │  UPDATE complaints SET category=?, subject=?, description=?
       │    ↓
       │  Redirect to viewServlet
       │
       └─ DELETE (if status = "Pending")
            ↓
          Confirm deletion (JavaScript)
            ↓
          → UserDeleteComplaintServlet (/userDeleteComplaint) [GET]
            ↓
          ComplaintDAO.deleteComplaint()
            ↓
          DELETE FROM complaints WHERE complaint_id=?
            ↓
          Redirect to viewServlet
```

**Code Flow:**
```
userdashboard.jsp → userViewServlet.java → ComplaintDAO.getComplaints() 
→ viewComplaints.jsp → [Edit] → userEditComplaint.jsp 
→ UserEditComplaintServlet.java → ComplaintDAO.updateComplaint()
```

---

### 3️⃣ VIEW SOLVED COMPLAINTS FLOW

```
userdashboard.jsp
   ↓
User clicks "Solved Complaints"
   ↓
→ userSolvedServlet (/solvedServlet) [GET/POST]
   ↓
Check session
   ↓
Get userId from session
   ↓
ComplaintDAO.getComplaints(userId, "Resolved")
   ↓
Query: SELECT * FROM complaints WHERE userId=? AND status='Resolved'
   ↓
Forward to → solvedComplaints.jsp
   ↓
Display resolved complaints in table
   ↓
User can view history (no edit/delete)
```

**Code Flow:**
```
userdashboard.jsp → userSolvedServlet.java → ComplaintDAO.getComplaints() 
→ solvedComplaints.jsp
```

---

## 👨‍💼 Admin Workflow (role = "owner")

### ADMIN DASHBOARD VIEW

```
Admin logs in → ownerdashboard.jsp
   ↓
Dashboard shows 3 options:
   1. View All Complaints
   2. View Residents
   3. Manage Status
```

---

### 1️⃣ VIEW ALL COMPLAINTS (ADMIN)

```
ownerdashboard.jsp
   ↓
Admin clicks "View All Complaints"
   ↓
→ ownerViewServlet (/oViewServlet) [GET/POST]
   ↓
Check session
   ├─ NO → Redirect to index.jsp
   └─ YES → Check role
       ├─ role ≠ "owner" → Redirect to index.jsp
       └─ role = "owner" → Continue
           ↓
   ComplaintDAO.getComplaintAllUsers()
       ↓
   Query: SELECT * FROM complaints (ALL complaints)
       ↓
   Set list as request attribute
       ↓
   Forward to → ownerViewComplaints.jsp
       ↓
   Display ALL complaints in table:
       - Complaint ID
       - User ID
       - Category
       - Subject
       - Description
       - Status
       - Created At
       - Action: "Edit Status" button
           ↓
   Admin clicks "Edit Status"
       ↓
   → ownerEditComplaint.jsp?complaintId=X
       ↓
   Admin selects new status:
       ○ Pending
       ○ In Progress
       ○ Resolved
       ↓
   Click "Update Status"
       ↓
   → ownerEditServlet (/editServlet) [POST]
       ↓
   Check session & role
       ↓
   ComplaintDAO.updateStatus(complaintId, newStatus)
       ↓
   UPDATE complaints SET status=? WHERE complaint_id=?
       ↓
   Redirect to oViewServlet
       ↓
   Updated complaint list shown
```

**Code Flow:**
```
ownerdashboard.jsp → ownerViewServlet.java → ComplaintDAO.getComplaintAllUsers() 
→ ownerViewComplaints.jsp → ownerEditComplaint.jsp 
→ ownerEditServlet.java → ComplaintDAO.updateStatus()
```

---

### 2️⃣ VIEW ALL RESIDENTS (ADMIN)

```
ownerdashboard.jsp
   ↓
Admin clicks "View Residents"
   ↓
→ AdminViewResidentsServlet (/adminViewResidents) [GET/POST]
   ↓
Check session & role
   ├─ role ≠ "owner" → Redirect to index.jsp
   └─ role = "owner" → Continue
       ↓
   ResidentDAO.getAllResidents()
       ↓
   Query: SELECT * FROM residents
       ↓
   Set residents list as request attribute
       ↓
   Forward to → adminViewResidents.jsp
       ↓
   Display all residents in table:
       - ID
       - Username
       - Full Name
       - Email
       - Phone
       - Role (user/owner)
       - Created At
       ↓
   Admin can see all registered users
```

**Code Flow:**
```
ownerdashboard.jsp → AdminViewResidentsServlet.java 
→ ResidentDAO.getAllResidents() → adminViewResidents.jsp
```

---

## 🔐 Session Management Flow

### SESSION CREATION (Login)
```
LoginServlet creates session:
   ↓
HttpSession session = request.getSession(true);
   ↓
session.setAttribute("username", resident.getUsername());
session.setAttribute("userId", resident.getId());
session.setAttribute("email", resident.getEmail());
session.setAttribute("fullName", resident.getFullname());
session.setAttribute("role", resident.getRole());
session.setAttribute("phone", resident.getPhone());
```

### SESSION VALIDATION (Every Page)
```
All servlets check:
   ↓
HttpSession session = request.getSession(false);
   ↓
if (session == null || session.getAttribute("userId") == null) {
    response.sendRedirect("index.jsp");
    return;
}
```

### SESSION DESTRUCTION (Logout)
```
User clicks "Logout" button
   ↓
→ LogoutServlet (/logout) [GET]
   ↓
HttpSession session = request.getSession(false);
   ↓
if (session != null) {
    session.invalidate();
}
   ↓
Redirect to index.jsp
   ↓
User logged out
```

---

## 🗄️ Database Schema & Logic

### RESIDENTS TABLE
```sql
CREATE TABLE residents (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE,
    full_name VARCHAR(100),
    role VARCHAR(20) NOT NULL,        -- "user" or "owner"
    phone VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

**Role Logic:**
- `role = "user"` → Regular resident (access to userdashboard.jsp)
- `role = "owner"` → Admin (access to ownerdashboard.jsp)

---

### COMPLAINTS TABLE
```sql
CREATE TABLE complaints (
    complaint_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    category VARCHAR(50) NOT NULL,    -- Service, Billing, Technical, Other
    subject VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    status VARCHAR(20) DEFAULT 'Pending',  -- Pending, In Progress, Resolved
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES residents(id) ON DELETE CASCADE
);
```

**Status Flow:**
```
NEW COMPLAINT
    ↓
status = "Pending" (User can edit/delete)
    ↓
Admin changes to "In Progress" (User CANNOT edit/delete)
    ↓
Admin changes to "Resolved" (User can only view)
```

---

## 📊 Complete Data Flow Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                        APPLICATION START                         │
│  Tomcat → Hibernate → MySQL Connection → Tables Created         │
└────────────────────────────┬────────────────────────────────────┘
                             ↓
                    ┌────────────────┐
                    │  index.jsp     │ (Login Page)
                    │  Entry Point   │
                    └────────┬───────┘
                             ↓
            ┌────────────────┴────────────────┐
            ↓                                  ↓
    ┌───────────────┐                 ┌───────────────┐
    │ New User?     │                 │ Existing User │
    │ Click Signup  │                 │ Enter Login   │
    └───────┬───────┘                 └───────┬───────┘
            ↓                                  ↓
    ┌───────────────┐                 ┌───────────────┐
    │ signup.jsp    │                 │ LoginServlet  │
    │ OR            │                 │ /login        │
    │ adminSignup   │                 └───────┬───────┘
    └───────┬───────┘                         ↓
            ↓                          ┌──────────────┐
    ┌───────────────┐                 │ Check Role   │
    │ SignupServlet │                 └──────┬───────┘
    │ /signup       │                        ↓
    └───────┬───────┘          ┌─────────────┴──────────────┐
            ↓                  ↓                             ↓
    ┌───────────────┐  ┌──────────────┐         ┌──────────────────┐
    │ ResidentDAO   │  │ role="user"  │         │  role="owner"    │
    │ .saveResident │  │ RESIDENT     │         │  ADMIN           │
    └───────┬───────┘  └──────┬───────┘         └──────┬───────────┘
            ↓                 ↓                         ↓
    ┌───────────────┐  ┌──────────────┐         ┌──────────────────┐
    │ MySQL INSERT  │  │ userdashboard│         │ ownerdashboard   │
    │ residents     │  │ .jsp         │         │ .jsp             │
    └───────────────┘  └──────┬───────┘         └──────┬───────────┘
                              ↓                         ↓
                    ┌─────────┴──────────┐   ┌─────────┴──────────┐
                    ↓                     ↓   ↓                     ↓
            ┌───────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐
            │ Submit        │  │ View        │  │ View All    │  │ View All    │
            │ Complaint     │  │ Complaints  │  │ Complaints  │  │ Residents   │
            └───────┬───────┘  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘
                    ↓                 ↓                 ↓                 ↓
            ┌───────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐
            │ComplaintDAO   │  │ComplaintDAO │  │ComplaintDAO │  │ResidentDAO  │
            │.saveComplaint │  │.getComplaints│ │.getAll...   │  │.getAll...   │
            └───────┬───────┘  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘
                    ↓                 ↓                 ↓                 ↓
            ┌───────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐
            │ MySQL INSERT  │  │ MySQL SELECT│  │ MySQL SELECT│  │ MySQL SELECT│
            │ complaints    │  │ complaints  │  │ complaints  │  │ residents   │
            └───────────────┘  └──────┬──────┘  └──────┬──────┘  └─────────────┘
                                      ↓                 ↓
                              ┌──────────────┐  ┌──────────────┐
                              │ User can     │  │ Admin can    │
                              │ Edit/Delete  │  │ Update Status│
                              │ (if Pending) │  │              │
                              └──────────────┘  └──────────────┘
```

---

## 🎯 Key Application Logic

### 1. AUTHENTICATION LOGIC
- Plain text passwords (for mini project)
- Session-based authentication
- No JWT/tokens needed

### 2. AUTHORIZATION LOGIC
```java
// Every protected servlet checks:
if (session == null || session.getAttribute("userId") == null) {
    response.sendRedirect("index.jsp");  // Redirect to login
    return;
}

// Admin-only pages check role:
String role = (String) session.getAttribute("role");
if (!"owner".equals(role)) {
    response.sendRedirect("index.jsp");  // Unauthorized
    return;
}
```

### 3. COMPLAINT STATUS LOGIC
```java
// Users can only edit/delete PENDING complaints
if ("Pending".equals(complaint.getStatus())) {
    // Show Edit and Delete buttons
} else {
    // Show "No actions" (In Progress or Resolved)
}
```

### 4. HIBERNATE AUTO-GENERATION
```xml
<property name="hibernate.hbm2ddl.auto">update</property>
```
- Creates tables automatically on first run
- Updates schema if entities change
- No manual SQL scripts needed

---

## 🔄 Complete Request-Response Cycle Example

### Example: User Submits Complaint

```
1. USER ACTION:
   User fills complaint form in submitComplaint.jsp
   ↓
2. HTTP REQUEST:
   POST /submitComplaintServlet
   Body: category=Service&subject=Water Issue&description=No water
   ↓
3. SERVLET PROCESSING:
   SubmitComplaintServlet.doPost() executes
   ↓
4. SESSION CHECK:
   HttpSession session = request.getSession(false);
   userId = session.getAttribute("userId");
   ↓
5. DAO LAYER:
   ComplaintDAO dao = new ComplaintDAO();
   dao.saveComplaint(complaint);
   ↓
6. HIBERNATE:
   session.save(complaint);
   ↓
7. SQL EXECUTION:
   INSERT INTO complaints (user_id, category, subject, description, status, created_at)
   VALUES (5, 'Service', 'Water Issue', 'No water', 'Pending', NOW());
   ↓
8. HTTP RESPONSE:
   response.sendRedirect("userdashboard.jsp");
   ↓
9. USER SEES:
   Dashboard page (complaint submitted successfully)
```

---

## 📝 Summary

**PROJECT START:** `index.jsp` → Login

**USER JOURNEY:**
1. Register/Login
2. Submit Complaints
3. View/Edit/Delete Pending Complaints
4. View Resolved Complaints
5. Logout

**ADMIN JOURNEY:**
1. Register with Secret Key/Login
2. View All Complaints
3. Update Complaint Status
4. View All Residents
5. Logout

**TECH FLOW:**
```
JSP → Servlet → DAO → Hibernate → MySQL → DAO → Servlet → JSP
```

---

## 🎓 Learning Points

1. **MVC Pattern:** JSP (View) → Servlet (Controller) → DAO (Model)
2. **Session Management:** Login creates session, all pages validate session
3. **Role-Based Access:** Single table with role column (RBAC pattern)
4. **Hibernate ORM:** Auto table creation, no raw SQL needed
5. **Separation of Concerns:** Clear layer separation (Presentation, Business, Data)

---

**END OF FLOW DOCUMENTATION** ✅
