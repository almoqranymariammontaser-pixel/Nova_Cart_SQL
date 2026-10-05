/* =========================================================
   NovaCart SQL Lab
   Phase 3 - Data Population
   File: 3_NovaCart_Insert_Data.sql
   ========================================================= */

USE NovaCartDB;
GO

/* =========================================================
   1. Customer
   ========================================================= */

INSERT INTO Customer
    (full_name, email, phone, home_address, join_date)
VALUES
    ('Ahmed Hassan',   'ahmed.hassan@gmail.com',   '01010000001', 'Cairo, Egypt',      '2025-01-10'),
    ('Mariam Ali',     'mariam.ali@gmail.com',     '01010000002', 'Giza, Egypt',       '2025-01-25'),
    ('Omar Khaled',    'omar.khaled@gmail.com',    '01010000003', 'Fayoum, Egypt',     '2025-02-12'),
    ('Sara Mohamed',   'sara.mohamed@gmail.com',   '01010000004', 'Alexandria, Egypt', '2025-03-05'),
    ('Youssef Samir',  'youssef.samir@gmail.com',  '01010000005', 'Cairo, Egypt',      '2025-03-20'),
    ('Nour Adel',      'nour.adel@gmail.com',      '01010000006', 'Giza, Egypt',       '2025-04-11'),
    ('Karim Tarek',    'karim.tarek@gmail.com',    '01010000007', 'Mansoura, Egypt',   '2025-05-02'),
    ('Laila Mostafa',  'laila.mostafa@gmail.com',  '01010000008', 'Cairo, Egypt',      '2025-05-18'),
    ('Hana Ibrahim',   'hana.ibrahim@gmail.com',   '01010000009', 'Fayoum, Egypt',     '2025-06-01'),
    ('Ali Nasser',     'ali.nasser@gmail.com',     '01010000010', 'Giza, Egypt',       '2025-06-15');
GO


/* =========================================================
   2. Category
   ========================================================= */

INSERT INTO Category
    (category_name)
VALUES
    ('Electronics'),
    ('Smartphones'),
    ('Laptops'),
    ('Fashion'),
    ('Home Appliances'),
    ('Books'),
    ('Accessories'),
    ('Gaming'),
    ('Cameras'),
    ('Office Supplies');
GO


/* =========================================================
   3. Product
   ========================================================= */

INSERT INTO Product
    (product_name, price, stock_quantity, category_id)
VALUES
    ('Wireless Headphones',  500.00,  50, 1),
    ('Smartphone Pro X',    6000.00,  25, 2),
    ('Mechanical Keyboard', 3000.00, 40, 7),
    ('Gaming Laptop',       8500.00, 15, 3),
    ('Smart Watch',          900.00,  60, 7),
    ('4K Smart TV',        12000.00,  10, 1),
    ('Running Shoes',       2500.00,  30, 4),
    ('Digital Camera',      7000.00,  12, 9),
    ('Gaming Console',      5500.00,  20, 8),
    ('Office Printer',      1800.00,  18, 10);
GO


/* =========================================================
   4. Orders
   ========================================================= */

INSERT INTO Orders
    (order_date, status, customer_id)
VALUES
    ('2025-07-01', 'Delivered',  1),
    ('2025-07-05', 'Shipped',    1),
    ('2025-07-10', 'Delivered',  2),
    ('2025-07-15', 'Pending',    3),
    ('2025-08-01', 'Delivered',  4),
    ('2025-08-08', 'Cancelled', 5),
    ('2025-08-15', 'Delivered',  6),
    ('2025-09-01', 'Shipped',    7),
    ('2025-09-10', 'Delivered',  8),
    ('2025-09-20', 'Pending',    9);
GO


/* =========================================================
   5. OrderDetails
   ========================================================= */

INSERT INTO OrderDetails
    (order_id, product_id, quantity, unit_price)
VALUES
    -- Order 1: multiple products
    (1, 1, 2,  450.00),
    (1, 2, 1, 5500.00),

    -- Order 2: product 1 appears again
    (2, 1, 1,  500.00),
    (2, 3, 2, 2800.00),

    -- Order 3: multiple products
    (3, 4, 1, 8000.00),
    (3, 5, 2,  850.00),

    -- Order 4
    (4, 2, 1, 6000.00),
    (4, 6, 1, 11500.00),

    -- Order 5
    (5, 7, 2, 2300.00),

    -- Order 6
    (6, 8, 1, 6800.00),

    -- Order 7
    (7, 9, 1, 5200.00),

    -- Order 8
    (8, 3, 1, 3000.00),

    -- Order 9
    (9, 4, 1, 8200.00),

    -- Order 10
    (10, 6, 1, 11800.00);
GO


/* =========================================================
   6. Payment
   ========================================================= */

INSERT INTO Payment
    (payment_date, amount, payment_method, order_id)
VALUES
    ('2025-07-01',  6400.00, 'Credit Card', 1),
    ('2025-07-05',  6100.00, 'PayPal',      2),
    ('2025-07-10',  9700.00, 'COD',         3),
    ('2025-07-15', 17500.00, 'Credit Card', 4),
    ('2025-08-01',  4600.00, 'PayPal',      5),
    ('2025-08-08',  6800.00, 'COD',         6),
    ('2025-08-15',  5200.00, 'Credit Card', 7),
    ('2025-09-01',  3000.00, 'PayPal',      8),
    ('2025-09-10',  8200.00, 'COD',         9),
    ('2025-09-20', 11800.00, 'Credit Card', 10);
GO


/* =========================================================
   7. Review
   ========================================================= */

INSERT INTO Review
    (rating, comment, review_date, customer_id, product_id)
VALUES
    (5, 'Excellent product and very good quality.', '2025-07-20', 1, 1),
    (4, 'Very good smartphone.',                    '2025-07-25', 1, 2),
    (3, 'The keyboard is good but a little noisy.', '2025-07-28', 2, 3),
    (5, 'Amazing laptop for gaming.',               '2025-08-05', 2, 4),
    (4, 'Good watch with useful features.',         '2025-08-10', 3, 5),
    (2, 'The product was acceptable.',              '2025-08-20', 4, 7),
    (5, 'Great camera quality.',                    '2025-08-25', 6, 8),
    (4, 'Very enjoyable gaming console.',           '2025-09-05', 7, 9),
    (3, 'Good keyboard for the price.',             '2025-09-12', 8, 3),
    (5, 'The laptop performance is excellent.',     '2025-09-15', 9, 4);
GO

USE NovaCartDB;
GO

SELECT 'Customer' AS TableName, COUNT(*) AS RecordCount
FROM Customer

UNION ALL

SELECT 'Category', COUNT(*)
FROM Category

UNION ALL

SELECT 'Product', COUNT(*)
FROM Product

UNION ALL

SELECT 'Orders', COUNT(*)
FROM Orders

UNION ALL

SELECT 'OrderDetails', COUNT(*)
FROM OrderDetails

UNION ALL

SELECT 'Payment', COUNT(*)
FROM Payment

UNION ALL

SELECT 'Review', COUNT(*)
FROM Review;