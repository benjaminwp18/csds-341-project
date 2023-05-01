package src.inventory.database;

import src.inventory.database.dao.TestConnection;

import java.sql.ResultSet;
import java.sql.SQLException;

public class TestHarness {
    public static void main(String[] args) {
        try {
            ResultSet results = TestConnection.selectWarehouses();

            while (results.next()) {
                System.out.println(
                    results.getString(1) + " " +
                    results.getString(2)
                );
            }
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
