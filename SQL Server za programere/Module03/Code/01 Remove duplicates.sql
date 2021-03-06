-------------------------------------------------------------------------------------
-- Workshop: SQL Server for Application Developers
-- Module 3: Common Transact-SQL Tasks - Remove duplicates
-- Milos Radivojevic, Data Platform MVP, bwin, Austria
-- E: milos.radivojevic@chello.at
-- W: https://milossql.wordpress.com/
-------------------------------------------------------------------------------------


USE StaraSrbija;
GO
DROP TABLE IF EXISTS dbo.tabPerson;
CREATE TABLE dbo.tabPerson(
	Id INT NOT NULL, 
	FirstName NVARCHAR(20),
	LastName NVARCHAR(30) NOT NULL,
	MiddleName NVARCHAR(30),
	DateOfBirth DATE,
	CreatedOn DATETIME CONSTRAINT DF_X_CreatedON DEFAULT GETDATE()
)
GO
INSERT INTO dbo.tabPerson(Id, FirstName,LastName,MiddleName,DateOfBirth)
VALUES(1,N'Cristiano', N'Ronaldo',N'CR7','19850215'),
(2,N'Lionel', N'Messi',N'','19870724'),
(3,N'Diego', N'Maradona',N'Armando','19601030'),
(4,N'Cristiano', N'Ronaldo',N'','19950215'),
(5,N'Lionel', N'Messi',N'','19870724'),
(6,N'Diego', N'Maradona',N'Armando','19601031'),
(7,N'Diego', N'Costa',N'da Silva','19881007') ,
(8,N'Diego', N'Maradona',N'Armando','19601031'),
(9,N'Ljuba', N'Aličić',N'','19551102'),
(10,N'Amar', N'Gile',N'','19901230') 
GO
SELECT * FROM dbo.tabPerson;
GO

SELECT * ,
ROW_NUMBER() OVER(ORDER BY Id DESC) rn
FROM dbo.tabPerson;




SELECT *, ROW_NUMBER() 
OVER(PARTITION BY FirstName, LastName, MiddleName ORDER BY id DESC) rn 
FROM dbo.tabPerson

SELECT *, ROW_NUMBER() 
OVER(PARTITION BY FirstName, LastName, MiddleName ORDER BY id DESC) rn 
FROM dbo.tabPerson

;WITH cte AS(
SELECT *, ROW_NUMBER()  
OVER(PARTITION BY FirstName, LastName, MiddleName ORDER BY id DESC) rn 
FROM dbo.tabPerson
)
DELETE FROM cte WHERE rn > 1;


