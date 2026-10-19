-- 1. Fetch and display every employee
DECLARE @EID INT,@FN VARCHAR(50),@LN VARCHAR(50),@Dept VARCHAR(50),
        @Sal DECIMAL(10,2),@City VARCHAR(50),@Gender VARCHAR(20),@Year INT;
DECLARE Employee_Cursor CURSOR LOCAL FAST_FORWARD FOR
 SELECT EID,FIRSTNAME,LASTNAME,DEPARTMENT,SALARY,CITY,GENDER,JOININGYEAR FROM dbo.EMPLOYEE;
OPEN Employee_Cursor;
FETCH NEXT FROM Employee_Cursor INTO @EID,@FN,@LN,@Dept,@Sal,@City,@Gender,@Year;
WHILE @@FETCH_STATUS=0
BEGIN
 PRINT CONCAT(@EID,' ',@FN,' ',@LN,' | ',COALESCE(@Dept,'NULL'),' | ',@Sal,' | ',COALESCE(@City,'NULL'));
 FETCH NEXT FROM Employee_Cursor INTO @EID,@FN,@LN,@Dept,@Sal,@City,@Gender,@Year;
END;
CLOSE Employee_Cursor; DEALLOCATE Employee_Cursor;
GO

-- 2. Display all female employees
DECLARE @FemaleName VARCHAR(120),@FemaleCity VARCHAR(50);
DECLARE Female_Cursor CURSOR LOCAL FAST_FORWARD FOR
 SELECT CONCAT(FIRSTNAME,' ',LASTNAME),CITY FROM dbo.EMPLOYEE WHERE GENDER='FEMALE';
OPEN Female_Cursor;
FETCH NEXT FROM Female_Cursor INTO @FemaleName,@FemaleCity;
WHILE @@FETCH_STATUS=0
BEGIN PRINT CONCAT(@FemaleName,' - ',COALESCE(@FemaleCity,'NULL'));
 FETCH NEXT FROM Female_Cursor INTO @FemaleName,@FemaleCity; END;
CLOSE Female_Cursor; DEALLOCATE Female_Cursor;
GO

-- 3. EID_FirstName_LastName format
DECLARE @EmpID3 INT,@First3 VARCHAR(50),@Last3 VARCHAR(50);
DECLARE Employee_Cursor_Fetch CURSOR LOCAL FAST_FORWARD FOR
 SELECT EID,FIRSTNAME,LASTNAME FROM dbo.EMPLOYEE;
OPEN Employee_Cursor_Fetch;
FETCH NEXT FROM Employee_Cursor_Fetch INTO @EmpID3,@First3,@Last3;
WHILE @@FETCH_STATUS=0
BEGIN PRINT CONCAT(@EmpID3,'_',@First3,'_',@Last3);
 FETCH NEXT FROM Employee_Cursor_Fetch INTO @EmpID3,@First3,@Last3; END;
CLOSE Employee_Cursor_Fetch; DEALLOCATE Employee_Cursor_Fetch;
GO

-- 4. Employees with salary > 12000
DECLARE @Name4 VARCHAR(120),@Salary4 DECIMAL(10,2);
DECLARE Salary_Cursor CURSOR LOCAL FAST_FORWARD FOR
 SELECT CONCAT(FIRSTNAME,' ',LASTNAME),SALARY FROM dbo.EMPLOYEE WHERE SALARY>12000;
OPEN Salary_Cursor; FETCH NEXT FROM Salary_Cursor INTO @Name4,@Salary4;
WHILE @@FETCH_STATUS=0
BEGIN PRINT CONCAT(@Name4,' salary = ',@Salary4);
 FETCH NEXT FROM Salary_Cursor INTO @Name4,@Salary4; END;
CLOSE Salary_Cursor; DEALLOCATE Salary_Cursor;
GO

-- 5. Employees joined in 2022 or later
DECLARE @Name5 VARCHAR(120),@Year5 INT;
DECLARE Joining_Cursor CURSOR LOCAL FAST_FORWARD FOR
 SELECT CONCAT(FIRSTNAME,' ',LASTNAME),JOININGYEAR FROM dbo.EMPLOYEE WHERE JOININGYEAR>=2022;
