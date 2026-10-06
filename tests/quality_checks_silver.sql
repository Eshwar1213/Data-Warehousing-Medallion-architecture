/*
===============================================================================
Quality Checks - Silver Layer 
===============================================================================
Script Purpose:
    This script performs quality checks for data consistency, accuracy,
    and standardization across the Silver layer.

    Checks include:
        - NULL or duplicate primary keys
        - Unwanted spaces
        - Data standardization
        - Invalid date ranges
        - Invalid sales calculations
        - Data consistency

Usage:
    Run these checks after loading the Silver Layer.
===============================================================================
*/


-- ============================================================================
-- 1. Checking silver.crm_cust_info
-- ============================================================================

-- Check for NULLs or Duplicates in Customer ID
-- Expected Result: No rows

SELECT
    cst_id,
    COUNT(*) AS record_count
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1
    OR cst_id IS NULL;


-- Check for Unwanted Spaces
-- Expected Result: No rows

SELECT
    cst_key
FROM silver.crm_cust_info
WHERE cst_key <> TRIM(cst_key);


-- Check Data Standardization
-- Expected values: Single, Married, n/a

SELECT DISTINCT
    cst_marital_status
FROM silver.crm_cust_info;


-- ============================================================================
-- 2. Checking silver.crm_prd_info
-- ============================================================================

-- Check for NULLs or Duplicates in Product ID
-- Expected Result: No rows

SELECT
    prd_id,
    COUNT(*) AS record_count
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1
    OR prd_id IS NULL;


-- Check for Unwanted Spaces in Product Name
-- Expected Result: No rows

SELECT
    prd_nm
FROM silver.crm_prd_info
WHERE prd_nm <> TRIM(prd_nm);


-- Check for NULL or Negative Product Cost
-- Expected Result: No rows

SELECT
    prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0
   OR prd_cost IS NULL;


-- Check Data Standardization
-- Expected values: Mountain, Road, Other Sales, Touring, n/a

SELECT DISTINCT
    prd_line
FROM silver.crm_prd_info;


-- Check for Invalid Date Orders
-- Start Date should not be greater than End Date

SELECT
    *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;


-- ============================================================================
-- 3. Checking silver.crm_sales_details
-- ============================================================================

-- Check for Invalid Order Dates in Bronze
-- Expected Result: No rows

SELECT
    sls_due_dt
FROM bronze.crm_sales_details
WHERE sls_due_dt <= 0
   OR CHAR_LENGTH(CAST(sls_due_dt AS CHAR)) <> 8
   OR sls_due_dt > 20500101
   OR sls_due_dt < 19000101;


-- Check for Invalid Date Orders
-- Order Date should be <= Shipping Date and Due Date

SELECT
    *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt
   OR sls_order_dt > sls_due_dt;


-- Check Data Consistency
-- Sales should equal Quantity * Price
-- Expected Result: No rows

SELECT DISTINCT
    sls_sales,
    sls_quantity,
    sls_price
FROM silver.crm_sales_details
WHERE sls_sales <> sls_quantity * sls_price
   OR sls_sales IS NULL
   OR sls_quantity IS NULL
   OR sls_price IS NULL
   OR sls_sales <= 0
   OR sls_quantity <= 0
   OR sls_price <= 0
ORDER BY
    sls_sales,
    sls_quantity,
    sls_price;


-- ============================================================================
-- 4. Checking silver.erp_cust_az12
-- ============================================================================

-- Check for Out-of-Range Birthdates
-- Expected: Birthdates between 1924-01-01 and today

SELECT DISTINCT
    bdate
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01'
   OR bdate > CURDATE();


-- Check Data Standardization
-- Expected values: Female, Male, n/a

SELECT DISTINCT
    gen
FROM silver.erp_cust_az12;


-- ============================================================================
-- 5. Checking silver.erp_loc_a101
-- ============================================================================

-- Check Data Standardization

SELECT DISTINCT
    cntry
FROM silver.erp_loc_a101
ORDER BY cntry;


-- ============================================================================
-- 6. Checking silver.erp_px_cat_g1v2
-- ============================================================================

-- Check for Unwanted Spaces
-- Expected Result: No rows

SELECT
    *
FROM silver.erp_px_cat_g1v2
WHERE cat <> TRIM(cat)
   OR subcat <> TRIM(subcat)
   OR maintenance <> TRIM(maintenance);


-- Check Data Standardization
-- Expected values should be consistent

SELECT DISTINCT
    maintenance
FROM silver.erp_px_cat_g1v2;