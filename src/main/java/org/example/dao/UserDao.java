package org.example.dao;

import org.example.model.User;
import org.example.util.HibernateUtil;
import org.hibernate.Session;

public class UserDao {

    public User findByEmail(String email) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery(
                            "from User u join fetch u.role where lower(u.email) = :email", User.class)
                    .setParameter("email", email.toLowerCase())
                    .uniqueResult();
        }
    }

    public User findById(Integer userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery(
                            "from User u join fetch u.role where u.userId = :userId", User.class)
                    .setParameter("userId", userId)
                    .uniqueResult();
        }
    }
}
