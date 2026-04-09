package org.example.controller;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class UrlRewriteDemoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String encodedBooksUrl = response.encodeURL(request.getContextPath() + "/app/books");
        request.setAttribute("encodedBooksUrl", encodedBooksUrl);
        request.getRequestDispatcher("/WEB-INF/views/rewrite-demo.jsp").forward(request, response);
    }
}
