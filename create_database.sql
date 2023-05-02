--- CREATE BASIC TABLES ---

create table Warehouse (
	WarehouseID int identity (0,1),
	Location int,
	primary key (WarehouseID)
);

create table Product (
	ProductID int identity (0,1),
	Name varchar(255) not null,
	Price bigint,
	primary key (ProductID)
);

create table ProductCategory (
	CategoryID int identity (0,1),
	CategoryName varchar(255),
	primary key (CategoryID)
);

create table Storefront (
	StorefrontID int identity (0,1),
	WarehouseID int,
	StoreName varchar(255),
	Location int,
	CreditRating char(1),
	primary key (StorefrontID),
	foreign key (WarehouseID) references Warehouse(WarehouseID),
	check (CreditRating in ('A', 'B', 'C'))
);


--- CREATE M:M RELATION TABLES ---

create table WarehousesProducts (
	WarehouseID int,
	ProductID int,
	Stock int,
	Aisle varchar(20),
	primary key (WarehouseID, ProductID),
	foreign key (WarehouseID) references Warehouse(WarehouseID),
	foreign key (ProductID) references Product(ProductID)
);

create table CategoriesProducts (
	ProductID int,
	CategoryID int,
	primary key (ProductID, CategoryID),
	foreign key (CategoryID) references ProductCategory(CategoryID),
	foreign key (ProductID) references Product(ProductID)
);

create table StorefrontsProducts (
	StorefrontID int,
	ProductID int,
	Stock int,
	Aisle varchar(20),
	primary key (StorefrontID, ProductID),
	foreign key (StorefrontID) references Storefront(StorefrontID),
	foreign key (ProductID) references Product(ProductID)
);


--- CREATE INDEXES ---

CREATE INDEX ProductNameIndex
ON Product (Name);

CREATE INDEX DefinedAisles
ON StorefrontsProducts (ProductID, StorefrontID, Aisle)
WHERE Aisle IS NOT NULL;

CREATE INDEX PoorCreditRating
ON Storefront(StorefrontID, CreditRating)
WHERE CreditRating = 'C';


--- INSERT DUMMY DATA ---

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