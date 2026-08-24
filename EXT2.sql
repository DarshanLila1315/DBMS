CREATE TABLE Employee1
(
 EmpID INT PRIMARY KEY,
 EmpName VARCHAR(50),
 Department VARCHAR(30),
 DesignaƟon VARCHAR(30),
 Salary INT,
 Gender CHAR(1),
 City VARCHAR(30),
 JoiningYear INT
)

INSERT INTO Employee1 VALUES
(101,'Amit','IT','Developer',70000,'M','Rajkot',2021),
(102,'Neha','IT','Developer',65000,'F','Rajkot',2022),
(103,'Rahul','IT','Tester',120000,'M','Rajkot',2023),
(104,'Pooja','IT','Tester',60000,'F','Rajkot',2021),
(105,'Kiran','HR','Manager',90000,'M','Ahmedabad',2019),
(106,'Rita','HR','ExecuƟve',30000,'F','Ahmedabad',2020),
(107,'Vikas','HR','ExecuƟve',35000,'M','Ahmedabad',2022),
(108,'Sneha','Sales','ExecuƟve',25000,'F','Surat',2020),
(109,'Ajay','Sales','ExecuƟve',55000,'M','Surat',2021),
(110,'Nidhi','Sales','Manager',95000,'F','Surat',2022),
(111,'Jay','Sales','ExecuƟve',45000,'M','Surat',2023),
(112,'Mehul','Finance','Accountant',50000,'M','Vadodara',2021),
(113,'Rina','Finance','Accountant',50000,'F','Vadodara',2022),
(114,'Sagar','Finance','Manager',100000,'M','Vadodara',2023),
(115,'Anita','Support','Engineer',42000,'F','Rajkot',2020),
(116,'Rakesh','Support','Engineer',43000,'M','Rajkot',2021),
(117,'Priya','Support','Lead',45000,'F','Rajkot',2022),
(118,'Manish','MarkeƟng','ExecuƟve',65000,'M','Ahmedabad',2020),
(119,'Komal','MarkeƟng','ExecuƟve',70000,'F','Ahmedabad',2021),
(120,'Nilesh','MarkeƟng','Manager',75000,'M','Ahmedabad',2022),
(121,'Bhavesh','Admin','Officer',41000,'M','Surat',2020),
(122,'Sejal','Admin','Officer',42000,'F','Surat',2021),
(123,'Hardik','Admin','Manager',80000,'M','Surat',2022),
(124,'Krupa','Admin','Officer',45000,'F','Surat',2023),
(125,'Yash','IT','Developer',80000,'M','Ahmedabad',2022),
(126,'Heena','IT','Developer',85000,'F','Ahmedabad',2023),
(127,'Milan','Sales','ExecuƟve',60000,'M','Ahmedabad',2022),
(128,'Dhara','Finance','Accountant',55000,'F','Ahmedabad',2023);

--Departments with at least 3 employees where the average salary is greater than 60,000 
SELECT Department 
FROM Employee1 
GROUP BY Department 
HAVING COUNT(EmpID) >= 3 AND AVG(Salary) > 60000;

--Show each city where the highest salary is greater than 90,000 and the lowest salary is less than 30,000
SELECT City 
FROM Employee1 
GROUP BY City 
HAVING MAX(Salary) > 90000 AND MIN(Salary) < 30000;

--Find departments where the difference between the highest and lowest salary is more than 50,000 
SELECT Department 
FROM Employee1 
GROUP BY Department 
HAVING (MAX(Salary) - MIN(Salary)) > 50000;

--Show department and designaƟon combinaƟons having more than 2 employees and total salary greater than 2,00,000 
SELECT Department, DesignaƟon 
FROM Employee1 
GROUP BY Department, DesignaƟon 
HAVING COUNT(EmpID) > 2 AND SUM(Salary) > 200000;

--Show departments where the average salary is between 50,000 and 80,000 and the maximum salary is at least twice the minimum salary
SELECT Department 
FROM Employee1 
GROUP BY Department 
HAVING AVG(Salary) BETWEEN 50000 AND 80000 
   AND MAX(Salary) >= 2 * MIN(Salary);

--Show departments where all employees earn more than ₹40,000. 
SELECT Department 
FROM Employee1 
GROUP BY Department 
HAVING MIN(Salary) > 40000;

--Show ciƟes having employees from at least 3 different departments.
SELECT City 
FROM Employee1 
GROUP BY City 
HAVING COUNT(DISTINCT Department) >= 3;

--Show departments where the total salary is greater than ₹5,00,000 and there are employees of both genders. 
SELECT Department 
FROM Employee1 
GROUP BY Department 
HAVING SUM(Salary) > 500000 
   AND COUNT(DISTINCT Gender) = 2;

--Show joining years where more than 5 employees joined and the average salary is less than ₹55,000
SELECT JoiningYear 
FROM Employee1 
GROUP BY JoiningYear 
HAVING COUNT(EmpID) > 5 AND AVG(Salary) < 55000;

--Show department and city combinaƟons where: At least 4 employees work, The average salary is above ₹60,000, The highest salary is below ₹1,20,000
SELECT Department, City 
FROM Employee1 
GROUP BY Department, City 
HAVING COUNT(EmpID) >= 4 
   AND AVG(Salary) > 60000 
   AND MAX(Salary) < 120000;

--Find departments where all employees joined in or aŌer 2020.
SELECT Department 
FROM Employee1 
GROUP BY Department 
HAVING MIN(JoiningYear) >= 2020;

--Show ciƟes where every employee has a unique salary (no duplicate salary within the city).
SELECT City 
FROM Employee1 
GROUP BY City 
HAVING COUNT(Salary) = COUNT(DISTINCT Salary);



