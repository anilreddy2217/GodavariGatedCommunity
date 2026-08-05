<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Submit Complaint · Godavari Gated Community</title>
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
      width:min(600px,96vw);
      border:1px solid var(--line); border-radius:var(--r);
      background:linear-gradient(180deg, rgba(17,24,39,.9), rgba(17,24,39,.78));
      padding:28px; display:flex; flex-direction:column; gap:16px;
    }
    h2,h3{font-family:Cinzel,serif; margin:0; letter-spacing:.5px;}
    form{display:flex; flex-direction:column; gap:14px;}
    label{font-weight:600; font-size:14px; margin-bottom:4px;}
    input[type=text],input[type=email],input[type=number],select,textarea{
      width:100%; padding:10px; border-radius:8px; border:1px solid var(--line);
      background:rgba(255,255,255,0.04); color:var(--text);
    }
    select option{color:black; background:white;}
    textarea{resize:vertical; min-height:120px;}
    input[type=submit]{
      align-self:flex-start; border:0; border-radius:12px; padding:12px 20px; cursor:pointer;
      font-weight:800; letter-spacing:.3px; color:#0b0f17;
      background:linear-gradient(92deg, var(--gold), var(--gold2));
    }
  </style>
</head>
<body>
  <div class="container">
    <h2>Welcome <%=session.getAttribute("username") %></h2>
    <h3>Submit a Complaint</h3>

    <form action="submitComplaintServlet" method="post">
      <label for="fullName">Full Name:</label>
      <input type="text" id="fullName" name="fullName" value="<%=session.getAttribute("fullName") %>" readonly>

      <label for="email">Email Address:</label>
      <input type="email" id="email" name="email" value="<%=session.getAttribute("email") %>" readonly>
      
      <label for="phone">Phone:</label>
      <input type="number" id="phone" name="phone" value="<%=session.getAttribute("phone")%>" readonly>

      <label for="category">Complaint Category:</label>
      <select id="category" name="category" required>
        <option value="">-- Select Category --</option>
        <option value="Service">Service</option>
        <option value="Billing">Billing</option>
        <option value="Technical">Technical</option>
        <option value="Other">Other</option>
      </select>

      <label for="subject">Subject:</label>
      <input type="text" id="subject" name="subject" placeholder="Brief summary of your complaint" required>

      <label for="description">Complaint Details:</label>
      <textarea id="description" name="description" placeholder="Describe your complaint in detail..." required></textarea>

      <input type="submit" value="Submit Complaint">
    </form>
  </div>
</body>
</html>
