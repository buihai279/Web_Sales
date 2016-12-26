use master;
DROP DATABASE shop;
CREATE DATABASE Shop;
use Shop;
------------CREATE TABLE------------------------
--------  TABLE NGUOI DUNG -------------
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Users' AND xtype='U')
CREATE TABLE Users (
	UserId int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Fullname nvarchar(255)  NULL,
	EmailAdress nvarchar(255) UNIQUE NULL,
	UserPassword nvarchar(255)  NULL,
	PhoneNumber bigint  NULL,
	UserType nvarchar(255)  NULL default('member'),--admin,manager,member
	DeletedUser bit default(0),--1: người dùng đã bị xóa,0: người dùng bình thường,
	CreatedDate datetime  NULL default(GETDATE())
)
--------  TABLE DANH MUC -------------
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Categories' AND xtype='U')
BEGIN
CREATE TABLE Categories (
	CategoryId int IDENTITY(0,1) PRIMARY KEY NOT NULL,
	CategoryName nvarchar(255) UNIQUE NULL,
	ModifiedDate datetime  NULL default(GETDATE())
)
insert into Categories (CategoryName) values(N'Chưa được phân loại');---INSERT DỮ LIỆU DANH MỤC MẶC ĐỊNH
END
--------  TABLE SAN PHAM -------------
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Products' AND xtype='U')
CREATE TABLE Products (
	ProductId int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	ProductName nvarchar(255) UNIQUE NULL,
	ProductDescription ntext  NULL,
	ProductImage nvarchar(255)  NULL,
	CategoryId int NOT NULL CONSTRAINT fk_categories_products  FOREIGN KEY (CategoryId) REFERENCES Categories(CategoryId),
	Quantity int  NULL CHECK(quantity>=0),
	Price money  NULL CHECK(price>0),
	ProductDeleted bit default(0),--1: Sản phẩm đã bị xóa,0: Sản phẩm bình thường,
	CreatedDate datetime  NULL default(GETDATE()),
	ModifiedDate datetime  NULL default(GETDATE())
)
--------  TABLE  DON HANG -------------
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Orders' AND xtype='U')
CREATE TABLE Orders (
	OrderId int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	UserId int NOT NULL CONSTRAINT fk_User_Order FOREIGN KEY (UserId)	REFERENCES Users(UserId),
	ShipAddress nvarchar(255)  NULL,
	CreatedDate datetime  NULL default(GETDATE()),
)
--------  TABLE CHI TIET DON HANG -------------
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='OrderDetails' AND xtype='U')
CREATE TABLE OrderDetails (
	OrderDetailId int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	OrderId int NOT NULL CONSTRAINT fk_Orders_OrderDetails FOREIGN KEY (OrderId)	REFERENCES Orders(OrderId),
	ProductId int  NULL CONSTRAINT fk_Products_OrderDetails FOREIGN KEY (ProductId) REFERENCES Products(ProductId),
	Quantity nvarchar(255)  NULL,
)
/*--------  TABLE LIEN HE -------------
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='contact' AND xtype='U')
CREATE TABLE contact (
	ContactId int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	EmailAdress nvarchar(255)  NULL,
	ContactMessage text  NULL,
	CreatedDate datetime  NULL default(GETDATE())
)
*/
----------INSERT Du Lieu
insert into categories (CategoryName) values(N'Điện thoại - Máy tính bảng');
insert into categories (CategoryName) values(N'Điện máy - Điện lạnh - Điện gia dụng');
insert into categories (CategoryName) values(N'ĐIỆN MÁY & CÔNG NGHỆ');
insert into categories (CategoryName) values(N'Thời trang nam');
insert into categories (CategoryName) values(N'NHÀ CỬA & ĐỜI SỐNG');
insert into categories (CategoryName) values(N'Sách, VPP & Âm nhạc');
insert into categories (CategoryName) values(N'Dụng cụ thể thao');
insert into categories (CategoryName) values(N'Ô tô - Xe máy');
insert into categories (CategoryName) values(N'THỰC PHẨM');
----
insert into Products(ProductName,CategoryId,Quantity,Price) values('sua vinamilk',1,9,10)
insert into Products(ProductName,CategoryId,Quantity,Price) values('sua th',2,11,9)
insert into Products(ProductName,CategoryId,Quantity,Price) values('sua sda',3,99,9)
----
insert into Users ( EmailAdress,UserPassword) values('admin','123456')
insert into Users ( EmailAdress,UserPassword) values('mod','123456')
------test---
select * from Products;
select * from Categories;
select * from Users;
----
GO
-------------============VIEW ==============------------
/*
IF OBJECT_ID('dbo.vTopProducts','V') IS NOT NULL
	DROP VIEW dbo.vTopProducts
GO
CREATE VIEW dbo.vTopProducts AS
*/
     
