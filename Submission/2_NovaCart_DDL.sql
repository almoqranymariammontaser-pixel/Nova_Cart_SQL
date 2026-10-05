/* =========================================================
   NovaCart SQL Lab
   Phase 2 - Database Implementation
   File: 2_NovaCart_DDL.sql
   ========================================================= */

------------------------------------------------------------
-- 1. Create Database
------------------------------------------------------------

IF DB_ID('NovaCartDB') IS NULL
BEGIN
    CREATE DATABASE NovaCartDB;
END;
GO

USE NovaCartDB;
GO

------------------------------------------------------------
-- 2. Customer
------------------------------------------------------------

CREATE TABLE Customer
(
    customer_id INT IDENTITY(1,1) NOT NULL,
    full_name NVARCHAR(100) NOT NULL,
    email NVARCHAR(150) NOT NULL,
    phone NVARCHAR(30) NOT NULL,
    home_address NVARCHAR(250) NOT NULL,
    join_date DATE NOT NULL,

    CONSTRAINT PK_Customer
        PRIMARY KEY (customer_id),

    CONSTRAINT UQ_Customer_Email
        UNIQUE (email)
);
GO

------------------------------------------------------------
-- 3. Category
------------------------------------------------------------

CREATE TABLE Category
(
    category_id INT IDENTITY(1,1) NOT NULL,
    category_name NVARCHAR(100) NOT NULL,

    CONSTRAINT PK_Category
        PRIMARY KEY (category_id),

    CONSTRAINT UQ_Category_Name
        UNIQUE (category_name)
);
GO

------------------------------------------------------------
-- 4. Product
------------------------------------------------------------

CREATE TABLE Product
(
    product_id INT IDENTITY(1,1) NOT NULL,
    product_name NVARCHAR(150) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL,
    category_id INT NOT NULL,

    CONSTRAINT PK_Product
        PRIMARY KEY (product_id),

    CONSTRAINT FK_Product_Category
        FOREIGN KEY (category_id)
        REFERENCES Category(category_id),

    CONSTRAINT CK_Product_Price
        CHECK (price >= 0),

    CONSTRAINT CK_Product_Stock
        CHECK (stock_quantity >= 0)
);
GO

------------------------------------------------------------
-- 5. Orders
------------------------------------------------------------

CREATE TABLE Orders
(
    order_id INT IDENTITY(1,1) NOT NULL,
    order_date DATE NOT NULL,
    status NVARCHAR(20) NOT NULL,
    customer_id INT NOT NULL,

    CONSTRAINT PK_Orders
        PRIMARY KEY (order_id),

    CONSTRAINT FK_Orders_Customer
        FOREIGN KEY (customer_id)
        REFERENCES Customer(customer_id),

    CONSTRAINT CK_Orders_Status
        CHECK (status IN
        (
            'Pending',
            'Shipped',
            'Delivered',
            'Cancelled'
        ))
);
GO

------------------------------------------------------------
-- 6. OrderDetails
------------------------------------------------------------

CREATE TABLE OrderDetails
(
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,

    CONSTRAINT PK_OrderDetails
        PRIMARY KEY (order_id, product_id),

    CONSTRAINT FK_OrderDetails_Order
        FOREIGN KEY (order_id)
        REFERENCES Orders(order_id),

    CONSTRAINT FK_OrderDetails_Product
        FOREIGN KEY (product_id)
        REFERENCES Product(product_id),

    CONSTRAINT CK_OrderDetails_Quantity
        CHECK (quantity > 0),

    CONSTRAINT CK_OrderDetails_UnitPrice
        CHECK (unit_price >= 0)
);
GO

------------------------------------------------------------
-- 7. Payment
------------------------------------------------------------

CREATE TABLE Payment
(
    payment_id INT IDENTITY(1,1) NOT NULL,
    payment_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method NVARCHAR(30) NOT NULL,
    order_id INT NOT NULL,

    CONSTRAINT PK_Payment
        PRIMARY KEY (payment_id),

    CONSTRAINT UQ_Payment_Order
        UNIQUE (order_id),

    CONSTRAINT FK_Payment_Order
        FOREIGN KEY (order_id)
        REFERENCES Orders(order_id),

    CONSTRAINT CK_Payment_Amount
        CHECK (amount >= 0),

    CONSTRAINT CK_Payment_Method
        CHECK (payment_method IN
        (
            'Credit Card',
            'PayPal',
            'COD'
        ))
);
GO

------------------------------------------------------------
-- 8. Review
------------------------------------------------------------

CREATE TABLE Review
(
    review_id INT IDENTITY(1,1) NOT NULL,
    rating INT NOT NULL,
    comment NVARCHAR(500) NULL,
    review_date DATE NOT NULL,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,

    CONSTRAINT PK_Review
        PRIMARY KEY (review_id),

    CONSTRAINT FK_Review_Customer
        FOREIGN KEY (customer_id)
        REFERENCES Customer(customer_id),

    CONSTRAINT FK_Review_Product
        FOREIGN KEY (product_id)
        REFERENCES Product(product_id),

    CONSTRAINT CK_Review_Rating
        CHECK (rating BETWEEN 1 AND 5),

    CONSTRAINT UQ_Review_Customer_Product
        UNIQUE (customer_id, product_id)
);
GO