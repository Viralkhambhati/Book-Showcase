<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bookstore</title>
    <link rel="icon" type="image/jpeg" href="<c:url value='/assets/logo.jpg'/>">
    <link rel="shortcut icon" type="image/jpeg" href="<c:url value='/assets/logo.jpg'/>">
    <link rel="apple-touch-icon" href="<c:url value='/assets/logo.jpg'/>">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --bg: #eef2f7;
            --surface: #ffffff;
            --surface-soft: #f8faff;
            --text: #101828;
            --muted: #667085;
            --border: #e2e8f0;
            --brand: #2962ff;
            --dark-nav: #121418;
            --shadow: 0 8px 24px rgba(17, 24, 39, 0.08);
        }
        html[data-theme="dark"] {
            --bg: #0f172a;
            --surface: #111827;
            --surface-soft: #182235;
            --text: #e5ecff;
            --muted: #a3b2d1;
            --border: #2b3a55;
            --brand: #5e8cff;
            --dark-nav: #0b0f18;
            --shadow: 0 12px 28px rgba(0, 0, 0, 0.35);
        }

        * { box-sizing: border-box; }
        body {
            margin: 0;
            font-family: "Outfit", sans-serif;
            background: var(--bg);
            color: var(--text);
        }

        .topbar {
            background: var(--dark-nav);
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
        }
        .topbar-inner {
            max-width: 1280px;
            margin: 0 auto;
            padding: 14px 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
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
        .brand i { color: #2962ff; }
        .top-nav {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .submit-btn {
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: #fff;
            text-decoration: none;
            border-radius: 10px;
            padding: 8px 14px;
            font-weight: 700;
            font-size: 0.92rem;
        }
        .login-btn {
            background: #2962ff;
            border: 1px solid #2962ff;
            color: #fff;
            text-decoration: none;
            border-radius: 10px;
            padding: 8px 16px;
            font-weight: 700;
            font-size: 0.95rem;
        }
        .theme-btn {
            border: 1px solid rgba(255, 255, 255, 0.18);
            background: rgba(255, 255, 255, 0.08);
            color: #fff;
            border-radius: 10px;
            width: 40px;
            height: 40px;
            display: grid;
            place-items: center;
            cursor: pointer;
            font-size: 1rem;
        }

        .container {
            max-width: 1280px;
            margin: 34px auto;
            padding: 0 20px 28px;
        }

        .hero h1 {
            margin: 0 0 10px;
            font-size: 3.1rem;
            font-weight: 800;
            line-height: 1.1;
        }
        .hero p {
            margin: 0 0 28px;
            color: var(--muted);
            max-width: 760px;
            font-size: 1.65rem;
            line-height: 1.45;
        }
        .hero-actions {
            display: flex;
            gap: 12px;
            margin: 0 0 24px;
        }
        .hero-submit-btn {
            background: var(--brand);
            color: #fff;
            text-decoration: none;
            border: 1px solid var(--brand);
            border-radius: 10px;
            padding: 10px 16px;
            font-weight: 700;
            font-size: 0.95rem;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .catalog-card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 16px;
            box-shadow: var(--shadow);
            overflow: hidden;
        }
        .catalog-head {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            padding: 20px 28px;
            border-bottom: 1px solid var(--border);
        }
        .catalog-head h2 {
            margin: 0;
            font-size: 2.2rem;
            font-weight: 800;
        }
        .catalog-tools {
            color: var(--muted);
            display: flex;
            gap: 16px;
            font-size: 1.1rem;
            align-items: center;
        }

        .books-grid {
            padding: 24px 28px;
            display: grid;
            grid-template-columns: repeat(auto-fit, 300px);
            gap: 16px;
            justify-content: center;
            align-items: start;
        }
        .book-card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 12px;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            width: 300px;
            max-width: 300px;
        }
        .cover {
            width: 250px;
            height: 300px;
            margin: 14px auto 0;
            background:
                radial-gradient(circle at 18% 22%, rgba(255,255,255,0.28), transparent 48%),
                linear-gradient(130deg, #95b7f3, #93e6cd);
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 16px;
        }
        .cover img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 4px;
        }
        .cover span {
            font-size: 0.8rem;
            color: rgba(16, 24, 40, 0.72);
            letter-spacing: 0.4px;
            text-transform: uppercase;
            font-weight: 700;
        }
        .info { padding: 14px 16px 16px; }
        .title {
            margin: 0 0 6px;
            font-size: 1.25rem;
            font-weight: 800;
            line-height: 1.25;
            min-height: 2.2rem;
        }
        .author {
            margin: 0 0 10px;
            color: var(--muted);
            font-size: 0.95rem;
            min-height: 1.2rem;
        }
        .meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
        .price {
            color: var(--brand);
            font-size: 1.2rem;
            font-weight: 800;
        }
        .qty { color: var(--muted); font-size: 0.85rem; font-weight: 600; }
        .details-btn {
            display: block;
            width: 100%;
            text-align: center;
            border: 1px solid var(--border);
            background: var(--surface-soft);
            color: var(--text);
            border-radius: 10px;
            padding: 9px;
            text-decoration: none;
            font-weight: 700;
            font-size: 0.9rem;
        }
        .details-btn:hover {
            border-color: var(--brand);
            color: var(--brand);
        }

        .view-all {
            text-align: center;
            padding: 0 0 24px;
        }
        .view-all a {
            color: var(--brand);
            text-decoration: none;
            font-weight: 700;
            font-size: 1.4rem;
        }

        .features {
            margin-top: 26px;
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 16px;
        }
        .feature {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 12px;
            padding: 18px;
        }
        .feature i { color: var(--brand); font-size: 1.25rem; }
        .feature h4 {
            margin: 10px 0 6px;
            font-size: 1.45rem;
            font-weight: 700;
        }
        .feature p {
            margin: 0;
            color: var(--muted);
            font-size: 1.2rem;
            line-height: 1.45;
        }

        .footer {
            margin-top: 26px;
            border-top: 1px solid var(--border);
            padding: 16px 4px 6px;
            color: var(--muted);
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            flex-wrap: wrap;
            font-size: 1rem;
        }
        .footer-brand {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: var(--text);
            font-weight: 700;
        }
        .footer-brand i { color: var(--brand); }
        .footer-links {
            display: flex;
            gap: 16px;
        }

        @media (max-width: 980px) {
            .hero h1 { font-size: 2.4rem; }
            .hero p { font-size: 1.05rem; }
            .catalog-head h2 { font-size: 1.8rem; }
            .features { grid-template-columns: 1fr; }
            .books-grid { grid-template-columns: 1fr; }
            .book-card {
                width: min(300px, 100%);
                max-width: 300px;
                margin: 0 auto;
            }
        }
    </style>
</head>
<body>
<header class="topbar">
    <div class="topbar-inner">
        <a href="<c:url value='/home'/>" class="brand"><i class="bi bi-book-half"></i>Bookstore</a>
        <nav class="top-nav">
            <button id="themeToggle" class="theme-btn" type="button" title="Toggle theme">
                <i class="bi bi-moon-stars-fill"></i>
            </button>
            <a class="submit-btn" href="<c:url value='/submit-book'/>">Add Your Book to Store</a>
            <a class="login-btn" href="<c:url value='/auth'/>">Login</a>
        </nav>
    </div>
</header>

<main class="container">
    <section class="hero">
        <h1>Explore our Collection</h1>
        <p>Check current stock availability in the bookstore inventory and open any title for detailed stock info.</p>
        <div class="hero-actions">
            <a class="hero-submit-btn" href="<c:url value='/submit-book'/>">
                <i class="bi bi-cloud-upload"></i> Request Book Listing
            </a>
        </div>
    </section>

    <section class="catalog-card" id="catalog">
        <div class="catalog-head">
            <h2>Available Books</h2>
            <div class="catalog-tools">
                <span><i class="bi bi-sort-down-alt"></i> Sort: Popular</span>
                <span><i class="bi bi-funnel"></i> Filter</span>
            </div>
        </div>

        <div class="books-grid">
            <c:forEach var="book" items="${books}">
                <article class="book-card">
                    <div class="cover">
                        <c:choose>
                            <c:when test="${not empty book.coverImageUrl}">
                                <img src="${book.coverImageUrl}" alt="${book.title}">
                            </c:when>
                            <c:otherwise>
                                <span>Book Cover</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="info">
                        <h3 class="title">${book.title}</h3>
                        <p class="author">${book.author}</p>
                        <div class="meta">
                            <span class="price">&#8377;${book.price}</span>
                            <span class="qty">Qty ${book.quantity}</span>
                        </div>
                        <a class="details-btn"
                           href="<c:url value='/book-details'><c:param name='bookId' value='${book.bookId}'/></c:url>">
                            View Details
                        </a>
                    </div>
                </article>
            </c:forEach>

            <c:if test="${empty books}">
                <article class="book-card">
                    <div class="cover"><span>No Cover</span></div>
                    <div class="info">
                        <h3 class="title">No books available</h3>
                        <p class="author">Add books from admin dashboard.</p>
                        <a class="details-btn" href="<c:url value='/auth'/>">Go to Login</a>
                    </div>
                </article>
            </c:if>
        </div>

        <div class="view-all">
            <a href="#catalog">View All Books <i class="bi bi-arrow-right"></i></a>
        </div>
    </section>

    <section class="features">
        <div class="feature">
            <i class="bi bi-box-seam"></i>
            <h4>Live Stock</h4>
            <p>See current available quantity for each book in real-time.</p>
        </div>
        <div class="feature">
            <i class="bi bi-clipboard-data"></i>
            <h4>Inventory Status</h4>
            <p>Track title-wise stock and current price from the database.</p>
        </div>
        <div class="feature">
            <i class="bi bi-arrow-repeat"></i>
            <h4>Updated Records</h4>
            <p>Data reflects latest add, update, and delete operations.</p>
        </div>
    </section>

    <footer class="footer">
        <div class="footer-brand"><i class="bi bi-book-half"></i> Bookstore</div>
        <div>&copy; 2024 Modern Bookstore Inc. All rights reserved.</div>
        <div class="footer-links">
            <span>Privacy</span><span>Terms</span><span>Support</span>
        </div>
    </footer>
</main>

<script>
    (function () {
        var root = document.documentElement;
        var btn = document.getElementById("themeToggle");
        var key = "bookstore-home-theme";

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