-----------============            STORE PROCEDURE          ================--------------------
-----------------------STORE PROCEDURE KIỂM TRA ĐĂNG NHẬP----------------------------------
IF ( OBJECT_ID('dbo.spCheckPassword') IS NOT NULL ) 
   DROP PROCEDURE dbo.spCheckPassword
GO
CREATE PROC spCheckPassword
    @username VARCHAR(255),
    @password varchar(255)
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT TOP 1 * FROM Users WHERE EmailAdress = @username AND UserPassword = @password )
		SELECT 'true' AS UserExists
	ELSE
		SELECT 'false' AS UserExists
END
GO
--exec CheckPassword @UserName='admin', @Password='123456'
-----------------------STORE PROCEDURE ĐỔI MẬT KHẨU----------------------------------
IF ( OBJECT_ID('dbo.spChangePassword') IS NOT NULL ) 
   DROP PROCEDURE dbo.spChangePassword
GO
CREATE PROC spChangePassword
    @email VARCHAR(255),
    @password varchar(255),
    @newpassword varchar(255)
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT TOP 1 * FROM Users WHERE EmailAdress = @email AND UserPassword = @password )
		UPDATE Users SET
		UserPassword = @newpassword
	WHERE 
    EmailAdress = @email
END
GO
--exec spChangePassword @email='admin', @password='123456', @newpassword='654321'
SELECT * FROM Users
-----------------------STORE PROCEDURE ĐĂNG KÝ TÀI KHOẢN MỚI----------------------------------
IF ( OBJECT_ID('dbo.spRegister') IS NOT NULL ) 
   DROP PROCEDURE dbo.spRegister
GO
CREATE PROC spRegister
    @fullname varchar(255),
    @email VARCHAR(255),
    @password varchar(255),
	@phonenumber bigint
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS (SELECT TOP 1 Users.UserId FROM Users WHERE Users.EmailAdress = @email)
	BEGIN
		PRINT 'EMAIL DA TON TAI TRONG CO SO DU LIEU '
	END
	ELSE
	BEGIN
		INSERT INTO Users(Fullname,EmailAdress,UserPassword,PhoneNumber) VALUES(@fullname,@email,@password,@phonenumber)
	END
END
GO

EXEC spRegister @fullname='Hai',@email='admin1', @password='123456', @phonenumber='654321'
SELECT * FROM Users

-----------------------STORE PROCEDURE THÊM DANH MỤC MỚI----------------------------------
IF ( OBJECT_ID('dbo.spInsertCategory') IS NOT NULL ) 
	DROP PROCEDURE dbo.spInsertCategory
GO 
---------------
GO
-----------------------STORE PROCEDURE XÓA DANH MỤC ----------------------------------
IF ( OBJECT_ID('dbo.spDeleteCategory') IS NOT NULL ) 
	DROP PROCEDURE dbo.spDeleteCategory
GO
CREATE PROCEDURE dbo.spDeleteCategory
       @CateID int
AS 
BEGIN 
     SET NOCOUNT ON 
     DELETE FROM Categories Where CategoryId=@CateID
END 
GO
--EXEC spDeleteCategory @CateID=1;
SELECT * FROM Categories
-----------------------STORE PROCEDURE SỬA DANH MỤC----------------------------------
IF ( OBJECT_ID('dbo.spUpdateCategory') IS NOT NULL ) 
	DROP PROCEDURE dbo.spUpdateCategory
GO
CREATE PROCEDURE dbo.spUpdateCategory
       @CateName nvarchar(255),
       @CateID int
AS 
BEGIN 
     SET NOCOUNT ON 
     UPDATE Categories 
	 SET 
		CategoryName=@CateName,
		ModifiedDate= GETDATE()
	WHERE
		CategoryId=@CateID
END 
GO
--EXEC spUpdateCategory @CateID=1,@CateName='000'
--SELECT * FROM Categories
go
-----------------------STORE PROCEDURE THÊM SẢN PHẨM MỚI----------------------------------
go
IF ( OBJECT_ID('dbo.spInsertProduct') IS NOT NULL ) 
   DROP PROCEDURE dbo.spInsertProduct
GO
CREATE PROCEDURE dbo.spInsertProduct
       @ProductName nvarchar(255), 
       @ProductDes ntext= NULL, 
       @ProductImg nvarchar(255), 
       @CategoryID int = NULL, 
       @Quantity int = NULL, 
       @Price Money = NULL                
AS 
BEGIN 
     SET NOCOUNT ON 
     INSERT INTO Products(ProductName,ProductDescription,ProductImage,CategoryId,Quantity,Price,ModifiedDate) 
     VALUES(@ProductName,@ProductDes,@ProductImg,@CategoryID,@Quantity,@Price,GETDATE()) 
	 RETURN 3;
