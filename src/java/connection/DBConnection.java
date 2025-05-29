package connection; // Change this to your actual package name if needed

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/groupchat";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    private static Connection connection = null;

    // Private constructor to prevent instantiation
    private DBConnection() {}

    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        if (connection == null || connection.isClosed()) {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
        }
        return connection;
    }
}