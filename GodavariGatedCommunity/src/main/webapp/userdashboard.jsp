<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Dashboard · Godavari Gated Community</title>
  <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@700&family=Inter:wght@400;600&display=swap" rel="stylesheet">
  <style>
    :root{ --bg:#0b0f17; --bg2:#0b152b; --line:rgba(148,163,184,.22); --text:#e5e7eb; --muted:#94a3b8; --gold:#d4af37; --gold2:#ffd97a; --r:16px; }
    *{box-sizing:border-box} html,body{height:100%}
    body{
      margin:0; font-family:Inter,system-ui,Arial; color:var(--text);
      background: radial-gradient(900px 600px at 20% -10%, rgba(34,211,238,.08), transparent 60%),
                 radial-gradient(800px 500px at 120% 10%, rgba(212,175,55,.08), transparent 60%),
                 linear-gradient(160deg, var(--bg), #0a1222 48%, var(--bg2));
      padding:20px; display:flex; flex-direction:column; align-items:center; justify-content:center;
    }
    .header{
      width:min(1200px,96vw); display:flex; justify-content:space-between; align-items:center; margin-bottom:20px;
    }
    h2{font-family:Cinzel,serif; font-size:24px; margin:0;}
    .logout{
      padding:10px 18px; background:rgba(239,68,68,.2); color:#fca5a5; border:1px solid rgba(239,68,68,.3);
      border-radius:8px; text-decoration:none; font-size:14px; font-weight:600;
    }

    .grid{
      width:min(1200px,96vw);
      display:grid; grid-template-columns:repeat(3,1fr); gap:20px;
    }
    @media (max-width:980px){ .grid{ grid-template-columns:1fr } }

    form.card{
      margin:0; border:1px solid var(--line); border-radius:var(--r);
      background:linear-gradient(180deg, rgba(17,24,39,.9), rgba(17,24,39,.78));
      padding:20px; display:flex; flex-direction:column; gap:12px;
    }
    h3{
      font-family:Cinzel,serif; font-size:20px; margin:0; letter-spacing:.5px; text-transform:uppercase;
    }
    .desc{
      color:var(--muted); font-size:13px; margin:0;
    }
    button{
      align-self:flex-start; border:0; border-radius:12px; padding:10px 16px; cursor:pointer;
      font-weight:800; letter-spacing:.3px; color:#0b0f17;
      background:linear-gradient(92deg, var(--gold), var(--gold2));
    }
  </style>
</head>
<body>
  <div class="header">
    <h2>Welcome <%=session.getAttribute("username") %></h2>
    <a href="logout" class="logout">Logout</a>
  </div>

  <div class="grid">
    <form class="card" action="submitComplaint.jsp" method="get">
      <h3>Submit a Complaint</h3>
      <p class="desc">Raise a new issue with location and details.</p>
      <button type="submit">Open form</button>
    </form>

    <form class="card" action="viewServlet" method="get">
      <h3>View Complaints</h3>
      <p class="desc">See all your complaints and their statuses.</p>
      <button type="submit">View list</button>
    </form>

    <form class="card" action="solvedServlet" method="get">
      <h3>Solved Complaints</h3>
      <p class="desc">Browse issues that have been resolved.</p>
      <button type="submit">See solved</button>
    </form>
  </div>
</body>
</html>
