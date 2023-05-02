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