--I'm going to split the main supply chain dataset into 3 different tables to mimic how the data must have been collected before it was conglomerated.

--Supplier

CREATE TABLE Suppliers (
    SupplierID INT IDENTITY(1,1) PRIMARY KEY, --self generating with an automatic plus1 to every row
    SupplierName VARCHAR(255),
    Location VARCHAR(255),
    LeadTime INT,
    ProductionVolumes INT,
    ManufacturingLeadTime INT,
    ManufacturingCosts DECIMAL(18,2),
    InspectionResults VARCHAR(50),
    DefectRates DECIMAL(5,2)
);


--insert relevant data from main table to suppliers table
INSERT INTO Suppliers (SupplierName, Location, LeadTime, ProductionVolumes, ManufacturingLeadTime, ManufacturingCosts, InspectionResults, DefectRates)
SELECT DISTINCT Supplier_name, Location, Lead_time, Production_volumes, Manufacturing_lead_time, Manufacturing_costs, Inspection_results, Defect_rates
FROM supply_chain_data;



--Warehouse

CREATE TABLE Warehouse (
    SKU VARCHAR(50) PRIMARY KEY,
    StockLevels INT,
    Availability VARCHAR(50),
    LeadTimes INT
);

--insert relevant data from main table to Warehouse table
INSERT INTO Warehouse (SKU, StockLevels, Availability, LeadTimes)
SELECT DISTINCT SKU, Stock_levels, Availability, Lead_times
FROM supply_chain_data;



--Orders

CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY, --self generating with an automatic plus1 to every row
    ProductType VARCHAR(255),
    SKU VARCHAR(50),
    Price DECIMAL(18,2),
    NumberOfProductsSold INT,
    RevenueGenerated DECIMAL(18,2),
    CustomerDemographics VARCHAR(255),
    OrderQuantities INT,
    ShippingTimes INT,
    ShippingCarriers VARCHAR(255),
    ShippingCosts DECIMAL(18,2),
    TransportationModes VARCHAR(255),
    Routes VARCHAR(255),
    Costs DECIMAL(18,2),
    FOREIGN KEY (SKU) REFERENCES Warehouse(SKU)
);


--insert relevant data from main table into orders table
INSERT INTO Orders (ProductType, SKU, Price, NumberOfProductsSold, RevenueGenerated, CustomerDemographics, OrderQuantities, ShippingTimes, ShippingCarriers, ShippingCosts, TransportationModes, Routes, Costs)
SELECT Product_type, SKU, Price, Number_of_products_sold, Revenue_generated, Customer_demographics, Order_quantities, Shipping_times, Shipping_carriers, Shipping_costs, Transportation_modes, Routes, Costs
FROM supply_chain_data;


--verify contents of tables
SELECT *
FROM Orders;