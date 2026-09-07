-- Part – A:
-- 1. Combine information from Person and Department table using cross join (Cartesian product).

SELECT * FROM PERSON CROSS JOIN DEPARTMENT;

-- 2. Find all persons with their department name

SELECT P.PERSONID, P.PERSONNAME, D.DEPARTMENTNAME
FROM PERSON P
LEFT JOIN DEPARTMENT D ON P.DEPARTMENTID = D.DEPARTMENTID;

-- 3. Find all persons with their department name & code.

SELECT P.PERSONID, P.PERSONNAME, D.DEPARTMENTNAME, D.DEPARTMENTCODE
FROM PERSON P
LEFT JOIN DEPARTMENT D ON P.DEPARTMENTID = D.DEPARTMENTID;

-- 4. Find all persons with their department code and location.

SELECT P.PERSONID, P.PERSONNAME, D.DEPARTMENTCODE, D.LOCATION
FROM PERSON P
LEFT JOIN DEPARTMENT D ON P.DEPARTMENTID = D.DEPARTMENTID;

-- 5. Find the detail of the person who belongs to Mechanical department.

SELECT P.*
FROM PERSON P
JOIN DEPARTMENT D ON P.DEPARTMENTID = D.DEPARTMENTID
WHERE D.DEPARTMENTNAME = 'MECHANICAL';

-- 6. Person’s name, department code and salary who lives in Ahmedabad city.

SELECT P.PERSONNAME, D.DEPARTMENTCODE, P.SALARY
FROM PERSON P
LEFT JOIN DEPARTMENT D ON P.DEPARTMENTID = D.DEPARTMENTID
WHERE UPPER(P.CITY) = 'AHMEDABAD';

-- 7. Find the person's name whose department is in C-Block.

SELECT P.PERSONNAME
FROM PERSON P
JOIN DEPARTMENT D ON P.DEPARTMENTID = D.DEPARTMENTID
WHERE UPPER(D.LOCATION) = 'C-BLOCK';

-- 8. Retrieve person name, salary & department name who belongs to Jamnagar city.

SELECT P.PERSONNAME, P.SALARY, D.DEPARTMENTNAME
FROM PERSON P
LEFT JOIN DEPARTMENT D ON P.DEPARTMENTID = D.DEPARTMENTID
WHERE UPPER(P.CITY) = 'JAMNAGAR';

-- 9. Retrieve person’s detail who joined the Civil department after 1-Aug-2001.

SELECT P.*
FROM PERSON P
JOIN DEPARTMENT D ON P.DEPARTMENTID = D.DEPARTMENTID
WHERE D.DEPARTMENTNAME = 'CIVIL'
  AND P.JOININGDATE > '2001-08-01';

-- 10. Display all the person's name with the department whose joining date difference with the current date is more than 25 years.

SELECT P.PERSONNAME, D.DEPARTMENTNAME, DATEDIFF(YEAR, P.JOININGDATE, GETDATE()) AS YearsWithCompany
FROM PERSON P
LEFT JOIN DEPARTMENT D ON P.DEPARTMENTID = D.DEPARTMENTID
WHERE DATEDIFF(YEAR, P.JOININGDATE, GETDATE()) > 25;

-- 11. Find department wise person counts.

SELECT D.DEPARTMENTNAME, COUNT(P.PERSONID) AS PersonCount
FROM DEPARTMENT D
LEFT JOIN PERSON P ON D.DEPARTMENTID = P.DEPARTMENTID
GROUP BY D.DEPARTMENTNAME;

-- 12. Give department wise maximum & minimum salary with department name.

SELECT D.DEPARTMENTNAME, MAX(P.SALARY) AS MaxSalary, MIN(P.SALARY) AS MinSalary
FROM DEPARTMENT D
LEFT JOIN PERSON P ON D.DEPARTMENTID = P.DEPARTMENTID
GROUP BY D.DEPARTMENTNAME;

-- 13. Find city wise total, average, maximum and minimum salary.

SELECT P.CITY,
       SUM(P.SALARY) AS TotalSalary,
       AVG(P.SALARY) AS AvgSalary,
       MAX(P.SALARY) AS MaxSalary,
       MIN(P.SALARY) AS MinSalary
FROM PERSON P
GROUP BY P.CITY;

-- 14. Find the average salary of a person who belongs to Ahmedabad city.

SELECT AVG(SALARY) AS AvgSalary_Ahmedabad
FROM PERSON
WHERE UPPER(CITY) = 'AHMEDABAD';

-- 15. Produce Output Like: <PersonName> lives in <City> and works in <DepartmentName> Department. (In single column)

SELECT CONCAT(P.PERSONNAME, ' lives in ', P.CITY, ' and works in ', COALESCE(D.DEPARTMENTNAME, 'No Department'), ' Department.') AS Info
FROM PERSON P
LEFT JOIN DEPARTMENT D ON P.DEPARTMENTID = D.DEPARTMENTID;

-- Part – B:
-- 16. Produce Output Like: <PersonName> earns <Salary> from <DepartmentName> department monthly. (In single column)

SELECT CONCAT(P.PERSONNAME, ' earns ', FORMAT(P.SALARY, 'N2'), ' from ', COALESCE(D.DEPARTMENTNAME, 'No Department'), ' department monthly.') AS Info
FROM PERSON P
LEFT JOIN DEPARTMENT D ON P.DEPARTMENTID = D.DEPARTMENTID;

-- 17. Find city & department wise total, average & maximum salaries.

SELECT P.CITY, D.DEPARTMENTNAME,
       SUM(P.SALARY) AS TotalSalary,
       AVG(P.SALARY) AS AvgSalary,
       MAX(P.SALARY) AS MaxSalary
FROM PERSON P
LEFT JOIN DEPARTMENT D ON P.DEPARTMENTID = D.DEPARTMENTID
GROUP BY P.CITY, D.DEPARTMENTNAME;

-- 18. Find all persons who do not belong to any department.

SELECT * FROM PERSON WHERE DEPARTMENTID IS NULL;

-- 19. Find all departments whose total salary is exceeding 100000.

SELECT D.DEPARTMENTNAME, SUM(P.SALARY) AS TotalSalary
FROM DEPARTMENT D
LEFT JOIN PERSON P ON D.DEPARTMENTID = P.DEPARTMENTID
GROUP BY D.DEPARTMENTNAME
HAVING SUM(P.SALARY) > 100000;

-- Part – C:
-- 20. List all departments who have no person.

SELECT D.DEPARTMENTNAME
FROM DEPARTMENT D
LEFT JOIN PERSON P ON D.DEPARTMENTID = P.DEPARTMENTID
WHERE P.PERSONID IS NULL;

-- 21. List out department names in which more than two persons are working.

SELECT D.DEPARTMENTNAME, COUNT(P.PERSONID) AS PersonCount
FROM DEPARTMENT D
JOIN PERSON P ON D.DEPARTMENTID = P.DEPARTMENTID
GROUP BY D.DEPARTMENTNAME
HAVING COUNT(P.PERSONID) > 2;

-- 22. Give a 10% increment in the computer department employee’s salary. (Use Update)

UPDATE PERSON
SET SALARY = ROUND(SALARY * 1.10, 2)
WHERE DEPARTMENTID = (SELECT DEPARTMENTID FROM DEPARTMENT WHERE DEPARTMENTNAME = 'COMPUTER');

