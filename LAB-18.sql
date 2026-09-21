--LAB-18--

--Part – A: 

--1. Display the details of students whose SPI is greater than the average SPI. --

SELECT STDID,SNAME,SPI FROM STUDENT1
WHERE SPI > (SELECT AVG(SPI) FROM STUDENT1)

--2. Display the names of students whose SPI is less than the average SPI. --

SELECT SNAME FROM STUDENT1
WHERE SPI < (SELECT AVG(SPI) FROM STUDENT1)

--3. Display the student details who has the highest SPI. --

SELECT SNAME FROM STUDENT1
WHERE SPI = (SELECT MAX(SPI) FROM STUDENT1)

--4. Display the student details who has the lowest SPI. --

SELECT SNAME FROM STUDENT1
WHERE SPI = (SELECT MIN(SPI) FROM STUDENT1)

--5. Display the students whose SPI is greater than SPI of student DHARMIK.--

SELECT SNAME FROM STUDENT1
WHERE SPI > (SELECT SPI FROM STUDENT1 WHERE SNAME='DHARMIK')

--6. Display the students whose SPI is less than SPI of student RIYA. --

SELECT SNAME FROM STUDENT1
WHERE SPI < (SELECT SPI FROM STUDENT1 WHERE SNAME='RIYA')

--7. Display the students who belong to the same branch as KRUNAL. --

SELECT * FROM STUDENT1
WHERE BRANCH = (SELECT BRANCH FROM STUDENT1 WHERE SNAME='KRUNAL')

--8. Display the students whose branch is different from HETVI. --

SELECT * FROM STUDENT1
WHERE BRANCH != (SELECT BRANCH FROM STUDENT1 WHERE SNAME='HETVI')

--9. Display the second highest SPI from RESULT table.  --

SELECT MAX(SPI) AS SECOND_HIGEST
FROM RESULT
WHERE SPI<(SELECT MAX(SPI) FROM RESULT)

--10. Display the second lowest SPI from RESULT table.  --

SELECT MIN(SPI) AS SECOND_LOWEST
FROM RESULT
WHERE SPI>(SELECT MIN(SPI) FROM RESULT)

--11. Display the names of students whose SPI is above branch-wise average SPI.--

SELECT S.SNAME,S.BRANCH,S.SPI 
FROM STUDENT1 S
WHERE S.SPI > (SELECT AVG(S2.SPI) FROM STUDENT1 S2 WHERE S2.BRANCH=S.BRANCH)

--12. Display the branch having maximum average SPI.  --

SELECT BRANCH, AVG(SPI) AS MaxAvgSPI
FROM STUDENT1
GROUP BY BRANCH
HAVING AVG(SPI) >= ALL (
    SELECT AVG(SPI) 
    FROM STUDENT1 
    GROUP BY BRANCH
);

--13. Display the branch having minimum average SPI. --

SELECT BRANCH, AVG(SPI) AS MinAvgSPI
FROM STUDENT1
GROUP BY BRANCH
HAVING AVG(SPI) <= ALL (
    SELECT AVG(SPI) 
    FROM STUDENT1 
    GROUP BY BRANCH
);

--Part – B: --

--14. Display the students whose SPI is greater than all students of ME branch.  --

SELECT * FROM STUDENT1
WHERE SPI > ALL (SELECT SPI FROM STUDENT1 WHERE BRANCH='MECHANICAL')

--15. Display the students whose SPI is less than any student of ME branch.  --

SELECT * FROM STUDENT1
WHERE SPI < ALL (SELECT SPI FROM STUDENT1 WHERE BRANCH='MECHANICAL')

--16. Display the student details whose SPI is not equal to any SPI of EC branch students. -- 

SELECT * FROM STUDENT1
WHERE SPI <> ALL (SELECT SPI FROM STUDENT1 WHERE BRANCH='EC')

--17. Display the names of students who scored higher SPI than student of RNO 103.  --

SELECT SNAME FROM STUDENT1
WHERE SPI > (SELECT SPI FROM STUDENT1 WHERE STDID=103)

--18. Display the students whose SPI is greater than average SPI of their own branch. -- 

SELECT * FROM STUDENT1 S1
WHERE S1.SPI > (SELECT AVG(S2.SPI) FROM STUDENT1 S2 WHERE S2.BRANCH=S1.BRANCH) 

--19. Display the students whose SPI is greater than the average SPI of CE branch but greater than the maximum SPI of ME branch.-- 

SELECT * FROM STUDENT1
WHERE SPI > (SELECT AVG(SPI) FROM STUDENT1 WHERE BRANCH='COMPUTER')
AND SPI >  (SELECT MAX(SPI) FROM STUDENT1 WHERE BRANCH='MECHANICAL')

--20. Display the branch names whose average SPI is greater than the overall average SPI.  --

SELECT BRANCH, AVG(SPI) AS BRANCH_AVG_SPI
FROM STUDENT1
GROUP BY BRANCH
HAVING AVG(SPI) > (SELECT AVG(SPI) FROM STUDENT1) 

--21. Display the students who have maximum SPI in their respective branch. --

SELECT * FROM STUDENT1 S1
WHERE S1.SPI =(SELECT MAX(S2.SPI) FROM STUDENT1 S2 WHERE S2.BRANCH=S1.BRANCH)

--22. Display the students whose SPI is greater than their average SPI of their branch and greater than overall average SPI.  --

SELECT s1.* 
FROM STUDENT1 s1
WHERE s1.SPI > (
    SELECT AVG(s2.SPI) 
    FROM STUDENT1 s2 
    WHERE s2.BRANCH = s1.BRANCH
)
AND s1.SPI > (
    SELECT AVG(SPI) 
    FROM STUDENT1
)


--Part – C: --

--23. Display the students whose SPI is greater than at least one student of every branch.--  

SELECT * 
FROM STUDENT1
WHERE SPI > (
    SELECT MAX(MinSPI) 
    FROM (
        SELECT MIN(SPI) AS MinSPI 
        FROM STUDENT1 
        GROUP BY BRANCH
    ) AS BranchMinimums
)


--24. Display the students whose SPI is less than all students of CE branch.  --

SELECT * 
FROM STUDENT1
WHERE SPI < (SELECT MIN(SPI) FROM STUDENT1 WHERE BRANCH = 'COMPUTER');


--25. Display the branch that contains the student with highest SPI.  --

SELECT DISTINCT BRANCH
FROM STUDENT1
WHERE SPI = (SELECT MAX(SPI) FROM STUDENT1);


--26. Display the students whose SPI is less than the SPI of every student in CE branch and greater than every student in ME branch.--

SELECT * 
FROM STUDENT1
WHERE SPI < (SELECT MIN(SPI) FROM STUDENT1 WHERE BRANCH = 'CE')
  AND SPI > (SELECT MAX(SPI) FROM STUDENT1 WHERE BRANCH = 'ME');
