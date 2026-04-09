<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bookstore Admin</title>
    <link rel="icon" type="image/jpeg" href="<c:url value='/assets/logo.jpg'/>">
    <link rel="shortcut icon" type="image/jpeg" href="<c:url value='/assets/logo.jpg'/>">
    <link rel="apple-touch-icon" href="<c:url value='/assets/logo.jpg'/>">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --bg: #f3f6fb;
            --surface: #ffffff;
            --surface-2: #f8fafc;
            --text: #14213d;
            --muted: #7081a1;
            --primary: #2f6df6;
            --border: #dbe3f1;
            --success-soft: #e6f7ef;
            --warning-soft: #fff4df;
            --danger-soft: #ffe8ed;
            --shadow: 0 10px 24px rgba(22, 34, 74, 0.08);
        }

        html[data-theme="dark"] {
            --bg: #0d1424;
            --surface: #111b2f;
            --surface-2: #0d1629;
            --text: #e8eeff;
            --muted: #9baccc;
            --primary: #5f8fff;
            --border: #243657;
            --success-soft: #1a3b2d;
            --warning-soft: #3e321d;
            --danger-soft: #3f1f2a;
            --shadow: 0 12px 26px rgba(0, 0, 0, 0.35);
        }

        * { box-sizing: border-box; }
        body {
            margin: 0;
            font-family: "Outfit", sans-serif;
            background: radial-gradient(circle at 10% 0%, rgba(47,109,246,0.12), transparent 45%), var(--bg);
            color: var(--text);
            min-height: 100vh;
            font-size: 16px;
        }

        .topbar {
            background: var(--surface);
            border-bottom: 1px solid var(--border);
            position: sticky;
            top: 0;
            z-index: 10;
        }
        .topbar-inner {
            max-width: 1320px;
            margin: 0 auto;
            padding: 14px 18px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
        }
        .brand {
            display: flex;
            align-items: center;
            gap: 10px;
            font-weight: 800;
            font-size: 1.8rem;
            color: var(--primary);
            text-decoration: none;
        }
        .brand i { color: #3f7dff; }
        .brand small {
            color: var(--muted);
            font-size: 0.8rem;
            font-weight: 700;
            margin-left: 2px;
        }

        .top-actions {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .toggle-btn, .logout-btn {
            border: 1px solid var(--border);
            background: var(--surface);
            color: var(--text);
            padding: 9px 12px;
            border-radius: 10px;
            cursor: pointer;
            text-decoration: none;
            font-weight: 700;
            font-size: 0.92rem;
        }
        .submissions-btn {
            border: 1px solid var(--border);
            background: var(--surface);
            color: var(--text);
            padding: 9px 12px;
            border-radius: 10px;
            cursor: pointer;
            text-decoration: none;
            font-weight: 700;
            font-size: 0.92rem;
        }
        .logout-btn { color: #f04467; }

        .user-pill {
            border-left: 1px solid var(--border);
            padding-left: 12px;
            color: var(--muted);
            font-weight: 700;
            line-height: 1.2;
        }

        .wrap {
            max-width: 1320px;
            margin: 20px auto;
            padding: 0 18px 24px;
        }
        .grid {
            display: grid;
            grid-template-columns: 380px 1fr;
            gap: 20px;
        }
        .card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 18px;
            box-shadow: var(--shadow);
            overflow: hidden;
        }
        .card-head {
            padding: 18px 22px;
            border-bottom: 1px solid var(--border);
            font-size: 1.6rem;
            font-weight: 800;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 10px;
        }
        .card-head .head-title {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            line-height: 1.2;
        }
        .head-muted {
            color: #159d67;
            background: var(--success-soft);
            border: 1px solid rgba(21, 157, 103, 0.25);
            padding: 6px 12px;
            border-radius: 999px;
            font-size: 0.95rem;
            font-weight: 800;
        }
        .card-body { padding: 20px 22px; }

        .label {
            font-size: 1rem;
            font-weight: 700;
            margin-bottom: 8px;
            display: block;
        }
        .field {
            width: 100%;
            border: 1px solid var(--border);
            background: var(--surface-2);
            color: var(--text);
            border-radius: 12px;
            padding: 11px 13px;
            margin-bottom: 16px;
            font-size: 0.95rem;
            font-weight: 600;
        }
        .row2 {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
        }
        .btn-primary {
            width: 100%;
            border: 0;
            border-radius: 13px;
            padding: 13px;
            font-weight: 800;
            font-size: 1rem;
            color: #fff;
            background: linear-gradient(135deg, #4b86ff, #2f6df6);
            cursor: pointer;
            box-shadow: 0 10px 18px rgba(47,109,246,0.3);
            margin-top: 8px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.95rem;
        }
        th, td {
            border-bottom: 1px solid var(--border);
            padding: 12px 10px;
            text-align: left;
            vertical-align: middle;
        }
        th {
            color: var(--muted);
            font-size: 0.76rem;
            letter-spacing: 0.3px;
            text-transform: uppercase;
        }
        .id-text { color: #7890b5; font-weight: 800; }
        .book-title { font-weight: 800; }
        .book-author { color: var(--muted); font-size: 0.85rem; }
        .qty-pill {
            display: inline-block;
            border-radius: 10px;
            padding: 4px 10px;
            font-weight: 800;
        }
        .qty-ok { background: #e7efff; color: #2f6df6; }
        .qty-low { background: var(--warning-soft); color: #b56d00; }
        .created-by {
            display: flex;
            align-items: center;
            gap: 8px;
            color: var(--text);
        }
        .created-by .bi-person-circle { color: #9bb1d4; font-size: 20px; }

        .action-wrap { display: flex; gap: 8px; }
        .icon-btn {
            border: 0;
            border-radius: 10px;
            width: 36px;
            height: 36px;
            display: grid;
            place-items: center;
            cursor: pointer;
            font-size: 14px;
            font-weight: 800;
        }
        .btn-edit { background: #fff3dc; color: #ce7f00; }
        .btn-del { background: #ffe8ee; color: #db214f; }
        .view-only {
            font-size: 0.85rem;
            font-weight: 700;
            color: var(--muted);
        }
        .table-foot {
            color: var(--muted);
            font-weight: 700;
            font-size: 0.9rem;
            padding: 14px 10px 2px;
        }

        @media (max-width: 1080px) {
            .grid { grid-template-columns: 1fr; }
            .brand { font-size: 1.35rem; }
            .brand small { display: none; }
        }
    </style>
</head>
<body>
<header class="topbar">
    <div class="topbar-inner">
        <a href="<c:url value='/home'/>" class="brand">
            <i class="bi bi-book-half"></i>
            <span>Bookstore</span>
            <small>Admin</small>
        </a>
        <div class="top-actions">
            <button id="themeToggle" class="toggle-btn" type="button" title="Toggle theme">
                <i class="bi bi-moon-stars-fill"></i>
            </button>
            <c:if test="${sessionScope.role eq 'ADMIN'}">
                <a href="<c:url value='/app/submissions'/>" class="submissions-btn">
                    <i class="bi bi-inbox"></i> Submissions
                </a>
            </c:if>
            <div class="user-pill">
                ${sessionScope.role}<br>${sessionScope.loggedInUser.fullName}
            </div>
            <a href="<c:url value='/logout'/>" class="logout-btn"><i class="bi bi-box-arrow-right"></i> Logout</a>
        </div>
    </div>
</header>

<main class="wrap">
    <div class="grid">
        <section class="card">
            <div class="card-head"><span class="head-title"><i class="bi bi-pencil-square"></i> Add / Update Book</span></div>
            <div class="card-body">
                <form id="bookForm" action="<c:url value='/app/books'/>" method="post">
                    <input type="hidden" name="action" id="action" value="add">
                    <input type="hidden" name="bookId" id="bookId">

                    <label class="label" for="title">Book Title</label>
                    <input class="field" type="text" id="title" name="title" placeholder="e.g. Atomic Habits" required>

                    <label class="label" for="author">Author Name</label>
                    <input class="field" type="text" id="author" name="author" placeholder="e.g. James Clear" required>

                    <div class="row2">
                        <div>
                            <label class="label" for="price">Price (₹)</label>
                            <input class="field" type="number" step="0.01" min="0" id="price" name="price" required>
                        </div>
                        <div>
                            <label class="label" for="quantity">Quantity</label>
                            <input class="field" type="number" min="0" id="quantity" name="quantity" required>
                        </div>
                    </div>
                    <label class="label" for="coverImageUrl">Cover Image URL</label>
                    <input class="field" type="url" id="coverImageUrl" name="coverImageUrl" placeholder="https://example.com/book-cover.jpg">

                    <button type="submit" class="btn-primary" id="submitBtn">
                        <i class="bi bi-plus-circle-fill"></i> Save to Inventory
                    </button>
                </form>
            </div>
        </section>

        <section class="card">
            <div class="card-head">
                <span><i class="bi bi-table"></i>&nbsp; Inventory Status</span>
                <span class="head-muted">${books.size()} Total Books</span>
            </div>
            <div class="card-body">
                <table>
                    <thead>
                    <tr>
                        <th>Sr No</th>
                        <th>Book Details</th>
                        <th>Pricing</th>
                        <th>Qty</th>
                        <th>Created By</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="book" items="${books}" varStatus="row">
                        <tr>
                            <td class="id-text">${row.count}</td>
                            <td>
                                <div class="book-title">${book.title}</div>
                                <div class="book-author">${book.author}</div>
                            </td>
                            <td><strong>₹${book.price}</strong></td>
                            <td>
                                <span class="qty-pill ${book.quantity <= 5 ? 'qty-low' : 'qty-ok'}">${book.quantity}</span>
                            </td>
                            <td>
                                <span class="created-by"><i class="bi bi-person-circle"></i>${book.createdBy.fullName}</span>
                            </td>
                            <td>
                                <div class="action-wrap">
                                    <c:choose>
                                        <c:when test="${sessionScope.role eq 'ADMIN'}">
                                            <button type="button"
                                                    class="icon-btn btn-edit edit-btn"
                                                    data-book-id="${book.bookId}"
                                                    data-title="${book.title}"
                                                    data-author="${book.author}"
                                                    data-price="${book.price}"
                                                    data-quantity="${book.quantity}"
                                                    data-cover-image-url="${book.coverImageUrl}">
                                                <i class="bi bi-pencil-fill"></i>
                                            </button>
                                            <form action="<c:url value='/app/books'/>" method="post" class="d-inline">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="bookId" value="${book.bookId}">
                                                <button type="submit" class="icon-btn btn-del"><i class="bi bi-trash-fill"></i></button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="view-only">View only</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty books}">
                        <tr>
                            <td colspan="6" class="table-foot text-center">No books found.</td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
                <c:if test="${not empty books}">
                    <div class="table-foot">Showing ${books.size()} books</div>
                </c:if>
            </div>
        </section>
    </div>
</main>

<script>
    (function () {
        var root = document.documentElement;
        var btn = document.getElementById("themeToggle");
        var key = "bookstore-theme";

        function setTheme(theme) {
            root.setAttribute("data-theme", theme);
            localStorage.setItem(key, theme);
            btn.innerHTML = theme === "dark"
                ? '<i class="bi bi-sun-fill"></i>'
                : '<i class="bi bi-moon-stars-fill"></i>';
        }

        var saved = localStorage.getItem(key);
        setTheme(saved === "dark" ? "dark" : "light");
        btn.addEventListener("click", function () {
            setTheme(root.getAttribute("data-theme") === "dark" ? "light" : "dark");
        });
    })();

    var form = document.getElementById("bookForm");
    var actionField = document.getElementById("action");
    var bookIdField = document.getElementById("bookId");
    var titleField = document.getElementById("title");
    var authorField = document.getElementById("author");
    var priceField = document.getElementById("price");
    var quantityField = document.getElementById("quantity");
    var coverImageUrlField = document.getElementById("coverImageUrl");
    var submitBtn = document.getElementById("submitBtn");

    document.querySelectorAll(".edit-btn").forEach(function (button) {
        button.addEventListener("click", function () {
            actionField.value = "update";
            bookIdField.value = this.dataset.bookId;
            titleField.value = this.dataset.title;
            authorField.value = this.dataset.author;
            priceField.value = this.dataset.price;
            quantityField.value = this.dataset.quantity;
            coverImageUrlField.value = this.dataset.coverImageUrl || "";
            submitBtn.innerHTML = '<i class="bi bi-arrow-repeat"></i> Update Inventory';
            window.scrollTo({ top: 0, behavior: "smooth" });
        });
    });

    form.addEventListener("submit", function (event) {
        if (!titleField.value.trim() || !authorField.value.trim()) {
            event.preventDefault();
            alert("Title and author are required.");
        }
    });
</script>
</body>
</html>


