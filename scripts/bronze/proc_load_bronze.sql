/*
===============================================================================
Stored Procedure: Load Bronze Layer
Source -> Bronze
===============================================================================
*/

USE bronze;

DROP PROCEDURE IF EXISTS load_bronze;

DELIMITER $$

CREATE PROCEDURE load_bronze()
BEGIN

    DECLARE start_time DATETIME;
    DECLARE end_time DATETIME;
    DECLARE batch_start_time DATETIME;
    DECLARE batch_end_time DATETIME;

    -- Error handler
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'ERROR OCCURRED DURING LOADING BRONZE LAYER' AS message;
    END;

    SET batch_start_time = NOW();

    SELECT '============================================' AS message;
    SELECT 'Loading Bronze Layer' AS message;
    SELECT '============================================' AS message;


    -- =========================================================================
    -- CRM TABLES
    -- =========================================================================

    SELECT '--------------------------------------------' AS message;
    SELECT 'Loading CRM Tables' AS message;
    SELECT '--------------------------------------------' AS message;


    -- -------------------------------------------------------------------------
    -- CRM Customer
    -- -------------------------------------------------------------------------

    SET start_time = NOW();

    SELECT 'Truncating Table: bronze.crm_cust_info' AS message;

    TRUNCATE TABLE crm_cust_info;

    SELECT 'Inserting Data Into: bronze.crm_cust_info' AS message;

    LOAD DATA LOCAL INFILE 'C:/sql/dwh_project/datasets/source_crm/cust_info.csv'
    INTO TABLE crm_cust_info
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

    SET end_time = NOW();

    SELECT CONCAT(
        'Load Duration: ',
        TIMESTAMPDIFF(SECOND, start_time, end_time),
        ' seconds'
    ) AS message;


    -- -------------------------------------------------------------------------
    -- CRM Product
    -- -------------------------------------------------------------------------

    SET start_time = NOW();

    SELECT 'Truncating Table: bronze.crm_prd_info' AS message;

    TRUNCATE TABLE crm_prd_info;

    SELECT 'Inserting Data Into: bronze.crm_prd_info' AS message;

    LOAD DATA LOCAL INFILE 'C:/sql/dwh_project/datasets/source_crm/prd_info.csv'
    INTO TABLE crm_prd_info
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

    SET end_time = NOW();

    SELECT CONCAT(
        'Load Duration: ',
        TIMESTAMPDIFF(SECOND, start_time, end_time),
        ' seconds'
    ) AS message;


    -- -------------------------------------------------------------------------
    -- CRM Sales Details
    -- -------------------------------------------------------------------------

    SET start_time = NOW();

    SELECT 'Truncating Table: bronze.crm_sales_details' AS message;

    TRUNCATE TABLE crm_sales_details;

    SELECT 'Inserting Data Into: bronze.crm_sales_details' AS message;

    LOAD DATA LOCAL INFILE 'C:/sql/dwh_project/datasets/source_crm/sales_details.csv'
    INTO TABLE crm_sales_details
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

    SET end_time = NOW();

    SELECT CONCAT(
        'Load Duration: ',
        TIMESTAMPDIFF(SECOND, start_time, end_time),
        ' seconds'
    ) AS message;


    -- =========================================================================
    -- ERP TABLES
    -- =========================================================================

    SELECT '--------------------------------------------' AS message;
    SELECT 'Loading ERP Tables' AS message;
    SELECT '--------------------------------------------' AS message;


    -- -------------------------------------------------------------------------
    -- ERP Location
    -- -------------------------------------------------------------------------

    SET start_time = NOW();

    SELECT 'Truncating Table: bronze.erp_loc_a101' AS message;

    TRUNCATE TABLE erp_loc_a101;

    SELECT 'Inserting Data Into: bronze.erp_loc_a101' AS message;

    LOAD DATA LOCAL INFILE 'C:/sql/dwh_project/datasets/source_erp/loc_a101.csv'
    INTO TABLE erp_loc_a101
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

    SET end_time = NOW();

    SELECT CONCAT(
        'Load Duration: ',
        TIMESTAMPDIFF(SECOND, start_time, end_time),
        ' seconds'
    ) AS message;


    -- -------------------------------------------------------------------------
    -- ERP Customer
    -- -------------------------------------------------------------------------

    SET start_time = NOW();

    SELECT 'Truncating Table: bronze.erp_cust_az12' AS message;

    TRUNCATE TABLE erp_cust_az12;

    SELECT 'Inserting Data Into: bronze.erp_cust_az12' AS message;

    LOAD DATA LOCAL INFILE 'C:/sql/dwh_project/datasets/source_erp/cust_az12.csv'
    INTO TABLE erp_cust_az12
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

    SET end_time = NOW();

    SELECT CONCAT(
        'Load Duration: ',
        TIMESTAMPDIFF(SECOND, start_time, end_time),
        ' seconds'
    ) AS message;


    -- -------------------------------------------------------------------------
    -- ERP Product Category
    -- -------------------------------------------------------------------------

    SET start_time = NOW();

    SELECT 'Truncating Table: bronze.erp_px_cat_g1v2' AS message;

    TRUNCATE TABLE erp_px_cat_g1v2;

    SELECT 'Inserting Data Into: bronze.erp_px_cat_g1v2' AS message;

    LOAD DATA LOCAL INFILE 'C:/sql/dwh_project/datasets/source_erp/px_cat_g1v2.csv'
    INTO TABLE erp_px_cat_g1v2
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

    SET end_time = NOW();

    SELECT CONCAT(
        'Load Duration: ',
        TIMESTAMPDIFF(SECOND, start_time, end_time),
        ' seconds'
    ) AS message;


    -- =========================================================================
    -- COMPLETION
    -- =========================================================================

    SET batch_end_time = NOW();

    SELECT '============================================' AS message;
    SELECT 'Loading Bronze Layer is Completed' AS message;

    SELECT CONCAT(
        'Total Load Duration: ',
        TIMESTAMPDIFF(SECOND, batch_start_time, batch_end_time),
        ' seconds'
    ) AS message;

    SELECT '============================================' AS message;

END$$

DELIMITER ;