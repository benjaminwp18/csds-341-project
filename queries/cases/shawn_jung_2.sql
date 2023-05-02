-- USE CASE 2
-- A store is closed. Delete the items that the store owned,
-- and if the item was only used in the store, delete the corresponding
-- row from the CategoriesProducts and WarehousesProducts tables.

-- 1. Get the store's ID based on its name. Enable searching with a fraction of the name.
SELECT *
FROM Storefront
WHERE Storefront.StoreName LIKE 'Stap%'

-- 2. Create stored procedure 
CREATE PROCEDURE delete_closed_store(@StorefrontID INT)
AS
BEGIN
    BEGIN TRANSACTION;

    -- 3. Delete the products owned by the store from the StorefrontsProducts table.
    DELETE FROM StorefrontsProducts
    WHERE StorefrontID = @StorefrontID;

    -- 4. Delete the corresponding rows from the CategoriesProducts table
    -- if the product was exclusively used in the closed store.
    DELETE FROM CategoriesProducts
    WHERE ProductID IN (
        SELECT CP.ProductID
        FROM CategoriesProducts CP
        WHERE NOT EXISTS (
            SELECT 1
            FROM StorefrontsProducts SP
            WHERE SP.ProductID = CP.ProductID
            AND SP.StorefrontID <> @StorefrontID
        )
    );

    -- 5. Delete the corresponding rows from the WarehousesProducts table
    -- if the product was exclusively used in the closed store.
    DELETE FROM WarehousesProducts
    WHERE ProductID IN (
        SELECT WP.ProductID
        FROM WarehousesProducts WP
        WHERE NOT EXISTS (
            SELECT 1
            FROM StorefrontsProducts SP
            WHERE SP.ProductID = WP.ProductID
            AND SP.StorefrontID <> @StorefrontID
        )
    );

    -- 6. Delete the closed storefront from the Storefront table.
    DELETE FROM Storefront
    WHERE StorefrontID = @StorefrontID;

    -- 7. Delete the product from the Product table if no other storefront uses it.
    DELETE FROM Product
    WHERE ProductID IN (
        SELECT P.ProductID
        FROM Product P
        LEFT JOIN StorefrontsProducts SP ON P.ProductID = SP.ProductID
        WHERE SP.ProductID IS NULL
    );

    COMMIT;
END;
