package org.example.controller;

import org.example.dao.BookDao;
import org.example.dao.UserDao;
import org.example.model.Book;
import org.example.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/app/books")
public class BookServlet extends HttpServlet {
    private final BookDao bookDao = new BookDao();
    private final UserDao userDao = new UserDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User loggedInUser = getAuthenticatedUser(request);
        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/auth");
            return;
        }

        List<Book> books = bookDao.findAll();
        request.setAttribute("books", books);
        request.getRequestDispatcher("/WEB-INF/views/books.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User loggedInUser = getAuthenticatedUser(request);
        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/auth");
            return;
        }

        String action = request.getParameter("action");
        if ("add".equalsIgnoreCase(action)) {
            addBook(request, loggedInUser);
        } else if ("update".equalsIgnoreCase(action) && isAdmin(request)) {
            updateBook(request);
        } else if ("delete".equalsIgnoreCase(action) && isAdmin(request)) {
            deleteBook(request);
        }

        response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/app/books"));
    }

    private void addBook(HttpServletRequest request, User loggedInUser) {
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String priceValue = request.getParameter("price");
        String quantityValue = request.getParameter("quantity");
        String coverImageUrl = request.getParameter("coverImageUrl");

        if (isBlank(title) || isBlank(author) || isBlank(priceValue) || isBlank(quantityValue)) {
            return;
        }

        User creator = userDao.findById(loggedInUser.getUserId());
        if (creator == null) {
            return;
        }

        Book book = new Book();
        book.setTitle(title.trim());
        book.setAuthor(author.trim());
        book.setPrice(new BigDecimal(priceValue.trim()));
        book.setQuantity(Integer.parseInt(quantityValue.trim()));
        book.setCoverImageUrl(isBlank(coverImageUrl) ? null : coverImageUrl.trim());
        book.setCreatedBy(creator);
        bookDao.save(book);
    }

    private void updateBook(HttpServletRequest request) {
        String bookIdValue = request.getParameter("bookId");
        if (isBlank(bookIdValue)) {
            return;
        }
        Book book = bookDao.findById(Integer.parseInt(bookIdValue));
        if (book == null) {
            return;
        }

        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String priceValue = request.getParameter("price");
        String quantityValue = request.getParameter("quantity");
        String coverImageUrl = request.getParameter("coverImageUrl");

        if (!isBlank(title)) {
            book.setTitle(title.trim());
        }
        if (!isBlank(author)) {
            book.setAuthor(author.trim());
        }
        if (!isBlank(priceValue)) {
            book.setPrice(new BigDecimal(priceValue.trim()));
        }
        if (!isBlank(quantityValue)) {
            book.setQuantity(Integer.parseInt(quantityValue.trim()));
        }
        book.setCoverImageUrl(isBlank(coverImageUrl) ? null : coverImageUrl.trim());
        bookDao.update(book);
    }

    private void deleteBook(HttpServletRequest request) {
        String bookIdValue = request.getParameter("bookId");
        if (isBlank(bookIdValue)) {
            return;
        }
        Book book = bookDao.findById(Integer.parseInt(bookIdValue));
        if (book != null) {
            bookDao.delete(book);
            try {
                bookDao.resequenceBookIds();
            } catch (RuntimeException ex) {
                ex.printStackTrace();
            }
        }
    }

    private User getAuthenticatedUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return null;
        }
        Object user = session.getAttribute("loggedInUser");
        return (user instanceof User) ? (User) user : null;
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return false;
        }
        Object role = session.getAttribute("role");
        return role != null && "ADMIN".equalsIgnoreCase(role.toString());
    }
}
