--Create the Products table
CREATE TABLE Products (
 Product_id INT PRIMARY KEY,
 Product_Name VARCHAR(250) NOT NULL,
 Price DECIMAL(10, 2) NOT NULL
);
-- Insert data into the Products table
INSERT INTO Products (Product_id, Product_Name, Price) VALUES
(1, 'Smartphone', 35000),
(2, 'Laptop', 65000),
(3, 'Headphones', 5500),
(4, 'Television', 85000),
(5, 'Gaming Console', 32000);

--Part - A

--1
--Create a cursor Product_Cursor to fetch all the rows from a products table.
DECLARE @PRODUCT_ID INT,@PRODUCT_NAME VARCHAR(100),@PRICE DECIMAL(10,2)

DECLARE PRODUCT_CURSOR CURSOR
FOR 
	SELECT * FROM PRODUCTS

OPEN PRODUCT_CURSOR
FETCH NEXT FROM PRODUCT_CURSOR
INTO @PRODUCT_ID,@PRODUCT_NAME,@PRICE

WHILE @@FETCH_STATUS=0
BEGIN 
	SELECT @PRODUCT_ID,@PRODUCT_NAME,@PRICE
	FETCH NEXT FROM PRODUCT_CURSOR
	INTO @PRODUCT_ID,@PRODUCT_NAME,@PRICE
END

CLOSE PRODUCT_CURSOR
DEALLOCATE PRODUCT_CURSOR

--2
--Create a cursor Product_Cursor_Fetch to fetch the records in form of ProductID_ProductName.(Example: 1_Smartphone)
DECLARE PRODUCT_CURSOR_FETCH CURSOR
FOR 
	SELECT CAST(PRODUCT_ID AS VARCHAR) + '_' + PRODUCT_NAME AS PRODUCT_INFO FROM PRODUCTS

OPEN PRODUCT_CURSOR_FETCH 

DECLARE @PRODUCT_INFO VARCHAR(100)

FETCH NEXT FROM PRODUCT_CURSOR_FETCH INTO @PRODUCT_INFO

WHILE @@FETCH_STATUS=0
BEGIN
	PRINT @PRODUCT_INFO
	FETCH NEXT FROM PRODUCT_CURSOR_FETCH INTO @PRODUCT_INFO
END

CLOSE PRODUCT_CURSOR_FETCH
DEALLOCATE PRODUCT_CURSOR_FETCH

--3
--Create a Cursor to Find and Display Products Above Price 30,000.
DECLARE @PRODUCT_NAME VARCHAR(100),@PRICE DECIMAL(10,2)
DECLARE CURSOR_PRODUCT CURSOR
FOR
	SELECT PRODUCT_NAME,PRICE FROM PRODUCTS

OPEN CURSOR_PRODUCT
FETCH NEXT FROM CURSOR_PRODUCT
INTO @PRODUCT_NAME,@PRICE

WHILE @@FETCH_STATUS=0
BEGIN
	IF @PRICE>30000
		PRINT @PRODUCT_NAME
		FETCH NEXT FROM CURSOR_PRODUCT
		INTO @PRODUCT_NAME,@PRICE
END

CLOSE CURSOR_PRODUCT
DEALLOCATE CURSOR_PRODUCT

--4
--Create a cursor Product_CursorDelete that deletes all the data from the Products table.
DECLARE @PRODUCT_ID INT
DECLARE PRODUCT_CURSORDELETE CURSOR
FOR
	SELECT PRODUCT_ID FROM PRODUCTS

OPEN PRODUCT_CURSORDELETE
FETCH NEXT FROM PRODUCT_CURSORDELETE
INTO @PRODUCT_ID

WHILE @@FETCH_STATUS=0
BEGIN
	DELETE FROM PRODUCTS WHERE PRODUCT_ID=@PRODUCT_ID
	FETCH NEXT FROM PRODUCT_CURSORDELETE
	INTO @PRODUCT_ID
END

CLOSE PRODUCT_CURSORDELETE
DEALLOCATE PRODUCT_CURSORDELETE

--Part � B

--5
--Create a cursor Product_CursorUpdate that retrieves all the data from the products table and increases the price by 10%.
DECLARE @PRODUCT_ID INT,@PRICE DECIMAL(10,2)

