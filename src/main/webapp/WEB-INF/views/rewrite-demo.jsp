<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>URL Rewriting Demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5">
    <div class="card shadow-sm">
        <div class="card-body">
            <h4 class="mb-3">URL Rewriting Demo</h4>
            <p class="mb-2">Encoded URL (with session support when cookies are disabled):</p>
            <code>${encodedBooksUrl}</code>
            <div class="mt-3">
                <a class="btn btn-primary" href="${encodedBooksUrl}">Go to Books (Encoded URL)</a>
                <a class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/auth">Back</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>
