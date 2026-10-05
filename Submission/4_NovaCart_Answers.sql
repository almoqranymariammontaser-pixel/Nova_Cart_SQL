/*
============================================================
                    NovaCart SQL Lab
                 SQL Answers
                 File: 4_NovaCart_Answers.sql
============================================================
*/

USE NovaCartDB;
GO

/*============================================================
                MISSION 1 — CUSTOMER & PRODUCT OVERVIEW
============================================================*/

-- M1-Q1
-- Display all customers.

SELECT *
FROM Customer;
GO


------------------------------------------------------------

-- M1-Q2
-- Display the product name, category, and current price
-- for every product.

SELECT
    p.product_name AS ProductName,
    c.category_name AS CategoryName,
    p.price AS CurrentPrice
FROM Product AS p
INNER JOIN Category AS c
    ON p.category_id = c.category_id;
GO


------------------------------------------------------------

-- M1-Q3
-- Display products whose current price is greater than 5000.

SELECT
    product_id,
    product_name,
    price
FROM Product
WHERE price > 5000;
GO


------------------------------------------------------------

-- M1-Q4
-- Display all customers ordered by join date, newest first.

SELECT
    customer_id,
    full_name,
    email,
    phone,
    home_address,
    join_date
FROM Customer
ORDER BY join_date DESC;
GO


------------------------------------------------------------

-- M1-Q5
-- Display the total number of customers.

SELECT
    COUNT(*) AS TotalCustomers
FROM Customer;
GO


/*============================================================
             MISSION 2 — AGGREGATION & BUSINESS TOTALS
============================================================*/

-- M2-Q1
-- Calculate the average current product price.

SELECT
    AVG(price) AS AverageProductPrice
FROM Product;
GO


------------------------------------------------------------

-- M2-Q2
-- Display the highest and lowest current product prices.

SELECT
    MAX(price) AS HighestProductPrice,
    MIN(price) AS LowestProductPrice
FROM Product;
GO


------------------------------------------------------------

-- M2-Q3
-- Calculate the total available stock quantity.

SELECT
    SUM(stock_quantity) AS TotalAvailableStock
FROM Product;
GO


------------------------------------------------------------

-- M2-Q4
-- Calculate the total amount recorded in Payments.

SELECT
    SUM(amount) AS TotalPaymentAmount
FROM Payment;
GO


------------------------------------------------------------

-- M2-Q5
-- Display the number of orders for each order status.

SELECT
    status,
    COUNT(*) AS NumberOfOrders
FROM Orders
GROUP BY status;
GO


------------------------------------------------------------

-- M2-Q6
-- Display the total payment amount for each payment method.

SELECT
    payment_method,
    SUM(amount) AS TotalPaymentAmount
FROM Payment
GROUP BY payment_method;
GO


/*============================================================
               MISSION 3 — ORDER & SALES ANALYSIS
============================================================*/

-- M3-Q1
-- Calculate the total sales amount for each order.
-- Use quantity multiplied by the historical unit price.

SELECT
    order_id,
    SUM(quantity * unit_price) AS TotalSales
FROM OrderDetails
GROUP BY order_id;
GO


------------------------------------------------------------

-- M3-Q2
-- Display only orders whose total sales exceed 5000.

SELECT
    order_id,
    SUM(quantity * unit_price) AS TotalSales
FROM OrderDetails
GROUP BY order_id
HAVING SUM(quantity * unit_price) > 5000;
GO


------------------------------------------------------------

-- M3-Q3
-- Display each order together with:
-- customer name, order date, and order status.

SELECT
    o.order_id,
    c.full_name AS CustomerName,
    o.order_date,
    o.status
FROM Orders AS o
INNER JOIN Customer AS c
    ON o.customer_id = c.customer_id;
GO


------------------------------------------------------------

-- M3-Q4
-- Display each order with:
-- product name, purchased quantity, and historical unit price.

SELECT
    od.order_id,
    p.product_name AS ProductName,
    od.quantity AS PurchasedQuantity,
    od.unit_price AS HistoricalUnitPrice
FROM OrderDetails AS od
INNER JOIN Product AS p
    ON od.product_id = p.product_id;
GO


------------------------------------------------------------

-- M3-Q5
-- Display the total amount spent by each customer.

SELECT
    c.customer_id,
    c.full_name AS CustomerName,
    COALESCE(SUM(od.quantity * od.unit_price), 0) AS TotalAmountSpent
FROM Customer AS c
LEFT JOIN Orders AS o
    ON c.customer_id = o.customer_id
LEFT JOIN OrderDetails AS od
    ON o.order_id = od.order_id
GROUP BY
    c.customer_id,
    c.full_name;
GO


/*============================================================
              MISSION 4 — REVIEWS & RELATIONSHIPS
============================================================*/

-- M4-Q1
-- Display the number of reviews received by each product,
-- including products with no reviews.

SELECT
    p.product_id,
    p.product_name AS ProductName,
    COUNT(r.review_id) AS NumberOfReviews
