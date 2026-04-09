package org.example.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public final class DBUtil {
    private static final Properties PROPERTIES = loadProperties();

    private DBUtil() {
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(
                PROPERTIES.getProperty("db.url"),
                PROPERTIES.getProperty("db.username"),
                PROPERTIES.getProperty("db.password")
        );
    }

    private static Properties loadProperties() {
        Properties properties = new Properties();
        try (InputStream inputStream = DBUtil.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (inputStream == null) {
                throw new IllegalStateException("db.properties not found in classpath.");
            }
            properties.load(inputStream);
            Class.forName(properties.getProperty("db.driver"));
            return properties;
        } catch (IOException | ClassNotFoundException ex) {
            throw new IllegalStateException("Database configuration could not be loaded.", ex);
        }
    }
}
