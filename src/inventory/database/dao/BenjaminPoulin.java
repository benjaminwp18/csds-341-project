package src.inventory.database.dao;

import src.inventory.database.utils.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

public class BenjaminPoulin {
    public static void ship(int storefront, int product, int amount) throws SQLException {
        String call = "{call dbo.ship_product(?, ?, ?)";

        try (
            Connection connection = DatabaseConnection.connection();
            PreparedStatement stmt = connection.prepareStatement(call);
        ) {
            stmt.setInt(1, storefront);
            stmt.setInt(2, product);
            stmt.setInt(3, amount);
        }
    }

    public static void make_high_end(int store) throws SQLException {
        String call = "{call dbo.make_store_high_end(?)";

        try (
            Connection connection = DatabaseConnection.connection();
            PreparedStatement stmt = connection.prepareStatement(call);
        ) {
            stmt.setInt(1, store);
        }
    }
}