OPEN Joining_Cursor; FETCH NEXT FROM Joining_Cursor INTO @Name5,@Year5;
WHILE @@FETCH_STATUS=0
BEGIN PRINT CONCAT(@Name5,' joined in ',@Year5);
 FETCH NEXT FROM Joining_Cursor INTO @Name5,@Year5; END;
CLOSE Joining_Cursor; DEALLOCATE Joining_Cursor;
GO

-- 6. Employee name with department
DECLARE @Name6 VARCHAR(120),@Department6 VARCHAR(50);
DECLARE EmployeeDepartment_Cursor CURSOR LOCAL FAST_FORWARD FOR
 SELECT CONCAT(FIRSTNAME,' ',LASTNAME),DEPARTMENT FROM dbo.EMPLOYEE;
OPEN EmployeeDepartment_Cursor; FETCH NEXT FROM EmployeeDepartment_Cursor INTO @Name6,@Department6;
WHILE @@FETCH_STATUS=0
BEGIN PRINT CONCAT(@Name6,' works in ',COALESCE(@Department6,'NULL'),' Department');
 FETCH NEXT FROM EmployeeDepartment_Cursor INTO @Name6,@Department6; END;
CLOSE EmployeeDepartment_Cursor; DEALLOCATE EmployeeDepartment_Cursor;
GO

-- 7. Update CITY to AHMEDABAD where NULL (cursor row-by-row)
DECLARE @FixEID INT;
DECLARE FixCity_Cursor CURSOR LOCAL FAST_FORWARD FOR SELECT EID FROM dbo.EMPLOYEE WHERE CITY IS NULL;
OPEN FixCity_Cursor; FETCH NEXT FROM FixCity_Cursor INTO @FixEID;
WHILE @@FETCH_STATUS=0
BEGIN UPDATE dbo.EMPLOYEE SET CITY='AHMEDABAD' WHERE EID=@FixEID;
 FETCH NEXT FROM FixCity_Cursor INTO @FixEID; END;
CLOSE FixCity_Cursor; DEALLOCATE FixCity_Cursor;
GO

-- 8. Employee name with city
DECLARE @Name8 VARCHAR(120),@City8 VARCHAR(50);
DECLARE EmployeeCity_Cursor CURSOR LOCAL FAST_FORWARD FOR SELECT CONCAT(FIRSTNAME,' ',LASTNAME),CITY FROM dbo.EMPLOYEE;
OPEN EmployeeCity_Cursor; FETCH NEXT FROM EmployeeCity_Cursor INTO @Name8,@City8;
WHILE @@FETCH_STATUS=0
BEGIN PRINT CONCAT(@Name8,' lives in ',COALESCE(@City8,'NULL'));
 FETCH NEXT FROM EmployeeCity_Cursor INTO @Name8,@City8; END;
CLOSE EmployeeCity_Cursor; DEALLOCATE EmployeeCity_Cursor;
GO

-- 9. Delete employees with salary < 5000 (cursor)
DECLARE @DeleteEID INT;
DECLARE DeleteLowSalary_Cursor CURSOR LOCAL FAST_FORWARD FOR SELECT EID FROM dbo.EMPLOYEE WHERE SALARY<5000;
OPEN DeleteLowSalary_Cursor; FETCH NEXT FROM DeleteLowSalary_Cursor INTO @DeleteEID;
WHILE @@FETCH_STATUS=0
BEGIN DELETE FROM dbo.EMPLOYEE WHERE EID=@DeleteEID;
 FETCH NEXT FROM DeleteLowSalary_Cursor INTO @DeleteEID; END;
CLOSE DeleteLowSalary_Cursor; DEALLOCATE DeleteLowSalary_Cursor;
GO

-- 10. Display employees department-wise
DECLARE @Name10 VARCHAR(120),@Department10 VARCHAR(50);
DECLARE Department_Cursor CURSOR LOCAL FAST_FORWARD FOR SELECT CONCAT(FIRSTNAME,' ',LASTNAME),DEPARTMENT FROM dbo.EMPLOYEE ORDER BY DEPARTMENT;
OPEN Department_Cursor; FETCH NEXT FROM Department_Cursor INTO @Name10,@Department10;
WHILE @@FETCH_STATUS=0
BEGIN PRINT CONCAT(COALESCE(@Department10,'NULL'),' Department: ',@Name10);
 FETCH NEXT FROM Department_Cursor INTO @Name10,@Department10; END;
