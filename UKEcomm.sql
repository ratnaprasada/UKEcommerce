SELECT * FROM transactiondata;

# Revenue = UnitPrice * Quantity #
SELECT InvoiceNo, Description, CustomerID, Country, InvoiceDate, Quantity, UnitPrice, Quantity*UnitPrice AS Revenue
FROM transactiondata;

# A. total order each month #
SELECT YEAR(InvoiceDate) AS `Year`, MONTH(InvoiceDate) AS `Month`, SUM(Quantity*UnitPrice) AS Revenue
FROM transactiondata
GROUP BY 1,2;

# B. Top Selling Product by Total Order #
SELECT Description, SUM(Quantity*UnitPrice) AS Revenue
FROM transactiondata
GROUP BY 1
HAVING Revenue > 0 AND Description NOT LIKE '%postage%'
ORDER BY 2 DESC limit 10;

# C. Costumer Distribution across the country with Revenue #
SELECT Country, SUM(Quantity*UnitPrice) AS Revenue, COUNT(DISTINCT CustomerID) AS `Number of Customers`
FROM transactiondata
GROUP BY 1
ORDER BY 2 DESC;

# D. The Amount of Cancelled Order each Month #
SELECT YEAR(InvoiceDate) AS `Year`, MONTH(InvoiceDate) AS `Month`, SUM(`Cancelled Order`)*(-1) AS `Cancelled Order`
FROM (SELECT InvoiceDate, Description, Quantity*UnitPrice AS `Cancelled Order`
FROM transactiondata
WHERE Quantity*UnitPrice < 0 AND Description NOT LIKE '%discount%') AS tabelbantu
GROUP BY 1,2;