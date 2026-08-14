--Copy all records from DEPOSIT where AMOUNT > 3000 into HIGH_AMOUNT.  
Select AMOUNT  into High_Amount from DEPOSIT where AMOUNT > 3000

Select * from Deposit

--Copy only CNAME and AMOUNT from DEPOSIT where BNAME = 'MAVDI' into MAVDI_CUSTOMERS. 

Select CName,Amount into MAVDI_CUSTOMERS from Deposit where BName='Mavdi'

--Copy records of DEPOSIT where ADATE > '2025-01-01' into RECENT_DEPOSITS.  

Select * into RECENT_DEPOSITS from Deposit where ADATE > '2025-01-01'

---Copy distinct BNAME from DEPOSIT into BRANCH_LIST.  

Select distinct BNAME into BRANCH_LIST from DEPOSIT

--Copy top 5 records from DEPOSIT into TOP_DEPOSITS.  

Select top 5  *  into TOP_DEPOSITS from DEPOSIT

--Copy records where AMOUNT between 2000 and 6000 into MID_RANGE. 

Select * into MID_RANGE from DEPOSIT where AMOUNT Between 2000 and 6000

--Copy distinct branch names from DEPOSIT into UNIQUE_BRANCH. 
Select distinct Bname  into UNIQUE_BRANCH from DEPOSIT

--Copy records with NULL branch into NO_BRANCH_ASSIGNED.  
Select * into NO_BRANCH_ASSIGNED from DEPOSIT where BName is null 

-- Copy all records and rename AMOUNT as BALANCE into DEPOSIT_COPY.  
SELECT *, AMOUNT AS BALANCE 
INTO DEPOSIT_COPY 
FROM DEPOSIT;
-- Copy records where BNAME in ('MAVDI','BEDI') into SELECTED_BRANCH. 
Select * into SELECTED_BRANCH from DEPOSIT where BNAME IN('MAVDI','BEDI')

---B----

--Create a new table STUDENT_BACKUP from STUDENT without copying any data.

select * into STUDENT_BACKUP from Student
where 1=0
select * from STUDENT_BACKUP
--Copy SNAME and CITY where BRANCH = 'COMPUTER' into CS_STUDENTS.  
select Sname,city into CS_STUDENTS from Student 
where BRANCH = ' COMPUTER'
select * from CS_STUDENTS
select * from Student

--Copy top 3 students based on SPI into TOPPER_LIST.

select top 3 * into TOPPER_LIST1 from Student
select * from TOPPER_LIST1

--Copy distinct CITY from STUDENT into CITY_LIST. 
select DIStinct CITY into CITY_LIST from Student
select * from CITY_LIST

--Copy records where STDID between 103 and 108 into MID_STUDENTS.  
select * into MID_STUDENTS  from Student
where STDID between 103 and 108
--C--
--Copy records with NULL branch into NULL_BRANCH_STUDENTS.
select * into NULL_BRANCH_STUDENT from Student
where BRANCH is null
--Copy all STUDENT records and rename SPI as PERFORMANCE into STUDENT_COPY. 
select * into STUDENT_COPY from Student
exec SP_RENAME 'STUDENT_COPY.SPI','PERFORMANCE'
-- Copy records where CITY in ('RAJKOT','SURAT') into CITY_WISE. 
select * into CITY_WISE from Student 
where CITY IN('RAJKOT','SURAT')
--Copy students where BRANCH <> 'CIVIL' into NON_CIVIL_STUDENTS. 
select * into NON_CIVIL_STUDENTS from Student
where BRANCH <> 'CIVIL'
select * from NON_CIVIL_STUDENTS
--Copy selected columns (SNAME, CITY) from STUDENT table into a new table.
select SNAME,CITY into SELECTED_COLUMN from Student
select * from SELECTED_COLUMN