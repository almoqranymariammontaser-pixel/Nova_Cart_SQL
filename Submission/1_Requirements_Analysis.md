# NovaCart SQL Lab — Requirements Analysis

## 1. System Overview

NovaCart is an online retail company that sells electronics, fashion items, home appliances, books, and accessories through an online platform.

The database is designed to manage customers, products, orders, payments, and customer reviews.

---

## 2. Main Entities

### Customer

Stores customer account information.

**Attributes:**

* customer_id — Primary Key
* full_name
* email — Unique
* phone
* home_address
* join_date

### Category

Stores product categories.

**Attributes:**

* category_id — Primary Key
* category_name — Unique

### Product

Stores product information.

**Attributes:**

* product_id — Primary Key
* product_name
* category_id — Foreign Key
* price
* stock_quantity

### Orders

Stores customer orders.

**Attributes:**

* order_id — Primary Key
* customer_id — Foreign Key
* order_date
* status

**Allowed Status Values:**

* Pending
* Shipped
* Delivered
* Cancelled

### OrderDetails

Represents the products included in each order.

**Attributes:**

* order_id — Primary Key / Foreign Key
* product_id — Primary Key / Foreign Key
* quantity
* unit_price

### Payment

Stores payment information for an order.

**Attributes:**

* payment_id — Primary Key
* order_id — Foreign Key / Unique
* payment_date
* amount
* payment_method

**Allowed Payment Methods:**

* Credit Card
* PayPal
* Cash on Delivery (COD)

### Review

Stores customer reviews for products.

**Attributes:**

* review_id — Primary Key
* customer_id — Foreign Key
* product_id — Foreign Key
* rating
* comment
* review_date

**Rating Constraint:**

* rating must be between 1 and 5.

---

## 3. Relationships

### Customer — Orders

* One customer can place multiple orders.
* Each order belongs to exactly one customer.
* Cardinality: 1 : N

### Category — Product

* One category can contain multiple products.
* Each product belongs to a category.
* Cardinality: 1 : N

### Orders — Products

* An order can contain multiple products.
* A product can appear in multiple orders.
* Cardinality: M : N
* The relationship is resolved using OrderDetails.

### Orders — OrderDetails

* One order can contain multiple order details.
* Each order detail belongs to one order.
* Cardinality: 1 : N

### Product — OrderDetails

* One product can appear in multiple order details.
* Each order detail refers to one product.
* Cardinality: 1 : N

### Order — Payment

* Each order has one associated payment.
* Each payment belongs to one order.
* order_id in Payment should be UNIQUE.

### Customer — Product

* A customer can review multiple products.
* A product can receive reviews from multiple customers.
* The relationship is resolved using Review.
* Cardinality: M : N

---

## 4. Important Business Rules

1. A customer must exist before an order can belong to that customer.
2. An order belongs to one customer.
3. An order can contain multiple products.
4. A product can appear in multiple orders.
5. Quantity belongs to a specific product within a specific order.
6. OrderDetails.unit_price stores the historical price at the time of purchase.
7. Each order has one associated payment.
8. Payment methods are restricted to Credit Card, PayPal, and Cash on Delivery.
9. Review rating must be between 1 and 5.
10. A customer should review a product only after purchasing it; enforcing this rule may require additional database logic.

---

## 5. Design Summary

The main entities of NovaCart are:

Customer, Category, Product, Orders, OrderDetails, Payment, and Review.

The many-to-many relationship between Orders and Products is resolved through OrderDetails.

The many-to-many relationship between Customers and Products for reviews is resolved through Review.
