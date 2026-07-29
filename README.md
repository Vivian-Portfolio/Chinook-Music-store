# CHINOOK MUSIC STORE - Customer & Revenue Analysis
> *SQL-based analysis of a digital music store's customer and invoice data to answer questions on customer distribution, spending behaviour, and revenue trends using MySQL.*

---

## ⚙️ Project Type Flags
> *Check what applies. This helps reviewers and collaborators understand the nature of the work at a glance. Delete this block before publishing.*

- [ ] Exploratory Data Analysis (EDA)
- [x] SQL Analysis / Querying
- [ ] Dashboard / Data Visualization
- [ ] Data Pipeline / ETL
- [ ] Predictive Modelling / Machine Learning
- [x] Data Cleaning / Wrangling
- [ ] End-to-End (multiple of the above)
- [ ] Other: ___________

---

## Table of Contents
1. [Project Overview](#1-project-overview)
2. [Key Questions Answered](#2-Key Questions Answered)
3. [Objectives](#2-objectives)
4. [Project Scope & Tools](#4-project-scope--tools)
5. [Repository Structure](#5-repository-structure)
6. [Data Workflow](#6-data-workflow)
7. [Data Model & Schema](#7-data-model--schema)
8. [SQL Analysis & Queries](#8-SQL Analysis & Queries)
9. [Key Insights](#9-key-insights)
10. [Recommendations](#10-recommendations)
11. [Deliverables](#11-deliverables)
12. [Author](#12-author)

---

## 1. Project Overview

**Context:** Chinook is a sample digital music store database. The store needed a clear picture of where its customers are located, how much they spend, and how revenue trends over time.

**Problem Statement:** The Customer and Invoice tables held raw transactional and customer data, but there was no structured analysis answering key customer and revenue questions — such as which country has the most customers, who the highest-spending customers are, and which customers have never purchased anything.

**Approach:** Used SQL in MySQL Workbench to query the Customer and Invoice tables, writing queries using INNER and LEFT JOINs, correlated subqueries, HAVING clauses, and the RANK() window function to answer nine business questions.

**Outcome:** Successfully extracted customer and revenue insights, identifying the country with the largest customer base, USA-based customers, countries with multiple customers, top-spending customers, average invoice value, inactive customers, above-average spenders, ranked spenders, and month-by-month revenue trends.
---

## 2. Key Questions Answered

Which country has the largest customer base?
Which customers are from the USA?
Which countries have more than one customer?
Which customers have spent the most money at the music store?
What is the average amount customers spend per invoice?
Which customers have never made a purchase?
Which customers have spent more than the average customer spending?
Who are the top-spending customers, ranked by total amount spent?
How has store revenue changed over time?

---

## 3. Objectives

- **Primary Objective:** Write and execute SQL queries in MySQL Workbench to analyze the Chinook Customer and Invoice tables and extract meaningful customer and revenue insights.
- **Secondary Objective 1:** Identify customer geographic distribution, including country with the largest base and countries with multiple customers.
- **Secondary Objective 2:**  Determine top-spending customers and customers with no purchase history using joins.
- **Secondary Objective 3:**  Identify customers spending above the average using correlated subqueries.
- **Secondary Objective 4:**  Demonstrate practical SQL skills including joins, subqueries, window functions, and date-based trend analysis.

---

## 4. Project Scope & Tools

### Scope

| Dimension | Details |
|-----------|---------|
| **In Scope** | Customer records (name, country) and Invoice records (total, invoice date) from the Chinook sample database |
| **Out of Scope** | Track-level, artist-level, and playlist-level data - analysis is limited to the Customer and Invoice tables|
| **Time Period** | Full invoice date range present in the Chinook database|
| **Granularity** | Row-level customer and invoice data|

### Tools & Technologies

| Category | Tool(s) Used |
|----------|-------------|
| Category| MySQL |
| Database Management | MySQL Workbench |
| Data Querying| SQL (SELECT, WHERE, GROUP BY, HAVING, ORDER BY |
| Joins | INNER JOIN, LEFT JOIN |
| Subqueries | Correlated / nested subqueries |
| Aggregate Functions| COUNT, SUM, AVG, ROUND|
| Date Functions| YEAR, MONTH |
| String Functions | CONCAT | 
| Documentation | Microsoft Word, GitHub

---

## 5. Repository Structure

```
Chinook-Music-Store-SQL-Analysis/
│
├── data/
│   └── raw/                 # Chinook sample database (Customer, Invoice tables)
│
├── docs/                     # Data dictionary and project notes
│
├── queries/
│   ├── exploratory/          # Initial investigative queries
│   └── final/                # Final production-ready queries
│
├── reports/                  # Written summary report
│
├── visuals/                  # Screenshots of query results
│
├── README.md                 # You are here
└── project_metadata.yml      # Project metadata
```

---

## 6. Data Workflow

1. **Source:** Two related tables from the pre-built Chinook sample database — Customer (customer records) and Invoice (transaction records).
2. **Ingestion:** Chinook database connected in MySQL Workbench; Customer and Invoice tables queried directly.
3. **Analysis:** Wrote and executed 9 SQL queries covering aggregation, joins (INNER and LEFT), correlated subqueries, HAVING clauses, and RANK() window functions to answer key customer and revenue questions.
4.  **Output:**  Query results documented in README, SQL script saved as a .sql file, selected screenshots of query outputs saved in the visuals/ folder, and a written summary report saved in the reports/ folder.
   
---

## 7. Data Model & Schema
The dataset uses two core tables from the Chinook sample database.
### Dataset Dictionary 


| Field Name | Data Type | Description | Example Value |
|------------|-----------|-------------|---------------|
| `CustomerId` | Integer | Unique identifier for each customer | 1 |
| `[FirstName` | Text | Customer's first name | Luís |
| `LastName` |Text| Customer's last name| Gonçalves |
| `Country` | Text | Customer's country | Brazil |
| `InvoiceId` | Integer | Unique identifier for each invoice | 1 |
| `CustomerId (Invoice)` | Integer | Foreign key linking invoice to customer | 1 |
| `InvoiceDate]` | Date| Date the invoice was issued| 2009-01-01 |
| `Total` | Float| Total amount of the invoice | 1.98|

**Key tables:** Customer, Invoice
**Relationship:** Customer.CustomerId → Invoice.CustomerId


---

## 8. SQL Analysis & Queries

Q1: Which country has the largest customer base?
``` sql
SELECT
    Country,
    COUNT(CustomerId) AS TotalCustomers
FROM Customer
GROUP BY Country
ORDER BY TotalCustomers DESC
LIMIT 1;
-- Result: [insert top country once available]
```

Q2: Which customers are from the USA?
``` sql
SELECT
    CustomerId,
    FirstName,
    LastName,
    Country
FROM Customer
WHERE Country = 'USA'
ORDER BY LastName ASC;
-- Result: [insert list/count of USA customers once available]
```

Q3: Which countries have more than one customer?
``` sql
SELECT
    Country,
    COUNT(CustomerId) AS TotalCustomers
FROM Customer
GROUP BY Country
HAVING COUNT(CustomerId) > 1
ORDER BY TotalCustomers DESC;
-- Result: [insert countries with multiple customers once available]
```

Q4: Which customers have spent the most money at the music store?
``` sql
SELECT
    c.CustomerId,
    CONCAT(c.FirstName,' ', c.LastName) AS CustomerName,
    SUM(i.Total) AS TotalSpent
FROM Customer c
INNER JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, CustomerName
ORDER BY TotalSpent DESC
LIMIT 5;
-- Result: [insert top 5 spending customers once available]
```
Q5: What is the average amount customers spend per invoice?
``` sql
SELECT
    ROUND(AVG(Total),2) AS AverageInvoiceValue
FROM Invoice;
-- Result: [insert average invoice value once available]
```

Q6: Which customers have never made a purchase?
``` sql
SELECT
    c.CustomerId,
    CONCAT(c.FirstName,' ', c.LastName) AS CustomerName,
    c.Country
FROM Customer c
LEFT JOIN Invoice i ON c.CustomerId = i.CustomerId
WHERE i.InvoiceId IS NULL;
-- Result: [insert list of inactive customers once available]
```

Q7: Which customers have spent more than the average customer spending?
``` sql
SELECT
    c.CustomerId,
    CONCAT(c.FirstName,' ', c.LastName) AS CustomerName,
    SUM(i.Total) AS TotalSpent
FROM Customer c
INNER JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, CustomerName
HAVING SUM(i.Total) > (
    SELECT AVG(CustomerTotal)
    FROM (
        SELECT SUM(Total) AS CustomerTotal
        FROM Invoice
        GROUP BY CustomerId
    ) AS AvgSpending
)
ORDER BY TotalSpent DESC;
-- Result: [insert count/list of above-average spenders once available]
```

Q8: Who are the top-spending customers, ranked by total amount spent?
``` sql
SELECT
    CustomerName,
    TotalSpent,
    RANK() OVER (ORDER BY TotalSpent DESC) AS CustomerRank
FROM (
    SELECT
        CONCAT(c.FirstName,' ', c.LastName) AS CustomerName,
        SUM(i.Total) AS TotalSpent
    FROM Customer c
    INNER JOIN Invoice i ON c.CustomerId = i.CustomerId
    GROUP BY c.CustomerId, CustomerName
) AS CustomerSpending;
-- Result: [insert ranked customer list once available]
```

Q9: How has store revenue changed over time?
``` sql
SELECT
    YEAR(InvoiceDate) AS SalesYear,
    MONTH(InvoiceDate) AS SalesMonth,
    ROUND(SUM(Total),2) AS TotalRevenue
FROM Invoice
GROUP BY YEAR(InvoiceDate), MONTH(InvoiceDate)
ORDER BY SalesYear, SalesMonth;
-- Result: [insert monthly/yearly revenue trend once available]
```
---

## 8. Key Insights

**Insight 1: [Short descriptive headline]**
[What you found + what it suggests. One short paragraph.]

**Insight 2: [Short descriptive headline]**
[What you found + what it suggests.]

**Insight 3: [Short descriptive headline]**
[What you found + what it suggests.]

**Insight 4 (if applicable): [Short descriptive headline]**
[What you found + what it suggests.]**


---

## 9. Recommendations

| Priority | Recommendation | Based On | Suggested Owner |
|----------|---------------|----------|-----------------|
| High | [Specific, actionable step] | [Insight it comes from] | [Who should act] |
| Medium | [Specific, actionable step] | [Insight it comes from] | [Who should act] |
| Low | [Exploratory or longer-term suggestion] | [Insight it comes from] | [Who should act] |


---

## 10. Deliverables

| Deliverable | Description | Location |
|-------------|-------------|----------|
| SQL Query File | All 9 queries written and executed in MySQL Workbench | queries/final/chinook_queries.sql |
| Summary Report | Written Word document summarizing findings and insights |reports/Chinook_Music_Store_SQL_Analysis_Report.docx|
|   Raw Dataset | Chinook sample database (Customer, Invoice tables) | `data/raw/` |
| Query Screenshots | Selected screenshots of query results from MySQL Workbench | visuals/

---

## 11. Author

**Okwara Vivian**
Data Analyst | Lagos, Nigeria

- 🔗 https://LinkedIn.com/in/okwara-vivian
- 💼 https://Vivian-Portfolio.github.io
- 📧 okwaravivian26@mail.com
---

*Last updated: June  2026

