<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Edit Complaint Status · Admin</title>
  <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@700&family=Inter:wght@400;600&display=swap" rel="stylesheet">
  <style>
    :root{ --bg:#0b0f17; --bg2:#0b152b; --line:rgba(148,163,184,.22); --text:#e5e7eb; --muted:#94a3b8; --gold:#d4af37; --gold2:#ffd97a; --r:16px; }
    *{box-sizing:border-box} html,body{height:100%; margin:0}
    body{
      font-family:Inter,system-ui,Arial; color:var(--text);
      background: radial-gradient(900px 600px at 20% -10%, rgba(34,211,238,.08), transparent 60%),
                 radial-gradient(800px 500px at 120% 10%, rgba(212,175,55,.08), transparent 60%),
                 linear-gradient(160deg, var(--bg), #0a1222 48%, var(--bg2));
      display:flex; align-items:center; justify-content:center; padding:20px;
    }
    .container{
      width:min(500px,96vw);
      border:1px solid var(--line); border-radius:var(--r);
      background:linear-gradient(180deg, rgba(17,24,39,.9), rgba(17,24,39,.78));
      padding:28px; display:flex; flex-direction:column; gap:16px;
    }
    h2{font-family:Cinzel,serif; margin:0; letter-spacing:.5px;}
    form{display:flex; flex-direction:column; gap:14px;}
    label{font-weight:600; font-size:14px; display:flex; align-items:center; gap:8px; padding:10px; border:1px solid var(--line); border-radius:8px; cursor:pointer;}
    label:hover{background:rgba(255,255,255,.03);}
    input[type=radio]{cursor:pointer;}
    button{
      align-self:flex-start; border:0; border-radius:12px; padding:12px 20px; cursor:pointer;
      font-weight:800; letter-spacing:.3px; color:#0b0f17;
      background:linear-gradient(92deg, var(--gold), var(--gold2));
    }
  </style>
</head>
<body>
  <div class="container">
    <h2>Update Complaint Status</h2>
    <p style="color:var(--muted); font-size:13px;">Complaint ID: <%= request.getParameter("complaintId")%></p>

    <form action="editServlet" method="post">
      <input type="hidden" name="complaintId" value="<%= request.getParameter("complaintId")%>">
      
      <label>
        <input type="radio" name="status" value="Pending" checked> Pending
      </label>
      
      <label>
        <input type="radio" name="status" value="In Progress"> In Progress
      </label>
      
      <label>
        <input type="radio" name="status" value="Resolved"> Resolved
      </label>

      <button type="submit">Update Status</button>
    </form>
  </div>
</body>
</html>