FROM Product AS p
LEFT JOIN Review AS r
    ON p.product_id = r.product_id
GROUP BY
    p.product_id,
    p.product_name;
GO


------------------------------------------------------------

-- M4-Q2
-- Display all reviews together with:
-- customer name and product name.

SELECT
    r.review_id,
    c.full_name AS CustomerName,
    p.product_name AS ProductName,
    r.rating,
    r.comment,
    r.review_date
FROM Review AS r
INNER JOIN Customer AS c
    ON r.customer_id = c.customer_id
INNER JOIN Product AS p
    ON r.product_id = p.product_id;
GO


------------------------------------------------------------

-- M4-Q3
-- Display customers who have placed at least one order.

SELECT DISTINCT
    c.customer_id,
    c.full_name AS CustomerName
FROM Customer AS c
INNER JOIN Orders AS o
    ON c.customer_id = o.customer_id;
GO


------------------------------------------------------------

-- M4-Q4
-- Display products that have never been ordered.

SELECT
    p.product_id,
    p.product_name
FROM Product AS p
LEFT JOIN OrderDetails AS od
    ON p.product_id = od.product_id
WHERE od.product_id IS NULL;
GO


------------------------------------------------------------

-- M4-Q5
-- Display products that have never received a review.

SELECT
    p.product_id,
    p.product_name
FROM Product AS p
LEFT JOIN Review AS r
    ON p.product_id = r.product_id
WHERE r.product_id IS NULL;
GO


------------------------------------------------------------

-- M4-Q6
-- Display all customers and their number of orders,
-- including customers who have never placed an order.

SELECT
    c.customer_id,
    c.full_name AS CustomerName,
    COUNT(o.order_id) AS NumberOfOrders
FROM Customer AS c
LEFT JOIN Orders AS o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.full_name;
GO


/*============================================================
                       MISSION 5 — SUBQUERIES
============================================================*/

-- M5-Q1
-- Display customers who placed more orders than the average
-- number of orders among customers who placed at least one order.

SELECT
    c.customer_id,
    c.full_name AS CustomerName,
    COUNT(o.order_id) AS NumberOfOrders
FROM Customer AS c
INNER JOIN Orders AS o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.full_name
HAVING COUNT(o.order_id) >
(
    SELECT AVG(OrderCount * 1.0)
    FROM
    (
        SELECT
            customer_id,
            COUNT(*) AS OrderCount
        FROM Orders
        GROUP BY customer_id
    ) AS CustomerOrders
);
GO


------------------------------------------------------------

-- M5-Q2
-- Display products whose current price is above the average
-- current product price.

SELECT
    product_id,
    product_name,
    price
FROM Product
WHERE price >
(
    SELECT AVG(price)
    FROM Product
);
GO


------------------------------------------------------------

-- M5-Q3
-- Display customers whose total spending is greater than
-- the average total spending among customers who have made
-- at least one payment.

SELECT
    c.customer_id,
    c.full_name AS CustomerName,
    SUM(p.amount) AS TotalSpending
FROM Customer AS c
INNER JOIN Orders AS o
    ON c.customer_id = o.customer_id
INNER JOIN Payment AS p
    ON o.order_id = p.order_id
GROUP BY
    c.customer_id,
    c.full_name
HAVING SUM(p.amount) >
(
    SELECT AVG(CustomerTotal)
    FROM
    (
        SELECT
            o.customer_id,
            SUM(p.amount) AS CustomerTotal
        FROM Orders AS o
        INNER JOIN Payment AS p
            ON o.order_id = p.order_id
        GROUP BY o.customer_id
    ) AS CustomerSpending
);
GO

/*============================================================
                MISSION 6 — COMMON TABLE EXPRESSIONS
============================================================*/

-- M6-Q1
-- Using a CTE, calculate total revenue by month.

WITH MonthlyRevenue AS
(
    SELECT
        YEAR(o.order_date) AS OrderYear,
        MONTH(o.order_date) AS OrderMonth,
        SUM(od.quantity * od.unit_price) AS TotalRevenue
    FROM Orders AS o
    INNER JOIN OrderDetails AS od
        ON o.order_id = od.order_id
    GROUP BY
        YEAR(o.order_date),
        MONTH(o.order_date)
)
SELECT
    OrderYear,
    OrderMonth,
    TotalRevenue
FROM MonthlyRevenue
ORDER BY
    OrderYear,
    OrderMonth;
GO


------------------------------------------------------------

-- M6-Q2
-- Using a CTE, calculate total spending by customer.
-- Return only customers whose total spending exceeds 10000.

WITH CustomerSpending AS
(
    SELECT
        c.customer_id,
        c.full_name AS CustomerName,
        SUM(od.quantity * od.unit_price) AS TotalSpending
    FROM Customer AS c
    INNER JOIN Orders AS o
        ON c.customer_id = o.customer_id
    INNER JOIN OrderDetails AS od
        ON o.order_id = od.order_id
    GROUP BY
        c.customer_id,
        c.full_name
)
SELECT
    customer_id,
    CustomerName,
    TotalSpending
