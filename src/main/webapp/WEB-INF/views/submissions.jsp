<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Book Submissions</title>
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
            --shadow: 0 10px 24px rgba(22, 34, 74, 0.08);
            --nav: #121418;
        }
        html[data-theme="dark"] {
            --bg: #0d1424;
            --surface: #111b2f;
            --surface-2: #0d1629;
            --text: #e8eeff;
            --muted: #9baccc;
            --primary: #5f8fff;
            --border: #243657;
            --shadow: 0 12px 26px rgba(0, 0, 0, 0.35);
            --nav: #0b0f18;
        }

        * { box-sizing: border-box; }
        body {
            margin: 0;
            font-family: "Outfit", sans-serif;
            background: radial-gradient(circle at 10% 0%, rgba(47,109,246,0.12), transparent 45%), var(--bg);
            color: var(--text);
        }

        .topbar {
            background: var(--nav);
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
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
            display: inline-flex;
            align-items: center;
            gap: 10px;
            color: #fff;
            text-decoration: none;
            font-weight: 800;
            font-size: 1.7rem;
        }
        .brand i { color: var(--primary); }
        .top-actions { display: flex; align-items: center; gap: 10px; }
        .theme-btn,
        .nav-btn {
            border: 1px solid rgba(255, 255, 255, 0.2);
            background: rgba(255, 255, 255, 0.1);
            color: #fff;
            border-radius: 10px;
            padding: 9px 12px;
            text-decoration: none;
            font-size: 0.92rem;
            font-weight: 700;
        }
        .theme-btn {
            width: 40px;
            height: 40px;
            display: grid;
            place-items: center;
            padding: 0;
            cursor: pointer;
        }

        .shell {
            max-width: 1320px;
            margin: 20px auto;
            padding: 0 18px 24px;
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
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 10px;
        }
        .card-head h2 {
            margin: 0;
            font-size: 1.6rem;
        }
        .count-pill {
            color: #159d67;
            background: #e6f7ef;
            border: 1px solid rgba(21, 157, 103, 0.25);
            padding: 6px 12px;
            border-radius: 999px;
            font-size: 0.9rem;
            font-weight: 800;
        }
        .table-wrap {
            overflow-x: auto;
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
        .cover-thumb {
            width: 56px;
            height: 78px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid var(--border);
            background: var(--surface-2);
        }
        .book-title, .submitter-name {
            font-weight: 800;
            color: var(--text);
        }
        .muted { color: var(--muted); font-size: 0.85rem; }
        .status {
            border-radius: 999px;
            padding: 4px 10px;
            font-size: 0.78rem;
            font-weight: 800;
            display: inline-block;
        }
        .pending { background: #fff4df; color: #b56d00; }
        .approved { background: #e6f7ef; color: #159d67; }
        .rejected { background: #ffe8ed; color: #db214f; }
        .action-wrap { display: flex; gap: 8px; flex-wrap: wrap; }
        .action-btn {
            border: 0;
            border-radius: 9px;
            padding: 7px 10px;
            font-size: 0.8rem;
            font-weight: 800;
            cursor: pointer;
        }
        .btn-approve { background: #e6f7ef; color: #0f8a57; }
        .btn-reject { background: #ffe8ed; color: #cf1c4c; }
        .btn-delete { background: #eef3ff; color: #2f6df6; }
        .empty {
            padding: 22px;
            color: var(--muted);
            text-align: center;
            font-weight: 700;
        }
    </style>
</head>
<body>
<header class="topbar">
    <div class="topbar-inner">
        <a href="<c:url value='/home'/>" class="brand"><i class="bi bi-book-half"></i>Bookstore</a>
        <div class="top-actions">
            <button id="themeToggle" class="theme-btn" type="button" title="Toggle theme"><i class="bi bi-moon-stars-fill"></i></button>
            <a href="<c:url value='/app/books'/>" class="nav-btn">Back to Admin</a>
            <a href="<c:url value='/logout'/>" class="nav-btn">Logout</a>
        </div>
    </div>
</header>

<main class="shell">
    <section class="card">
        <div class="card-head">
            <h2>Book Submission Requests</h2>
            <span class="count-pill">${submissions.size()} Total</span>
        </div>

        <div class="table-wrap">
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Cover</th>
                    <th>Submitter</th>
                    <th>Book</th>
                    <th>Price</th>
                    <th>Qty</th>
                    <th>Status</th>
                    <th>Submitted At</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="s" items="${submissions}">
                    <tr>
                        <td>${s.submissionId}</td>
                        <td>
                            <img class="cover-thumb" src="<c:url value='/${s.coverImagePath}'/>" alt="${s.title}">
                        </td>
                        <td>
                            <div class="submitter-name">${s.submitterName}</div>
                            <div class="muted">${s.submitterEmail}</div>
                            <c:if test="${not empty s.submitterPhone}">
                                <div class="muted">${s.submitterPhone}</div>
                            </c:if>
                        </td>
                        <td>
                            <div class="book-title">${s.title}</div>
                            <div class="muted">${s.author}</div>
                        </td>
                        <td>&#8377;${s.price}</td>
                        <td>${s.quantity}</td>
                        <td>
                            <span class="status ${s.status eq 'PENDING' ? 'pending' : (s.status eq 'APPROVED' ? 'approved' : 'rejected')}">${s.status}</span>
                        </td>
                        <td>${s.submittedAt}</td>
                        <td>
                            <div class="action-wrap">
                                <c:if test="${s.status eq 'PENDING'}">
                                    <form action="<c:url value='/app/submissions'/>" method="post">
                                        <input type="hidden" name="action" value="approve">
                                        <input type="hidden" name="submissionId" value="${s.submissionId}">
                                        <button class="action-btn btn-approve" type="submit">Approve</button>
                                    </form>
                                    <form action="<c:url value='/app/submissions'/>" method="post">
                                        <input type="hidden" name="action" value="reject">
                                        <input type="hidden" name="submissionId" value="${s.submissionId}">
                                        <button class="action-btn btn-reject" type="submit">Reject</button>
                                    </form>
                                </c:if>
                                <c:if test="${s.status ne 'PENDING'}">
                                    <form action="<c:url value='/app/submissions'/>" method="post">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="submissionId" value="${s.submissionId}">
                                        <button class="action-btn btn-delete" type="submit">Delete</button>
                                    </form>
                                </c:if>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <c:if test="${empty submissions}">
                <div class="empty">No submissions found.</div>
            </c:if>
        </div>
    </section>
</main>

<script>
    (function () {
        var root = document.documentElement;
        var btn = document.getElementById("themeToggle");
        var key = "bookstore-submissions-theme";

        function setTheme(theme) {
            root.setAttribute("data-theme", theme);
            localStorage.setItem(key, theme);
            btn.innerHTML = theme === "dark"
                ? '<i class="bi bi-sun-fill"></i>'
                : '<i class="bi bi-moon-stars-fill"></i>';
        }

        setTheme(localStorage.getItem(key) === "dark" ? "dark" : "light");
        btn.addEventListener("click", function () {
            setTheme(root.getAttribute("data-theme") === "dark" ? "light" : "dark");
        });
    })();
</script>
</body>
</html>


