--1. Create a table valued function to display all student records.

CREATE  FUNCTION TVF_AllStudents()
RETURNS TABLE
AS RETURN (SELECT * FROM STUDENT);
GO

select * from TVF_AllStudents()

-- 2. Students from a city

CREATE FUNCTION TVF_StudentsByCity(@City VARCHAR(50))
RETURNS TABLE
AS RETURN (SELECT * FROM dbo.STUDENT WHERE CITY=@City);
GO

-- 3. Students of a branch

CREATE  FUNCTION TVF_StudentsByBranch(@Branch VARCHAR(50))
RETURNS TABLE
AS RETURN (SELECT * FROM dbo.STUDENT WHERE BRANCH=@Branch);
GO

-- 4. Students with SPI greater than supplied SPI

CREATE  FUNCTION TVF_StudentsAboveSPI(@SPI DECIMAL(4,2))
RETURNS TABLE
AS RETURN (SELECT * FROM dbo.STUDENT WHERE SPI>@SPI);
GO

-- 5. Students whose SPI is between a minimum and maximum

CREATE  FUNCTION TVF_StudentsSPIrange(@MinSPI DECIMAL(4,2),@MaxSPI DECIMAL(4,2))
RETURNS TABLE
AS RETURN (SELECT * FROM dbo.STUDENT WHERE SPI BETWEEN @MinSPI AND @MaxSPI);
GO

-- 6. Student details by ID

CREATE  FUNCTION TVF_StudentByID(@STDID INT)
RETURNS TABLE
AS RETURN (SELECT * FROM dbo.STUDENT WHERE STDID=@STDID);
GO

-- 7. Students with SPI > 7 from a city

CREATE  FUNCTION TVF_CityStudentsAbove7(@City VARCHAR(50))
RETURNS TABLE
AS RETURN (SELECT * FROM dbo.STUDENT WHERE CITY=@City AND SPI>7);
GO

-- 8. Students with SPI < 8 from a branch

CREATE  FUNCTION TVF_BranchStudentsBelow8(@Branch VARCHAR(50))
RETURNS TABLE
AS RETURN (SELECT * FROM dbo.STUDENT WHERE BRANCH=@Branch AND SPI<8);
GO

-- 9. Top N students by SPI

CREATE  FUNCTION TVF_TopNStudents(@TopN INT)
RETURNS TABLE
AS RETURN
(
 SELECT TOP (CASE WHEN @TopN>0 THEN @TopN ELSE 0 END) *
 FROM dbo.STUDENT ORDER BY SPI DESC,STDID
);
GO

-- 10. Highest SPI student(s) from a branch

CREATE  FUNCTION TVF_HighestSPIByBranch(@Branch VARCHAR(50))
RETURNS TABLE
AS RETURN
(
 SELECT * FROM dbo.STUDENT
 WHERE BRANCH=@Branch AND SPI=(SELECT MAX(SPI) FROM dbo.STUDENT WHERE BRANCH=@Branch)
);
GO

-- 11. Return one-row table containing total students from a city

CREATE  FUNCTION TVF_CountStudentsByCity(@City VARCHAR(50))
RETURNS TABLE
AS RETURN
(
 SELECT @City AS CITY,COUNT(*) AS TotalStudents FROM dbo.STUDENT WHERE CITY=@City
);
GO

-- 12. Students from branch ordered by SPI descending

CREATE  FUNCTION TVF_BranchStudentsBySPI(@Branch VARCHAR(50))
RETURNS TABLE
AS RETURN
(
 SELECT STDID,SNAME,CITY,SPI,BRANCH,
        ROW_NUMBER() OVER(ORDER BY SPI DESC,STDID) AS SPIOrder
 FROM dbo.STUDENT WHERE BRANCH=@Branch
);
GO

-- 13. Top 3 students by SPI from a city

CREATE  FUNCTION TVF_Top3StudentsByCity(@City VARCHAR(50))
RETURNS TABLE
AS RETURN
(
 SELECT TOP (3) * FROM dbo.STUDENT WHERE CITY=@City ORDER BY SPI DESC,STDID
);
GO

-- 14. Student rank by SPI (RANK)

CREATE  FUNCTION TVF_StudentRank(@STDID INT)
RETURNS TABLE
AS RETURN
(
 SELECT STDID,SNAME,SPI,RANK() OVER(ORDER BY SPI DESC) AS SPIRank
 FROM dbo.STUDENT WHERE STDID=@STDID
);
GO

-- 15. Students with second-highest distinct SPI in a branch

CREATE  FUNCTION TVF_SecondHighestSPIByBranch(@Branch VARCHAR(50))
RETURNS TABLE
AS RETURN
(
 SELECT * FROM
 (
   SELECT *,DENSE_RANK() OVER(PARTITION BY BRANCH ORDER BY SPI DESC) AS SPIrank
   FROM dbo.STUDENT WHERE BRANCH=@Branch
 ) AS X
 WHERE SPIrank=2
);
GO