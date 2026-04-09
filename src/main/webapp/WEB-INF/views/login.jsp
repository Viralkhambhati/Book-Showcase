<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login | Bookstore</title>
    <link rel="icon" type="image/jpeg" href="<c:url value='/assets/logo.jpg'/>">
    <link rel="shortcut icon" type="image/jpeg" href="<c:url value='/assets/logo.jpg'/>">
    <link rel="apple-touch-icon" href="<c:url value='/assets/logo.jpg'/>">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --bg: #edf1f7;
            --surface: #ffffff;
            --surface-soft: #f6f8fc;
            --text: #101828;
            --muted: #52617c;
            --border: #dbe3f1;
            --brand: #2962ff;
            --nav: #121418;
            --shadow: 0 12px 28px rgba(17, 24, 39, 0.08);
            --input-bg: #ffffff;
            --input-border: #cfd8e6;
        }
        html[data-theme="dark"] {
            --bg: #0f172a;
            --surface: #111b2f;
            --surface-soft: #182338;
            --text: #e7edff;
            --muted: #9cb0d2;
            --border: #2d3f5f;
            --brand: #5e8cff;
            --nav: #0b0f18;
            --shadow: 0 14px 30px rgba(0, 0, 0, 0.35);
            --input-bg: #0f1a2d;
            --input-border: #3a4f72;
        }

        * { box-sizing: border-box; }
        body {
            margin: 0;
            font-family: "Outfit", sans-serif;
            background: radial-gradient(circle at 15% 0%, rgba(41,98,255,0.10), transparent 38%), var(--bg);
            color: var(--text);
            min-height: 100vh;
        }

        .topbar {
            background: var(--nav);
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
        }
        .topbar-inner {
            max-width: 1280px;
            margin: 0 auto;
            padding: 14px 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
        }
        .brand {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            color: #fff;
            text-decoration: none;
            font-weight: 800;
            font-size: 1.7rem;
        }
        .brand i { color: var(--brand); }
        .top-right { display: flex; align-items: center; gap: 10px; }
        .theme-btn {
            border: 1px solid rgba(255, 255, 255, 0.18);
            background: rgba(255, 255, 255, 0.08);
            color: #fff;
            border-radius: 10px;
            width: 40px;
            height: 40px;
            display: grid;
            place-items: center;
            font-size: 1rem;
            cursor: pointer;
        }
        .home-btn {
            background: var(--brand);
            border: 1px solid var(--brand);
            color: #fff;
            border-radius: 10px;
            padding: 8px 14px;
            text-decoration: none;
            font-weight: 700;
            font-size: 0.95rem;
        }

        .wrap {
            max-width: 1180px;
            margin: 34px auto;
            padding: 0 20px 28px;
            display: grid;
            grid-template-columns: 1.1fr 0.9fr;
            gap: 26px;
            align-items: stretch;
        }

        .intro {
            background: linear-gradient(160deg, rgba(41,98,255,0.17), rgba(67,233,123,0.10));
            border: 1px solid var(--border);
            border-radius: 20px;
            box-shadow: var(--shadow);
            padding: 34px;
        }
        .intro h1 {
            margin: 0 0 10px;
            font-size: 2.7rem;
            line-height: 1.15;
        }
        .intro p {
            margin: 0;
            color: var(--muted);
            font-size: 1.05rem;
            line-height: 1.55;
            max-width: 520px;
        }
        .intro-points {
            margin-top: 20px;
            display: grid;
            gap: 10px;
        }
        .intro-points div {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 12px;
            padding: 10px 12px;
            font-size: 0.95rem;
            color: var(--muted);
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .intro-points i { color: var(--brand); }

        .card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 20px;
            box-shadow: var(--shadow);
            padding: 26px;
        }
        .card h2 {
            margin: 0 0 16px;
            font-size: 1.8rem;
        }

        .error {
            background: #ffe8ed;
            border: 1px solid #ffc2d0;
            color: #b42347;
            border-radius: 10px;
            padding: 9px 11px;
            margin-bottom: 12px;
            font-size: 0.9rem;
            font-weight: 600;
        }

        .field-wrap { margin-bottom: 13px; }
        label {
            display: block;
            margin-bottom: 6px;
            font-size: 0.95rem;
            font-weight: 700;
            color: var(--text);
        }
        .input {
            width: 100%;
            border: 1px solid var(--input-border);
            border-radius: 12px;
            padding: 11px 12px;
            font-size: 0.96rem;
            font-weight: 500;
            color: var(--text);
            background: var(--input-bg);
            outline: none;
            transition: border-color .2s ease, box-shadow .2s ease, background-color .2s ease;
        }
        .input::placeholder {
            color: #8ea0be;
        }
        .input:focus {
            border-color: var(--brand);
            box-shadow: 0 0 0 3px rgba(41, 98, 255, 0.15);
            background: var(--surface);
        }

        .submit {
            width: 100%;
            border: 0;
            border-radius: 12px;
            padding: 11px;
            background: linear-gradient(135deg, #3678ff, #2962ff);
            color: #fff;
            font-size: 1rem;
            font-weight: 800;
            cursor: pointer;
            box-shadow: 0 10px 18px rgba(41,98,255,0.30);
            margin-top: 4px;
        }

        .hint {
            margin-top: 10px;
            font-size: 0.85rem;
            color: var(--muted);
            text-align: center;
        }

        @media (max-width: 980px) {
            .wrap {
                grid-template-columns: 1fr;
                gap: 16px;
            }
            .card { order: 1; }
            .intro { order: 2; }
            .intro h1 { font-size: 2rem; }
        }
    </style>
</head>
<body>
<header class="topbar">
    <div class="topbar-inner">
        <a href="<c:url value='/home'/>" class="brand"><i class="bi bi-book-half"></i>Bookstore</a>
        <div class="top-right">
            <button id="themeToggle" class="theme-btn" type="button" title="Theme toggle">
                <i class="bi bi-moon-stars-fill"></i>
            </button>
            <a class="home-btn" href="<c:url value='/home'/>">Home</a>
        </div>
    </div>
</header>

<main class="wrap">
    <section class="intro">
        <h1>Welcome Back to Bookstore</h1>
        <p>Sign in to manage inventory, update books, and maintain the catalog with role-based access.</p>
        <div class="intro-points">
            <div><i class="bi bi-shield-check"></i> Secure login with authorization control</div>
            <div><i class="bi bi-lightning-charge"></i> Fast CRUD operations for your books</div>
            <div><i class="bi bi-cloud-check"></i> Data synced with your live MySQL database</div>
        </div>
    </section>

    <section class="card">
        <h2>Sign In</h2>
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        <form method="post" action="<c:url value='/auth'/>" id="loginForm">
            <div class="field-wrap">
                <label for="email">Email</label>
                <input class="input" type="email" id="email" name="email" placeholder="Enter your email" autocomplete="username" required>
            </div>
            <div class="field-wrap">
                <label for="password">Password</label>
                <input class="input" type="password" id="password" name="password" placeholder="Enter your password" autocomplete="current-password" required>
            </div>
            <button type="submit" class="submit">Sign In</button>
            <p class="hint">Use your registered account credentials.</p>
        </form>
    </section>
</main>

<script>
    (function () {
        var root = document.documentElement;
        var btn = document.getElementById("themeToggle");
        var key = "bookstore-login-theme";

        function apply(theme) {
            root.setAttribute("data-theme", theme);
            localStorage.setItem(key, theme);
            btn.innerHTML = theme === "dark"
                ? '<i class="bi bi-sun-fill"></i>'
                : '<i class="bi bi-moon-stars-fill"></i>';
        }

        apply(localStorage.getItem(key) === "dark" ? "dark" : "light");
        btn.addEventListener("click", function () {
            apply(root.getAttribute("data-theme") === "dark" ? "light" : "dark");
        });
    })();

    document.getElementById("loginForm").addEventListener("submit", function (event) {
        var email = document.getElementById("email").value.trim();
        var password = document.getElementById("password").value.trim();
        if (!email || !password) {
            event.preventDefault();
            alert("Email and password are required.");
        }
    });
</script>
</body>
</html>