FROM CustomerSpending
WHERE TotalSpending > 10000;
GO


/*============================================================
                  MISSION 7 — WINDOW FUNCTIONS
============================================================*/

-- M7-Q1
-- Rank customers by total spending using RANK(),
-- with the highest spending ranked first.

WITH CustomerSpending AS
(
    SELECT
        c.customer_id,
        c.full_name AS CustomerName,
        COALESCE(SUM(od.quantity * od.unit_price), 0) AS TotalSpending
    FROM Customer AS c
    LEFT JOIN Orders AS o
        ON c.customer_id = o.customer_id
    LEFT JOIN OrderDetails AS od
        ON o.order_id = od.order_id
    GROUP BY
        c.customer_id,
        c.full_name
)
SELECT
    customer_id,
    CustomerName,
    TotalSpending,
    RANK() OVER (ORDER BY TotalSpending DESC) AS SpendingRank
FROM CustomerSpending;
GO


------------------------------------------------------------

-- M7-Q2
-- Rank products by total quantity sold using DENSE_RANK(),
-- with the highest quantity ranked first.

WITH ProductSales AS
(
    SELECT
        p.product_id,
        p.product_name AS ProductName,
        COALESCE(SUM(od.quantity), 0) AS TotalQuantitySold
    FROM Product AS p
    LEFT JOIN OrderDetails AS od
        ON p.product_id = od.product_id
    GROUP BY
        p.product_id,
        p.product_name
)
SELECT
    product_id,
    ProductName,
    TotalQuantitySold,
    DENSE_RANK() OVER
    (
        ORDER BY TotalQuantitySold DESC
    ) AS QuantityRank
FROM ProductSales;
GO


------------------------------------------------------------

-- M7-Q3
-- Display each payment together with the previous payment amount
-- using LAG().
-- Order the sequence by payment date and payment ID.

SELECT
    payment_id,
    payment_date,
    amount,
    payment_method,
    LAG(amount) OVER
    (
        ORDER BY payment_date, payment_id
    ) AS PreviousPaymentAmount
FROM Payment
ORDER BY
    payment_date,
    payment_id;
GO


------------------------------------------------------------

-- M7-Q4
-- Display a running total of payment amounts.
-- Order the sequence by payment date and payment ID.

SELECT
    payment_id,
    payment_date,
    amount,
    SUM(amount) OVER
    (
        ORDER BY payment_date, payment_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS RunningTotal
FROM Payment
ORDER BY
    payment_date,
    payment_id;
GO

/*============================================================
                         MISSION 8 — VIEWS
============================================================*/

-- M8-Q1
-- Create a view named vw_revenue_by_month
-- that displays monthly revenue.

CREATE OR ALTER VIEW vw_revenue_by_month
AS
SELECT
    YEAR(o.order_date) AS OrderYear,
    MONTH(o.order_date) AS OrderMonth,
    SUM(od.quantity * od.unit_price) AS TotalRevenue
FROM Orders AS o
INNER JOIN OrderDetails AS od
    ON o.order_id = od.order_id
GROUP BY
    YEAR(o.order_date),
    MONTH(o.order_date);
GO


------------------------------------------------------------

-- Test View 1

SELECT *
FROM vw_revenue_by_month
ORDER BY
    OrderYear,
    OrderMonth;
GO


------------------------------------------------------------

-- M8-Q2
-- Create a view named vw_best_selling_products
-- that displays:
-- Product Name
-- Total Quantity Sold
-- Total Revenue

CREATE OR ALTER VIEW vw_best_selling_products
AS
SELECT
    p.product_name AS ProductName,
    COALESCE(SUM(od.quantity), 0) AS TotalQuantitySold,
    COALESCE(SUM(od.quantity * od.unit_price), 0) AS TotalRevenue
FROM Product AS p
LEFT JOIN OrderDetails AS od
    ON p.product_id = od.product_id
GROUP BY
    p.product_id,
    p.product_name;
GO


------------------------------------------------------------

-- Test View 2

SELECT *
FROM vw_best_selling_products
ORDER BY TotalRevenue DESC;
GO


------------------------------------------------------------

-- M8-Q3
-- Create a view named vw_customer_summary
-- that displays:
-- Customer Name
-- Number of Orders
-- Total Amount Spent

CREATE OR ALTER VIEW vw_customer_summary
AS
SELECT
    c.full_name AS CustomerName,
    COUNT(DISTINCT o.order_id) AS NumberOfOrders,
    COALESCE(SUM(od.quantity * od.unit_price), 0) AS TotalAmountSpent
FROM Customer AS c
LEFT JOIN Orders AS o
    ON c.customer_id = o.customer_id
LEFT JOIN OrderDetails AS od
    ON o.order_id = od.order_id
GROUP BY
    c.customer_id,
    c.full_name;
GO


------------------------------------------------------------

-- Test View 3

SELECT *
FROM vw_customer_summary
ORDER BY TotalAmountSpent DESC;
GO


/*============================================================
                           END
============================================================*/