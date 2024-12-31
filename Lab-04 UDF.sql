--Part � A
--1
--Write a function to print "hello world".
CREATE OR ALTER FUNCTION FN_HELLOWORD()
RETURNS VARCHAR(100)
AS
BEGIN
	RETURN 'HELLO WORLD'
END

SELECT DBO.FN_HELLOWORD()
DROP FUNCTION FN_HELLOWORD

--2
--Write a function which returns addition of two numbers.
CREATE OR ALTER FUNCTION FN_ADDITION(@NUM1 INT,@NUM2 INT)
RETURNS	INT
AS
BEGIN
	DECLARE @SUM INT
	SET @SUM=@NUM1+@NUM2
	RETURN @SUM
END

SELECT DBO.FN_ADDITION(2,6) AS ADDITION
DROP FUNCTION FN_ADDITION

--3
--Write a function to check whether the given number is ODD or EVEN.
CREATE OR ALTER FUNCTION FN_EVEN_ODD(@NUMBER INT)
RETURNS	VARCHAR(100)
AS
BEGIN
	DECLARE @MSG VARCHAR(100)
	IF(@NUMBER%2=0)
		SET @MSG='EVEN NUMBER'
	ELSE
		SET @MSG='ODD NUMBER'
	RETURN @MSG
END

SELECT DBO.FN_EVEN_ODD(5) AS ODD_EVEN
DROP FUNCTION FN_EVEN_ODD

--4
--Write a function which returns a table with details of a person whose first name starts with B.
CREATE OR ALTER FUNCTION FN_PERSONALDETAILS_NAME()
RETURNS TABLE
	AS
	RETURN
		(SELECT * FROM PERSON WHERE FIRSTNAME LIKE 'B%')
SELECT * FROM DBO.FN_PERSONALDETAILS_NAME()

--5
--Write a function which returns a table with unique first names from the person table.
CREATE OR ALTER FUNCTION FN_UNIQUE_FIRSTNAME()
RETURNS TABLE
	AS
	RETURN
		(SELECT DISTINCT FIRSTNAME FROM PERSON)
SELECT * FROM DBO.FN_UNIQUE_FIRSTNAME()

--6
--Write a function to print number from 1 to N. (Using while loop)
CREATE OR ALTER FUNCTION FN_PRINTNO(@NUM INT)
RETURNS VARCHAR(100)
AS
BEGIN
	DECLARE @MSG VARCHAR(100),@COUNT INT
	SET @MSG=''

	SET @COUNT=1
	WHILE(@COUNT<=@NUM)
		BEGIN
			SET @MSG=@MSG+''+CAST(@COUNT AS VARCHAR)
			SET @COUNT=@COUNT+1
		END
			RETURN @MSG
END

SELECT DBO.FN_PRINTNO(10)

--7
--Write a function to find the factorial of a given integer.
CREATE OR ALTER FUNCTION FN_FACTORIAL(@NUM INT)
RETURNS	INT
AS
BEGIN
	DECLARE @COUNTER INT,@FACTORIAL INT
	SET @COUNTER=1
	SET @FACTORIAL=1
	WHILE(@COUNTER<=@NUM)
		BEGIN 
			SET @FACTORIAL=@FACTORIAL*@COUNTER
			SET @COUNTER=@COUNTER+1
		END
RETURN @FACTORIAL
END

SELECT DBO.FN_FACTORIAL(5) AS FACTORIAL

--Part � B
--8
--Write a function to compare two integers and return the comparison result. (Using Case statement)
CREATE OR ALTER FUNCTION FN_COMPARISON(@NUM1 INT,@NUM2 INT)
RETURNS VARCHAR(100)
AS
BEGIN
		RETURN CASE
		WHEN @NUM1>@NUM2 THEN 'FIRST'
		WHEN @NUM1<@NUM2 THEN 'SECOND'
	END
END

SELECT DBO.FN_COMPARISON(2,7) AS COMPARE

