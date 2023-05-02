--- Ship some amount of a product to a store if it is available ---
CREATE PROCEDURE ship_product (
    @StorefrontID INT,
    @ProductID INT,
    @Amount INT
)
AS
BEGIN
    BEGIN TRANSACTION ship;

    SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

    UPDATE WarehousesProducts
    SET Stock = Stock - @Amount
    WHERE
        ProductID = @ProductID AND
        Stock >= @Amount AND
        WarehouseID IN (
            SELECT Storefront.WarehouseID FROM Storefront
            WHERE StorefrontID = @StorefrontID
        );

    IF @@ROWCOUNT = 1
        BEGIN
            UPDATE StorefrontsProducts
            SET Stock = Stock + @Amount
            WHERE
                ProductID = @ProductID AND
                StorefrontID = @StorefrontID;
        END
    ELSE
        BEGIN
            ROLLBACK TRANSACTION ship;
        END

    COMMIT TRANSACTION ship;
END

--- Remove the least expensive item from the store ---
CREATE PROCEDURE make_store_high_end(
    @StorefrontID INT
)
AS
BEGIN
    BEGIN TRANSACTION high_end;

    DELETE FROM ProductsStorefronts
    WHERE ProductID in (
        SELECT ProductID
        FROM Product AS p
        INNER JOIN (
            SELECT MIN(i.Price) AS minPrice FROM Product AS i
            INNER JOIN ProductsStorefronts
            ON ProductsStorefronts.ProductID = i.ProductID
            WHERE ProductsStorefronts.StorefrontID = 7
        ) AS p2
        ON p.ProductID = p2.ProductID
        WHERE p.Price = p2.minPrice;
    )

    COMMIT TRANSACTION high_end;
END