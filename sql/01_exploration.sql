-- ============================================================
-- E-COMMERCE SQL ANALYSIS
-- 01 - Data Exploration
-- ============================================================


-- ============================================================
-- 1. DATASET OVERVIEW
-- ============================================================

-- Number of customers
SELECT COUNT(*) AS number_of_customers
FROM customers;


-- Number of orders
SELECT COUNT(*) AS number_of_orders
FROM orders;


-- Number of products
SELECT COUNT(*) AS number_of_products
FROM products;


-- Number of categories
SELECT COUNT(*) AS number_of_categories
FROM categories;


-- Number of order items
SELECT COUNT(*) AS number_of_order_items
FROM order_items;


-- Number of returns
SELECT COUNT(*) AS number_of_returns
FROM returns;


-- ============================================================
-- 2. ORDER STATUS ANALYSIS
-- ============================================================

-- Number of orders by status
SELECT
    order_status,
    COUNT(*) AS number_of_orders
FROM orders
GROUP BY order_status;


-- ============================================================
-- 3. OVERALL CANCELLATION RATE
-- ============================================================

-- Calculate the percentage of canceled orders
SELECT
    SUM(
        CASE
            WHEN order_status = 'Canceled' THEN 1
            ELSE 0
        END
    ) * 100.0 / COUNT(*) AS cancellation_rate
FROM orders;


-- ============================================================
-- 4. CANCELLATION BY PAYMENT METHOD
-- ============================================================

-- Number of total and canceled orders for each payment method
SELECT
    payment_method,
    COUNT(*) AS total_orders,
    SUM(
        CASE
            WHEN order_status = 'Canceled' THEN 1
            ELSE 0
        END
    ) AS canceled_orders
FROM orders
GROUP BY payment_method;


-- ============================================================
-- 5. CANCELLATION RATE BY PAYMENT METHOD
-- ============================================================

WITH payment_stats AS (
    SELECT
        payment_method,
        COUNT(*) AS total_orders,
        SUM(
            CASE
                WHEN order_status = 'Canceled' THEN 1
                ELSE 0
            END
        ) AS canceled_orders
    FROM orders
    GROUP BY payment_method
)

SELECT
    payment_method,
    total_orders,
    canceled_orders,
    canceled_orders * 100.0 / total_orders AS cancellation_rate
FROM payment_stats;