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

    public static Connection connection() {
        Connection connection = null;

        try {
            connection = DriverManager.getConnection(CONNECTION_URL);
        }
            catch (SQLException e) {
            e.printStackTrace();
        }

        return connection;
    }
}
