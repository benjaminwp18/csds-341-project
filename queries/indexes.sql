CREATE INDEX ProductNameIndex
ON Product (Name);

CREATE INDEX DefinedAisles
ON StorefrontsProducts (ProductID, StorefrontID, Aisle)
WHERE Aisle IS NOT NULL;

CREATE INDEX PoorCreditRating
ON Storefront(StorefrontID, CreditRating)
WHERE CreditRating = 'C';