END 
GO
--EXEC spInsertProduct @ProductName='abc1',@ProductDes='abc',@ProductImg='',@CategoryID=9,@Quantity=1,@Price=10
SELECT * FROM Products
-----------------------STORE PROCEDURE LẤY TOÀN BỘ SẢN PHẨM----------------------------------
GO
IF ( OBJECT_ID('dbo.spGetAllProduct') IS NOT NULL ) 
   DROP PROCEDURE dbo.spGetAllProduct
GO
CREATE PROCEDURE dbo.spGetAllProduct
AS 
BEGIN 
     SELECT * FROM Products
END 
GO
--EXEC spGetAllProduct;
SELECT * FROM Products
go
-----------------------STORE PROCEDURE LẤY SẢN PHẨM MỚI NHẤT----------------------------------
GO
IF ( OBJECT_ID('dbo.spGetNewProducts') IS NOT NULL ) 
   DROP PROCEDURE dbo.spGetNewProducts
GO
CREATE PROCEDURE dbo.spGetNewProducts
AS 
BEGIN 
     SET NOCOUNT ON 
     SELECT * FROM Products 
	 ORDER BY CreatedDate DESC
END 
GO
PRINT @@ROWCOUNT
--EXEC spGetNewProducts;
SELECT * FROM Products
go
-----------------------STORE PROCEDURE LẤY SẢN PHẨM MỚI CẬP NHẬY----------------------------------
GO
IF ( OBJECT_ID('dbo.spGetModifiedProducts') IS NOT NULL ) 
   DROP PROCEDURE dbo.spGetModifiedProducts
GO
CREATE PROCEDURE dbo.spGetModifiedProducts
AS 
BEGIN 
     SET NOCOUNT ON 
     SELECT * FROM Products 
	 ORDER BY ModifiedDate DESC
END 
GO
PRINT @@ROWCOUNT
--EXEC spGetModifiedProducts;
SELECT * FROM Products
go
-----------------------STORE PROCEDURE LẤY SẢN TOP PHẨM BÁN CHẠY TRONG THÁNG----------------------------------
GO
IF ( OBJECT_ID('dbo.spGetModifiedProducts') IS NOT NULL ) 
   DROP PROCEDURE dbo.spGetModifiedProducts
GO
CREATE PROCEDURE dbo.spGetModifiedProducts
AS 
BEGIN 
	SET NOCOUNT ON 
	SELECT * FROM Products 
	WHERE ProductId IN (
		SELECT TOP 100 ProductId /*,SUM(CAST(Quantity as int))  AS Total */
		FROM OrderDetails 
		GROUP BY ProductId
		ORDER BY SUM(CAST(Quantity as int)) DESC
	) AND ProductId IN  (
			SELECT OrderId 
			FROM Orders
			WHERE CreatedDate BETWEEN (Select DATEADD(Month, -1, getdate())) AND GETDATE()
	)
END 
GO
PRINT @@ROWCOUNT
--EXEC spGetModifiedProducts;
SELECT * FROM Products
go
-----------------------STORE PROCEDURE ĐẾM SỐ SẢN PHẨM----------------------------------
GO
IF ( OBJECT_ID('dbo.spCountProduct') IS NOT NULL ) 
   DROP PROCEDURE dbo.spCountProduct
GO
CREATE PROCEDURE dbo.spCountProduct
 @CategoryID int = NULL
AS 
BEGIN 
------------Nếu KHÔNG truyền tham số @CategoryID thì đếm toàn bộ sản phẩm trong bảng 
------------Nếu truyền tham số @CategoryID thì đếm những sản phẩm có CategoryID= @CategoryID
	IF(@CategoryID IS NULL)
		SELECT COUNT(*) FROM Products
	ELSE
		SELECT COUNT(*) FROM Products WHERE CategoryId=@CategoryID
END 
GO
--EXEC spCountProduct;
--EXEC spCountProduct @CategoryID=1;

-----------------------STORE PROCEDURE SỬA LẠI SẢN PHẨM----------------------------------
IF ( OBJECT_ID('dbo.spUpdateProduct') IS NOT NULL ) 
   DROP PROCEDURE dbo.spUpdateProduct
GO
CREATE PROCEDURE dbo.spUpdateProduct
       @ProductID int, 
       @ProductName nvarchar(255), 
       @ProductDes ntext, 
       @ProductImg nvarchar(255), 
       @CategoryID int = NULL, 
       @Quantity int = NULL, 
       @Price Money = NULL                
