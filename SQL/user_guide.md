# 📘 User Guide: Loading Data into PostgreSQL
This guide explains how to set up the SalesScope database in PostgreSQL and load CSV data into the respective tables.

## 1️⃣ Create Database

Open pgAdmin or psql and run:
CREATE DATABASE SalesScope;

## 2️⃣ Create Tables

Connect to the SalesScope database, then create the following tables.
Make sure column names exactly match the CSV headers.

### 📍 Table 1: order_location
CREATE TABLE order_location (
    index SERIAL PRIMARY KEY,
    country TEXT NOT NULL,
    city TEXT NOT NULL,
    postal_code NUMERIC NOT NULL,
    region TEXT
);

### 📍 Table 2: orders
CREATE TABLE orders (
    order_id         VARCHAR,
    order_date       DATE,
    ship_mode        VARCHAR,
    segment          VARCHAR,
    country          VARCHAR,
    city             VARCHAR,
    state            VARCHAR,
    postal_code      VARCHAR,
    region           VARCHAR,
    category         VARCHAR,
    sub_category     VARCHAR,
    product_id       VARCHAR,
    cost_price       NUMERIC,
    list_price       NUMERIC,
    quantity         INT,
    discount_percent NUMERIC
);

### 📍 Table 3: products
CREATE TABLE products (
    index        SERIAL PRIMARY KEY,      
    product_id   VARCHAR(100),             
    category     VARCHAR(100),
    sub_category VARCHAR(100),
    cost_price   NUMERIC(10,2),
    list_price   NUMERIC(10,2)
);

### 📍 Table 4: monthly_profit
CREATE TABLE monthly_profit (
    order_date    VARCHAR,      -- Format: YYYY-MM
    monthly_price NUMERIC
);

## 3️⃣ Import Data into Tables

After creating the tables, refresh the public schema on the left-hand side of pgAdmin.
For each table:

- Right-click the table → Import/Export.
- Set Filename to your CSV file path (e.g., orders.csv).
- Enable Header.
- Set Delimiter to ,.
- Click OK.

Repeat this process for all 4 tables:

* orders → orders.csv
* products → products.csv
* order_location → order_location.csv
* monthly_profit → monthly_profit.csv

## 4️⃣ Verify Data

Open the Query Tool and check your data with:

- SELECT * FROM orders;
- SELECT * FROM products;
- SELECT * FROM order_location;
- SELECT * FROM monthly_profit;

## ✅ Notes

+ Ensure column names in the .csv files match exactly with the SQL table definitions above.
+ You can copy the SQL code for table creation directly from this guide.
+ If you face permissions issues with COPY, use pgAdmin Import/Export (as described above).