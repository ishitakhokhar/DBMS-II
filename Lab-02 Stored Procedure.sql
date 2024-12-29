-- Create Department Table
CREATE TABLE Department (
 DepartmentID INT PRIMARY KEY,
 DepartmentName VARCHAR(100) NOT NULL UNIQUE
);
-- Create Designation Table
CREATE TABLE Designation (
 DesignationID INT PRIMARY KEY,
 DesignationName VARCHAR(100) NOT NULL UNIQUE
);
-- Create Person Table
CREATE TABLE Person (
 PersonID INT PRIMARY KEY IDENTITY(101,1),
 FirstName VARCHAR(100) NOT NULL,
 LastName VARCHAR(100) NOT NULL,
 Salary DECIMAL(8, 2) NOT NULL,
 JoiningDate DATETIME NOT NULL,
 DepartmentID INT NULL,
 DesignationID INT NULL,
 FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
 FOREIGN KEY (DesignationID) REFERENCES Designation(DesignationID)

--DEPARTMENT INSERT
CREATE PROCEDURE PR_DEPARTMENT_INSERT
	@DEPARTMENTID	INT,
	@DEPARTMENTNAME	VARCHAR(100)
		AS
		BEGIN
			INSERT INTO DEPARTMENT VALUES
			(
				@DEPARTMENTID,
				@DEPARTMENTNAME
			)
		END
SELECT * FROM DEPARTMENT
EXEC PR_DEPARTMENT_INSERT 4,'ACCOUNT'

--UPDATE
CREATE PROCEDURE PR_DEPARTMENT_UPDATE
	@DEPARTMENTID	INT,
	@DEPARTMENTNAME	VARCHAR(100)
		AS
		BEGIN
			UPDATE DEPARTMENT
				SET @DEPARTMENTNAME=@DEPARTMENTNAME
				WHERE DepartmentID=@DEPARTMENTID
		END

--DELETE
CREATE PROCEDURE PR_DEPARTMENT_DELETE
	@DEPARTMENTID INT
		AS
		BEGIN
			DELETE FROM DEPARTMENT
			WHERE DEPARTMENTID=@DEPARTMENTID
		END

--DESIGNATION INSERT
CREATE PROCEDURE PR_DESIGNATION_INSERT
	@DESIGNATIONID	INT,
	@DESIGNATIONNAME	VARCHAR(100)
		AS
		BEGIN
			INSERT INTO DESIGNATION VALUES
			(
				@DESIGNATIONID,
				@DESIGNATIONNAME
			)
		END
SELECT * FROM DESIGNATION
EXEC PR_DESIGNATION_INSERT 15,'CEO'

--UPDATE
CREATE PROCEDURE PR_DESIGNATION_UPDATE
	@DESIGNATIONID	INT,
	@DESIGNATIONNAME	VARCHAR(100)
		AS
		BEGIN
			UPDATE DESIGNATION
				SET DESIGNATIONNAME=@DESIGNATIONNAME
				WHERE DESIGNATIONID=@DESIGNATIONID
		END

--DELETE
CREATE PROCEDURE PR_DESIGNATION_DELETE
	@DESIGNATIONID INT
		AS
		BEGIN
			DELETE FROM DESIGNATION
			WHERE DESIGNATIONID=@DESIGNATIONID
		END

--PERSON INSERT
CREATE PROCEDURE PR_PERSON_INSERT
	@FIRSTNAME	VARCHAR(100),
	@LASTNAME	VARCHAR(100),
	@SALARY		DECIMAL(8,2),
	@JOININGDATE	DATETIME,
	@DEPARTMENTID	INT,
	@DESIGNATIONID	INT
		AS
		BEGIN
			INSERT INTO PERSON VALUES
			(
				@FIRSTNAME,
				@LASTNAME,
				@SALARY,
				@JOININGDATE,
				@DEPARTMENTID,
				@DESIGNATIONID
			)
		END

--UPDATE
CREATE PROCEDURE PR_PERSON_UPDATE
	@PERSONID	INT,
	@FIRSTNAME	VARCHAR(100),
	@LASTNAME	VARCHAR(100),
	@SALARY		DECIMAL(8,2),
	@JOININGDATE	DATETIME,
	@DEPARTMENTID	INT,
	@DESIGNATIONID	INT
		AS
		BEGIN
			UPDATE PERSON
			SET	FIRSTNAME=@FIRSTNAME,
				LASTNAME=@LASTNAME,
				SALARY=@SALARY,
				JOININGDATE=@JOININGDATE,
				DEPARTMENTID=@DEPARTMENTID,
				DESIGNATIONID=@DESIGNATIONID
			WHERE PERSONID=@PERSONID
		END

--DELETE
CREATE PROCEDURE PR_PERSON_DELETE
	@PERSONID	INT
		AS
		BEGIN
			DELETE FROM PERSON
			WHERE PERSONID=@PERSONID
		END

SELECT * FROM PERSON
EXEC PR_PERSON_INSERT 'NEHA','TRIVEDI',18000,'2014-02-20',3,15

--2
--Department, Designation & Person Table�s SELECTBYPRIMARYKEY
CREATE OR ALTER PROCEDURE PR_GETDEPARTMENTBYID
	@DEPARTMENTID	INT
		AS
		BEGIN
			SELECT DEPARTMENTID,DEPARTMENTNAME FROM DEPARTMENT WHERE DEPARTMENTID=@DEPARTMENTID
		END

CREATE OR ALTER PROCEDURE PR_GETDESIGNATIONBYID
	@DESIGNATIONID	INT
		AS
		BEGIN
			SELECT DESIGNATIONID,DESIGNATIONNAME FROM DESIGNATION WHERE DESIGNATIONID=@DESIGNATIONID
		END

CREATE OR ALTER PROCEDURE PR_GETPERSONBYID
	@PERSONID	INT
		AS
		BEGIN
			SELECT FIRSTNAME,LASTNAME FROM PERSON WHERE PERSONID=@PERSONID
		END

--3
--Department, Designation & Person Table�s (If foreign key is available then do write join and take columns on select list)
CREATE OR ALTER PROCEDURE PR_GETBYFOREGINKEY
	AS
	BEGIN
		SELECT PERSONID,FIRSTNAME,LASTNAME,SALARY,JOININGDATE,DEPARTMENT.DEPARTMENTID,DESIGNATION.DESIGNATIONID FROM PERSON
		INNER JOIN DESIGNATION ON PERSON.DESIGNATIONID=DESIGNATION.DESIGNATIONID
		INNER JOIN DEPARTMENT ON PERSON.DEPARTMENTID=DEPARTMENT.DEPARTMENTID 
	END

--4--Create a Procedure that shows details of the first 3 persons.CREATE OR ALTER PROCEDURE PR_PERSON_TOPDETAIL	AS	BEGIN		SELECT TOP 3 PERSONID,FIRSTNAME,LASTNAME,SALARY,JOININGDATE,PERSON.DEPARTMENTID FROM PERSON	END--Part � B
--5
--Create a Procedure that takes the department name as input and returns a table with all workers working in that department.
CREATE  OR ALTER  PROCEDURE PR_DEPARTMNET_NAME
	@DEPARTMENTNAME	VARCHAR(100)
		AS
		BEGIN
			SELECT * FROM PERSON JOIN DEPARTMENT ON PERSON.DEPARTMENTID=DEPARTMENT.DEPARTMENTID
			WHERE DEPARTMENTNAME=@DEPARTMENTNAME
		END

--6
--Create Procedure that takes department name & designation name as input and returns a table with worker�s first name, salary, joining date & department name.
CREATE OR ALTER PROCEDURE PR_DESIGNATION_NAME
	@DEPARTMENTNAME	VARCHAR(100),
	@DESIGNATIONNAME	VARCHAR(100)
		AS
		BEGIN
			SELECT FIRSTNAME,SALARY,JOININGDATE,DEPARTMENTNAME FROM PERSON JOIN DEPARTMENT ON PERSON.DEPARTMENTID=PERSON.DEPARTMENTID
			JOIN DESIGNATION ON PERSON.DESIGNATIONID=DESIGNATION.DESIGNATIONID
			WHERE DEPARTMENTNAME=@DEPARTMENTNAME AND DESIGNATIONNAME=@DESIGNATIONNAME
		END

--7
--Create a Procedure that takes the first name as an input parameter and display all the details of the worker with their department & designation name.
CREATE OR ALTER PROCEDURE PR_PERSON_NAME
	@FIRSTNAME	VARCHAR(100)
		AS
		BEGIN
			SELECT * FROM PERSON JOIN DEPARTMENT ON PERSON.DEPARTMENTID=DEPARTMENT.DEPARTMENTID
			JOIN DESIGNATION ON PERSON.DESIGNATIONID=DESIGNATION.DESIGNATIONID
			WHERE FIRSTNAME=@FIRSTNAME
		END

--8
--Create Procedure which displays department wise maximum, minimum & total salaries.
CREATE OR ALTER PROCEDURE PR_MIN_MAX_SALARY
	AS
	BEGIN
		SELECT MAX(SALARY),MIN(SALARY),SUM(SALARY) FROM PERSON JOIN DEPARTMENT ON PERSON.DEPARTMENTID=DEPARTMENT.DEPARTMENTID
		GROUP BY DEPARTMENTNAME 
	END

--9--Create Procedure which displays designation wise average & total salaries.CREATE OR ALTER PROCEDURE PR_AVG_TOTAL_SALARY	AS	BEGIN		SELECT AVG(SALARY),AVG(SALARY) FROM PERSON JOIN DESIGNATION ON PERSON.DESIGNATIONID=DESIGNATION.DESIGNATIONID		GROUP BY DESIGNATIONNAME	END--Part � C
--10
--Create Procedure that Accepts Department Name and Returns Person Count.
CREATE OR ALTER PROCEDURE PR_COUNT_PERSON
	@DEPARTMENTNAME	VARCHAR(100)
		AS
		BEGIN
			SELECT COUNT(PERSONID) FROM PERSON JOIN DEPARTMENT ON PERSON.DEPARTMENTID=DEPARTMENT.DEPARTMENTID
			WHERE DEPARTMENTNAME=@DEPARTMENTNAME
		END

--11
--Create a procedure that takes a salary value as input and returns all workers with a salary greater than input salary value along with their department and designation details.
CREATE OR ALTER PROCEDURE PR_SALARY_PERSON
	@SALARY	DECIMAL(8,2)
		AS
		BEGIN
			SELECT * FROM PERSON JOIN DEPARTMENT ON PERSON.DEPARTMENTID=DEPARTMENT.DEPARTMENTID
			JOIN DESIGNATION ON PERSON.DESIGNATIONID=DESIGNATION.DESIGNATIONID
			WHERE SALARY>@SALARY
		END

--12
--Create a procedure to find the department(s) with the highest total salary among all departments.
CREATE OR ALTER PROCEDURE PR_SALARY_DEPARTMENT
	AS
	BEGIN
		SELECT SUM(SALARY),DEPARTMENT.DEPARTMENTID,DEPARTMENTNAME FROM PERSON JOIN DEPARTMENT ON PERSON.DEPARTMENTID=DEPARTMENT.DEPARTMENTID
		GROUP BY DEPARTMENT.DEPARTMENTID,DEPARTMENTNAME ORDER BY SUM(SALARY) DESC
	END

--13
--Create a procedure that takes a designation name as input and returns a list of all workers under that designation who joined within the last 10 years, along with their department.
CREATE OR ALTER PROCEDURE PR_NAME_TABLE
	@DESIGNATIONNAME	VARCHAR(100)
		AS
		BEGIN
			SELECT PERSON.FIRSTNAME,PERSON.LASTNAME,PERSON.SALARY,DEPARTMENTNAME,JOININGDATE,DESIGNATIONNAME FROM PERSON JOIN DESIGNATION ON PERSON.DESIGNATIONID=DESIGNATION.DESIGNATIONID
			JOIN DEPARTMENT ON PERSON.DEPARTMENTID=DEPARTMENT.DEPARTMENTID
			WHERE DESIGNATIONNAME=@DESIGNATIONNAME AND  JOININGDATE>=DATEADD(YEAR,-10,GETDATE()) ORDER BY DEPARTMENTNAME
		END

--14
--Create a procedure to list the number of workers in each department who do not have a designation assigned.
CREATE OR ALTER PROCEDURE PR_WORKERS_DEPARTMENT
	AS
	BEGIN
		SELECT FIRSTNAME,DEPARTMENTNAME FROM PERSON JOIN DEPARTMENT ON PERSON.DEPARTMENTID=DEPARTMENT.DEPARTMENTID
		JOIN DESIGNATION ON PERSON.DESIGNATIONID=DESIGNATION.DESIGNATIONID
		WHERE PERSON.DESIGNATIONID IS NULL GROUP BY DEPARTMENTNAME 
	END

--15
--Create a procedure to retrieve the details of workers in departments where the average salary is above 12000.CREATE OR ALTER PROCEDURE PR_PERSON_SALARY	AS	BEGIN		SELECT AVG(SALARY),DEPARTMENTNAME FROM PERSON JOIN DEPARTMENT ON PERSON.DEPARTMENTID=DEPARTMENT.DEPARTMENTID		GROUP BY DEPARTMENTNAME HAVING AVG(SALARY)>12000	END