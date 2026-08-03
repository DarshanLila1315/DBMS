Create Table EmployeeTable
(
EmpID INT,
EmpName VARCHAR(50) NOT NULL,
Department VARCHAR(30),
City VARCHAR(30),
Salary INT,
Experience INT,
Gender CHAR(1)
)

exec sp_rename 'EmployeeTale' , 'EmployeeTable'

Insert Into EmployeeTable Values
(1, 'Rahul', 'IT', 'Rajkot', 55000, 4, 'M'),
(2, 'Amit', 'HR', 'Ahmedabad', 45000, 3, 'M'),
(3, 'Neha', 'IT', 'Rajkot', 55000, 5, 'F'),
(4, 'Priya', 'Sales', 'Surat', 70000, 7, 'F'),
(5, 'Jay', 'IT', 'Vadodara', 35000, 2, 'M'),
(6, 'Karan', 'HR', 'Rajkot', 42000, 3, 'M'),
(7, 'Meera', 'IT', 'Surat', 80000, 8, 'F'),
(8, 'Vijay', 'Sales', 'Ahmedabad', 60000, 6, 'M'),
(9, 'Pooja', 'IT', 'Rajkot', 90000, 10, 'F'),
(10, 'Ravi', 'Finance', 'Jamnagar', 50000, 5, 'M'),
(11, 'Nisha', 'HR', 'Surat', 38000, 2, 'F'),
(12, 'Harsh', 'IT', 'Ahmedabad', 65000, 7, 'M'),
(13, 'Riya', 'Sales', 'Rajkot', 45000, 4, 'F'),
(14, 'Dhruv', 'Finance', 'Surat', 75000, 9, 'M'),
(15, 'Mihir', 'IT', 'Rajkot', 48000, 3, 'M');

Select Empname , Salary from EmployeeTable Where Salary > 60000

Select * from EmployeeTable Where Department='IT' And Salary > 60000 And Experience > 3

Select * from EmployeeTable where City = 'Rajkot' OR City = 'Ahmedabad'

Select * from EmployeeTable where City IN('Rajkot','Ahmedabad','Surat')

Select * from EmployeeTable where Department IN('IT','HR','SALES') AND Salary > 50000

Select Empname , Salary from EmployeeTable Where Salary BETWEEN 40000 AND 70000

Select * from EmployeeTable Where Salary BETWEEN 40000 AND 80000 AND Experience Between 3 and 8

Select * from EmployeeTable Where Salary BETWEEN 30000 AND 50000 OR Experience Between 10 and 15

Select * from EmployeeTable where City IN('Rajkot','Ahmedabad','Surat') AND Salary BETWEEN 40000 AND 80000

Select * from EmployeeTable where City IN('Rajkot','Ahmedabad') AND Department IN('IT','HR') AND Salary BETWEEN 50000 AND 90000

Select * from EmployeeTable where Department = 'IT' AND Salary > 70000 OR Department = 'HR' AND Salary > 50000 OR City = 'Rajkot' AND Experience > 10

Update EmployeeTable
set Salary = Salary * 2.20

Update EmployeeTable
set Salary = Salary * 1.15
where Salary < 40000

select * from EmployeeTable

Update EmployeeTable
set Salary = Salary * 2.20
where Department = 'IT' And Experience > 5 AND Salary < 60000

Update EmployeeTable
set Salary = Salary * 1.10
where Department IN('IT','HR','SALES')

Update EmployeeTable
Set Salary = Salary * 1.15
Where Salary BETWEEN 40000 AND 60000 AND Experience Between 4 and 7

Update EmployeeTable
Set City = 'Rajkot'
where City IN('Ahmedabad','Jamnagar') AND Salary > 50000

Delete From EmployeeTable
where Salary < 25000

Delete from EmployeeTable
where Department IN('HR','SALES')

Delete from EmployeeTable
where Experience between 0 and 2 AND Salary < 30000

Delete from EmployeeTable
where City IN('Rajkot' , 'Ahmedabad') And Salary < 35000
Alter Table EmployeeTable
Add Email varchar(100)

Alter Table EmployeeTable
Alter Column Empname Varchar(100)

exec sp_rename 'EmployeeTable.Empname' , 'EmployeeName'

TRUNCATE Table EmployeeTable

Drop Table EmployeeTable