AS 
BEGIN 
	SET NOCOUNT ON 
	UPDATE Products SET
		ProductName = @ProductName,
		ProductDescription=@ProductDes,
		ProductImage=@ProductImg,
		CategoryId=@CategoryID,
		Quantity=@Quantity,
		Price=@Price,
		ModifiedDate=GETDATE()
	WHERE 
    ProductId = @ProductID
END 
go
--EXEC spUpdateProduct @ProductID=2, @ProductName='3333',@ProductDes='abc',@ProductImg='',@CategoryID=9,@Quantity=1,@Price=10
SELECT * FROM Products

-----------------------STORE PROCEDURE XÓA SẢN PHẨM----------------------------------
IF ( OBJECT_ID('dbo.spDeleteProduct') IS NOT NULL ) 
   DROP PROCEDURE dbo.spDeleteProduct
GO
CREATE PROCEDURE dbo.spDeleteProduct
       @ProductID int    
AS 
BEGIN 
	SET NOCOUNT ON 
	UPDATE Products
	SET ProductDeleted=1,ModifiedDate=GETDATE()
	WHERE ProductId = @ProductID
END 
go
--EXEC spDeleteProduct @ProductID=2
SELECT * FROM Products
-----------------------STORE PROCEDURE KHÔI PHỤC SẢN PHẨM----------------------------------
IF ( OBJECT_ID('dbo.sRestoreProduct') IS NOT NULL ) 
   DROP PROCEDURE dbo.sRestoreProduct
GO
CREATE PROCEDURE dbo.sRestoreProduct
       @ProductID int    
AS 
BEGIN 
	SET NOCOUNT ON 
	UPDATE Products
	SET ProductDeleted=0,ModifiedDate=GETDATE()
	WHERE ProductId = @ProductID
END 
go
--EXEC sRestoreProduct @ProductID=2
SELECT * FROM Products
-----------------------STORE PROCEDURE THÊM ĐƠN HÀNG----------------------------------
IF ( OBJECT_ID('dbo.spInsertOrder') IS NOT NULL ) 
	DROP PROCEDURE dbo.spInsertOrder
GO
CREATE PROCEDURE dbo.spInsertOrder
       @UserID int,
       @ShipAddress nvarchar(255)
AS 
DECLARE @newId int
BEGIN 
	INSERT Orders VALUES(@UserID,@ShipAddress,GETDATE())
	SELECT @newId = SCOPE_IDENTITY()
	RETURN @newId
END 
GO
SELECT * FROM OrderDetails
SELECT * FROM Orders
SELECT * FROM Products
GO
-----------------------STORE PROCEDURE THÊM CHI TIẾT ĐƠN HÀNG----------------------------------
IF ( OBJECT_ID('dbo.spInsertOrderDetail') IS NOT NULL ) 
	DROP PROCEDURE dbo.spInsertOrderDetail
GO
CREATE PROCEDURE dbo.spInsertOrderDetail
       @OrderID int,
       @ProductID int,
       @Quantity int
AS 
DECLARE @tmp int;
BEGIN 
	SELECT @tmp=Products.Quantity FROM Products
			WHERE Products.ProductId = @ProductID
	IF(@tmp >= @Quantity)
		BEGIN
			INSERT OrderDetails VALUES(@OrderID,@ProductID,@Quantity)
			UPDATE Products
			SET Products.Quantity=@tmp-@Quantity
			WHERE Products.ProductId = @ProductID
		END
	ELSE 
		ROLLBACK TRANSACTION;
END 
--------------------
DECLARE @newID int;
EXEC @newID=spInsertOrder @UserID=2,@ShipAddress=N'GIAO THỦY';
EXEC spInsertOrderDetail @OrderID=@newID,@ProductID=3,@Quantity=17;
SELECT * FROM OrderDetails
SELECT * FROM Orders
SELECT * FROM Products
GO
----------------TRIGGER------------
----------------TRIGGER Xóa Danh Mục-------------
go
IF OBJECT_ID ('trgDeleteCategory', 'TR') IS NOT NULL  
   DROP TRIGGER trgDeleteCategory;  
go
CREATE TRIGGER trgDeleteCategory  
ON  Categories
INSTEAD OF DELETE 
AS 
	BEGIN
		UPDATE Products
		SET Products.CategoryId=0
		WHERE Products.CategoryId IN (SELECT deleted.CategoryId FROM deleted)
		--DELETE Products FROM Products WHERE Products.CategoryId IN (SELECT deleted.CategoryId FROM deleted)
		DELETE Categories FROM Categories WHERE Categories.CategoryId IN (SELECT deleted.CategoryId FROM deleted)
	END
GO
-----------------TEST
--DELETE Categories WHERE CategoryId=3;
SELECT * FROM Products
SELECT * FROM Categories
----------------TRIGGER Thêm Đơn Hàng-------------
go
---------------------------------------------------------
go