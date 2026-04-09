<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Error</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-7">
            <div class="card border-danger shadow-sm">
                <div class="card-body p-4">
                    <h4 class="text-danger mb-3">Something went wrong</h4>
                    <p class="mb-1"><strong>Status:</strong> ${statusCode}</p>
                    <p class="mb-1"><strong>Path:</strong> ${requestUri}</p>
                    <p class="mb-3"><strong>Message:</strong> ${errorMessage}</p>
                    <a class="btn btn-primary" href="<%=request.getContextPath()%>/auth">Back to Login</a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
