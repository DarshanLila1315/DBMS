--Lab 5 --

--Perform SQL Queries for ALTER, RENAME, DELETE, TRUNCATE, and DROP Commands 
--From the table DEPOSIT perform the following queries:  

-- Part – A: 

-- 1. Add column state varchar(20).

ALTER TABLE DEPOSIT
ADD STATE VARCHAR(20)
SELECT * FROM DEPOSIT

-- 2. Add two more columns city varchar(20) and pincode int. 

ALTER TABLE DEPOSIT
ADD CITY VARCHAR(20),PINCODE INT
SELECT * FROM DEPOSIT

-- 3. Change the size of cname column from varchar(50) to varchar(35).  

ALTER TABLE DEPOSIT
ALTER COLUMN CNAME VARCHAR(35)

-- 4. Change the data type of amount from decimal to int.

ALTER TABLE DEPOSIT
ALTER COLUMN AMOUNT INT 

-- 5. Delete column city from the DEPOSIT table. 

ALTER TABLE DEPOSIT
DROP COLUMN CITY
SELECT * FROM DEPOSIT

-- 6. Rename column actno to ano.

SP_RENAME 'DEPOSIT.ACTON' ,'ANO'
SELECT * FROM DEPOSIT

-- 7. Rename column bname to branch_name.

-- 8. Rename table DEPOSIT to DEPOSIT_DETAIL.  
-- 9. Add column ifsc_code varchar(15).  
-- 10. Change the size of bname column from varchar(50) to varchar(30). 
 
-- Part – B: 
-- 11. Rename column adate to aopendate.  
-- 12. Delete column aopendate from DEPOSIT_DETAIL table.  
-- 13. Rename column cname to customer_name.  
-- 14. Add column country varchar(20).  
-- 15. Add column account_type varchar(15). 
 
 
-- Part – C: 
-- 16. Change data type of pincode from int to bigint. 
-- 17. Delete column account_type. 
-- 18. Rename column amount to balance. 
-- 19. Add column status varchar(10). 
-- 20. Change table name deposit_detail to bank_deposit. 
 

-- From the table DEPOSIT perform the following queries:  

-- Part – A: 
-- 1. Delete all the records having amount less than or equal to 3000.  
-- 2. Delete all the accounts of ‘BEDI’ branch customer. 
-- 3. Delete all the accounts having account number greater than 102 and less than 109.  
-- 4. Delete all the accounts whose branch is ‘BEDI’ or ‘MADHAPAR’.  
-- 5. Delete all the accounts details where amount is 8000 and account open after 1-1-2025; 
-- 6. Delete all the accounts whose account branch is NULL.  
-- 7. Delete all the accounts details where amount is 7000 and name is CHARMI and branch is SHITAL PARK. 
-- 8. Delete all the remaining records using DELETE command.  
-- 9. Delete all the records of DEPOSIT table. (Use TRUNCATE)  
-- 10. Remove DEPOSIT table. (Use DROP) 
 
-- From the table STUDENT perform the following queries:  

-- Part – B: 
-- 11. Delete all the students whose stdid is greater than 105.  
-- 12. Delete the records whose branch is NULL and sname is not NULL.  
-- 13. Delete the records whose SPI is less than 9 and city is RAJKOT.  
-- 14. Delete the records whose branch name is not empty.  
-- 15. Delete all the records of STUDENT table. (Use TRUNCATE) 