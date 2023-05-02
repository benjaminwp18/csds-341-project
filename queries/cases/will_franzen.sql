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

--- Price Change with New Product ---
CREATE PROCEDURE update_price_on_product_insert(
  user_prod_name VARCHAR(50),
  user_prod_price INT
)
AS
BEGIN
     BEGIN TRANSACTION;

     IF EXISTS (SELECT 1 FROM Product WHERE Name = user_prod_name) THEN
          UPDATE Product SET Price = user_prod_price WHERE Name =
         user_prod_name;
     ELSE
          INSERT INTO Product (Name, Price, CategoryName)
          VALUES (user_prod_name, user_prod_price, 'Uncategorized');
     END IF;
     COMMIT;
END;
