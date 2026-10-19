-- A1. Divide-by-zero error
BEGIN TRY
 DECLARE @A1 INT=10,@B1 INT=0;
 SELECT @A1/@B1 AS Result;
END TRY
BEGIN CATCH
 PRINT 'Error occurs that is - Divide by zero error.';
 PRINT ERROR_MESSAGE();
END CATCH;
GO

-- A2. Convert text to integer and handle error
BEGIN TRY
 DECLARE @Text2 VARCHAR(20)='ABC';
 DECLARE @Number2 INT=CONVERT(INT,@Text2);
 PRINT CONCAT('Number = ',@Number2);
END TRY
BEGIN CATCH
 PRINT CONCAT('Conversion error: ',ERROR_MESSAGE());
END CATCH;
GO

-- A3. Procedure to add two integer inputs; invalid text conversion is caught at caller
CREATE OR ALTER PROCEDURE dbo.SP_AddTwoNumbers
 @Value1 VARCHAR(50),@Value2 VARCHAR(50)
AS
BEGIN
 SET NOCOUNT ON;
 BEGIN TRY
  DECLARE @N1 INT=TRY_CONVERT(INT,@Value1),@N2 INT=TRY_CONVERT(INT,@Value2);
  IF @N1 IS NULL OR @N2 IS NULL
    THROW 50010,'Both inputs must be valid integers.',1;
  SELECT @N1+@N2 AS SumResult;
 END TRY
 BEGIN CATCH
  SELECT ERROR_MESSAGE() AS ErrorMessage,ERROR_NUMBER() AS ErrorNumber,
         ERROR_SEVERITY() AS ErrorSeverity,ERROR_STATE() AS ErrorState;
 END CATCH
END;
GO
-- EXEC dbo.SP_AddTwoNumbers '10','20';
-- EXEC dbo.SP_AddTwoNumbers 'ten','20';

-- A4. Handle primary-key violation on STUDENT_INFO
BEGIN TRY
 INSERT INTO dbo.STUDENT_INFO(RNO,NAME,BRANCH) VALUES(101,'DUPLICATE TEST','CE');
END TRY
BEGIN CATCH
 SELECT ERROR_MESSAGE() AS ErrorMessage,ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,ERROR_STATE() AS ErrorState;
END CATCH;
GO
-- This example assumes RNO=101 already exists; otherwise it inserts the row successfully.

-- A5. Throw error if RNO does not exist
CREATE OR ALTER PROCEDURE dbo.SP_CheckStudentRNO @RNO INT
AS
BEGIN
 SET NOCOUNT ON;
 IF NOT EXISTS(SELECT 1 FROM dbo.STUDENT_INFO WHERE RNO=@RNO)
   THROW 50011,'No RNO is available in database.',1;
 SELECT * FROM dbo.STUDENT_INFO WHERE RNO=@RNO;
END;
GO

-- B6. Update employee salary; reject salary <= 0
CREATE OR ALTER PROCEDURE dbo.SP_UpdateEmployeeSalary
 @EID INT,@NewSalary DECIMAL(10,2)
AS
BEGIN
 SET NOCOUNT ON;
 BEGIN TRY
  IF @NewSalary<=0 THROW 50012,'Salary must be greater than zero.',1;
  IF NOT EXISTS(SELECT 1 FROM dbo.EMPLOYEE WHERE EID=@EID)
    THROW 50013,'Employee ID does not exist.',1;
  UPDATE dbo.EMPLOYEE SET SALARY=@NewSalary WHERE EID=@EID;
 END TRY
 BEGIN CATCH
  SELECT ERROR_MESSAGE() AS ErrorMessage,ERROR_NUMBER() AS ErrorNumber;
 END CATCH
END;
GO

-- B7. Handle foreign-key violation inserting RESULT
BEGIN TRY
 -- Choose an RNO that does not exist in STUDENT_INFO to demonstrate FK error.
 INSERT INTO dbo.RESULT(RESULTID,SPI,RNO) VALUES(999,8.5,-999);
END TRY
BEGIN CATCH
 SELECT 'Foreign key insert failed' AS Message,ERROR_MESSAGE() AS ErrorMessage,
        ERROR_NUMBER() AS ErrorNumber;
