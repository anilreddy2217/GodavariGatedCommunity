<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Sign up · Godavari Gated Community</title>
  <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@700&family=Inter:wght@400;600&display=swap" rel="stylesheet">
  <style>
    :root{ --bg:#0b0f17; --bg2:#0b152b; --line:rgba(148,163,184,.22); --text:#e5e7eb; --muted:#94a3b8; --gold:#d4af37; --gold2:#ffd97a; --ring:rgba(34,211,238,.35); --r:16px; }
    *{box-sizing:border-box} html,body{height:100%}
    body{margin:0; font-family:Inter,system-ui,Arial; color:var(--text);
      background: radial-gradient(900px 600px at 20% -10%, rgba(34,211,238,.08), transparent 60%),
                 radial-gradient(800px 500px at 120% 10%, rgba(212,175,55,.08), transparent 60%),
                 linear-gradient(160deg, var(--bg), #0a1222 48%, var(--bg2));
      display:flex; align-items:center; justify-content:center; padding:20px }

    .wrap{display:flex; gap:24px; width:min(1000px,94vw)}
    @media (max-width:880px){ .wrap{flex-direction:column} }

    .panel,.card{border:1px solid var(--line); border-radius:var(--r); background:rgba(10,15,26,.6); padding:20px}
    .panel{flex:1}
    .card{flex:1; background:linear-gradient(180deg, rgba(17,24,39,.9), rgba(17,24,39,.78))}

    .brand{display:flex; align-items:center; gap:10px}
    .crest{width:44px; height:44px; border-radius:12px; display:grid; place-items:center;
      background:linear-gradient(135deg, rgba(212,175,55,.25), rgba(34,211,238,.12)); border:1px solid rgba(212,175,55,.35);
      font-family:Cinzel,serif; color:var(--gold); font-weight:700}
    .title{font-family:Cinzel,serif; font-weight:700; letter-spacing:.5px; font-size:24px}
    .subtitle{color:var(--muted); font-size:13px; margin-top:4px}

    .hero{margin-top:16px; border:1px solid var(--line); border-radius:12px; min-height:240px; background:#0b1324; display:grid; place-items:center; overflow:hidden}
    .hero img{width:100%; height:100%; object-fit:cover; display:block}

    h2{margin:0 0 6px; font-family:Cinzel,serif; font-size:20px}
    p.small{margin:0 0 14px; color:var(--muted); font-size:13px}

    label{display:block; font-size:13px; color:#cbd5e1; margin:10px 0 6px}
    .field{position:relative}
    input{width:100%; padding:12px; border-radius:12px; border:1px solid var(--line); background:#0b1220; color:var(--text); font-size:14px; outline:none}
    input:focus{border-color:var(--ring); box-shadow:0 0 0 4px var(--ring)}
    .row{display:flex; gap:12px}
    .row .col{flex:1}
    .btn{width:100%; margin-top:14px; border:0; border-radius:12px; padding:12px 16px; cursor:pointer; font-weight:800; letter-spacing:.3px; color:#0b0f17;
      background:linear-gradient(92deg, var(--gold), var(--gold2))}
    .foot{margin-top:14px; color:var(--muted); font-size:12.5px; text-align:center}
    a{color:#cbd5e1; text-decoration:none}
    a:hover{text-decoration:underline}
  </style>
</head>
<body>
  <main class="wrap">
    <section class="panel">
      <div class="brand">
        <div class="crest">G</div>
        <div>
          <div class="title">Godavari Gated Community</div>
          <div class="subtitle">Gated Community Complaint Tracker. Secure access for Residents & Admins</div>
        </div>
      </div>
      <figure class="hero">
        <!-- Optional: set a hero image for the same vibe -->
        <img id="hero" src="images/godavari.jpg" alt="Community visual" />
      </figure>
    </section>

    <section class="card">
      <h2>Create your account</h2>
      <p class="small">Join the Complaint Tracker to report and follow issues in your community.</p>

      <% if(request.getAttribute("error") != null) { %>
        <div style="padding:10px; background:rgba(239,68,68,.1); border:1px solid rgba(239,68,68,.3); border-radius:8px; color:#fca5a5; font-size:13px; margin-bottom:10px;">
          <%= request.getAttribute("error") %>
        </div>
      <% } %>

      <form action="signup" method="post">
        <label for="username">Username</label>
        <input type="text" name="username" id="username" placeholder="Enter Username" required>

        <label for="password">Password</label>
        <input type="password" name="password" id="password" placeholder="Enter Password" required minlength="6">

        <label for="email">Email</label>
        <input type="email" name="email" id="email" placeholder="Enter Email" required>

        <div class="row">
          <div class="col">
            <label for="fullname">Full Name</label>
            <input type="text" name="fullname" id="fullname" placeholder="Enter Full Name" required>
          </div>
          <div class="col">
            <label for="phone">Phone</label>
            <input type="tel" name="phone" id="phone" placeholder="Enter Phone" pattern="[0-9]{10}" required>
          </div>
        </div>

        <button class="btn" type="submit">Create account</button>
        <div class="foot">Already have an account? <a href="index.jsp"><b>Login</b></a></div>
      </form>
    </section>
  </main>

  <script>
    // Optional: test hero image quickly
    // document.getElementById('hero').src='https://picsum.photos/1200/600'
  </script>
</body>
</html>