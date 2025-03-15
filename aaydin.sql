DROP TABLE COUNTRIES CASCADE CONSTRAINTS;
DROP TABLE REGIONS CASCADE CONSTRAINTS;
DROP TABLE LOCATIONS CASCADE CONSTRAINTS;
DROP TABLE DEPARTMENTS CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEES CASCADE CONSTRAINTS;
DROP TABLE JOB_HISTORY CASCADE CONSTRAINTS;
DROP TABLE JOBS CASCADE CONSTRAINTS;

CREATE TABLE regions (
region_id INT PRIMARY KEY,
region_name VARCHAR(30)
);

CREATE TABLE countries (
country_id INT PRIMARY KEY,
country_name VARCHAR(30),
region_id INT,
FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE locations (
location_id INT PRIMARY KEY,
street_address VARCHAR(30),
postal_code VARCHAR(30),
city VARCHAR(30),
state_province VARCHAR(30),
country_id INT,
FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

CREATE TABLE departments (
department_id INT PRIMARY KEY,
department_name VARCHAR(30),
manager_id INT,
location_id INT,
FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE employees (
employee_id INT PRIMARY KEY,
first_name VARCHAR(30),
last_name VARCHAR(30),
email VARCHAR(30),
PHONE_NUMBER VARCHAR(15),
hire_date DATE,
job_id INT,
salary DECIMAL(6,2),
commission_pct DECIMAL(6,2),
manager_id INT,
department_id INT,
FOREIGN KEY (department_id) REFERENCES departments(department_id),
FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

CREATE TABLE job_history (
employee_id INT,
start_date DATE,
end_date DATE,
job_id INT,
department_id INT,
PRIMARY KEY (employee_id, start_date),
FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE jobs (
job_id INT PRIMARY KEY,
job_title VARCHAR(30),
min_salary DECIMAL(6,2),
max_salary DECIMAL(6,2),
CONSTRAINT salary_check check (min_salary < max_salary AND max_salary - min_salary >= 2000)
);

ALTER TABLE job_history ADD FOREIGN KEY (job_id) REFERENCES jobs(job_id);
ALTER TABLE employees ADD FOREIGN KEY (job_id) REFERENCES jobs(job_id);
ALTER TABLE departments ADD FOREIGN KEY (manager_id) REFERENCES employees(employee_id);

