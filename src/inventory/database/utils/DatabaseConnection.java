package src.inventory.database.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private static String CONNECTION_URL =
        "jdbc:sqlserver://localhost;" +
            "database=inventory;" +
            "user=dbuser;" +
            "password=scsd431134dscs;" +
            "encrypt=true;" +
            "trustServerCertificate=true;" +
            "loginTimeout=15;";

    private static Connection CONNECTION;

    static {
        try {
            CONNECTION = DriverManager.getConnection(CONNECTION_URL);
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static synchronized Connection connection() {
        return CONNECTION;
    }
}
