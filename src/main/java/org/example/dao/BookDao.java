package org.example.dao;

import org.example.model.Book;
import org.example.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;

public class BookDao {

    public List<Book> findAll() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery(
                            "from Book b join fetch b.createdBy cb join fetch cb.role order by b.bookId desc",
                            Book.class)
                    .list();
        }
    }

    public Book findById(Integer bookId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(Book.class, bookId);
        }
    }

    public void save(Book book) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.save(book);
            transaction.commit();
        } catch (RuntimeException ex) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw ex;
        }
    }

    public void update(Book book) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.update(book);
            transaction.commit();
        } catch (RuntimeException ex) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw ex;
        }
    }

    public void delete(Book book) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.delete(book);
            transaction.commit();
        } catch (RuntimeException ex) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw ex;
        }
    }

    public void resequenceBookIds() {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            // Resequence inside same table only:
            // 1) Shift IDs to high range, 2) assign negative sequence, 3) flip to positive.
            session.createNativeQuery("SET @offset := 1000000").executeUpdate();
            session.createNativeQuery("UPDATE books SET book_id = book_id + @offset").executeUpdate();
            session.createNativeQuery("SET @rownum := 0").executeUpdate();
            session.createNativeQuery(
                    "UPDATE books b " +
                            "JOIN (SELECT book_id, (@rownum := @rownum + 1) AS new_id FROM books ORDER BY book_id) x " +
                            "ON b.book_id = x.book_id " +
                            "SET b.book_id = -x.new_id")
                    .executeUpdate();
            session.createNativeQuery("UPDATE books SET book_id = -book_id").executeUpdate();
            session.createNativeQuery("ALTER TABLE books AUTO_INCREMENT = 1").executeUpdate();
            transaction.commit();
        } catch (RuntimeException ex) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw ex;
        }
    }
}
