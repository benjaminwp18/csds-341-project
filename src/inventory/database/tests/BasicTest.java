package src.inventory.database.tests;

import src.inventory.database.dao.TestConnection;

import java.sql.SQLException;
import java.util.List;

public class BasicTest {
    public static void main(String[] args) {
        try {
            List<List<String>> results = TestConnection.selectWarehouses();

            for (List<String> row : results) {
                System.out.println(
                    row.get(0) + " " +
                    row.get(1)
                );
            }
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
