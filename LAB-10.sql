--Part – A:
--1. Display the result of 5 multiply by 30.

select 5*30 as multiply

--2. Find out the absolute value of -25, 25, -50 and 50.

select ABS(-25) ,
	   ABS(25),
	   ABS(-50),
	   ABS(50)

--3. Find smallest integer value that is greater than or equal to 25.2, 25.7 and -25.2.

select CEILING(25.2), CEILING(25.7), CEILING(-25.2)

--4. Find largest integer value that is smaller than or equal to 25.2, 25.7 and -25.2.

select FLOOR(25.2), FLOOR(25.7), FLOOR(-25.2)

--5. Find out remainder of 5 divided 2 and 5 divided by 3.

select 5%2, 5%3

--6. Find out value of 3 raised to 2nd power and 4 raised 3rd power.

select POWER(3, 2), POWER(4, 3)

--7. Find out the square root of 25, 30 and 50.

select SQRT(25), SQRT(30), SQRT(50)

--8. Find out the square of 5, 15, and 25.

select SQUARE(5), SQUARE(15), SQUARE(25)

--9. Find out the value of PI.

select PI()

--10. Find out round value of 157.732 for 2, 0 and -2 decimal points.

select ROUND(157.732, 2), ROUND(157.732, 0), ROUND(157.732, -2)

--11. Find out exponential value of 2 and 3.

select EXP(2), EXP(3)

--12. Find out logarithm having base e of 10 and 2.

select LOG(10), LOG(2)

--13. Find logarithm base 10 of 5 and 100

select LOG10(5), LOG10(100)

--14. Find sine, cosine and tangent of 3.1415.

select SIN(3.1415), COS(3.1415), TAN(3.1415)

--15. Find sign of -25, 0 and 25.

select SIGN(-25), SIGN(0), SIGN(25)

--16. Generate random number using function.

select RAND()

--String functions
--Part – A:
--1. Find the length of following. (I) NULL (II) ‘ hello ’ (III) Blank

select LEN(NULL), LEN(' hello '), LEN('')

--2. Display your name in lower & upper case.

select LOWER('Name'), UPPER('Name')

--3. Display first three characters of your name.

select LEFT('Name', 3)

--4. Display 3rd to 10th character of your name.

select SUBSTRING('FirstName LastName', 3, 8)

--5. Write a query to convert ‘abc123efg’ to ‘abcXYZefg’ & ‘abcabcabc’ to ‘ab5ab5ab5’ using REPLACE.

select REPLACE('abc123efg', '123', 'XYZ'), REPLACE('abcabcabc', 'c', '5')

--6. Write a query to display ASCII code for ‘a’,’A’,’z’,’Z’, 0, 9.

select ASCII('a'), ASCII('A'), ASCII('z'), ASCII('Z'), ASCII('0'), ASCII('9')

--7. Write a query to display character based on number 97, 65,122,90,48,57.

select CHAR(97), CHAR(65), CHAR(122), CHAR(90), CHAR(48), CHAR(57)

--8. Write a query to remove spaces from left of a given string ‘hello world ‘.

select LTRIM('  hello world ')

--9. Write a query to remove spaces from right of a given string ‘ hello world ‘.

select RTRIM(' hello world  ')

--10. Write a query to display first 4 & Last 5 characters of ‘SQL Server’.

select LEFT('SQL Server', 4), RIGHT('SQL Server', 5)

--11. Write a query to convert a string ‘1234.56’ to number (Use cast and convert function).

select CAST('1234.56' AS FLOAT), CONVERT(FLOAT, '1234.56')

--12. Write a query to convert a float 10.58 to integer (Use cast and convert function).

select CAST(10.58 AS INT), CONVERT(INT, 10.58)

--13. Put 10 space before your name using function.

select SPACE(10) + 'Name'

--14. Combine two strings using + sign as well as CONCAT ().

select 'Hello' + ' World', CONCAT('Hello', ' World')

--15. Find reverse of “Darshan”.

select REVERSE('Darshan')

--16. Repeat your name 3 times.

select REPLICATE('Name', 3)

--Part – B: Perform following queries on EMPLOYEE table.
--17. Display FIRSTNAME and LASTNAME in lowercase and uppercase.

select LOWER(FIRSTNAME), UPPER(FIRSTNAME), LOWER(LASTNAME), UPPER(LASTNAME) FROM EMPLOYEE;

--18. Display full name by combining FIRSTNAME and LASTNAME.

select CONCAT(FIRSTNAME, ' ', LASTNAME) FROM EMPLOYEE;

--19. Display FIRSTNAME with first 3 characters only.

select LEFT(FIRSTNAME, 3) FROM EMPLOYEE;

--20. Display LASTNAME with last 2 characters only.

select RIGHT(LASTNAME, 2) FROM EMPLOYEE;

--21. Display length of each employee’s FIRSTNAME.

select LEN(FIRSTNAME) FROM EMPLOYEE;

--22. Display FIRSTNAME after replacing ‘A’ with ‘@’.

select REPLACE(FIRSTNAME, 'A', '@') FROM EMPLOYEE;

--23. Display FIRSTNAME and LASTNAME with - between them using CONCAT.

select CONCAT(FIRSTNAME, '-', LASTNAME) FROM EMPLOYEE;

--Part – C: Perform following queries on EMPLOYEE table.
--24. Display FIRSTNAME without first and last character.

select SUBSTRING(FIRSTNAME, 2, LEN(FIRSTNAME) - 2) FROM EMPLOYEE;

--25. Display FIRSTNAME after replacing vowels with '*'.

select REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(FIRSTNAME, 'A', '*'), 'E', '*'), 'I', '*'), 'O', '*'), 'U', '*') FROM EMPLOYEE;

--26. Display employees where combined length of FIRSTNAME and LASTNAME is greater than 10.

select * FROM EMPLOYEE WHERE (LEN(FIRSTNAME) + LEN(LASTNAME)) > 10;

--27. Display FIRSTNAME and its reverse.

select FIRSTNAME, REVERSE(FIRSTNAME) FROM EMPLOYEE;

--28. Display employees whose FIRSTNAME and LASTNAME start with same character using LEFT()

select * FROM EMPLOYEE WHERE LEFT(FIRSTNAME, 1) = LEFT(LASTNAME, 1);
