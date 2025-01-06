CREATE OR REPLACE FILE FORMAT csv_file_format
    TYPE = CSV
    FIELD_DELIMITER = ','
    SKIP_HEADER = 1
    NULL_IF = ('NULL', 'null', '')
    EMPTY_FIELD_AS_NULL = TRUE
    COMPRESSION = AUTO;

--verify
SELECT 
    $1, $2, $3, $4, $5, $6
FROM @adls_stage/Customer
    (FILE_FORMAT => csv_file_format)
LIMIT 10;


--- Create Customer Table

CREATE TABLE IF NOT EXISTS raw_customer (
    customer_id INT,
    name STRING,
    email STRING,
    country STRING,
    customer_type STRING,
    registration_date DATE,
	age INT,
    gender STRING,
    total_purchases INT,
    source_file_name STRING,
    source_file_row_number INT,
    ingestion_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);


-- create task
CREATE OR REPLACE TASK load_customer_data_task
    WAREHOUSE = compute_wh
    SCHEDULE = 'USING CRON 0 2 * * * America/New_York'
AS

    COPY INTO raw_customer (
        customer_id,
        name,
        email,
        country,
        customer_type,
        registration_date,
		age,
		gender,
		total_purchases,
        source_file_name,
        source_file_row_number
    )
    FROM (
        SELECT 
            $1,
            $2,
            $3,
            $4,
            $5,
            $6::DATE,
			$7,
			$8,
			$9,
            metadata$filename,
            metadata$file_row_number
        FROM @adls_stage/Customer/
    )
    FILE_FORMAT = (FORMAT_NAME = 'csv_file_format')
    ON_ERROR = 'CONTINUE'
    PATTERN = '.*[.]csv';

-- start the task
alter task load_customer_data_task resume;






