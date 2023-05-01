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
	('Pencil', 2),
	('Peanut Butter', 7),
	('Body Wash', 10),
	('Scissors', 3),
	('Towel', 5),
	('Shirt', 10);

INSERT INTO ProductCategory (CategoryName)
VALUES
	('Home Goods'),
	('Back to School'),
	('Food');

INSERT INTO Storefront (StoreName, WarehouseID, Location, CreditRating)
VALUES
	('Staples', 0, 44106, 'A'),
	('Plum Market', 0, 44106, 'A'),
	('Seedy Grocery', 1, 55555, 'B'),
	('shirt.gov', 2, 12345, 'C');

INSERT INTO Warehouse (Location)
VALUES
	(44106),
	(55555),
	(12345);

INSERT INTO CategoriesProducts (ProductID, CategoryID)
VALUES
	(11, 1),
	(14, 1),
	(13, 0),
	(15, 0),
	(12, 2);

INSERT INTO StorefrontsProducts (StorefrontID, ProductID, Stock, Aisle)
VALUES
	(0, 11, 500, 'Stationary'),
	(0, 14, 80, 'Stationary'),
	(1, 12, 30, 'Condiments'),
	(2, 12, 13, 'Condiments'),
	(2, 13, 40, 'Soaps'),
	(2, 15, 15, 'Linens'),
	(3, 16, 8000, 'Shirts');

INSERT INTO WarehousesProducts (WarehouseID, ProductID, Stock, Aisle)
VALUES
	(0, 11, 1000, 'AISLE 1 BUILDING 1'),
	(0, 14, 1000, 'AISLE 4 BUILDING 1'),
	(0, 12, 500, 'AISLE 12 BUILDING 3'),
	(1, 12, 300, 'AISLE 1 BUILDING 1'),
	(1, 13, 400, 'AISLE 2 BUILDING 1'),
	(1, 15, 200, 'AISLE 1 BUILDING 2'),
	(2, 16, 10000, 'AISLE 1 BUILDING 1');