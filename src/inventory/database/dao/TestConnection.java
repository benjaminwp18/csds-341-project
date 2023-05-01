package src.inventory.database.dao;

import src.inventory.database.utils.DatabaseConnection;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class TestConnection {
    public static List<List<String>> selectWarehouses() throws SQLException {
        List<List<String>> results = new ArrayList<>();

        try (
            Connection connection = DatabaseConnection.connection();
            Statement statement = connection.createStatement();
        ) {
            String selectSql = "SELECT top 100 * from Warehouse";
            ResultSet resultSet = statement.executeQuery(selectSql);

            while (resultSet.next()) {
                results.add(List.of(
                    resultSet.getString(1),
                    resultSet.getString(2)
                ));
            }
        }

        return results;
    }
}
