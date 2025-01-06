use pacificretail_db.gold;

CREATE OR REPLACE VIEW VW_DAILY_SALES_ANALYSIS AS
SELECT 
    o.transaction_date,
    p.product_id,
    p.name AS product_name,
    p.category AS product_category,
    c.customer_id,
    c.customer_type,
    SUM(o.quantity) AS total_quantity,
    SUM(o.total_amount) AS total_sales,
    COUNT(DISTINCT o.transaction_id) AS num_transactions,
    SUM(o.total_amount) / NULLIF(SUM(o.quantity), 0) AS avg_price_per_unit,
    SUM(o.total_amount) / NULLIF(COUNT(DISTINCT o.transaction_id), 0) AS avg_transaction_value
FROM SILVER.ORDERs o
JOIN SILVER.PRODUCT p ON o.product_id = p.product_id
JOIN SILVER.CUSTOMER c ON o.customer_id = c.customer_id
GROUP BY 
    o.transaction_date,
    p.product_id,
    p.name,
    p.category,
    c.customer_id,
    c.customer_type;


select * from VW_DAILY_SALES_ANALYSIS;