<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Book Details</title>
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
        }

        body {
            margin: 0;
            font-family: "Outfit", sans-serif;
            background: var(--bg);
            color: var(--text);
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
        .login-btn {
            background: var(--brand);
            border: 1px solid var(--brand);
            color: #fff;
            border-radius: 10px;
            padding: 8px 16px;
            text-decoration: none;
            font-weight: 700;
            font-size: 0.95rem;
        }

        .container {
            max-width: 1120px;
            margin: 34px auto;
            padding: 0 20px 30px;
        }
        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            color: var(--muted);
            font-size: 1.1rem;
            margin-bottom: 18px;
            font-weight: 500;
        }

        .details-card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 20px;
            box-shadow: var(--shadow);
            overflow: hidden;
            display: grid;
            grid-template-columns: 42% 58%;
        }
        .cover-side {
            background: var(--surface-soft);
            padding: 28px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .cover-frame {
            width: 100%;
            max-width: 340px;
            aspect-ratio: 2 / 3;
            border-radius: 14px;
            overflow: hidden;
            background:
                radial-gradient(circle at 20% 20%, rgba(255, 255, 255, 0.28), transparent 52%),
                linear-gradient(130deg, #95b7f3, #93e6cd);
            box-shadow: 0 14px 26px rgba(16, 24, 40, 0.18);
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .cover-frame img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .cover-fallback {
            color: rgba(16, 24, 40, 0.7);
            text-transform: uppercase;
            font-size: 0.8rem;
            letter-spacing: 0.4px;
            font-weight: 700;
        }

        .info-side {
            padding: 34px 34px 28px;
        }
        .tag {
            color: var(--brand);
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 2.2px;
            font-weight: 700;
            margin-bottom: 10px;
        }
        .title {
            margin: 0;
            font-size: 2.45rem;
            font-weight: 800;
            line-height: 1.12;
        }
        .subtitle {
            margin: 8px 0 26px;
            color: var(--muted);
            font-size: 1.45rem;
        }

        .row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-top: 1px solid var(--border);
            padding: 13px 0;
        }
        .row-label {
            color: #8ca0c0;
            text-transform: uppercase;
            letter-spacing: 1.4px;
            font-size: 0.88rem;
            font-weight: 700;
        }
        .row-value {
            color: var(--text);
            font-size: 1.25rem;
            font-weight: 800;
        }
        .row-price { font-size: 1.8rem; }

        .note {
            margin-top: 20px;
            border: 1px solid var(--border);
            border-radius: 14px;
            background: var(--surface-soft);
            color: var(--muted);
            padding: 12px 14px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 0.95rem;
            font-style: italic;
        }

        .footer {
            text-align: center;
            margin-top: 18px;
            color: var(--muted);
            font-size: 0.95rem;
        }

        @media (max-width: 940px) {
            .details-card { grid-template-columns: 1fr; }
            .title { font-size: 2rem; }
            .subtitle { font-size: 1.3rem; }
            .row-label { font-size: 0.78rem; }
            .row-value { font-size: 1rem; }
            .row-price { font-size: 1.4rem; }
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
            <a href="<c:url value='/auth'/>" class="login-btn">Login</a>
        </div>
    </div>
</header>

<main class="container">
    <a href="<c:url value='/home'/>" class="back-link"><i class="bi bi-arrow-left"></i> Back to Catalog</a>

    <section class="details-card">
        <div class="cover-side">
            <div class="cover-frame">
                <c:choose>
                    <c:when test="${not empty book.coverImageUrl}">
                        <img src="${book.coverImageUrl}" alt="${book.title}">
                    </c:when>
                    <c:otherwise>
                        <span class="cover-fallback">Book Cover</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="info-side">
            <div class="tag">Book Details</div>
            <h1 class="title">${book.title}</h1>
            <p class="subtitle">by ${book.author}</p>

            <div class="row">
                <span class="row-label">Book ID</span>
                <span class="row-value">REF-${book.bookId}</span>
            </div>
            <div class="row">
                <span class="row-label">Price</span>
                <span class="row-value row-price">₹${book.price}</span>
            </div>
            <div class="row">
                <span class="row-label">Quantity</span>
                <span class="row-value">${book.quantity} Units</span>
            </div>
            <div class="row">
                <span class="row-label">Created At</span>
                <span class="row-value">${book.createdAt}</span>
            </div>

            <div class="note">
                <i class="bi bi-info-circle-fill"></i>
                This record is displayed as per the administrative archive.
            </div>
        </div>
    </section>

    <div class="footer">© 2024 Bookstore Management Application.</div>
</main>

<script>
    (function () {
        var root = document.documentElement;
        var btn = document.getElementById("themeToggle");
        var key = "bookstore-details-theme";

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
</script>
</body>
</html>


