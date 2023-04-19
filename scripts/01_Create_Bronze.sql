CREATE TABLE maven_parental_leave_bronze (
    record_id serial PRIMARY KEY,
    company VARCHAR(150),
    industry VARCHAR(150),
    paid_maternity_leave VARCHAR(50),
    unpaid_maternity_leave VARCHAR(50),
    paid_paternity_leave VARCHAR(50),
    unpaid_paternity_leave VARCHAR(50)
    );
