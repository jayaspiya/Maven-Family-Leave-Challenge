CREATE TABLE maven_parental_leave_silver (
    record_id NUMERIC PRIMARY KEY,
    company VARCHAR(150),
    industry VARCHAR(150),
    subindustry VARCHAR(150),
    paid_maternity_leave NUMERIC,
    unpaid_maternity_leave NUMERIC,
    paid_paternity_leave NUMERIC,
    unpaid_paternity_leave NUMERIC
    );

INSERT INTO maven_parental_leave_silver (
    record_id,
    company,
    industry,
    subindustry,
    paid_maternity_leave,
    unpaid_maternity_leave,
    paid_paternity_leave,
    unpaid_paternity_leave
    )
WITH TEMP AS (
        SELECT record_id,
            company,
            industry AS source_industry,
            string_to_array(industry, ':') AS industry_arr,
            paid_maternity_leave,
            unpaid_maternity_leave,
            paid_paternity_leave,
            unpaid_paternity_leave
        FROM maven_parental_leave_bronze
        )
SELECT record_id,
    company,
    trim(industry_arr [1]) AS industry,
    trim(industry_arr [2]) AS subindustry,
    CASE 
        WHEN paid_maternity_leave = 'N/A'
            THEN 0
        ELSE paid_maternity_leave::NUMERIC
        END AS paid_maternity_leave_numeric,
    CASE 
        WHEN unpaid_maternity_leave = 'N/A'
            THEN 0
        ELSE unpaid_maternity_leave::NUMERIC
        END AS unpaid_maternity_leave_numeric,
    CASE 
        WHEN paid_paternity_leave = 'N/A'
            THEN 0
        ELSE paid_paternity_leave::NUMERIC
        END AS paid_paternity_leave_numeric,
    CASE 
        WHEN unpaid_paternity_leave = 'N/A'
            THEN 0
        ELSE unpaid_paternity_leave::NUMERIC
        END AS unpaid_paternity_leave_numeric
FROM TEMP;