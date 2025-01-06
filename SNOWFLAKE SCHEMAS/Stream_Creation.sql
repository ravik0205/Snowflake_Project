use pacificretail_db.bronze;

CREATE OR REPLACE STREAM customer_changes_stream ON TABLE raw_customer
    APPEND_ONLY = TRUE;


CREATE OR REPLACE STREAM product_changes_stream ON TABLE raw_product
    APPEND_ONLY = TRUE;
    
CREATE OR REPLACE STREAM order_changes_stream ON TABLE raw_order
    APPEND_ONLY = TRUE;

show streams in pacificretail_db.bronze

    