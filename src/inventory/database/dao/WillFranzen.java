package src.inventory.database.dao;

import src.inventory.database.utils.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class WillFranzen {
    public static int add_product(int product, int warehouse) throws SQLException {
        String call = "{call dbo.add_product_w_ware(?, ?)}";

        try (
            Connection connection = DatabaseConnection.connection();
            PreparedStatement stmt = connection.prepareStatement(call);
        ) {
            stmt.setInt(1, product);
            stmt.setInt(2, warehouse);
            stmt.execute();
            return stmt.getUpdateCount();
        }
    }

    public static int update_price_on_product_insert(String product, int price) throws SQLException {
        String call = "{call dbo.update_price_on_product_insert(?, ?)}";

        try (
            Connection connection = DatabaseConnection.connection();
            PreparedStatement stmt = connection.prepareStatement(call);
        ) {
            stmt.setString(1, product);
            stmt.setInt(2, price);
            stmt.execute();
            return stmt.getUpdateCount();
        }
    }
}
