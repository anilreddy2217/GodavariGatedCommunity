<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Resident" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>All Residents · Admin Panel</title>
  <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@700&family=Inter:wght@400;600&display=swap" rel="stylesheet">
  <style>
    :root{ --bg:#0b0f17; --bg2:#0b152b; --line:rgba(148,163,184,.22); --text:#e5e7eb; --muted:#94a3b8; --r:16px; --chip:#0b1220; --chipline:rgba(148,163,184,.35); }
    *{box-sizing:border-box} html,body{height:100%; margin:0}
    body{
      font-family:Inter,system-ui,Arial; color:var(--text);
      background: radial-gradient(900px 600px at 20% -10%, rgba(34,211,238,.08), transparent 60%),
                 radial-gradient(800px 500px at 120% 10%, rgba(212,175,55,.08), transparent 60%),
                 linear-gradient(160deg, var(--bg), #0a1222 48%, var(--bg2));
      display:flex; align-items:center; justify-content:center; padding:20px;
    }

    .wrap{ width:min(1200px,96vw); border:1px solid var(--line); border-radius:var(--r);
      background:linear-gradient(180deg, rgba(17,24,39,.9), rgba(17,24,39,.78)); padding:22px; }

    .head{ display:flex; justify-content:space-between; align-items:center; margin-bottom:14px }
    h2{ margin:0; font-family:Cinzel,serif; font-size:22px; letter-spacing:.4px }
    .welcome{ color:var(--muted); font-size:13.5px }

    .table{ overflow:auto; border:1px solid var(--line); border-radius:12px; }
    table{ width:100%; border-collapse:collapse; font-size:14px; }
    th,td{ padding:12px 14px; border-bottom:1px solid var(--line); vertical-align:top; }
    th{ text-align:left; color:#cbd5e1; background:#0b1220; font-weight:600; }
    tr:last-child td{ border-bottom:none }

    .chip{ display:inline-block; padding:4px 8px; border-radius:999px; background:var(--chip); border:1px solid var(--chipline); font-size:12px }
    .btn{ display:inline-block; padding:10px 18px; background:#2563eb; color:#fff; text-decoration:none; border-radius:6px; font-size:14px; font-weight:500; }
    .back{ margin-top:20px; text-align:center; }
  </style>
</head>
<body>
  <div class="wrap">
    <div class="head">
      <h2>All Residents</h2>
      <div class="welcome">Admin: <%=session.getAttribute("username") %></div>
    </div>

    <div class="table">
      <table>
        <thead>
          <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Full Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Role</th>
            <th>Created At</th>
          </tr>
        </thead>
        <tbody>
        <%
          List<Resident> residents = (List<Resident>) request.getAttribute("residents");
          if (residents != null && !residents.isEmpty()) {
            for (Resident resident : residents) {
        %>
              <tr>
                <td><%= resident.getId() %></td>
                <td><%= resident.getUsername() %></td>
                <td><%= resident.getFullname() %></td>
                <td><%= resident.getEmail() %></td>
                <td><%= resident.getPhone() %></td>
                <td><span class="chip"><%= resident.getRole() %></span></td>
                <td><%= resident.getCreatedAt() %></td>
              </tr>
        <%
            }
          } else {
        %>
            <tr>
              <td colspan="7">No residents found.</td>
            </tr>
        <%
          }
        %>
        </tbody>
      </table>
    </div>
    <div class="back">
      <a href="ownerdashboard.jsp" class="btn">Back to Dashboard</a>
    </div>
  </div>
</body>
</html>
