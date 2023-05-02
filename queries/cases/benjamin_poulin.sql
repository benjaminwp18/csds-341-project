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

	WITH p2 AS (
		SELECT
			MIN(i.Price) AS minPrice
		FROM Product AS i
        INNER JOIN StorefrontsProducts
        ON StorefrontsProducts.ProductID = i.ProductID
        WHERE StorefrontsProducts.StorefrontID = @StorefrontID
	)
    DELETE FROM StorefrontsProducts
    WHERE
		StorefrontsProducts.ProductID IN (
			SELECT StorefrontsProducts.ProductID FROM StorefrontsProducts
			INNER JOIN Product as p
			ON StorefrontsProducts.ProductID = p.ProductID
			WHERE p.Price IN (SELECT minPrice from p2)
		) AND
		StorefrontsProducts.StorefrontID IN (
			SELECT StorefrontsProducts.StorefrontID FROM StorefrontsProducts
			INNER JOIN Product as p
			ON StorefrontsProducts.ProductID = p.ProductID
			WHERE p.Price IN (SELECT minPrice from p2)
		)

    COMMIT TRANSACTION high_end;
END