--9
--Write a function to print the sum of even numbers between 1 to 20.
CREATE OR ALTER FUNCTION FN_EVEN_NUMBER(@NUM1 INT)
RETURNS INT
AS
BEGIN
	DECLARE @SUM INT
	SET @SUM=0
	WHILE(@NUM1<=20)
		BEGIN
			IF(@NUM1%2=0)
			SET @SUM=@SUM+1
		SET @NUM1=@NUM1+1
	END
RETURN @SUM
END

SELECT DBO.FN_EVEN_NUMBER(1) AS EVEN

--10
--Write a function that checks if a given string is a palindrome
CREATE OR ALTER FUNCTION FN_PALINDROME(@NUM INT)
RETURNS VARCHAR(100)
AS
BEGIN
	DECLARE @SUM INT,@TEMP INT,@REVERSE INT,@MSG VARCHAR(100)
	SET @SUM=0
	SET @TEMP=@NUM
	WHILE(@NUM!=0)
		BEGIN
			SET @REVERSE=@NUM%10
			SET @SUM=@SUM*10+@REVERSE
			SET @NUM=@NUM/10
	END
			IF(@TEMP=@SUM)
				SET @MSG='NUMBER IS PALINDROME'
			ELSE
				SET @MSG='NUMBER IS NOT PALINDROME'
			RETURN @MSG
END

SELECT DBO.FN_PALINDROME(123) AS PALINDROME
SELECT DBO.FN_PALINDROME(121) AS PALINDROME

--Part � C
--11
--Write a function to check whether a given number is prime or not.
CREATE OR ALTER FUNCTION FN_PRIME(@NUM INT)
RETURNS VARCHAR(100)
AS
BEGIN
	DECLARE @MSG VARCHAR(100)
	IF(@NUM%2!=0)
		SET @MSG='NUMBER IS PRIME'
	ELSE
		SET @MSG='NUMBER IS NOT PRIME'
RETURN @MSG
END

SELECT DBO.FN_PRIME(20)

--12
--Write a function which accepts two parameters start date & end date, and returns a difference in days.
CREATE FUNCTION FN_DIFDATE(@STARTDAT DATE,@ENDDATE DATE)
RETURNS INT
AS
BEGIN
	DECLARE @DAY INT
	SET @DAY=DATEDIFF(DAY,@STARTDAT,@ENDDATE)
	RETURN @DAY
END

SELECT DBO.FN_DIFDATE('2024-12-01','2025-12-28') AS DATEDIFFERENCE

--13
--Write a function which accepts two parameters year & month in integer and returns total days each year.
CREATE OR ALTER FUNCTION FN_DATE(@YEAR INT,@MONTH INT)
RETURNS INT
AS 
BEGIN
	DECLARE @ANS VARCHAR(150),@DATE DATE,@DAYS INT
	SET @ANS=CAST(@YEAR AS VARCHAR)+'-'+CAST(@MONTH AS VARCHAR)+'-1'
	SET @DATE=CAST(@ANS AS DATE)
	SET @DAYS=DAY(EOMONTH(@DATE))
	RETURN @DAYS
END

SELECT DBO.FN_DATE(2024,12) AS DAYS_OF_MONTH

--14
--Write a function which accepts departmentID as a parameter & returns a detail of the persons.
CREATE FUNCTION FN_PERSON(@DEPARTMENTID INT)
RETURNS TABLE
	AS
	RETURN
	(SELECT PERSONID,FIRSTNAME,LASTNAME,SALARY,JOININGDATE,DEPARTMENTID,DESIGNATIONID 
	FROM PERSON WHERE DEPARTMENTID=@DEPARTMENTID
	)

SELECT * FROM DBO.FN_PERSON(1)

--15
--Write a function that returns a table with details of all persons who joined after 1-1-1991.
CREATE FUNCTION FN_PERSON_DATE()
RETURNS TABLE
	AS
	RETURN
		(SELECT * FROM PERSON WHERE JOININGDATE >'1991-01-01')
SELECT * FROM FN_PERSON_DATE()
