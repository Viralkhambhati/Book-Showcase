<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Submit Book Request</title>
    <link rel="icon" type="image/jpeg" href="<c:url value='/assets/logo.jpg'/>">
    <link rel="shortcut icon" type="image/jpeg" href="<c:url value='/assets/logo.jpg'/>">
    <link rel="apple-touch-icon" href="<c:url value='/assets/logo.jpg'/>">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --bg: #eef2f7;
            --surface: #ffffff;
            --text: #101828;
            --muted: #667085;
            --border: #e2e8f0;
            --brand: #2962ff;
            --nav: #121418;
        }
        html[data-theme="dark"] {
            --bg: #0f172a;
            --surface: #111827;
            --text: #e5ecff;
            --muted: #a3b2d1;
            --border: #2b3a55;
            --brand: #5e8cff;
            --nav: #0b0f18;
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
        .top-right {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .shell {
            max-width: 960px;
            margin: 26px auto;
            padding: 0 18px;
        }
        .form-card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 22px;
        }
        .form-label {
            font-weight: 700;
            color: var(--text);
        }
        .form-control {
            border-color: var(--border);
            background: transparent;
            color: var(--text);
        }
        .form-control:focus {
            border-color: var(--brand);
            box-shadow: 0 0 0 0.2rem rgba(41, 98, 255, 0.15);
        }
        .muted {
            color: var(--muted);
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

<main class="shell">
    <div class="form-card">
        <h2 class="mb-1">Add Your Book to Our Store</h2>
        <p class="muted mb-4">Share your details, enter your book info, and upload cover image for admin approval.</p>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>

        <form action="<c:url value='/submit-book'/>" method="post" enctype="multipart/form-data">
            <div class="row g-3">
                <div class="col-md-6">
                    <label class="form-label" for="submitterName">Your Name</label>
                    <input id="submitterName" name="submitterName" class="form-control" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label" for="submitterEmail">Your Email</label>
                    <input id="submitterEmail" type="email" name="submitterEmail" class="form-control" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label" for="submitterPhone">Phone (Optional)</label>
                    <input id="submitterPhone" name="submitterPhone" class="form-control">
                </div>
                <div class="col-md-6">
                    <label class="form-label" for="title">Book Title</label>
                    <input id="title" name="title" class="form-control" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label" for="author">Author</label>
                    <input id="author" name="author" class="form-control" required>
                </div>
                <div class="col-md-3">
                    <label class="form-label" for="price">Price (INR)</label>
                    <input id="price" name="price" type="number" min="0" step="0.01" class="form-control" required>
                </div>
                <div class="col-md-3">
                    <label class="form-label" for="quantity">Quantity</label>
                    <input id="quantity" name="quantity" type="number" min="0" class="form-control" required>
                </div>
                <div class="col-12">
                    <label class="form-label" for="coverImage">Book Cover Image</label>
                    <input id="coverImage" name="coverImage" type="file" accept="image/*" class="form-control" required>
                </div>
            </div>
            <div class="mt-4 d-flex gap-2">
                <button type="submit" class="btn btn-primary">
                    <i class="bi bi-cloud-upload"></i> Submit Request
                </button>
                <a href="<c:url value='/home'/>" class="btn btn-outline-secondary">Back</a>
            </div>
        </form>
    </div>
</main>

<script>
    (function () {
        var root = document.documentElement;
        var btn = document.getElementById("themeToggle");
        var key = "bookstore-submit-theme";

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


