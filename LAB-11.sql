--1.Write a query to display the current date & time. Label the column Today_Date. 
select GETDATE() as Today_Date
--2.Write a query to find new date after 365 day with reference to today. 
select dateAdd(day,365, GETDATE())
--Display the current date in a format that appears as may 5 1994 12:00AM.
select format(getdate(),'MMM d yyyy hh:mmtt')
--Display the current date in a format that appears as 03 Jan 1995. 
select format(getdate(),'d MMM yyyy ')
--Display the current date in a format that appears as Jan 04, 96. 
select FORMAT(GETDATE(),'MMM d,yy')
--Write a query to find out total number of months between 31-Dec-08 and 31-Mar-09. 
select DATEDIFF(MONTH,'31-Dec-08 ','31-Mar-09')
-- Write a query to find out total number of hours between 25-Jan-12 7:00 and 26-Jan-12 10:30.
select DATEDIFF(HOUR,'25-Jan-12 7:00 ','26-Jan-12 10:30')
--Write a query to extract Day, Month, Year from given date 12-May-16
SELECT DAY('2016-05-12'),MONTH('2016-05-12'), YEAR('2016-05-12')
--Write a query that adds 5 years to current date.
select dateAdd(YEAR,5, GETDATE())
--Write a query to subtract 2 months from current date
select dateAdd(MONTH,-2, GETDATE())
--Extract month from current date using datename () and datepart () function. 
select DATENAME(MONTH,GETDATE())
select DATEPART(MONTH,GETDATE())
--Write a query to find out last date of current month
select EOMONTH(GETDATE())
-- Calculate your age in years and months.
SELECT DATEDIFF(MONTH,'2007-08-02',GETDATE()),
	   DATEDIFF(YEAR,'2007-08-02',GETDATE())
--Part – B: Perform following queries on DEPOSIT table. 
-- Display all records where account date is in the year 2025.
select * from DEPOSIT where YEAR(ADATE)='2025'
-- Display all records where account date is in the month of March
select * from DEPOSIT where MONTH (ADATE)=3
--Display records where account date is after ‘01-Jan-2025’
SELECT * FROM DEPOSIT WHERE ADATE>'01-Jan-2025'
--Display records where account date is before ‘01-Jan-2025’
SELECT * FROM DEPOSIT WHERE ADATE<'01-Jan-2025'
--Display records where day of account date is 1.
SELECT * FROM DEPOSIT WHERE DAY(ADATE)=1
--Display records where month of account date is greater than 6.
SELECT * FROM DEPOSIT WHERE MONTH(ADATE)>6
--Display records where year of account date is 2026.
SELECT * FROM DEPOSIT WHERE YEAR(ADATE)=2026
-- Display number of accounts opened in each year.
SELECT YEAR(ADATE) AS OpenedYear, COUNT(*) AS TotalAccounts 
FROM DEPOSIT GROUP BY YEAR(ADATE)
-- Display number of accounts opened in each month.
SELECT MONTH(ADATE) AS OpenedYear, COUNT(*) AS TotalAccounts 
FROM DEPOSIT GROUP BY MONTH(ADATE)
--Display maximum amount deposited in each year.
SELECT YEAR(ADATE) AS Year, MAX(AMOUNT) AS MaxAmount 
FROM DEPOSIT GROUP BY YEAR(ADATE);
-- Display minimum amount deposited in each month
SELECT MONTH(ADATE) AS OpenedYear, MIN(AMOUNT) AS TotalAccounts 
FROM DEPOSIT GROUP BY MONTH(ADATE)
---Display total amount deposited in each year
SELECT YEAR(ADATE) AS Year, SUM(AMOUNT) AS TOTALAmount 
FROM DEPOSIT GROUP BY YEAR(ADATE);
-- Display records where account date is between ‘01-Mar-2025’ and ‘31-Dec-2025’
SELECT * FROM DEPOSIT WHERE ADATE BETWEEN '2025-03-01' AND '2025-12-31';
--Display records where account date is in the current year.
SELECT * FROM DEPOSIT WHERE YEAR(ADATE) = YEAR(GETDATE());
-- Display difference in days between today’s date and account date.
SELECT ADATE, DATEDIFF(DAY, ADATE, GETDATE()) AS DiffInDays 
FROM DEPOSIT;


