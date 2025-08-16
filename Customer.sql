SELECT *
FROM [dbo].[Order$]

SELECT *
FROM [dbo].[Customer$]

SELECT *
FROM [dbo].[Salesman$]

DELETE FROM [dbo].[Order$]
WHERE [Order Number] IS NULL

/*
1. write a SQL query to find the salesperson and customer who reside in the same city. Return Salesman, cust_name and city.
*/

SELECT s.Salesman_id
		,s.Name AS Salesman_Name
		,c.Customer_Name
		,c.city
FROM [dbo].[Salesman$] AS s
JOIN [dbo].[Customer$] AS c
ON s.Salesman_id = c.Salesman_ID
WHERE s.city = c.City

/*
2. write a SQL query to find those orders where the order amount exists between 500 and 2000. Return ord_no, purch_amt, cust_name, city.
*/

SELECT o.[Order Number]
		,o.Purchase_Amount
		,c.Customer_Name
		,c.City
FROM [dbo].[Order$] AS o
JOIN [dbo].[Customer$] AS c
ON o.[Customer ID] = c.Customer_ID
WHERE o.Purchase_Amount BETWEEN 500 AND 2000

/*
3. write a SQL query to find the salesperson(s) and the customer(s) he represents. Return Customer Name, city, Salesman, commission.
*/

SELECT 	s.Name AS Salesman_Name
		,s.Salesman_id
		,c.Customer_Name
		,c.City
		,s.commission
FROM [dbo].[Customer$] AS c
JOIN [dbo].[Salesman$] AS s
ON s.Salesman_id = c.Salesman_ID

/*
4. write a SQL query to find salespeople who received commissions of more than 12 percent from the company. Return Customer Name, customer city, Salesman, commission.  
*/
SELECT c.Customer_Name
		,c.City AS Customer_City
		,s.Name AS Salesman
		,s.Salesman_id
		,s.commission
FROM [dbo].[Customer$] AS c
JOIN [dbo].[Salesman$] AS s
ON c.Salesman_ID = s.Salesman_id
WHERE s.commission >0.12

/*
5. write a SQL query to locate those salespeople who do not live in the same city where their customers live and have received a commission of more than 12% from the company. Return Customer Name, customer city, Salesman, salesman city, commission.
*/

SELECT c.Customer_Name
		,c.City AS Customer_City
		,s.Name AS Salesman_Name
		,s.city AS Salesman_City
		,s.commission
FROM [dbo].[Customer$] AS c
JOIN [dbo].[Salesman$] AS s
ON c.Salesman_ID = s.Salesman_id
WHERE c.city != s.City
AND s.commission >0.12

/*
6. write a SQL query to find the details of an order. Return ord_no, ord_date, purch_amt, Customer Name, grade, Salesman, commission
*/

SELECT o.[Order Number]
		,o.[Order Date]
		,o.Purchase_Amount
		,c.Customer_Name
		,c.Grade
		,s.Name AS Salesperson_Name
		,s.commission
FROM [dbo].[Order$] AS o
INNER JOIN [dbo].[Customer$] AS c
ON o.[Customer ID] = c.Customer_ID
INNER JOIN [dbo].[Salesman$] AS s
ON c.Salesman_ID = s.Salesman_id

/*
7. Write a SQL statement to join the tables salesman, customer and orders so that the same column of each table appears once and only the relational rows are returned. 
*/
SELECT o.[Order Number]
		,o.Purchase_Amount
		,o.[Order Date]
		,o.[Customer ID]
		,c.Customer_Name
		,c.City AS Customer_City
		,c.Grade
		,s.Salesman_id
		,s.Name AS Salesman_Name
		,s.city AS Salesman_City
		,s.commission AS Commission
FROM [dbo].[Order$] AS o
JOIN [dbo].[Customer$] AS c
ON o.[Customer ID] = c.Customer_ID
JOIN [dbo].[Salesman$] AS s
ON c.Salesman_ID = s.Salesman_id

/*
8. write a SQL query to display the customer name, customer city, grade, salesman, salesman city. The results should be sorted by ascending customer_id.
*/
SELECT c.Customer_Name
		,c.City AS Customer_City
		,c.Grade
		,s.Name AS Salesman_Name
		,s.city AS Salesman_City
FROM [dbo].[Customer$] AS c
JOIN [dbo].[Salesman$] AS s
ON c.Salesman_ID = s.Salesman_id
ORDER BY c.Customer_id asc

