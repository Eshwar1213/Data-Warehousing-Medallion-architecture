/*
===============================================================================
Quality Checks - Gold Layer
===============================================================================
Script Purpose:
    This script performs quality checks to validate the integrity,
    consistency, and accuracy of the Gold Layer.

    Checks:
        1. Uniqueness of customer surrogate keys.
        2. Uniqueness of product surrogate keys.
        3. Referential integrity between fact and dimension tables.

Expected Result:
    - Duplicate checks should return NO rows.
    - Referential integrity check should return NO rows.
===============================================================================
*/


-- ============================================================================
-- 1. Checking gold.dim_customers
-- ============================================================================
-- Check for duplicate customer keys
-- Expected Result: No rows

SELECT
    customer_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;


-- ============================================================================
-- 2. Checking gold.dim_products
-- ============================================================================
-- Check for duplicate product keys
-- Expected Result: No rows

SELECT
    product_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;


-- ============================================================================
-- 3. Checking gold.fact_sales
-- ============================================================================
-- Check referential integrity between fact and dimension tables
-- Expected Result: No rows

SELECT
    f.order_number,
    f.customer_key,
    f.product_key
FROM gold.fact_sales AS f

LEFT JOIN gold.dim_customers AS c
    ON c.customer_key = f.customer_key

LEFT JOIN gold.dim_products AS p
    ON p.product_key = f.product_key

WHERE c.customer_key IS NULL
   OR p.product_key IS NULL;