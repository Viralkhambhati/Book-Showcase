package org.example.controller;

import org.example.dao.BookSubmissionDao;
import org.example.model.BookSubmission;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

@WebServlet("/submit-book")
@MultipartConfig
public class SubmitBookServlet extends HttpServlet {
    private final BookSubmissionDao submissionDao = new BookSubmissionDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/submit-book.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String submitterName = request.getParameter("submitterName");
        String submitterEmail = request.getParameter("submitterEmail");
        String submitterPhone = request.getParameter("submitterPhone");
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String priceValue = request.getParameter("price");
        String quantityValue = request.getParameter("quantity");
        Part coverPart = request.getPart("coverImage");

        if (isBlank(submitterName) || isBlank(submitterEmail) || isBlank(title) || isBlank(author)
                || isBlank(priceValue) || isBlank(quantityValue) || coverPart == null || coverPart.getSize() == 0) {
            request.setAttribute("error", "All required fields and cover image are mandatory.");
            request.getRequestDispatcher("/WEB-INF/views/submit-book.jsp").forward(request, response);
            return;
        }

        String contentType = coverPart.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            request.setAttribute("error", "Only image files are allowed for cover upload.");
            request.getRequestDispatcher("/WEB-INF/views/submit-book.jsp").forward(request, response);
            return;
        }

        String fileName = sanitizeFileName(coverPart.getSubmittedFileName());
        String extension = extractExtension(fileName);
        String storedFileName = UUID.randomUUID().toString() + (extension.isEmpty() ? "" : ("." + extension));
        String relativePath = "uploads/covers/" + storedFileName;

        String realBasePath = getServletContext().getRealPath("/");
        Path uploadDir = Paths.get(realBasePath, "uploads", "covers");
        Files.createDirectories(uploadDir);
        Path targetFile = uploadDir.resolve(storedFileName);
        Files.copy(coverPart.getInputStream(), targetFile, StandardCopyOption.REPLACE_EXISTING);

        try {
            BookSubmission submission = new BookSubmission();
            submission.setSubmitterName(submitterName.trim());
            submission.setSubmitterEmail(submitterEmail.trim());
            submission.setSubmitterPhone(isBlank(submitterPhone) ? null : submitterPhone.trim());
            submission.setTitle(title.trim());
            submission.setAuthor(author.trim());
            submission.setPrice(new BigDecimal(priceValue.trim()));
            submission.setQuantity(Integer.parseInt(quantityValue.trim()));
            submission.setCoverImagePath(relativePath);
            submission.setStatus("PENDING");
            submissionDao.save(submission);
        } catch (RuntimeException ex) {
            Files.deleteIfExists(targetFile);
            throw ex;
        }

        request.setAttribute("success", "Book request submitted successfully. Admin will review it.");
        request.getRequestDispatcher("/WEB-INF/views/submit-book.jsp").forward(request, response);
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    private String sanitizeFileName(String fileName) {
        if (fileName == null) {
            return "cover";
        }
        return new File(fileName).getName().replaceAll("[^a-zA-Z0-9._-]", "_");
    }

    private String extractExtension(String fileName) {
        int dot = fileName.lastIndexOf('.');
        if (dot <= 0 || dot == fileName.length() - 1) {
            return "";
        }
        return fileName.substring(dot + 1).toLowerCase();
    }
}