/*
9. write a SQL query to find those customers with a grade less than 300. Return cust_name, customer city, grade, Salesman, salesmancity. The result should be ordered by ascending customer_id.
*/
SELECT c.Customer_Name
		,c.City AS Customer_City
		,c.Grade
		,s.Name AS Salesman_Name
		,s.city AS Salesman_City
FROM [dbo].[Customer$] AS c
JOIN [dbo].[Salesman$] AS s
ON c.Salesman_ID = s.Salesman_id
WHERE c.Grade < 300
ORDER BY c.Customer_id asc

/*
10. Write a SQL statement to make a report with customer name, city, order number, order date, and order amount in ascending order according to the order date to determine whether any of the existing customers have placed an order or not.
*/
SELECT c.Customer_Name,
		c.City AS Customer_City,
		o.[Order Number],
		o.[Order Date],
		o.Purchase_Amount AS [Order Amount],
		CASE
			WHEN o.[Order Date] IS NOT NULL
			THEN 'Yes'
		ELSE 'No'
		END [Has Placed Order]
FROM [dbo].[Customer$] AS c
LEFT JOIN [dbo].[Order$] AS o
ON c.Customer_ID = o.[Customer ID]
ORDER BY o.[Order Date] ASC

/*
11. SQL statement to generate a report with customer name, city, order number, order date, order amount, salesperson name, and commission to determine if any of the existing customers have not placed orders or if they have placed orders through their salesman or by themselves.
*/

SELECT c.Customer_Name,
		c.City AS Customer_City,
		o.[Order Number],
		o.[Order Date],
		o.Purchase_Amount AS [Order Amount],
		s.Name AS Salesman_Name,
		s.commission AS Commission,
		CASE
			WHEN o.[Order Date] IS NOT NULL
			THEN 'Yes'
		ELSE 'No'
		END [Has Placed Order],
		CASE
			WHEN o.Salesman_id IS NOT NULL
			THEN 'Yes'
		ELSE 'No'
		END [Placed Order Through Salesman]
FROM [dbo].[Customer$] AS c
LEFT JOIN [dbo].[Order$] AS o
ON c.Customer_ID = o.[Customer ID]
LEFT JOIN [dbo].[Salesman$] AS s
ON c.Salesman_ID = s.Salesman_id


