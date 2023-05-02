package src.inventory.database.dao;

import src.inventory.database.utils.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ShawnJung {
    public static void searchStoresWithA() throws SQLException {
        List<List<String>> results = new ArrayList<>();

        try (
            Connection connection = DatabaseConnection.connection();
            Statement statement = connection.createStatement();
        ) {
            String selectSql = "SELECT Storefront.StoreName, Warehouse.Location FROM Storefront INNER JOIN Warehouse ON Storefront.WarehouseID = Warehouse.WarehouseID WHERE Storefront.CreditRating = 'A';";
            ResultSet resultSet = statement.executeQuery(selectSql);

            while (resultSet.next()) {
                results.add(List.of(
                    resultSet.getString(1),
                    resultSet.getString(2)
                ));
            }
        }
    }

    public static int launchDiscountEvent() throws SQLException {
        String call = "{call dbo.discount_event}";

        try (
            Connection connection = DatabaseConnection.connection();
            PreparedStatement stmt = connection.prepareStatement(call);
        ) {
            stmt.execute();
            return stmt.getUpdateCount();
        }
    }

    public static void searchStoresByName(String str) throws SQLException {
        List<List<String>> results = new ArrayList<>();

        try (
            Connection connection = DatabaseConnection.connection();
            Statement statement = connection.createStatement();
        ) {
            String selectSql = String.format("SELECT * FROM Storefront WHERE Storefront.StoreName LIKE '%s%%'", str);
            ResultSet resultSet = statement.executeQuery(selectSql);

            while (resultSet.next()) {
                results.add(List.of(
                    resultSet.getString(1),
                    resultSet.getString(2)
                ));
            }
        }
    }

    public static int deleteClosedStore(int storefront) throws SQLException {
        String call = "{call dbo.delete_closed_store(?)}";

        try (
            Connection connection = DatabaseConnection.connection();
            PreparedStatement stmt = connection.prepareStatement(call);
        ) {
            stmt.setInt(1, storefront);
            stmt.execute();
            return stmt.getUpdateCount();
        }
    }
}
