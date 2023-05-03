--- Only allow products to be inserted for stores with good credit ---
CREATE TRIGGER store_credit_check
ON StorefrontsProducts
AFTER INSERT
AS
BEGIN
	DECLARE @CreditRating CHAR(1)
	SELECT @CreditRating = CreditRating FROM Storefront WHERE StorefrontID = (SELECT StorefrontID FROM inserted)

	IF @CreditRating = 'C'
		BEGIN
			RAISERROR ('Credit rating too low for new products', 16, 1)
			ROLLBACK TRANSACTION
		END
END

--- Update or Insert Product ---
CREATE PROCEDURE update_or_insert_product (
   @ProductName VARCHAR(50),
   @Price INT,
   @CategoryName VARCHAR(50)
)
AS
BEGIN
    BEGIN TRANSACTION update_or_insert;
    IF EXISTS (SELECT 1 FROM Product WHERE Name = @ProductName)
        UPDATE Product SET Price = @Price WHERE Name = @ProductName
    ELSE
        BEGIN
            INSERT INTO Product (Name, Price)
            VALUES (@ProductName, @Price)

            IF NOT EXISTS (SELECT 1 FROM ProductCategory WHERE CategoryName = @CategoryName)
                INSERT INTO ProductCategory (CategoryName) VALUES (@CategoryName)

			INSERT INTO CategoriesProducts (ProductID, CategoryID) VALUES (
				(SELECT ProductID from Product WHERE Name = @ProductName),
				(SELECT CategoryID from ProductCategory WHERE CategoryName = @CategoryName)
			)
        END
END