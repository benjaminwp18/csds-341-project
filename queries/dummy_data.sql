INSERT INTO Product (Name, Price)
VALUES
	('Pencil', 200),
	('Peanut Butter', 700),
	('Body Wash', 1000),
	('Scissors', 300),
	('Towel', 500),
	('Shirt', 1000);

INSERT INTO ProductCategory (CategoryName)
VALUES
	('Home Goods'),
	('Back to School'),
	('Food');

INSERT INTO Warehouse (Location)
VALUES
	(44106),
	(55555),
	(12345);

INSERT INTO Storefront (StoreName, WarehouseID, Location, CreditRating)
VALUES
	('Staples', 0, 44106, 'A'),
	('Plum Market', 0, 44106, 'A'),
	('Seedy Grocery', 1, 55555, 'B'),
	('shirt.gov', 2, 12345, 'C');

INSERT INTO CategoriesProducts (ProductID, CategoryID)
VALUES
	(0, 1),
	(3, 1),
	(2, 0),
	(4, 0),
	(1, 2);

INSERT INTO StorefrontsProducts (StorefrontID, ProductID, Stock, Aisle)
VALUES
	(0, 0, 500, 'Stationary'),
	(0, 3, 80, 'Stationary'),
	(1, 1, 30, 'Condiments'),
	(2, 1, 13, 'Condiments'),
	(2, 2, 40, 'Soaps'),
	(2, 4, 15, 'Linens'),
	(3, 5, 8000, 'Shirts');

INSERT INTO WarehousesProducts (WarehouseID, ProductID, Stock, Aisle)
VALUES
	(0, 0, 1000, 'AISLE 1 BUILDING 1'),
	(0, 3, 1000, 'AISLE 4 BUILDING 1'),
	(0, 1, 500, 'AISLE 12 BUILDING 3'),
	(1, 1, 300, 'AISLE 1 BUILDING 1'),
	(1, 2, 400, 'AISLE 2 BUILDING 1'),
	(1, 4, 200, 'AISLE 1 BUILDING 2'),
	(2, 5, 10000, 'AISLE 1 BUILDING 1');