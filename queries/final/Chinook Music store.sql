# Question 1. Which country has the largest customer base?
Use Chinook;

select 
	Country,
	count(CustomerId) as 
TotalCustomers
from Customer
group by Country
order by TotalCustomers desc
limit 1;

# Question 2. Which customers are from USA? 
select 
	customerId,
	firstName
    lastName,
    Country
from Customer
where Country = 'USA'
order by lastName asc;

# Question 3. Which Countries has more than one customer?
select
	Country,
    count(CustomerId) as 
TotalCustomers
from Customer 
group by Country
having count(CustomerId) > 1 
order by TotalCustomers desc;

# Question 4. Which five customers have spent the most money at the music store?
select
	c.CustomerId,
    concat(c.firstName, ' ', c.lastName) as CustomerName,
	sum(i.Total) as TotalSpent
from Customer c
inner join Invoice i
	on c.CustomerId = i.CustomerId
group by c.customerId, CustomerName
order by TotalSpent desc
limit 5;

# Question 5. what is the average amount customers spend per invoive?
select
round(avg(Total), 2) as 
AverageInvoiceValue
from Invoice;

# Question 6. Which Customer has never made a purchase? 
select
	c.CustomerId,
    concat(c.firstName, ' ', c.lastName) as CustomerName, c.Country
from Customer c
left join Invoice i
	on c.CustomerId = i.CustomerId
where i.InvoiceId is null;

# Question 7. which customer have spent more than the average customer spending?
SELECT
    c.CustomerId,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    SUM(i.Total) AS TotalSpent
FROM Customer c
INNER JOIN Invoice i
    ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, CustomerName
HAVING SUM(i.Total) >
(
    SELECT AVG(CustomerTotal)
    FROM
    (
        SELECT SUM(Total) AS CustomerTotal
        FROM Invoice
        GROUP BY CustomerId
    ) AS AvgSpending
)
ORDER BY TotalSpent DESC;

# Question 8. Who has the top-spending customers ranked by total amount spent?
SELECT
    CustomerName,
    TotalSpent,
    RANK() OVER (ORDER BY TotalSpent DESC) AS CustomerRank
FROM
(
    SELECT
        CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
        SUM(i.Total) AS TotalSpent
    FROM Customer c
    INNER JOIN Invoice i
        ON c.CustomerId = i.CustomerId
    GROUP BY c.CustomerId, CustomerName
) AS CustomerSpending;

# Question 9. How has the store revenue changed over time?
SELECT
    YEAR(InvoiceDate) AS SalesYear,
    MONTH(InvoiceDate) AS SalesMonth,
    ROUND(SUM(Total), 2) AS TotalRevenue
FROM Invoice
GROUP BY
    YEAR(InvoiceDate),
    MONTH(InvoiceDate)
ORDER BY
    SalesYear,
    SalesMonth;