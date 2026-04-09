package org.example.controller;

import org.example.dao.BookDao;
import org.example.dao.BookSubmissionDao;
import org.example.dao.UserDao;
import org.example.model.Book;
import org.example.model.BookSubmission;
import org.example.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/app/submissions")
public class SubmissionAdminServlet extends HttpServlet {
    private final BookSubmissionDao submissionDao = new BookSubmissionDao();
    private final BookDao bookDao = new BookDao();
    private final UserDao userDao = new UserDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Admin access required.");
            return;
        }

        List<BookSubmission> submissions = submissionDao.findAll();
        request.setAttribute("submissions", submissions);
        request.getRequestDispatcher("/WEB-INF/views/submissions.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Admin access required.");
            return;
        }

        String action = request.getParameter("action");
        String submissionIdValue = request.getParameter("submissionId");
        if (isBlank(action) || isBlank(submissionIdValue)) {
            response.sendRedirect(request.getContextPath() + "/app/submissions");
            return;
        }

        Integer submissionId = Integer.parseInt(submissionIdValue);
        BookSubmission submission = submissionDao.findById(submissionId);
        if (submission == null) {
            response.sendRedirect(request.getContextPath() + "/app/submissions");
            return;
        }

        if ("approve".equalsIgnoreCase(action)) {
            if (!"PENDING".equalsIgnoreCase(submission.getStatus())) {
                response.sendRedirect(request.getContextPath() + "/app/submissions");
                return;
            }
            User admin = getAuthenticatedUser(request);
            User creator = admin == null ? null : userDao.findById(admin.getUserId());
            if (creator != null) {
                Book book = new Book();
                book.setTitle(submission.getTitle());
                book.setAuthor(submission.getAuthor());
                book.setPrice(submission.getPrice());
                book.setQuantity(submission.getQuantity());
                book.setCoverImageUrl(request.getContextPath() + "/" + submission.getCoverImagePath());
                book.setCreatedBy(creator);
                bookDao.save(book);
                submissionDao.markReviewed(submissionId, "APPROVED");
            }
        } else if ("reject".equalsIgnoreCase(action)) {
            if ("PENDING".equalsIgnoreCase(submission.getStatus())) {
                submissionDao.markReviewed(submissionId, "REJECTED");
            }
        } else if ("delete".equalsIgnoreCase(action)) {
            if (!"PENDING".equalsIgnoreCase(submission.getStatus())) {
                submissionDao.deleteById(submissionId);
            }
        }

        response.sendRedirect(request.getContextPath() + "/app/submissions");
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

    private User getAuthenticatedUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return null;
        }
        Object user = session.getAttribute("loggedInUser");
        return (user instanceof User) ? (User) user : null;
    }
}
