USE Online_Bookstore;


SELECT COUNT(*) FROM books;
SELECT * FROM customers;
SELECT * FROM orders;

DESC orders;  

-- 1) Retrieve all books in the "Fiction" genre 
SELECT * FROM books
where Genre = 'Fiction';

-- 2) Find books published after the year 1950
SELECT * FROM books
where Published_Year >1950;

-- 3) List all customers from the Canada
SELECT * FROM customers
where Country = 'Canada';

-- 4) Show orders placed in November 2023
SELECT * FROM orders
where Order_Date BETWEEN '2023-11-01' AND '2023-11-30' ;

-- 5) Retrieve the total stock of books available

SELECT SUM(Stock) as Totalstock
FROM books;


-- 6) Find the details of the most expensive book

SELECT * FROM books
ORDER BY Price DESC; 

-- 7) Show all customers who ordered more than 1 quantity of a book
SELECT * FROM orders
where Quantity > 1;





-- 8) Retrieve all orders where the total amount exceeds $20

SELECT * FROM orders
where Total_Amount > 20;


-- 9) List all genres available in the Books table

SELECT DISTINCT Genre from books;

-- 10) Find the book with the lowest stock
SELECT * FROM books
ORDER BY Stock;

-- 11) Calculate the total revenue generated from all orders

SELECT ROUND(SUM(Total_Amount),2) AS Total_revenue 
FROM orders;

-- Advance Queries
-- 1) Retrieve the total number of books sold for each genre

SELECT b.Genre,SUM(o.Quantity) AS Total_Books_Sold
from orders o
JOIN books b ON b.Book_ID = o.Book_ID
GROUP BY b.Genre;

-- 2) Find the average price of books in the "Fantasy" genre
SELECT ROUND(AVG(Price),2) as Avg_Price FROM books
where Genre = 'Fantasy';

-- 3) List customers who have placed at least 2 orders
-- SELECT c.Name,o.Quantity 
-- from orders o 
-- JOIN customers c 
-- ON c.Customer_ID = o.Customer_ID
-- HAVING o.Quantity > 2;

SELECT o.Customer_ID,c.name, COUNT(o.Order_ID) AS ORDER_COUNT
FROM orders o
JOIN customers c 
ON c.Customer_ID = o.Customer_ID
GROUP BY o.Customer_ID, c.name
HAVING COUNT(o.Order_ID)  >= 2;

-- 4) Find the most frequently ordered book

SELECT o.Book_ID,b.Title,COUNT(o.Order_ID) AS Order_Count
FROM orders o
JOIN books b 
ON b.Book_ID = o.Book_ID
GROUP BY o.Book_ID
ORDER BY Order_Count DESC 
LIMIT 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre
SELECT Title,Price FROM books
where Genre = 'Fantasy'
ORDER BY Price DESC LIMIT 3;

-- 6) Retrieve the total quantity of books sold by each author
SELECT  b.Author,sum(o.Quantity) AS Total_Books_Sold
from books b 
JOIN orders o 
ON o.Book_ID = b.Book_ID
GROUP BY b.Author;

-- 7) List the cities where customers who spent over $30 are located
SELECT * FROM books;
SELECT * FROM customers;
SELECT * FROM orders;

SELECT distinct c.City , o.Total_Amount
from orders o
JOIN customers c	
ON c.Customer_ID = o.Customer_ID
WHERE o.Total_Amount > 30;



-- 8) Find the customer who spent the most on orders

SELECT c.Customer_ID ,c.name ,ROUND(SUM(o.Total_Amount),2) AS Total_spend
FROM orders o
JOIN customers c ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID ,c.name 
ORDER BY Total_spend DESC;


-- 9) Calculate the stock remaining after fulfilling all orders
SELECT b.Book_ID,b.title,b.stock, coalesce(SUM(o.Quantity),0) AS Order_quantity,
b.stock-coalesce(SUM(o.Quantity),0) AS Remaining_Quantity
FROM books b 
LEFT JOIN orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID
ORDER BY b.Book_ID;
