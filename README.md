# Zepto E-Commerce SQL Analysis Documentation

## Project Title
Zepto E-Commerce Sales Analysis Using SQL

---

# 1. Project Overview

This project focuses on analyzing Zepto e-commerce product and inventory data using SQL.

The main objective is to extract meaningful business insights related to:

- Product pricing analysis
- Discount trends
- Inventory management
- Product availability
- Revenue estimation
- Category-wise performance

The project demonstrates practical SQL skills used in real-world e-commerce data analysis projects.

---

# 2. Objectives

The objectives of this project are:

- Perform data cleaning using SQL
- Analyze e-commerce product data
- Solve business-related analytical questions
- Generate insights from raw inventory data
- Practice SQL querying techniques
- Understand product pricing and discount strategies

---

# 3. Tools & Technologies Used

| Tool | Purpose |
|---|---|
| SQL | Data Analysis |
| PostgreSQL | Database Management |
| CSV Dataset | Source Data |
| GitHub | Project Hosting |

---

# 4. Dataset Description

The dataset contains Zepto e-commerce product and inventory records.

## Columns Used

| Column Name | Description |
|---|---|
| sku_id | Unique product ID |
| category | Product category |
| name | Product name |
| mrp | Maximum Retail Price |
| discountPercent | Discount percentage |
| availableQuantity | Available inventory quantity |
| discountedSellingPrice | Discounted selling price |
| weightInGms | Product weight |
| outOfStock | Product stock availability |
| quantity | Product quantity |

---

# 5. Database Schema

```sql
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
```

---

# 6. Data Cleaning Process

The following data cleaning operations were performed:

- Checked total records
- Identified NULL values
- Removed invalid pricing data
- Converted paise values into rupees
- Verified dataset consistency
- Prepared data for analysis

## NULL Value Check

```sql
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
```

---

# 7. Business Problems Solved

## Q1. Find the top 10 best-value products based on discount percentage

```sql
SELECT DISTINCT
    name,
    mrp,
    discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;
```

### Objective

Identify products offering the highest discounts.

---

## Q2. Find products with high MRP that are out of stock

```sql
SELECT DISTINCT
    name,
    mrp
FROM zepto
WHERE outOfStock = TRUE
  AND mrp > 300
ORDER BY mrp DESC;
```

### Objective

Analyze premium products with inventory shortages.

---

## Q3. Calculate estimated revenue for each category

```sql
SELECT
    category,
    SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue DESC;
```

### Objective

Evaluate category-wise revenue contribution.

---

## Q4. Find products where MRP is greater than ₹500 and discount is less than 10%

```sql
SELECT DISTINCT
    name,
    mrp,
    discountPercent
FROM zepto
WHERE mrp > 500
  AND discountPercent < 10
ORDER BY mrp DESC;
```

### Objective

Identify expensive products with low discounts.

---

## Q5. Identify the top 5 categories offering the highest average discount percentage

```sql
SELECT
    category,
    ROUND(AVG(discountPercent), 2) AS average_discount
FROM zepto
GROUP BY category
ORDER BY average_discount DESC
LIMIT 5;
```

### Objective

Analyze category-wise discount strategies.

---

## Q6. Find the price per gram for products above 100g

```sql
SELECT DISTINCT
    name,
    weightInGms,
    discountedSellingPrice,
    ROUND(discountedSellingPrice / weightInGms, 2) AS price_per_gram
FROM zepto
WHERE weightInGms >= 100
ORDER BY price_per_gram;
```

### Objective

Identify products offering the best value by weight.

---

## Q7. Categorize products based on weight

```sql
SELECT DISTINCT
    name,
    weightInGms,

    CASE
        WHEN weightInGms < 1000 THEN 'Low'
        WHEN weightInGms < 5000 THEN 'Medium'
        ELSE 'Bulk'
    END AS weight_category

FROM zepto;
```

### Objective

Perform product segmentation based on product weight.

---

## Q8. Calculate total inventory weight per category

```sql
SELECT
    category,
    SUM(weightInGms * availableQuantity) AS total_inventory_weight
FROM zepto
GROUP BY category
ORDER BY total_inventory_weight DESC;
```

### Objective

Analyze inventory distribution across categories.

---

# 8. Key SQL Concepts Used

The project demonstrates the following SQL concepts:

- SELECT Statement
- WHERE Clause
- GROUP BY
- ORDER BY
- Aggregate Functions
- CASE WHEN
- Data Cleaning
- Filtering & Sorting
- Mathematical Operations
- Business Analysis Queries

---

# 9. Key Insights

Some major insights from the analysis:

- Certain categories offered significantly higher discounts.
- Premium products frequently faced stock shortages.
- Inventory distribution varied across product categories.
- Discount strategies influenced product pricing competitiveness.
- Some products provided better value based on weight and pricing.

---

# 10. Project Structure

```text
Zepto-Ecommerce-Sales-Analysis/
│
├── dataset/
│   └── zepto_sales.csv
│
├── sql_queries/
│   └── Zepto_Ecommerce_Analysis.sql
│
└── README.md
```


# 11. Future Improvements

Potential future enhancements:

- Build interactive Power BI dashboard
- Add advanced inventory forecasting
- Perform customer behavior analysis
- Create automated SQL reports
- Integrate Python for advanced analytics

---

# 12. Author

Abhishek More  
Aspiring Data Analyst skilled in SQL, PostgreSQL, Power BI, and Data Analytics.
