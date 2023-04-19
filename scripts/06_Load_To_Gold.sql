INSERT INTO maven_parental_leave_gold
WITH avg_paid_maternity_leave_tbl AS (
        SELECT industry,
            trunc(avg(paid_maternity_leave), 2) AS avg_paid_maternity_leave
        FROM maven_parental_leave_silver
        WHERE paid_maternity_leave <> 0
        GROUP BY 1
        ),
    avg_paid_paternity_leave_tbl AS (
        SELECT industry,
            trunc(avg(paid_paternity_leave), 2) AS avg_paid_paternity_leave
        FROM maven_parental_leave_silver
        WHERE paid_paternity_leave <> 0
        GROUP BY 1
        ),
    avg_unpaid_maternity_leave_tbl AS (
        SELECT industry,
            trunc(avg(unpaid_maternity_leave), 2) AS avg_unpaid_maternity_leave
        FROM maven_parental_leave_silver
        WHERE unpaid_maternity_leave <> 0
        GROUP BY 1
        ),
    avg_unpaid_paternity_leave_tbl AS (
        SELECT industry,
            trunc(avg(unpaid_paternity_leave), 2) AS avg_unpaid_paternity_leave
        FROM maven_parental_leave_silver
        WHERE unpaid_paternity_leave <> 0
        GROUP BY 1
        ),
    TEMP AS (
        SELECT avg_paid_maternity_leave_tbl.industry,
            avg_paid_maternity_leave,
            avg_unpaid_maternity_leave,
            avg_paid_paternity_leave,
            avg_unpaid_paternity_leave
        FROM avg_paid_maternity_leave_tbl
        JOIN avg_paid_paternity_leave_tbl ON avg_paid_maternity_leave_tbl.industry = avg_paid_paternity_leave_tbl.industry
        JOIN avg_unpaid_maternity_leave_tbl ON avg_paid_maternity_leave_tbl.industry = avg_unpaid_maternity_leave_tbl.industry
        JOIN avg_unpaid_paternity_leave_tbl ON avg_paid_maternity_leave_tbl.industry = avg_unpaid_paternity_leave_tbl.industry
        )
SELECT industry,
    avg_paid_maternity_leave,
    avg_unpaid_maternity_leave,
    avg_paid_paternity_leave,
    avg_unpaid_paternity_leave
FROM TEMP
