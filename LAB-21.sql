
-- 1. Display all students whose SPI is greater than 8

WITH StudentCTE AS (
    SELECT *
    FROM Student
)
SELECT *
FROM StudentCTE
WHERE spi > 8;


-- 2. Display average SPI of all students

WITH StudentCTE AS (
    SELECT spi
    FROM Student
)
SELECT AVG(spi) AS Average_SPI
FROM StudentCTE;


-- 3. Display total number of students in each branch

WITH BranchCount AS (
    SELECT branch, COUNT(*) AS Total_Students
    FROM Student
    GROUP BY branch
)
SELECT *
FROM BranchCount;


-- 4. Display students who belong to RAJKOT city

WITH StudentCTE AS (
    SELECT *
    FROM Student
)
SELECT *
FROM StudentCTE
WHERE UPPER(city) = 'RAJKOT';


-- 5. Find branch names that appear more than once

WITH BranchCount AS (
    SELECT branch, COUNT(*) AS Total_Students
    FROM Student
    GROUP BY branch
)
SELECT *
FROM BranchCount
WHERE Total_Students > 1;


-- 6. Display row number for each student

WITH StudentRows AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY sid) AS Row_No
    FROM Student
)
SELECT *
FROM StudentRows;


-- 7. Display top 3 students based on SPI

WITH StudentRank AS (
    SELECT *,
           ROW_NUMBER() OVER (
               ORDER BY spi DESC, sid
           ) AS Row_No
    FROM Student
)
SELECT *
FROM StudentRank
WHERE Row_No <= 3;


-- 8. Display students having maximum SPI

WITH MaxSPI AS (
    SELECT MAX(spi) AS Highest_SPI
    FROM Student
)
SELECT s.*
FROM Student AS s
CROSS JOIN MaxSPI AS m
WHERE s.spi = m.Highest_SPI;


-- 9. Display students having minimum SPI

WITH MinSPI AS (
    SELECT MIN(spi) AS Lowest_SPI
    FROM Student
)
SELECT s.*
FROM Student AS s
CROSS JOIN MinSPI AS m
WHERE s.spi = m.Lowest_SPI;


-- 10. Display branch-wise rank of students
select * from STUDENT

WITH StudentRanks AS (
    SELECT STDID, sname, branch, spi,
           RANK() OVER (
               PARTITION BY branch
               ORDER BY spi DESC
           ) AS Branch_Rank
    FROM Student
)
SELECT *
FROM StudentRanks;



-- 11. Display average SPI of Computer branch

WITH ComputerStudents AS (
    SELECT spi
    FROM Student
    WHERE branch = 'Computer'
)
SELECT AVG(spi) AS Computer_Average_SPI
FROM ComputerStudents;


-- 12. Display students whose SPI is greater than the average SPI of their branch

WITH BranchAverage AS (
    SELECT branch, AVG(spi) AS Average_SPI
    FROM Student
    GROUP BY branch
)
SELECT s.*
FROM Student AS s
JOIN BranchAverage AS b
    ON s.branch = b.branch
WHERE s.spi > b.Average_SPI;


-- 13. Display branches having more than 2 students

WITH BranchCount AS (
    SELECT branch, COUNT(*) AS Total_Students
    FROM Student
    GROUP BY branch
)
SELECT *
FROM BranchCount
WHERE Total_Students > 2;


-- 14. Display branches having average SPI between 7 and 9

WITH BranchAverage AS (
    SELECT branch, AVG(spi) AS Average_SPI
    FROM Student
    GROUP BY branch
)
SELECT *
FROM BranchAverage
WHERE Average_SPI BETWEEN 7 AND 9;


-- 15. Display students whose SPI is lower than the overall average SPI

WITH OverallAverage AS (
    SELECT AVG(spi) AS Average_SPI
    FROM Student
)
SELECT s.*
FROM Student AS s
CROSS JOIN OverallAverage AS a
WHERE s.spi < a.Average_SPI;


-- 16. Display branches having exactly one student

WITH BranchCount AS (
    SELECT branch, COUNT(*) AS Total_Students
    FROM Student
    GROUP BY branch
)
SELECT *
FROM BranchCount
WHERE Total_Students = 1;


-- 17. Display branch having the highest average SPI

WITH BranchAverage AS (
    SELECT branch, AVG(spi) AS Average_SPI
    FROM Student
    GROUP BY branch
),
HighestAverage AS (
    SELECT MAX(Average_SPI) AS Highest_SPI
    FROM BranchAverage
)
SELECT b.*
FROM BranchAverage AS b
CROSS JOIN HighestAverage AS h
WHERE b.Average_SPI = h.Highest_SPI;


-- 18. Display branch having the lowest average SPI

WITH BranchAverage AS (
    SELECT branch, AVG(spi) AS Average_SPI
    FROM Student
    GROUP BY branch
),
LowestAverage AS (
    SELECT MIN(Average_SPI) AS Lowest_SPI
    FROM BranchAverage
)
SELECT b.*
FROM BranchAverage AS b
CROSS JOIN LowestAverage AS l
WHERE b.Average_SPI = l.Lowest_SPI;


-- 19. Display students whose SPI is lower than their branch average SPI

WITH BranchAverage AS (
    SELECT branch, AVG(spi) AS Average_SPI
    FROM Student
    GROUP BY branch
)
SELECT s.*
FROM Student AS s
JOIN BranchAverage AS b
    ON s.branch = b.branch
WHERE s.spi < b.Average_SPI;


-- 20. Display branches having the maximum number of students

WITH BranchCount AS (
    SELECT branch, COUNT(*) AS Total_Students
    FROM Student
    GROUP BY branch
),
MaximumCount AS (
    SELECT MAX(Total_Students) AS Max_Students
    FROM BranchCount
)
SELECT b.*
FROM BranchCount AS b
CROSS JOIN MaximumCount AS m
WHERE b.Total_Students = m.Max_Students;

