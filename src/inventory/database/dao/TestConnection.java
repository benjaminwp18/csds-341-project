package src.inventory.database.dao;

import src.inventory.database.utils.DatabaseConnection;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class TestConnection {
    public static ResultSet selectWarehouses() throws SQLException {
        ResultSet resultSet = null;

        try (
            Connection connection = DatabaseConnection.connection();
            Statement statement = connection.createStatement();
        ) {
            String selectSql = "SELECT top 100 * from Warehouse";
            resultSet = statement.executeQuery(selectSql);
        }

        return resultSet;
    }
}
