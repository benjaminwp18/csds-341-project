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