CLOSE Department_Cursor; DEALLOCATE Department_Cursor;
GO

-- 11. Count employees in each department using cursor
DECLARE @D11 VARCHAR(50),@Count11 INT;
DECLARE DeptCount_Cursor CURSOR LOCAL FAST_FORWARD FOR SELECT DEPARTMENT,COUNT(*) FROM dbo.EMPLOYEE GROUP BY DEPARTMENT;
OPEN DeptCount_Cursor; FETCH NEXT FROM DeptCount_Cursor INTO @D11,@Count11;
WHILE @@FETCH_STATUS=0
BEGIN PRINT CONCAT(COALESCE(@D11,'NULL'),' = ',@Count11,' employees');
 FETCH NEXT FROM DeptCount_Cursor INTO @D11,@Count11; END;
CLOSE DeptCount_Cursor; DEALLOCATE DeptCount_Cursor;
GO

-- 12. Employees whose city starts with R
DECLARE @Name12 VARCHAR(120),@City12 VARCHAR(50);
DECLARE CityR_Cursor CURSOR LOCAL FAST_FORWARD FOR SELECT CONCAT(FIRSTNAME,' ',LASTNAME),CITY FROM dbo.EMPLOYEE WHERE CITY LIKE 'R%';
OPEN CityR_Cursor; FETCH NEXT FROM CityR_Cursor INTO @Name12,@City12;
WHILE @@FETCH_STATUS=0
BEGIN PRINT CONCAT(@Name12,' - ',@City12);
 FETCH NEXT FROM CityR_Cursor INTO @Name12,@City12; END;
CLOSE CityR_Cursor; DEALLOCATE CityR_Cursor;
GO

-- 13. Top 3 highest salary employees
DECLARE @Name13 VARCHAR(120),@Salary13 DECIMAL(10,2);
DECLARE TopSalary_Cursor CURSOR LOCAL FAST_FORWARD FOR
 SELECT TOP (3) CONCAT(FIRSTNAME,' ',LASTNAME),SALARY FROM dbo.EMPLOYEE ORDER BY SALARY DESC;
OPEN TopSalary_Cursor; FETCH NEXT FROM TopSalary_Cursor INTO @Name13,@Salary13;
WHILE @@FETCH_STATUS=0
BEGIN PRINT CONCAT(@Name13,' salary = ',@Salary13);
 FETCH NEXT FROM TopSalary_Cursor INTO @Name13,@Salary13; END;
CLOSE TopSalary_Cursor; DEALLOCATE TopSalary_Cursor;
GO

-- 14. Total salary department-wise using cursor
DECLARE @D14 VARCHAR(50),@Total14 DECIMAL(12,2);
DECLARE DeptSalary_Cursor CURSOR LOCAL FAST_FORWARD FOR SELECT DEPARTMENT,SUM(SALARY) FROM dbo.EMPLOYEE GROUP BY DEPARTMENT;
OPEN DeptSalary_Cursor; FETCH NEXT FROM DeptSalary_Cursor INTO @D14,@Total14;
WHILE @@FETCH_STATUS=0
BEGIN PRINT CONCAT(COALESCE(@D14,'NULL'),' Department total salary = ',@Total14);
 FETCH NEXT FROM DeptSalary_Cursor INTO @D14,@Total14; END;
CLOSE DeptSalary_Cursor; DEALLOCATE DeptSalary_Cursor;
GO

-- 15. Average salary city-wise using cursor
DECLARE @City15 VARCHAR(50),@Average15 DECIMAL(12,2);
DECLARE CityAverage_Cursor CURSOR LOCAL FAST_FORWARD FOR SELECT CITY,AVG(SALARY) FROM dbo.EMPLOYEE GROUP BY CITY;
OPEN CityAverage_Cursor; FETCH NEXT FROM CityAverage_Cursor INTO @City15,@Average15;
WHILE @@FETCH_STATUS=0
BEGIN PRINT CONCAT(COALESCE(@City15,'NULL'),' average salary = ',@Average15);
 FETCH NEXT FROM CityAverage_Cursor INTO @City15,@Average15; END;
CLOSE CityAverage_Cursor; DEALLOCATE CityAverage_Cursor;
GO

