package org.example.controller;

import org.example.dao.BookDao;
import org.example.model.Book;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"/book-details", "/book-details.xhtml"})
public class BookDetailsServlet extends HttpServlet {
    private final BookDao bookDao = new BookDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookIdValue = request.getParameter("bookId");
        if (bookIdValue == null || bookIdValue.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "bookId is required.");
            return;
        }

        Book book = bookDao.findById(Integer.parseInt(bookIdValue));
        if (book == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Book not found.");
            return;
        }

        request.setAttribute("book", book);
        request.getRequestDispatcher("/WEB-INF/views/book-details.jsp").forward(request, response);
    }
}
