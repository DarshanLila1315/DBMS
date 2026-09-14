-- 1. List all books with their authors.

SELECT B.BOOKID, B.TITLE, A.AUTHORNAME
FROM BOOK B
LEFT JOIN AUTHOR A ON B.AUTHORID = A.AUTHORID;

-- 2. List all books with their publishers.
SELECT B.BOOKID, B.TITLE, P.PUBLISHERNAME
FROM BOOK B
LEFT JOIN PUBLISHER P ON B.PUBLISHERID = P.PUBLISHERID;

-- 3. List all books with their authors and publishers.
SELECT B.BOOKID, B.TITLE, A.AUTHORNAME, P.PUBLISHERNAME
FROM BOOK B
LEFT JOIN AUTHOR A ON B.AUTHORID = A.AUTHORID
LEFT JOIN PUBLISHER P ON B.PUBLISHERID = P.PUBLISHERID;

-- 4. List all books published after 2010 with their authors and publisher and price.
SELECT B.BOOKID, B.TITLE, A.AUTHORNAME, P.PUBLISHERNAME, B.PRICE, B.PUBLICATIONYEAR
FROM BOOK B
LEFT JOIN AUTHOR A ON B.AUTHORID = A.AUTHORID
LEFT JOIN PUBLISHER P ON B.PUBLISHERID = P.PUBLISHERID
WHERE B.PUBLICATIONYEAR > 2010
ORDER BY B.PUBLICATIONYEAR;

-- 5. List all authors and the number of books they have written.
SELECT A.AUTHORID, A.AUTHORNAME, COUNT(B.BOOKID) AS BookCount
FROM AUTHOR A
LEFT JOIN BOOK B ON A.AUTHORID = B.AUTHORID
GROUP BY A.AUTHORID, A.AUTHORNAME;

-- 6. List all publishers and the total price of books they have published.
SELECT P.PUBLISHERID, P.PUBLISHERNAME, SUM(B.PRICE) AS TotalPrice
FROM PUBLISHER P
LEFT JOIN BOOK B ON P.PUBLISHERID = B.PUBLISHERID
GROUP BY P.PUBLISHERID, P.PUBLISHERNAME;

-- 7. List authors who have not written any books.
SELECT A.AUTHORID, A.AUTHORNAME
FROM AUTHOR A
LEFT JOIN BOOK B ON A.AUTHORID = B.AUTHORID
WHERE B.BOOKID IS NULL;

-- 8. Display the total number of books written by each author along with the average price of their books.
SELECT A.AUTHORNAME, COUNT(B.BOOKID) AS BookCount, AVG(B.PRICE) AS AvgPrice
FROM AUTHOR A
LEFT JOIN BOOK B ON A.AUTHORID = B.AUTHORID
GROUP BY A.AUTHORNAME;

-- 9. List each publisher along with the total number of books they have published, sorted from highest to lowest.
SELECT P.PUBLISHERNAME, COUNT(B.BOOKID) AS BookCount
FROM PUBLISHER P
LEFT JOIN BOOK B ON P.PUBLISHERID = B.PUBLISHERID
GROUP BY P.PUBLISHERNAME
ORDER BY BookCount DESC;

-- 10. Display number of books published each year.
SELECT B.PUBLICATIONYEAR, COUNT(*) AS BooksPublished
FROM BOOK B
GROUP BY B.PUBLICATIONYEAR
ORDER BY B.PUBLICATIONYEAR;

-- 11. List publishers whose total book prices exceed 500, ordered by the total price.
SELECT P.PUBLISHERID, P.PUBLISHERNAME, SUM(B.PRICE) AS TotalPrice
FROM PUBLISHER P
JOIN BOOK B ON P.PUBLISHERID = B.PUBLISHERID
GROUP BY P.PUBLISHERID, P.PUBLISHERNAME
HAVING SUM(B.PRICE) > 500
ORDER BY TotalPrice;