DECLARE PRODUCT_CURSORUPDATE CURSOR
FOR
	SELECT PRODUCT_ID,PRICE FROM PRODUCTS

OPEN PRODUCT_CURSORUPDATE
FETCH NEXT FROM PRODUCT_CURSORUPDATE
INTO @PRODUCT_ID,@PRICE

WHILE @@FETCH_STATUS=0
BEGIN
	UPDATE PRODUCTS
	SET @PRICE=@PRICE+(@PRICE*0.1)
	WHERE PRODUCT_ID=@PRODUCT_ID
	FETCH NEXT FROM PRODUCT_CURSORUPDATE
	INTO @PRODUCT_ID,@PRICE
END

CLOSE PRODUCT_CURSORUPDATE
DEALLOCATE PRODUCT_CURSORUPDATE

--6
--Create a Cursor to Rounds the price of each product to the nearest whole number.
DECLARE @PRODUCT_ID INT,@PRICE DECIMAL(10,2)

DECLARE PRODUCT_ROUND CURSOR
FOR
	SELECT PRODUCT_ID,PRICE FROM PRODUCTS

OPEN PRODUCT_ROUND 
FETCH NEXT FROM PRODUCT_ROUND
INTO @PRODUCT_ID,@PRICE

WHILE @@FETCH_STATUS=0
BEGIN
	SELECT ROUND(@PRICE,0)
	FETCH NEXT FROM PRODUCT_ROUND
END

CLOSE PRODUCT_ROUND
DEALLOCATE PRODUCT_ROUND

--Part � C
--7
--Create a cursor to insert details of Products into the NewProducts table if the product is �Laptop�
--(Note: Create NewProducts table first with same fields as Products table)
CREATE TABLE NEWPRODUCTS (
 Product_id INT PRIMARY KEY,
 Product_Name VARCHAR(250) NOT NULL,
 Price DECIMAL(10, 2) NOT NULL
);

DECLARE @PRODUCT_ID INT,@PRODUCT_NAME VARCHAR(250),@PRICE DECIMAL(10,2)

DECLARE PRODUCT_CURSOR CURSOR
FOR
	SELECT PRODUCT_ID,PRODUCT_NAME,PRICE FROM PRODUCTS WHERE PRODUCT_NAME='LAPTOP'

OPEN PRODUCT_CURSOR
FETCH NEXT FROM PRODUCT_CURSOR INTO @PRODUCT_ID,@PRODUCT_NAME,@PRICE

WHILE @@FETCH_STATUS=0
BEGIN
	INSERT INTO NEWPRODUCTS VALUES(@PRODUCT_ID,@PRODUCT_NAME,@PRICE)

	FETCH NEXT FROM PRODUCT_CURSOR INTO @PRODUCT_ID,@PRODUCT_NAME,@PRICE
END

CLOSE PRODUCT_CURSOR
DEALLOCATE PRODUCT_CURSOR

--8
--Create a Cursor to Archive High-Price Products in a New Table (ArchivedProducts), Moves products
--with a price above 50000 to an archive table, removing them from the original Products table.
CREATE TABLE ARCHIVEDPRODUCTS (
 Product_id INT PRIMARY KEY,
 Product_Name VARCHAR(250) NOT NULL,
 Price DECIMAL(10, 2) NOT NULL
);

DECLARE @PRODUCT_ID INT,@PRODUCT_NAME VARCHAR(250),@PRICE DECIMAL(10,2)

DECLARE REMOVE_CURSOR CURSOR
FOR
	SELECT PRODUCT_ID,PRODUCT_NAME,PRICE FROM PRODUCTS WHERE PRICE>50000

OPEN REMOVE_CURSOR
FETCH NEXT FROM REMOVE_CURSOR INTO @PRODUCT_ID,@PRODUCT_NAME,@PRICE

WHILE @@FETCH_STATUS=0
BEGIN
	INSERT INTO ARCHIVEDPRODUCTS VALUES(@PRODUCT_ID,@PRODUCT_NAME,@PRICE)
	DELETE FROM PRODUCTS WHERE PRODUCT_ID=@PRODUCT_ID

	FETCH NEXT FROM PRODUCT_CURSOR INTO @PRODUCT_ID,@PRODUCT_NAME,@PRICE
END

CLOSE REMOVE_CURSOR
DEALLOCATE REMOVE_CURSOR