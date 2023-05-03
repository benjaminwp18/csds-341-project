--- Add New Product and Create Warehouse Space ---
CREATE FUNCTION add_product_w_ware(new_product Product, User_Ware_ID INTEGER)
RETURNS void AS $$
BEGIN

  INSERT INTO Product (Name, Price)
  VALUES (new_product.Name, new_product.Price)
  RETURNING ProductID INTO new_product.ProductID;

  INSERT INTO WarehousesProducts (WarehouseID, ProductID, Stock, Aisle)
  VALUES (User_Ware_ID, new_product.ProductID, 0, '');

END;

--- Update or Insert Product ---
CREATE PROCEDURE update_or_insert_product (
   @ProductName VARCHAR(50),
   @Price INT,
   @CategoryName VARCHAR(50)
)
AS
BEGIN
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