-- 12. Most expensive book for each author, sorted by highest price (author, book, price).
WITH RankedBooks AS
(
  SELECT A.AUTHORID, A.AUTHORNAME, B.BOOKID, B.TITLE, B.PRICE,
         ROW_NUMBER() OVER (PARTITION BY A.AUTHORID ORDER BY B.PRICE DESC) AS rn
  FROM AUTHOR A
  JOIN BOOK B ON A.AUTHORID = B.AUTHORID
)
SELECT AUTHORID, AUTHORNAME, BOOKID, TITLE, PRICE
FROM RankedBooks
WHERE rn = 1
ORDER BY PRICE DESC;

-- 13. Publisher name and difference between maximum and minimum book price.
SELECT P.PUBLISHERNAME,
       (MAX(B.PRICE) - MIN(B.PRICE)) AS PriceDifference
FROM PUBLISHER P
JOIN BOOK B ON P.PUBLISHERID = B.PUBLISHERID
GROUP BY P.PUBLISHERNAME;

-- 14. Publisher name and total price of books published each year.
SELECT P.PUBLISHERNAME, B.PUBLICATIONYEAR, SUM(B.PRICE) AS TotalPriceByYear
FROM PUBLISHER P
JOIN BOOK B ON P.PUBLISHERID = B.PUBLISHERID
GROUP BY P.PUBLISHERNAME, B.PUBLICATIONYEAR
ORDER BY P.PUBLISHERNAME, B.PUBLICATIONYEAR;

-- 15. Author name and total price of books, sorted by highest total price.
SELECT A.AUTHORNAME, SUM(B.PRICE) AS TotalPrice
FROM AUTHOR A
JOIN BOOK B ON A.AUTHORID = B.AUTHORID
GROUP BY A.AUTHORNAME
ORDER BY TotalPrice DESC;

-- 16. Employee name with their manager's name
SELECT e.EmployeeNo, e.Name AS EmployeeName, m.Name AS ManagerName
FROM EMPLOYEE_MASTER e
LEFT JOIN EMPLOYEE_MASTER m ON e.ManagerNo = m.EmployeeNo;

-- 17. Employees who are managers (appear as a ManagerNo for someone)
SELECT DISTINCT m.EmployeeNo, m.Name
FROM EMPLOYEE_MASTER m
JOIN EMPLOYEE_MASTER e ON e.ManagerNo = m.EmployeeNo;

-- 18. Number of employees working under each manager (direct reports)
SELECT m.EmployeeNo AS ManagerNo, m.Name AS ManagerName, COUNT(e.EmployeeNo) AS DirectReports
FROM EMPLOYEE_MASTER m
LEFT JOIN EMPLOYEE_MASTER e ON e.ManagerNo = m.EmployeeNo
GROUP BY m.EmployeeNo, m.Name;

-- 19. Employee name with their manager and senior manager names
SELECT e.EmployeeNo, e.Name AS EmployeeName,
       m.EmployeeNo AS ManagerNo, m.Name AS ManagerName,
       sm.EmployeeNo AS SeniorManagerNo, sm.Name AS SeniorManagerName
FROM EMPLOYEE_MASTER e
LEFT JOIN EMPLOYEE_MASTER m  ON e.ManagerNo = m.EmployeeNo
LEFT JOIN EMPLOYEE_MASTER sm ON m.ManagerNo = sm.EmployeeNo;

-- 20. Managers and count of employees under them, sorted descending
SELECT m.EmployeeNo AS ManagerNo, m.Name AS ManagerName, COUNT(e.EmployeeNo) AS DirectReports
FROM EMPLOYEE_MASTER m
LEFT JOIN EMPLOYEE_MASTER e ON e.ManagerNo = m.EmployeeNo
GROUP BY m.EmployeeNo, m.Name
HAVING COUNT(e.EmployeeNo) > 0
ORDER BY DirectReports DESC;
