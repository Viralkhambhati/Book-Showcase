package org.example.dao;

import org.example.model.BookSubmission;
import org.example.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.sql.Timestamp;
import java.util.List;

public class BookSubmissionDao {

    public List<BookSubmission> findAll() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("from BookSubmission bs order by bs.submissionId desc", BookSubmission.class).list();
        }
    }

    public BookSubmission findById(Integer submissionId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(BookSubmission.class, submissionId);
        }
    }

    public void save(BookSubmission submission) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.save(submission);
            transaction.commit();
        } catch (RuntimeException ex) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw ex;
        }
    }

    public void markReviewed(Integer submissionId, String status) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            BookSubmission submission = session.get(BookSubmission.class, submissionId);
            if (submission != null) {
                submission.setStatus(status);
                submission.setReviewedAt(new Timestamp(System.currentTimeMillis()));
                session.update(submission);
            }
            transaction.commit();
        } catch (RuntimeException ex) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw ex;
        }
    }

    public void deleteById(Integer submissionId) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            BookSubmission submission = session.get(BookSubmission.class, submissionId);
            if (submission != null) {
                session.delete(submission);
            }
            transaction.commit();
        } catch (RuntimeException ex) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw ex;
        }
    }
}
