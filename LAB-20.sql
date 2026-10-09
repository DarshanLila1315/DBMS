--1. Display rank of students based on SPI.

select * , RANK() over(order by spi ) as rank from STUDENT

--2. Display dense rank of students based on SPI.

select * , DENSE_RANK() over(order by spi ) as rank from STUDENT

--3. Display sequential number for each student record.

SELECT *, ROW_NUMBER() OVER (ORDER BY SPI DESC) AS SeqNo FROM STUDENT;

--4. Display branch-wise rank of students.

SELECT *, RANK() OVER (PARTITION BY BRANCH ORDER BY SPI DESC) AS BranchRank FROM STUDENT;


--5. Display branch-wise dense ranking of students.

SELECT *, DENSE_RANK() OVER (PARTITION BY BRANCH ORDER BY SPI DESC) AS BranchDenseRank FROM STUDENT;

--6. Display branch-wise sequential numbering of students.

SELECT *, ROW_NUMBER() OVER (PARTITION BY BRANCH ORDER BY SPI DESC) AS BranchSeqNo FROM STUDENT;

--7. Display SNAME, Current SPI, Previous SPI and SPI Difference with previous student in ascending order of SPI.

SELECT
  SNAME,
  SPI AS CurrentSPI,
  LAG(SPI) OVER (ORDER BY SPI ASC) AS PreviousSPI,
  SPI - LAG(SPI) OVER (ORDER BY SPI ASC) AS DiffWithPrevious
FROM STUDENT
ORDER BY SPI ASC;

--8. Display SNAME, Current SPI, Next SPI and SPI Difference with next student in descending order of SPI.

SELECT
  SNAME,
  SPI AS CurrentSPI,
  LEAD(SPI) OVER (ORDER BY SPI DESC) AS NextSPI,
  SPI - LEAD(SPI) OVER (ORDER BY SPI DESC) AS DiffWithNext
FROM STUDENT
ORDER BY SPI DESC;

--9. Display top 3 students based on SPI.

SELECT TOP (3) *
FROM STUDENT
ORDER BY SPI DESC;

--10. Display top 2 students from each branch.
SELECT *
FROM (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY BRANCH ORDER BY SPI DESC) AS rn
  FROM STUDENT
) t
WHERE rn <= 2
ORDER BY BRANCH, rn;

--11. Display 5th highest SPI.

SELECT SPI
FROM (
  SELECT DISTINCT SPI,
         ROW_NUMBER() OVER (ORDER BY SPI DESC) AS rn
  FROM STUDENT
) t
WHERE rn = 5;
-- 12. 6th highest SPI
SELECT SPI
FROM (
  SELECT DISTINCT SPI,
         ROW_NUMBER() OVER (ORDER BY SPI DESC) AS rn
  FROM STUDENT
) t
WHERE rn = 6;

-- 13. Students having same ranking (ties using RANK)
WITH r AS (
  SELECT *, RANK() OVER (ORDER BY SPI DESC) AS rnk
  FROM STUDENT
)
SELECT *
FROM r
WHERE rnk IN (
  SELECT rnk FROM r GROUP BY rnk HAVING COUNT(*) > 1
)
ORDER BY rnk, SPI DESC;

-- 14. SNAME, Previous SPI, Current SPI and Next SPI based on ascending SPI
SELECT
  SNAME,
  LAG(SPI)  OVER (ORDER BY SPI ASC) AS PreviousSPI,
  SPI AS CurrentSPI,
  LEAD(SPI) OVER (ORDER BY SPI ASC) AS NextSPI
FROM STUDENT
ORDER BY SPI ASC;

-- 15. Topper of each branch
SELECT SNAME, BRANCH, SPI
FROM (
  SELECT SNAME, BRANCH, SPI,
         ROW_NUMBER() OVER (PARTITION BY BRANCH ORDER BY SPI DESC) AS rn
  FROM STUDENT
) t
WHERE rn = 1
ORDER BY BRANCH;

-- 16. Students whose SPI is greater than the previous student and less than the next student
SELECT *
FROM (
  SELECT *,
         LAG(SPI)  OVER (ORDER BY SPI ASC) AS prev_spi,
         LEAD(SPI) OVER (ORDER BY SPI ASC) AS next_spi
  FROM STUDENT
) t
WHERE prev_spi IS NOT NULL AND next_spi IS NOT NULL
  AND SPI > prev_spi
  AND SPI < next_spi
ORDER BY SPI ASC;

-- 17. Branch-wise second topper students
SELECT SNAME, BRANCH, SPI
FROM (
  SELECT SNAME, BRANCH, SPI,
         ROW_NUMBER() OVER (PARTITION BY BRANCH ORDER BY SPI DESC) AS rn
  FROM STUDENT
) t
WHERE rn = 2
ORDER BY BRANCH;

-- 18. Students whose rank and dense rank are different
SELECT *
FROM (
  SELECT *,
         RANK()        OVER (ORDER BY SPI DESC) AS rnk,
         DENSE_RANK()  OVER (ORDER BY SPI DESC) AS drnk
  FROM STUDENT
) t
WHERE rnk <> drnk
ORDER BY SPI DESC;

-- 19. Consecutive students having same branch ordered by SPI (shows rows where previous row has same branch)
SELECT *
FROM (
  SELECT *,
         LAG(BRANCH) OVER (ORDER BY SPI DESC) AS prev_branch
  FROM STUDENT
) t
WHERE prev_branch = BRANCH
ORDER BY SPI DESC;

-- 20. Students whose SPI difference with previous student is maximum
SELECT TOP (1) SNAME, SPI, prev_spi, ABS(SPI - prev_spi) AS DiffWithPrev
FROM (
  SELECT SNAME, SPI,
         LAG(SPI) OVER (ORDER BY SPI ASC) AS prev_spi
  FROM STUDENT
) t
WHERE prev_spi IS NOT NULL
ORDER BY ABS(SPI - prev_spi) DESC;