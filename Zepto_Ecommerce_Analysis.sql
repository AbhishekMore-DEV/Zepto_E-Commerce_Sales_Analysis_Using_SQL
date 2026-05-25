-- =========================================================
-- PROJECT: Zepto E-Commerce Analysis Using SQL
-- DATABASE: PostgreSQL
-- =========================================================

-- =========================================================
-- CREATE TABLE
-- =========================================================

CREATE TABLE zepto (
    sku_id SERIAL PRIMARY KEY,
    category VARCHAR(120),
    name VARCHAR(150) NOT NULL,
    mrp NUMERIC(8,2),
    discountPercent NUMERIC(5,2),
    availableQuantity INTEGER,
    discountedSellingPrice NUMERIC(8,2),
    weightInGms INTEGER,
    outOfStock BOOLEAN,
    quantity INTEGER
);

-- =========================================================
-- DATA PREVIEW
-- =========================================================

SELECT *
FROM zepto
LIMIT 10;

-- =========================================================
-- DATA CLEANING
-- =========================================================

-- Check total number of rows
SELECT COUNT(*) AS total_rows
FROM zepto;

-- Check NULL values
SELECT *
FROM zepto
WHERE name IS NULL
   OR category IS NULL
   OR mrp IS NULL
   OR discountPercent IS NULL
   OR discountedSellingPrice IS NULL
   OR weightInGms IS NULL
   OR availableQuantity IS NULL
   OR outOfStock IS NULL
   OR quantity IS NULL;

-- Check products with price = 0
SELECT *
FROM zepto
WHERE mrp = 0
   OR discountedSellingPrice = 0;

-- Delete products where MRP = 0
DELETE FROM zepto
WHERE mrp = 0;

-- Convert paise values into rupees
UPDATE zepto
SET mrp = mrp / 100.0,
    discountedSellingPrice = discountedSellingPrice / 100.0;

-- Verify updated prices
SELECT
    mrp,
    discountedSellingPrice
FROM zepto;

-- =========================================================
-- DATA EXPLORATION
-- =========================================================

-- Total number of products
SELECT COUNT(*) AS total_products
FROM zepto;

-- Available product categories
SELECT DISTINCT category
FROM zepto
ORDER BY category;

-- Products in stock vs out of stock
SELECT
    outOfStock,
    COUNT(sku_id) AS total_products
FROM zepto
GROUP BY outOfStock;

-- Products appearing multiple times
SELECT
    name,
    COUNT(sku_id) AS number_of_skus
FROM zepto
GROUP BY name
HAVING COUNT(sku_id) > 1
ORDER BY number_of_skus DESC;

-- =========================================================
-- BUSINESS PROBLEMS & ANALYSIS
-- =========================================================

-- Q1. Find the top 10 best-value products based on
-- discount percentage

SELECT DISTINCT
    name,
    mrp,
    discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;

-- =========================================================

-- Q2. Find products with high MRP that are out of stock

SELECT DISTINCT
    name,
    mrp
FROM zepto
WHERE outOfStock = TRUE
  AND mrp > 300
ORDER BY mrp DESC;

-- =========================================================

-- Q3. Calculate estimated revenue for each category

SELECT
    category,
    SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue DESC;

-- =========================================================

-- Q4. Find products where MRP is greater than ₹500
-- and discount is less than 10%

SELECT DISTINCT
    name,
    mrp,
    discountPercent
FROM zepto
WHERE mrp > 500
  AND discountPercent < 10
ORDER BY mrp DESC,
         discountPercent DESC;

-- =========================================================

-- Q5. Identify the top 5 categories offering the
-- highest average discount percentage

SELECT
    category,
    ROUND(AVG(discountPercent), 2) AS average_discount
FROM zepto
GROUP BY category
ORDER BY average_discount DESC
LIMIT 5;

-- =========================================================

-- Q6. Find the price per gram for products above 100g
-- and sort by best value

SELECT DISTINCT
    name,
    weightInGms,
    discountedSellingPrice,
    ROUND(discountedSellingPrice / weightInGms, 2) AS price_per_gram
FROM zepto
WHERE weightInGms >= 100
ORDER BY price_per_gram;

-- =========================================================

-- Q7. Categorize products into Low, Medium,
-- and Bulk based on weight

SELECT DISTINCT
    name,
    weightInGms,

    CASE
        WHEN weightInGms < 1000 THEN 'Low'
        WHEN weightInGms < 5000 THEN 'Medium'
        ELSE 'Bulk'
    END AS weight_category

FROM zepto;

-- =========================================================

-- Q8. Calculate total inventory weight per category

SELECT
    category,
    SUM(weightInGms * availableQuantity) AS total_inventory_weight
FROM zepto
GROUP BY category
ORDER BY total_inventory_weight DESC;

-- =========================================================
-- END OF PROJECT
-- =========================================================