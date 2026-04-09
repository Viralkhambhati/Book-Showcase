package org.example.controller;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ErrorServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Object statusCode = request.getAttribute("javax.servlet.error.status_code");
        Object requestUri = request.getAttribute("javax.servlet.error.request_uri");
        Throwable exception = (Throwable) request.getAttribute("javax.servlet.error.exception");

        request.setAttribute("statusCode", statusCode == null ? 500 : statusCode);
        request.setAttribute("requestUri", requestUri == null ? "N/A" : requestUri.toString());
        request.setAttribute("errorMessage",
                exception == null ? "Unexpected error occurred." : exception.getMessage());

        request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
    }
}
