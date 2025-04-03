--we're creating seperate tables sothat we can split the table imported from Kaggle.
--This split will atempt to mimic real life data



--create Customers table

CREATE TABLE Customers (
    CustomerID VARCHAR(50) PRIMARY KEY,
    CustomerName VARCHAR(100),
    Segment VARCHAR(50),
    Country VARCHAR(100),
    City VARCHAR(100),
    State VARCHAR(100),
    PostalCode VARCHAR(20)
);

--add corresponding values from the superstore dataset to the Customers table

WITH UniqueCustomers AS (
    SELECT 
        [Customer_ID], 
        [Customer_Name], 
        [Segment], 
        [Country], 
        [City], 
        [State], 
        [Postal_Code], 
        ROW_NUMBER() OVER (PARTITION BY [Customer_ID] ORDER BY [Customer_Name]) AS RowNum
    FROM Superstore
)
INSERT INTO Customers (CustomerID, CustomerName, Segment, Country, City, State, PostalCode)
SELECT [Customer_ID], [Customer_Name], [Segment], [Country], [City], [State], [Postal_Code]
FROM UniqueCustomers
WHERE RowNum = 1; -- Ensures each Customer_ID appears only once

SELECT CustomerID FROM Customers;


--create Products table

CREATE TABLE Products (
    ProductID VARCHAR(50) PRIMARY KEY,
    ProductName VARCHAR(500),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50)
);


--add corresponding values from the superstore dataset to the Products table

INSERT INTO Products (ProductID, ProductName, Category, Sub_Category)
SELECT Product_ID, 
       MIN(Product_Name), 
       MIN(Category), 
       MIN(Sub_Category)
FROM Superstore
GROUP BY Product_ID;





-- Create Orders Table

CREATE TABLE Orders (
    OrderID VARCHAR(50) PRIMARY KEY,
    OrderDate DATE,
    ShipDate DATE,
    ShipMode VARCHAR(100),
    CustomerID VARCHAR(50),
    Country VARCHAR(100),
    City VARCHAR(100),
    State VARCHAR(100),
    PostalCode VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


--add corresponding values from the superstore dataset to the Orders table

INSERT INTO Orders (OrderID, OrderDate, ShipDate, ShipMode, CustomerID, Country, City, State, PostalCode)
SELECT DISTINCT [Order_ID], [Order_Date], [Ship_Date], [Ship_Mode], [Customer_ID], 
       [Country], [City], [State], [Postal_Code]
FROM Superstore;




-- Create OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID VARCHAR(50),
    ProductID VARCHAR(50),
    Sales DECIMAL(12,5),
    Quantity INT,
    Discount DECIMAL(12,5),
    Profit DECIMAL(12,5),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);



--add corresponding values from the superstore dataset to the OrderDetails table

INSERT INTO OrderDetails (OrderID, ProductID, Sales, Quantity, Discount, Profit)
SELECT [Order_ID], [Product_ID], [Sales], [Quantity], [Discount], [Profit]
FROM Superstore;


--verify the data 

SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;

--check if relationships are linked correctly
SELECT O.OrderID, O.OrderDate, C.CustomerName, P.ProductName, OD.Sales
FROM OrderDetails OD
JOIN Orders O ON OD.OrderID = O.OrderID
JOIN Customers C ON O.CustomerID = C.CustomerID
JOIN Products P ON OD.ProductID = P.ProductID;







SELECT [Product_Name] FROM Superstore;










SELECT [Customer_ID], COUNT(*)
FROM Superstore
GROUP BY [Customer_ID]
HAVING COUNT(*) > 1;