<%@ page session="true" %>
<%@ page import="dao.ComplaintDAO" %>
<%@ page import="model.Complaint" %>
<%
  int complaintId = Integer.parseInt(request.getParameter("complaintId"));
  ComplaintDAO dao = new ComplaintDAO();
  Complaint complaint = dao.getComplaintById(complaintId);
  
  if(complaint == null || complaint.getUserId() != (Integer)session.getAttribute("userId")) {
    response.sendRedirect("viewServlet");
    return;
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Edit Complaint · Godavari Gated Community</title>
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
    input[type=text],select,textarea{
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
    .back{margin-top:10px;}
    .back a{color:#cbd5e1; text-decoration:none; font-size:14px;}
  </style>
</head>
<body>
  <div class="container">
    <h2>Edit Complaint</h2>
    <p style="color:var(--muted); font-size:13px;">Update your complaint details (Only pending complaints can be edited)</p>

    <form action="userEditComplaint" method="post">
      <input type="hidden" name="complaintId" value="<%= complaint.getComplaintId() %>">

      <label for="category">Complaint Category:</label>
      <select id="category" name="category" required>
        <option value="Service" <%= complaint.getCategory().equals("Service") ? "selected" : "" %>>Service</option>
        <option value="Billing" <%= complaint.getCategory().equals("Billing") ? "selected" : "" %>>Billing</option>
        <option value="Technical" <%= complaint.getCategory().equals("Technical") ? "selected" : "" %>>Technical</option>
        <option value="Other" <%= complaint.getCategory().equals("Other") ? "selected" : "" %>>Other</option>
      </select>

      <label for="subject">Subject:</label>
      <input type="text" id="subject" name="subject" value="<%= complaint.getSubject() %>" required>

      <label for="description">Complaint Details:</label>
      <textarea id="description" name="description" required><%= complaint.getDescription() %></textarea>

      <input type="submit" value="Update Complaint">
      <div class="back"><a href="viewServlet">← Back to Complaints</a></div>
    </form>
  </div>
</body>
</html>
