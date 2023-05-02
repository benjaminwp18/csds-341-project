package src.inventory.gui;

import src.inventory.database.dao.BenjaminPoulin;
import src.inventory.database.dao.ShawnJung;

import javax.swing.*;
import java.awt.*;
import java.sql.SQLException;
import java.util.List;

public class App {
    private static JLabel resultsLabel;

    public static void main(String[] args) {
        JFrame frame = new JFrame();

        resultsLabel = new JLabel();

        List<JButton> buttons = List.of(
            new JButton("1. Add a new product and create space in warehouse"),
            new JButton("2. Price change with new product"),
            new JButton("3. Discount Event"),
            new JButton("4. Closed Store"),
            new JButton("5. Restock a Store"),
            new JButton("6. Make a Store Seem Fancier")
        );

        List<List<JTextField>> forms = List.of(
            List.of(

            ),
            List.of(

            ),
            List.of(

            ),
            List.of(
                new JTextField("StorefrontID")
            ),
            List.of(
                new JTextField("WarehouseID"),
                new JTextField("ProductID"),
                new JTextField("Amount")
            ),
            List.of(
                new JTextField("StorefrontID")

            )
        );

        // buttons.get(2).addActionListener((e) -> {
        //     try {
        //         ShawnJung.ship(
        //             Integer.parseInt(forms.get(4).get(0).getText()),
        //             Integer.parseInt(forms.get(4).get(1).getText()),
        //             Integer.parseInt(forms.get(4).get(2).getText())
        //         );
        //     }
        //     catch (SQLException | NumberFormatException ex) {
        //         resultsLabel.setText("Use case 5 failed. Please be sure to enter valid parameters.");
        //     }
        // });

        buttons.get(3).addActionListener((e) -> {
            try {
                showAffectedRows(ShawnJung.delete_closed_store(
                    Integer.parseInt(forms.get(3).get(0).getText())
                ));
            }
            catch (SQLException | NumberFormatException ex) {
                showError(4);
                ex.printStackTrace();
            }
        });

        buttons.get(4).addActionListener((e) -> {
            try {
                showAffectedRows(BenjaminPoulin.ship(
                    Integer.parseInt(forms.get(4).get(0).getText()),
                    Integer.parseInt(forms.get(4).get(1).getText()),
                    Integer.parseInt(forms.get(4).get(2).getText())
                ));
            }
            catch (SQLException | NumberFormatException ex) {
                showError(5);
                ex.printStackTrace();
            }
        });

        buttons.get(5).addActionListener((e) -> {
            try {
                showAffectedRows(BenjaminPoulin.make_high_end(
                    Integer.parseInt(forms.get(5).get(0).getText())
                ));
            }
            catch (SQLException | NumberFormatException ex) {
                showError(6);
                ex.printStackTrace();
            }
        });

        for (int i = 0; i < buttons.size(); i++) {
            JPanel section = new JPanel();
            for (Component c : forms.get(i)) {
                section.add(c);
            }
            section.add(buttons.get(i));
            section.setLayout(new BoxLayout(section, BoxLayout.X_AXIS));
            frame.add(section);
        }

        frame.add(resultsLabel);

        frame.setSize(500, 600);
        frame.setLayout(new BoxLayout(frame.getContentPane(), BoxLayout.Y_AXIS));
        frame.setVisible(true);
    }

    public static void showAffectedRows(int rows) {
        resultsLabel.setText("Query affected " + rows + " rows.");
    }

    public static void showError(int useCase) {
        resultsLabel.setText("Use case " + useCase + " failed. Please be sure to enter valid parameters.");
    }
}
