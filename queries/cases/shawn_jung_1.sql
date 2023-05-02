-- USE CASE 1
-- Our warehouse company runs a discount event, only for storefronts with credit rating of 'A'.
-- We are offering 10% discount for every product they have.

-- 1. Get the store names and their corresponding warehouse locations,
-- where the stores have a credit rating of A.
SELECT Storefront.StoreName, Warehouse.Location
FROM Storefront
INNER JOIN Warehouse ON Storefront.WarehouseID = Warehouse.WarehouseID
WHERE Storefront.CreditRating = 'A';

-- 2. Add discounted products to the Product table for storefronts that have a credit rating of “A”,
-- with a 10% discount applied to the original prices. The discounted products have the same names
-- as the original products, with “_discounted” appended to the end of the names.
INSERT INTO Product (Name, Price)
SELECT CONCAT(Name, '_discounted'), ROUND(Price * 0.9, 0)
FROM Product
WHERE ProductID IN (
    SELECT ProductID
    FROM StorefrontsProducts sp
    INNER JOIN Storefront s ON sp.StorefrontID = s.StorefrontID
    WHERE s.CreditRating = 'A'
);

-- 3. After discounting products for storefronts with 'A' rating,
-- update the ProductID values in the StorefrontsProducts table for the discounted products,
-- based on the matching CreditRating condition.
UPDATE sp
SET sp.ProductID = p2.ProductID
FROM StorefrontsProducts sp
INNER JOIN Storefront s ON sp.StorefrontID = s.StorefrontID
INNER JOIN Product p1 ON sp.ProductID = p1.ProductID
INNER JOIN Product p2 ON p1.Name + '_discounted' = p2.Name
WHERE s.CreditRating = 'A';