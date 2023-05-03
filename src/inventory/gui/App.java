package src.inventory.gui;

import src.inventory.database.dao.BenjaminPoulin;
import src.inventory.database.dao.ShawnJung;
import src.inventory.database.dao.WillFranzen;

import javax.swing.*;
import javax.swing.border.EmptyBorder;
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
            new JButton("2. Update or create product"),
            new JButton("3. Discount Event"),
            new JButton("4. Closed Store"),
            new JButton("5. Restock a Store"),
            new JButton("6. Make a Store Seem Fancier")
        );

        List<List<JTextField>> forms = List.of(
            List.of(
                new JTextField("ProductID"),
                new JTextField("WarehouseID")
            ),
            List.of(
                new JTextField("Product Name"),
                new JTextField("Price"),
                new JTextField("Category Name")
            ),
            List.of(),
            List.of(
                new JTextField("StorefrontID")
            ),
            List.of(
                new JTextField("StorefrontID"),
                new JTextField("ProductID"),
                new JTextField("Amount")
            ),
            List.of(
                new JTextField("StorefrontID")

            )
        );

        buttons.get(0).addActionListener((e) -> {
            try {
                clearResults();
                showAffectedRows(WillFranzen.addProduct(
                    Integer.parseInt(forms.get(0).get(0).getText()),
                    Integer.parseInt(forms.get(0).get(1).getText())
                ));
            }
            catch (SQLException | NumberFormatException ex) {
                showError(1);
                ex.printStackTrace();
            }
        });

        buttons.get(1).addActionListener((e) -> {
            try {
                clearResults();
                showAffectedRows(WillFranzen.updateOrInsertProduct(
                    forms.get(1).get(0).getText(),
                    Integer.parseInt(forms.get(1).get(1).getText()),
                    forms.get(1).get(2).getText()
                ));
            }
            catch (SQLException | NumberFormatException ex) {
                showError(2);
                ex.printStackTrace();
            }
        });

        buttons.get(2).addActionListener((e) -> {
            try {
                clearResults();
                showAffectedRows(ShawnJung.launchDiscountEvent());
            }
            catch (SQLException | NumberFormatException ex) {
                showError(3);
                ex.printStackTrace();
            }
        });

        buttons.get(3).addActionListener((e) -> {
            try {
                clearResults();
                showAffectedRows(ShawnJung.deleteClosedStore(
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
                clearResults();
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
                clearResults();
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
            section.setAlignmentX(Component.LEFT_ALIGNMENT);
            section.setBorder(new EmptyBorder(10, 10, 10, 10));
            for (Component c : forms.get(i)) {
                section.add(c);
                c.setMaximumSize(new Dimension(
                    Integer.MAX_VALUE,
                    (int)c.getPreferredSize().getHeight() + 5
                ));
            }
            section.add(buttons.get(i));
            section.setLayout(new BoxLayout(section, BoxLayout.X_AXIS));
            frame.add(section);
        }

        resultsLabel.setBorder(new EmptyBorder(10, 10, 10, 10));
        frame.add(resultsLabel);
        resultsLabel.setFont(new Font(Font.SANS_SERIF, Font.PLAIN, 25));
        resultsLabel.setText("Results will appear here");

        frame.setSize(400, 375);
        frame.setLayout(new BoxLayout(frame.getContentPane(), BoxLayout.Y_AXIS));
        frame.setVisible(true);
    }

    public static void showAffectedRows(int rows) {
        resultsLabel.setText("Query affected " + rows + " rows.");
    }

    public static void showError(int useCase) {
        resultsLabel.setText("Use case " + useCase + " failed. Please be sure to enter valid parameters.");
    }

    public static void clearResults() {
        resultsLabel.setText("");
    }
}
