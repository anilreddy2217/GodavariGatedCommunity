<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Login · Godavari Gated Community</title>
  <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@700&family=Inter:wght@400;600&display=swap" rel="stylesheet">
  <style>
    :root{
      --bg:#0b0f17; --bg2:#0b152b; --slate:#0f172a; --card:#111827;
      --text:#e5e7eb; --muted:#94a3b8; --line:rgba(148,163,184,.22);
      --gold:#d4af37; --gold2:#ffd97a; --ring:rgba(34,211,238,.35); --r:16px;
    }
    *{box-sizing:border-box} html,body{height:100%}
    body{margin:0; font-family:Inter,system-ui,Arial; color:var(--text);
      background: radial-gradient(900px 600px at 20% -10%, rgba(34,211,238,.08), transparent 60%),
                 radial-gradient(800px 500px at 120% 10%, rgba(212,175,55,.08), transparent 60%),
                 linear-gradient(160deg, var(--bg), #0a1222 48%, var(--bg2));
      display:flex; align-items:center; justify-content:center; padding:20px; }

    .wrap{display:flex; gap:24px; width:min(1000px,94vw)}
    @media (max-width:880px){ .wrap{flex-direction:column} }

    .panel, .card{border:1px solid var(--line); border-radius:var(--r); background:rgba(10,15,26,.6); padding:20px}
    .panel{flex:1}
    .card{flex:1; background:linear-gradient(180deg, rgba(17,24,39,.9), rgba(17,24,39,.78))}

    .brand{display:flex; align-items:center; gap:10px}
    .crest{width:44px; height:44px; border-radius:12px; display:grid; place-items:center;
      background:linear-gradient(135deg, rgba(212,175,55,.25), rgba(34,211,238,.12)); border:1px solid rgba(212,175,55,.35);
      font-family:Cinzel,serif; color:var(--gold); font-weight:700}
    .title{font-family:Cinzel,serif; font-weight:700; letter-spacing:.5px; font-size:24px}
    .subtitle{color:var(--muted); font-size:13px; margin-top:4px}

    .hero{margin-top:16px; border:1px solid var(--line); border-radius:12px; min-height:240px; background:#0b1324;
      display:grid; place-items:center; overflow:hidden}
    .hero img{width:100%; height:100%; object-fit:cover; display:block}

    h2{margin:0 0 6px; font-family:Cinzel,serif; font-size:20px}
    p.small{margin:0 0 14px; color:var(--muted); font-size:13px}

    label{display:block; font-size:13px; color:#cbd5e1; margin:10px 0 6px}
    .field{position:relative}
    input{width:100%; padding:12px; border-radius:12px; border:1px solid var(--line); background:#0b1220; color:var(--text); font-size:14px; outline:none}
    input:focus{border-color:var(--ring); box-shadow:0 0 0 4px var(--ring)}
    .toggle{position:absolute; right:8px; top:50%; transform:translateY(-50%); background:transparent; border:0; color:#cbd5e1; cursor:pointer; padding:6px 8px}

    .row{display:flex; justify-content:space-between; align-items:center; margin-top:10px; gap:8px}
    .row a{color:#cbd5e1; font-size:13px; text-decoration:none}
    .row a:hover{text-decoration:underline}

    .btn{width:100%; margin-top:14px; border:0; border-radius:12px; padding:12px 16px; cursor:pointer; font-weight:800; letter-spacing:.3px; color:#0b0f17;
      background:linear-gradient(92deg, var(--gold), var(--gold2))}
    .foot{margin-top:14px; color:var(--muted); font-size:12.5px; text-align:center}
    .center-link {
    display: block;
    text-align: center;
	}
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
        <!-- Set your picture here -->
        <img id="hero" src="images/godavari.jpg" alt="Community visual" />
      </figure>
    </section>

    <section class="card">
      <h2>Welcome back</h2>
      <p class="small">Sign in to continue to the Complaint Tracker.</p>

      <% if(request.getAttribute("error") != null) { %>
        <div style="padding:10px; background:rgba(239,68,68,.1); border:1px solid rgba(239,68,68,.3); border-radius:8px; color:#fca5a5; font-size:13px; margin-bottom:10px;">
          <%= request.getAttribute("error") %>
        </div>
      <% } %>
      
      <% if(request.getAttribute("success") != null) { %>
        <div style="padding:10px; background:rgba(34,197,94,.1); border:1px solid rgba(34,197,94,.3); border-radius:8px; color:#86efac; font-size:13px; margin-bottom:10px;">
          <%= request.getAttribute("success") %>
        </div>
      <% } %>

    <form action="login" method="post">
    <label for="username">Username</label>
    <div class="field">
        <input id="username" name="username" type="text" placeholder="Enter the username" autocomplete="username" >
    </div>

    <label for="password">Password</label>
    <div class="field">
        <input id="password" name="password" type="password" placeholder="Enter the password" autocomplete="current-password" autofocus="autofocus">
       
    </div>

    <div class="foot">
        Don't have an account? <a href="signup.jsp"><b>Signup</b></a> | <a href="adminSignup.jsp"><b>Admin Signup</b></a>
    </div>

    <button class="btn" type="submit">Sign in</button>
    <div class="foot">2025 Godavari Gated Community</div>
</form>

    </section>
  </main>

  <script>3
    // Minimal: only password show/hide
    const p=document.getElementById('password');
    document.getElementById('show').onclick=(e)=>{const h=p.type==='password';p.type=h?'text':'password';e.currentTarget.textContent=h?'Hide':'Show'}
    // Quick test image (optional):
    // document.getElementById('hero').src='https://picsum.photos/1200/600'
  </script>
</body>
</html>