/*
12. Write a SQL statement to generate a list in ascending order of salespersons who work either for one or more customers or have not yet joined any of the customers.
*/
SELECT  DISTINCT s.Salesman_id,
		s.Name AS [Salesman's Name],
		s.city AS [Salesman's City],
		s.commission Commission
FROM [dbo].[Salesman$] AS s
LEFT JOIN [dbo].[Customer$] AS c
ON s.Salesman_id = c.Salesman_ID
ORDER BY s.Name ASC

/*
13. write a SQL query to list all salespersons along with customer name, city, grade, order number, date, and amount.
*/
SELECT  s.Salesman_id,
		s.Name AS [Salesman's Name],
		s.city AS [Salesman's City],
		s.commission Commission,
		c.Customer_Name,
		c.City [Customer's City],
		c.Grade,
		o.[Order Number],
		o.[Order Date],
		o.Purchase_Amount [Order Amount]
FROM [dbo].[Salesman$] AS s
LEFT JOIN [dbo].[Customer$] AS c
ON s.Salesman_id = c.Salesman_ID
LEFT JOIN [dbo].[Order$] AS o
ON o.Salesman_ID = s.Salesman_id

/*
14. Write a SQL statement to make a list for the salesmen who either work for one or more customers or yet to join any of the customer. The customer may have placed, either one or more orders on or above order amount 2000 and must have a grade, or he may not have placed any order to the associated supplier.
*/
/*SELECT  DISTINCT s.Salesman_id,
		s.Name AS [Salesman's Name],
		s.city AS [Salesman's City],
		s.commission Commission
FROM [dbo].[Salesman$] AS s
LEFT JOIN [dbo].[Customer$] AS c
ON s.Salesman_id = c.Salesman_ID
WHERE (SELECT c.Customer_ID,
		c.Customer_Name,
		COUNT(o.[Order Number]) AS [Count Of Order],
		SUM(o.Purchase_Amount) AS [Sum Of Order Amount]
FROM [dbo].[Customer$] AS c
LEFT JOIN [dbo].[Order$] AS o
ON c.Customer_ID = o.[Customer ID]
GROUP BY c.Customer_ID, c.Customer_Name
HAVING COUNT(o.[Order Number]) >= 1
OR SUM(o.Purchase_Amount) >2000
)*/


SELECT DISTINCT s.Salesman_id,
		s.Name AS [Salesman's Name],
		s.City AS [Salesman's City],
		s.Commission
FROM [dbo].[Salesman$] AS s
LEFT JOIN [dbo].[Customer$] AS c
ON s.Salesman_id = c.Salesman_ID
LEFT JOIN [dbo].[Order$] AS o
ON c.Customer_ID = o.[Customer ID]
GROUP BY s.Salesman_id,
			s.Name,
			s.City,
			s.Commission,
			c.Customer_ID,
			c.Grade
HAVING c.Customer_ID IS NULL  -- salesman with no customers
OR (c.Grade IS NOT NULL  -- must have a grade
AND (COUNT(o.[Order Number]) >= 1
OR SUM(o.Purchase_Amount) > 2000))


/*
15. For those customers from the existing list who put one or more orders, or which orders have been placed by the customer who is not on the list, create a report containing the customer name, city, order number, order date, and purchase amount
*/

SELECT c.Customer_Name,
		c.City AS [Customer City],
		o.[Order Number],
		o.[Order Date],
		COUNT(o.[Order Number]) AS [Count of Order],
		o.Purchase_Amount [Order Amount]
FROM [dbo].[Salesman$] AS s
LEFT JOIN [dbo].[Customer$] AS c
ON s.Salesman_id = c.Salesman_ID
LEFT JOIN [dbo].[Order$] AS o
ON c.Customer_ID = o.[Customer ID]
GROUP BY c.Customer_Name,
			c.City,
			o.[Order Number],
			o.[Order Date],
			o.Purchase_Amount,
			o.Salesman_id
HAVING o.Salesman_ID IS NULL  -- customers with no salesman
OR COUNT(o.[Order Number]) >= 1


/*
16. Write a SQL statement to generate a report with the customer name, city, order no. order date, purchase amount for only those customers on the list who must have a grade and placed one or more orders or which order(s) have been placed by the customer who neither is on the list nor has a grade.
*/

SELECT c.Customer_Name,
		c.City [Customer City],
		o.[Order Number],
		o.[Order Date],
		o.Purchase_Amount [Order Amount],
		s.Name AS [Salesman Name],
		s.commission 
FROM [dbo].[Customer$] AS c
LEFT JOIN [dbo].[Salesman$] AS s
ON c.Salesman_ID = s.Salesman_id
LEFT JOIN [dbo].[Order$] AS o
ON o.Salesman_id = s.Salesman_id

/*
17. Write a SQL query to combine each row of the salesman table with each row of the customer table.
*/
SELECT s.Salesman_id,
		s.Name [Salesman Name],
		s.city [Salesman City],
		s.commission,
		c.Customer_ID,
		c.Customer_Name,
		c.City [Customer City],
		c.Grade
FROM [dbo].[Salesman$] AS s
CROSS JOIN [dbo].[Customer$] AS c


/*
18. Write a SQL statement to create a Cartesian product between salesperson and customer, i.e. each salesperson will appear for all customers and vice versa for that salesperson who belongs to that city.
*/

SELECT s.Salesman_id,
		s.Name [Salesman Name],
		s.city [Salesman City],
		s.commission,
		c.Customer_ID,
		c.Customer_Name,
		c.City [Customer City],
		c.Grade
FROM [dbo].[Salesman$] AS s
CROSS JOIN [dbo].[Customer$] AS c
WHERE s.city = c.City


/*
19. Write a SQL statement to create a Cartesian product between salesperson and customer, i.e. each salesperson will appear for every customer and vice versa for those salesmen who belong to a city and customers who require a grade.
*/

SELECT s.Salesman_id,
		s.Name [Salesman Name],
		s.city [Salesman City],
		s.commission,
		c.Customer_ID,
		c.Customer_Name,
		c.City [Customer City],
		c.Grade
FROM [dbo].[Salesman$] AS s
CROSS JOIN [dbo].[Customer$] AS c
WHERE s.city = c.City
AND c.Grade IS NOT NULL

/*
20. Write a SQL statement to make a Cartesian product between salesman and customer i.e. each salesman will appear for all customers and vice versa for those salesmen who must belong to a city which is not the same as his customer and the customers should have their own grade.
*/

SELECT s.Salesman_id,
		s.Name [Salesman Name],
		s.city [Salesman City],
		s.commission,
		c.Customer_ID,
		c.Customer_Name,
		c.City [Customer City],
		c.Grade
FROM [dbo].[Salesman$] AS s
CROSS JOIN [dbo].[Customer$] AS c
WHERE s.city != c.City
AND c.Grade IS NOT NULL










