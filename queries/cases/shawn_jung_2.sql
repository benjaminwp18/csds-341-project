-- USE CASE 2
-- A store is closed. Delete the items that the store owned,
-- and if the item was only used in the store, delete the corresponding
-- row from the CategoriesProducts and WarehousesProducts tables.

-- 1. Get the store's ID based on its name. Enable searching with a fraction of the name.
SELECT *
FROM Storefront
WHERE Storefront.StoreName LIKE 'Stap%'

-- 2. Delete the products owned by the store from the StorefrontsProducts table.
DELETE FROM StorefrontsProducts
WHERE StorefrontID = 0;

-- 3. Delete the corresponding rows from the CategoriesProducts table
-- if the product was exclusively used in the closed store.
DELETE FROM CategoriesProducts
WHERE ProductID IN (
    SELECT CP.ProductID
    FROM CategoriesProducts CP
    LEFT JOIN StorefrontsProducts SP ON CP.ProductID = SP.ProductID
    WHERE SP.ProductID IS NULL
);

-- 4. Delete the corresponding rows from the WarehousesProducts table
-- if the product was exclusively used in the closed store.
DELETE FROM WarehousesProducts
WHERE ProductID IN (
    SELECT WP.ProductID
    FROM WarehousesProducts WP
    LEFT JOIN StorefrontsProducts SP ON WP.ProductID = SP.ProductID
    WHERE SP.ProductID IS NULL
);

-- 5. Delete the closed storefront from the Storefront table.
DELETE FROM Storefront
WHERE StorefrontID = 0;