-- 16. Employee experience from JOININGYEAR
DECLARE @Name16 VARCHAR(120),@Year16 INT;
DECLARE Experience_Cursor CURSOR LOCAL FAST_FORWARD FOR SELECT CONCAT(FIRSTNAME,' ',LASTNAME),JOININGYEAR FROM dbo.EMPLOYEE;
OPEN Experience_Cursor; FETCH NEXT FROM Experience_Cursor INTO @Name16,@Year16;
WHILE @@FETCH_STATUS=0
BEGIN PRINT CONCAT(@Name16,' has experience = ',YEAR(GETDATE())-@Year16,' years');
 FETCH NEXT FROM Experience_Cursor INTO @Name16,@Year16; END;
CLOSE Experience_Cursor; DEALLOCATE Experience_Cursor;
GO

-- 17. Employee full name with annual salary
DECLARE @Name17 VARCHAR(120),@Monthly17 DECIMAL(10,2);
DECLARE AnnualSalary_Cursor CURSOR LOCAL FAST_FORWARD FOR SELECT CONCAT(FIRSTNAME,' ',LASTNAME),SALARY FROM dbo.EMPLOYEE;
OPEN AnnualSalary_Cursor; FETCH NEXT FROM AnnualSalary_Cursor INTO @Name17,@Monthly17;
WHILE @@FETCH_STATUS=0
BEGIN PRINT CONCAT(@Name17,' annual salary = ',@Monthly17*12);
 FETCH NEXT FROM AnnualSalary_Cursor INTO @Name17,@Monthly17; END;
CLOSE AnnualSalary_Cursor; DEALLOCATE AnnualSalary_Cursor;
GO

-- 18. Count male and female employees separately using cursor
DECLARE @Gender18 VARCHAR(20),@Count18 INT;
DECLARE GenderCount_Cursor CURSOR LOCAL FAST_FORWARD FOR SELECT GENDER,COUNT(*) FROM dbo.EMPLOYEE GROUP BY GENDER;
OPEN GenderCount_Cursor; FETCH NEXT FROM GenderCount_Cursor INTO @Gender18,@Count18;
WHILE @@FETCH_STATUS=0
BEGIN PRINT CONCAT(COALESCE(@Gender18,'NULL'),' employees = ',@Count18);
 FETCH NEXT FROM GenderCount_Cursor INTO @Gender18,@Count18; END;
CLOSE GenderCount_Cursor; DEALLOCATE GenderCount_Cursor;
GO

-- 19. Employees whose salary is greater than their department average
DECLARE @Name19 VARCHAR(120),@Salary19 DECIMAL(10,2),@D19 VARCHAR(50);
DECLARE AboveAverage_Cursor CURSOR LOCAL FAST_FORWARD FOR
 SELECT E.FIRSTNAME+' '+E.LASTNAME,E.SALARY,E.DEPARTMENT
 FROM dbo.EMPLOYEE E
 WHERE E.SALARY>(SELECT AVG(E2.SALARY) FROM dbo.EMPLOYEE E2 WHERE E2.DEPARTMENT=E.DEPARTMENT);
OPEN AboveAverage_Cursor; FETCH NEXT FROM AboveAverage_Cursor INTO @Name19,@Salary19,@D19;
WHILE @@FETCH_STATUS=0
BEGIN PRINT CONCAT(@Name19,' (',@D19,') salary = ',@Salary19);
 FETCH NEXT FROM AboveAverage_Cursor INTO @Name19,@Salary19,@D19; END;
CLOSE AboveAverage_Cursor; DEALLOCATE AboveAverage_Cursor;
GO

-- 20. Transfer all ADMIN employees to HR using cursor
DECLARE @TransferEID INT;
DECLARE TransferAdmin_Cursor CURSOR LOCAL FAST_FORWARD FOR SELECT EID FROM dbo.EMPLOYEE WHERE DEPARTMENT='ADMIN';
OPEN TransferAdmin_Cursor; FETCH NEXT FROM TransferAdmin_Cursor INTO @TransferEID;
WHILE @@FETCH_STATUS=0
BEGIN UPDATE dbo.EMPLOYEE SET DEPARTMENT='HR' WHERE EID=@TransferEID;
 FETCH NEXT FROM TransferAdmin_Cursor INTO @TransferEID; END;
CLOSE TransferAdmin_Cursor; DEALLOCATE TransferAdmin_Cursor;
GO

