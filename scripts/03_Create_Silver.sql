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