END CATCH;
GO

-- B8. Handle invalid date when inserting DEPOSIT
BEGIN TRY
 INSERT INTO dbo.DEPOSIT(ACTNO,CNAME,BNAME,AMOUNT,ADATE)
 VALUES(999,'TEST','MAVDI',1000,CONVERT(DATETIME,'not-a-date'));
END TRY
BEGIN CATCH
 SELECT 'Invalid date format' AS Message,ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
GO

-- B9. Validate gender before inserting employee
CREATE OR ALTER PROCEDURE dbo.SP_InsertEmployeeValidateGender
 @EID INT,@FIRSTNAME VARCHAR(50),@LASTNAME VARCHAR(50),@DEPARTMENT VARCHAR(50),
 @SALARY DECIMAL(10,2),@CITY VARCHAR(50),@GENDER VARCHAR(20),@JOININGYEAR INT
AS
BEGIN
 SET NOCOUNT ON;
 BEGIN TRY
  IF UPPER(@GENDER) NOT IN ('MALE','FEMALE') OR @GENDER IS NULL
    THROW 50014,'Gender must be Male or Female.',1;
  INSERT INTO dbo.EMPLOYEE(EID,FIRSTNAME,LASTNAME,DEPARTMENT,SALARY,CITY,GENDER,JOININGYEAR)
  VALUES(@EID,@FIRSTNAME,@LASTNAME,@DEPARTMENT,@SALARY,@CITY,UPPER(@GENDER),@JOININGYEAR);
 END TRY
 BEGIN CATCH
  SELECT ERROR_MESSAGE() AS ErrorMessage,ERROR_NUMBER() AS ErrorNumber;
 END CATCH
END;
GO

-- B10. Validate joining year is not in the future
CREATE OR ALTER PROCEDURE dbo.SP_ValidateJoiningYear @JoiningYear INT
AS
BEGIN
 SET NOCOUNT ON;
 IF @JoiningYear>YEAR(GETDATE())
   THROW 50015,'Joining year cannot be greater than current year.',1;
 SELECT * FROM dbo.EMPLOYEE WHERE JOININGYEAR=@JoiningYear;
END;
GO

-- C10. Delete employee and handle non-existent EID
CREATE OR ALTER PROCEDURE dbo.SP_DeleteEmployeeSafe @EID INT
AS
BEGIN
 SET NOCOUNT ON;
 BEGIN TRY
  IF NOT EXISTS(SELECT 1 FROM dbo.EMPLOYEE WHERE EID=@EID)
    THROW 50016,'Employee does not exist.',1;
  DELETE FROM dbo.EMPLOYEE WHERE EID=@EID;
  PRINT 'Employee deleted successfully.';
 END TRY
 BEGIN CATCH
  SELECT ERROR_MESSAGE() AS ErrorMessage,ERROR_NUMBER() AS ErrorNumber;
 END CATCH
END;
GO

-- C11. Insert employee with department validation (NULL department rejected)
CREATE OR ALTER PROCEDURE dbo.SP_InsertEmployeeRequireDepartment
 @EID INT,@FIRSTNAME VARCHAR(50),@LASTNAME VARCHAR(50),@DEPARTMENT VARCHAR(50),
 @SALARY DECIMAL(10,2),@CITY VARCHAR(50),@GENDER VARCHAR(20),@JOININGYEAR INT
AS
BEGIN
 SET NOCOUNT ON;
 BEGIN TRY
  IF @DEPARTMENT IS NULL
    THROW 50017,'Department name cannot be NULL.',1;
  INSERT INTO dbo.EMPLOYEE(EID,FIRSTNAME,LASTNAME,DEPARTMENT,SALARY,CITY,GENDER,JOININGYEAR)
  VALUES(@EID,@FIRSTNAME,@LASTNAME,@DEPARTMENT,@SALARY,@CITY,@GENDER,@JOININGYEAR);
 END TRY
 BEGIN CATCH
  SELECT ERROR_MESSAGE() AS ErrorMessage,ERROR_NUMBER() AS ErrorNumber;
 END CATCH
END;
GO
