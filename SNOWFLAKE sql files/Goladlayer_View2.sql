use pacificretail_db.gold;

CREATE OR REPLACE VIEW VW_CUSTOMER_PRODUCT_AFFINITY AS
SELECT 
    c.customer_id,
    c.customer_type,
    p.product_id,
    p.name AS product_name,
    p.category AS product_category,
    DATE_TRUNC('MONTH', o.transaction_date) AS purchase_month,
    COUNT(DISTINCT o.transaction_id) AS purchase_count,
    SUM(o.quantity) AS total_quantity,
    SUM(o.total_amount) AS total_spent,
    AVG(o.total_amount) AS avg_purchase_amount,
    DATEDIFF('DAY', MIN(o.transaction_date), MAX(o.transaction_date)) AS days_between_first_last_purchase
FROM SILVER.CUSTOMER c
JOIN SILVER.ORDERS o ON c.customer_id = o.customer_id
JOIN SILVER.PRODUCT p ON o.product_id = p.product_id
GROUP BY 
    c.customer_id,
    c.customer_type,
    p.product_id,
    p.name,
    p.category,
    DATE_TRUNC('MONTH', o.transaction_date);

select * from VW_CUSTOMER_PRODUCT_AFFINITY;