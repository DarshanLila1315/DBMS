 
-- Lab 4 --

--Perform SQL Queries for Update Data (UPDATE) 
 
 --  Part – A: -- 
-- 1. Update SPI of all students from 7.00 to 8.00.

SELECT * FROM STUDENT
UPDATE STUDENT 
SET SPI = 8.00
WHERE SPI = 7.00

-- 2. Change city of HETVI from RAJKOT to AHMEDABAD.

SELECT * FROM STUDENT
UPDATE STUDENT
SET CITY = 'AHMEDABAD'
WHERE SNAME = 'HETVI' AND  CITY = 'RAJKOT'

-- 3. Update SPI of DEEP to 9.20 and city to VADODARA. 

SELECT * FROM STUDENT
UPDATE STUDENT
SET SPI = 9.20 , CITY = 'VADODARA'
WHERE SNAME = 'DEEP' AND  SPI = 8.80 AND  CITY = 'SURAT'

-- 4. Update SPI of DHARMIK to 8.50. 

SELECT * FROM STUDENT
UPDATE STUDENT
SET SPI = 8.50 
WHERE SNAME = 'DHARMIK' AND  SPI = 8.80

-- 5. Update branch name from COMPUTER to IT. 

SELECT * FROM STUDENT
UPDATE STUDENT
SET BRANCH = 'IT' 
WHERE BRANCH = 'COMPUTER' 

-- 6. Update branch of RAJ to AUTOMOBILE.

SELECT * FROM STUDENT
UPDATE STUDENT
SET BRANCH = 'AUTOMOBILE' 
WHERE SNAME = 'RAJ' AND BRANCH = 'MECHANICAL'

-- 7. Update SPI to 7.50 where STDID is between 103 and 107. 

SELECT * FROM STUDENT
UPDATE STUDENT
SET SPI = 7.50
WHERE STDID BETWEEN 103 AND 107  

-- 8. Update city of PARAG to MUMBAI. 

SELECT * FROM STUDENT
UPDATE STUDENT
SET CITY = 'MUMBAI' 
WHERE SNAME = 'PARAG' AND city = 'SURAT'

-- 9. Update SPI of RIYA to 6.00. 

SELECT * FROM STUDENT
UPDATE STUDENT
SET SPI = 6.00
WHERE SNAME = 'RIYA' AND  SPI = 7.50

-- 10. Update SPI of SMAIR to 7.20 and branch to ELECTRICAL. 

SELECT * FROM STUDENT
UPDATE STUDENT
SET BRANCH = 'ELECTRICAL',SPI = 7.20
WHERE SNAME = 'SMAIR' AND  BRANCH = 'EC' AND SPI = 6.80


-- Part – B:

-- 11. Give 10% increment in SPI.

SELECT * FROM STUDENT
UPDATE STUDENT
SET SPI = SPI * 1.10

-- 12. Increase SPI by 20% for all students.  

SELECT * FROM STUDENT
UPDATE STUDENT
SET SPI = SPI * 1.10

-- 13. Increase SPI by 0.50 in all records.  

SELECT * FROM STUDENT
UPDATE STUDENT
SET SPI = SPI * 0.50

-- 14. Update branch to 'EC' and SPI to 8.00 and city to Surat where SNAME is KRUNAL.  

SELECT * FROM STUDENT
UPDATE STUDENT
SET BRANCH = 'EC' , SPI = 8.00 , CITY = 'SURAT'
WHERE SNAME = 'KRUNAL' AND  BRANCH = 'CIVIL' AND  SPI = 4.54 AND CITY = 'VAPI'

-- 15. Update city to 'RAJKOT' and SPI to 7.00 where branch is CIVIL and stdid is less than 105. 
 
SELECT * FROM STUDENT
UPDATE STUDENT
SET CITY = 'RAJKOT', SPI = 7.00 
WHERE BRANCH = 'CIVIL' AND  STDID < 105


-- Part – C: 

-- 16. Update SPI of student with stdid 110 to NULL.

SELECT * FROM STUDENT
UPDATE STUDENT
SET SPI  = NULL 
WHERE STDID = 110 

-- 17. Update branch of VISHAL to NULL.  

SELECT * FROM STUDENT
UPDATE STUDENT
SET BRANCH  = NULL 
WHERE SNAME = 'VISHAL' AND BRANCH  = 'CIVIL' 

-- 18. Display names of students whose SPI is NULL. 

SELECT * FROM STUDENT 
WHERE SPI IS NULL

-- 19. Display students who have branch assigned.  

SELECT * FROM STUDENT 
WHERE BRANCH IS NOT  NULL

-- 20. Update student with stdid 108 to name DARSHAN, branch COMPUTER, and SPI 8.50.  

SELECT * FROM STUDENT
UPDATE STUDENT
SET  SNAME = 'DARSHAN' , BRANCH = 'COMPUTER' , SPI = 8.50
WHERE STDID = 108 

-- 21. Update city to SURAT where SPI is less than 7.00.  

SELECT * FROM STUDENT
UPDATE STUDENT
SET  CITY = 'SURAT'
WHERE SPI < 7.00

-- 22. Update city to NULL and branch to MECHANICAL where stdid is 109.

SELECT * FROM STUDENT
UPDATE STUDENT
SET  CITY = NULL , BRANCH = 'MECHANICAL'
WHERE STDID = 109 


--X--X--X--X--X--X--X--X--X--X--X--X--X--X--X--X--X--X--X--X--X--X--X--X--X--X--X--X--X--X--X--X--X--X--X--X--X--X--X--X--X--X--X--X--X