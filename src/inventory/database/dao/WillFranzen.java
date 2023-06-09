package src.inventory.database.dao;

import src.inventory.database.utils.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class WillFranzen {
    public static int insertStorefrontsProducts(int storefront, int product) throws SQLException {
        String call = "INSERT INTO StorefrontsProducts (StorefrontID, ProductID) VALUES (?, ?)";

        try (
            Connection connection = DatabaseConnection.connection();
            PreparedStatement stmt = connection.prepareStatement(call);
        ) {
            stmt.setInt(1, storefront);
            stmt.setInt(2, product);
            stmt.execute();
            return stmt.getUpdateCount();
        }
    }

    public static int updateOrInsertProduct(String product, int price, String category) throws SQLException {
        String call = "{call dbo.update_or_insert_product(?, ?, ?)}";

        try (
            Connection connection = DatabaseConnection.connection();
            PreparedStatement stmt = connection.prepareStatement(call);
        ) {
            stmt.setString(1, product);
            stmt.setInt(2, price);
            stmt.setString(3, category);
            stmt.execute();
            return stmt.getUpdateCount();
        }
    }
}
