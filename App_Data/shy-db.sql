USE [master]
GO
/****** Object:  Database [shy]    Script Date: 7/14/2018 9:41:30 AM ******/
CREATE DATABASE [shy]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'shy', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\shy.mdf' , SIZE = 132672KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'shy_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\shy_1.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [shy] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [shy].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [shy] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [shy] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [shy] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [shy] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [shy] SET ARITHABORT OFF 
GO
ALTER DATABASE [shy] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [shy] SET AUTO_SHRINK ON 
GO
ALTER DATABASE [shy] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [shy] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [shy] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [shy] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [shy] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [shy] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [shy] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [shy] SET  DISABLE_BROKER 
GO
ALTER DATABASE [shy] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [shy] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [shy] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [shy] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [shy] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [shy] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [shy] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [shy] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [shy] SET  MULTI_USER 
GO
ALTER DATABASE [shy] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [shy] SET DB_CHAINING OFF 
GO
ALTER DATABASE [shy] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [shy] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [shy] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [shy] SET QUERY_STORE = OFF
GO
USE [shy]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [shy]
GO
/****** Object:  User [shy]    Script Date: 7/14/2018 9:41:31 AM ******/
CREATE USER [shy] FOR LOGIN [shy] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [shy]
GO
/****** Object:  Table [dbo].[subscribers]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[subscribers](
	[id] [uniqueidentifier] NOT NULL,
	[firstname] [nvarchar](20) NULL,
	[lastname] [nvarchar](20) NULL,
	[phone] [nvarchar](20) NULL,
	[email] [nvarchar](50) NOT NULL,
	[address] [nvarchar](255) NULL,
	[city] [nvarchar](20) NULL,
	[state] [nchar](2) NULL,
	[zipcode] [nvarchar](10) NULL,
	[opt_out] [bit] NOT NULL,
	[email2] [nvarchar](50) NULL,
	[phone2] [nvarchar](20) NULL,
 CONSTRAINT [PK_subscriber] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Email List]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Email List]
AS
SELECT        TOP (100) PERCENT email
FROM            dbo.subscribers
ORDER BY email
GO
/****** Object:  Table [dbo].[locations]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[locations](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[active] [bit] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_locations] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[students]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[students](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[active] [bit] NOT NULL,
	[firstname] [nvarchar](20) NOT NULL,
	[lastname] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_students] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_students_name] UNIQUE NONCLUSTERED 
(
	[firstname] ASC,
	[lastname] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[attendances]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[attendances](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[instructor_id] [uniqueidentifier] NOT NULL,
	[class_id] [uniqueidentifier] NOT NULL,
	[location_id] [uniqueidentifier] NOT NULL,
	[student_id] [uniqueidentifier] NOT NULL,
	[class_date] [date] NOT NULL,
 CONSTRAINT [PK_attendances] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_attendances] UNIQUE NONCLUSTERED 
(
	[instructor_id] ASC,
	[class_id] ASC,
	[location_id] ASC,
	[student_id] ASC,
	[class_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[students_who_go_to_SH]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[students_who_go_to_SH]
AS
SELECT DISTINCT TOP (100) PERCENT dbo.students.lastname + ', ' + dbo.students.firstname AS Student, dbo.locations.name AS School
FROM            dbo.students INNER JOIN
                         dbo.attendances ON dbo.students.id = dbo.attendances.student_id INNER JOIN
                         dbo.locations ON dbo.attendances.location_id = dbo.locations.id
WHERE        (dbo.locations.name = 'Squirrel Hill') AND (dbo.attendances.class_date BETWEEN DATEFROMPARTS(YEAR(GETDATE()), 1, 1) AND GETDATE()) AND 
                         (dbo.students.firstname IS NOT NULL) AND (dbo.students.lastname IS NOT NULL)
ORDER BY 'Student'
GO
/****** Object:  View [dbo].[students_who_go_to_SD]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[students_who_go_to_SD]
AS
SELECT DISTINCT TOP (100) PERCENT dbo.students.lastname + ', ' + dbo.students.firstname AS Student, dbo.locations.name AS School
FROM            dbo.students INNER JOIN
                         dbo.attendances ON dbo.students.id = dbo.attendances.student_id INNER JOIN
                         dbo.locations ON dbo.attendances.location_id = dbo.locations.id
WHERE        (dbo.locations.name = 'Strip District') AND (dbo.attendances.class_date BETWEEN DATEFROMPARTS(YEAR(GETDATE()), 1, 1) AND GETDATE()) AND 
                         (dbo.students.firstname IS NOT NULL) AND (dbo.students.lastname IS NOT NULL)
ORDER BY 'Student'
GO
/****** Object:  View [dbo].[students_who_go_to_NH]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[students_who_go_to_NH]
AS
SELECT DISTINCT TOP (100) PERCENT dbo.students.lastname + ', ' + dbo.students.firstname AS Student, dbo.locations.name AS School
FROM            dbo.students INNER JOIN
                         dbo.attendances ON dbo.students.id = dbo.attendances.student_id INNER JOIN
                         dbo.locations ON dbo.attendances.location_id = dbo.locations.id
WHERE        (dbo.locations.name = 'North Hills') AND (dbo.attendances.class_date BETWEEN DATEFROMPARTS(YEAR(GETDATE()), 1, 1) AND GETDATE()) AND 
                         (dbo.students.firstname IS NOT NULL) AND (dbo.students.lastname IS NOT NULL)
ORDER BY 'Student'
GO
/****** Object:  View [dbo].[subscriber_zipcodes]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[subscriber_zipcodes]
AS
SELECT        address, city, state, zipcode, lastname + ', ' + firstname AS Student
FROM            dbo.subscribers
WHERE        (lastname IS NOT NULL) AND (zipcode IS NOT NULL) AND (firstname IS NOT NULL)
GO
/****** Object:  View [dbo].[NH_zipcodes]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[NH_zipcodes]
AS
SELECT DISTINCT TOP (100) PERCENT dbo.students_who_go_to_NH.Student, dbo.students_who_go_to_NH.School, dbo.subscriber_zipcodes.Zipcode
FROM            dbo.students_who_go_to_NH INNER JOIN
                         dbo.subscriber_zipcodes ON dbo.students_who_go_to_NH.Student = dbo.subscriber_zipcodes.Student
ORDER BY dbo.students_who_go_to_NH.Student
GO
/****** Object:  Table [dbo].[class_purchases]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[class_purchases](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[student_id] [uniqueidentifier] NOT NULL,
	[purchased_on] [datetime] NOT NULL,
	[quantity] [smallint] NULL,
	[payment_type_id] [uniqueidentifier] NOT NULL,
	[location_id] [uniqueidentifier] NULL,
	[instructor_id] [uniqueidentifier] NULL,
	[class_id] [uniqueidentifier] NULL,
	[source_ip] [varchar](50) NULL,
 CONSTRAINT [PK_class_purchases] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[students_purchased_attended]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[students_purchased_attended]
AS
SELECT        student.firstname, student.lastname, SUM(purchases.quantity) AS classes_purchased, COUNT(attendances.id) AS classes_attended
FROM            dbo.students AS student LEFT OUTER JOIN
                         dbo.attendances AS attendances ON student.id = attendances.student_id LEFT OUTER JOIN
                         dbo.class_purchases AS purchases ON student.id = purchases.student_id
GROUP BY student.firstname, student.lastname, student.id
GO
/****** Object:  View [dbo].[SS_zipcodes]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SS_zipcodes]
AS
SELECT DISTINCT 
                         TOP (100) PERCENT dbo.students_who_go_to_SS.Student, dbo.students_who_go_to_SS.School, dbo.subscriber_zipcodes.address, 
                         dbo.subscriber_zipcodes.city, dbo.subscriber_zipcodes.state, dbo.subscriber_zipcodes.zipcode
FROM            dbo.students_who_go_to_SS INNER JOIN
                         dbo.subscriber_zipcodes ON dbo.students_who_go_to_SS.Student = dbo.subscriber_zipcodes.Student
ORDER BY dbo.students_who_go_to_SS.Student
GO
/****** Object:  View [dbo].[SD_zipcodes]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SD_zipcodes]
AS
SELECT DISTINCT TOP (100) PERCENT dbo.students_who_go_to_SD.Student, dbo.students_who_go_to_SD.School, dbo.subscriber_zipcodes.Zipcode
FROM            dbo.students_who_go_to_SD INNER JOIN
                         dbo.subscriber_zipcodes ON dbo.students_who_go_to_SD.Student = dbo.subscriber_zipcodes.Student
ORDER BY dbo.students_who_go_to_SD.Student
GO
/****** Object:  View [dbo].[SH_zipcodes]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SH_zipcodes]
AS
SELECT DISTINCT TOP (100) PERCENT dbo.students_who_go_to_SH.Student, dbo.students_who_go_to_SH.School, dbo.subscriber_zipcodes.Zipcode
FROM            dbo.students_who_go_to_SH INNER JOIN
                         dbo.subscriber_zipcodes ON dbo.students_who_go_to_SH.Student = dbo.subscriber_zipcodes.Student
ORDER BY dbo.students_who_go_to_SH.Student
GO
/****** Object:  View [dbo].[students_schools]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[students_schools]
AS
SELECT DISTINCT TOP (100) PERCENT dbo.students.lastname + ', ' + dbo.students.firstname AS Student, dbo.locations.name AS School
FROM            dbo.students INNER JOIN
                         dbo.attendances ON dbo.students.id = dbo.attendances.student_id INNER JOIN
                         dbo.locations ON dbo.attendances.location_id = dbo.locations.id
WHERE        (dbo.students.firstname IS NOT NULL) AND (dbo.students.lastname IS NOT NULL) AND (dbo.attendances.class_date BETWEEN 
                         DATEFROMPARTS(YEAR(GETDATE()) - 1, 1, 1) AND GETDATE())
ORDER BY 'Student'
GO
/****** Object:  View [dbo].[attendees]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[attendees]
AS
SELECT     dbo.attendances.id, dbo.students.lastname + ', ' + dbo.students.firstname AS name, dbo.attendances.class_date, dbo.attendances.instructor_id, 
                      dbo.attendances.class_id, dbo.attendances.location_id, dbo.attendances.student_id
FROM         dbo.attendances INNER JOIN
                      dbo.students ON dbo.attendances.student_id = dbo.students.id
GO
/****** Object:  View [dbo].[student_balances]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[student_balances]
AS
SELECT        id, firstname, lastname,
                             (SELECT        ISNULL(SUM(quantity), 0) AS purchases
                               FROM            dbo.class_purchases
                               WHERE        (student_id = dbo.students.id)) +
                             (SELECT        - COUNT(*) AS attendances
                               FROM            dbo.attendances
                               WHERE        (student_id = dbo.students.id)) AS balance,
                             (SELECT        MAX(class_date) AS Expr1
                               FROM            dbo.attendees
                               WHERE        (student_id = dbo.students.id)) AS last_attended,
                             (SELECT        MAX(purchased_on) AS Expr2
                               FROM            dbo.class_purchases AS class_purchases_1
                               WHERE        (student_id = dbo.students.id)) AS last_purchase
FROM            dbo.students
WHERE        (active = 1)
GO
/****** Object:  View [dbo].[free_classes]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[free_classes]
AS
SELECT        TOP (100) PERCENT dbo.students.firstname, dbo.students.lastname, dbo.class_purchases.purchased_on AS credit_issued_on, dbo.class_purchases.quantity
FROM            dbo.class_purchases INNER JOIN
                         dbo.students ON dbo.class_purchases.student_id = dbo.students.id
WHERE        (dbo.class_purchases.payment_type_id = '33E6600E-65B6-40BE-A1D8-78908F9D1BD8')
ORDER BY dbo.students.lastname, dbo.students.firstname
GO
/****** Object:  Table [dbo].[instructors]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[instructors](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[active] [bit] NOT NULL,
	[firstname] [nvarchar](20) NOT NULL,
	[lastname] [nvarchar](20) NOT NULL,
	[email] [nvarchar](50) NULL,
 CONSTRAINT [PK_instructors] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_instructors_name] UNIQUE NONCLUSTERED 
(
	[lastname] ASC,
	[firstname] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[classes]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[classes](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[active] [bit] NOT NULL,
	[name] [nvarchar](80) NOT NULL,
 CONSTRAINT [PK_classes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[attendances_full_info]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[attendances_full_info]
AS
SELECT     TOP (100) PERCENT dbo.instructors.lastname + ', ' + dbo.instructors.firstname AS instructor, dbo.classes.name AS class, dbo.locations.name AS location, 
                      dbo.attendances.class_date, dbo.students.lastname + ', ' + dbo.students.firstname AS student
FROM         dbo.attendances INNER JOIN
                      dbo.instructors ON dbo.attendances.instructor_id = dbo.instructors.id INNER JOIN
                      dbo.students ON dbo.attendances.student_id = dbo.students.id INNER JOIN
                      dbo.locations ON dbo.attendances.location_id = dbo.locations.id INNER JOIN
                      dbo.classes ON dbo.attendances.class_id = dbo.classes.id
ORDER BY instructor, class, location, dbo.attendances.class_date
GO
/****** Object:  View [dbo].[class_counts]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[class_counts]
AS
SELECT     TOP (100) PERCENT dbo.instructors.lastname + ', ' + dbo.instructors.firstname AS instructor, dbo.classes.name AS class, dbo.locations.name AS location, 
                      dbo.attendances.class_date, COUNT(dbo.attendances.student_id) AS students
FROM         dbo.attendances INNER JOIN
                      dbo.instructors ON dbo.attendances.instructor_id = dbo.instructors.id INNER JOIN
                      dbo.students ON dbo.attendances.student_id = dbo.students.id INNER JOIN
                      dbo.locations ON dbo.attendances.location_id = dbo.locations.id INNER JOIN
                      dbo.classes ON dbo.attendances.class_id = dbo.classes.id
GROUP BY dbo.instructors.lastname + ', ' + dbo.instructors.firstname, dbo.classes.name, dbo.locations.name, dbo.attendances.class_date
ORDER BY instructor, class, location, dbo.attendances.class_date
GO
/****** Object:  View [dbo].[attendances_location]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[attendances_location]
AS
SELECT     TOP (100) PERCENT dbo.locations.name AS location, dbo.classes.name AS class, dbo.instructors.lastname + ', ' + dbo.instructors.firstname AS instructor, 
                      dbo.attendances.class_date, COUNT(dbo.attendances.student_id) AS students
FROM         dbo.attendances INNER JOIN
                      dbo.locations ON dbo.attendances.location_id = dbo.locations.id INNER JOIN
                      dbo.instructors ON dbo.attendances.instructor_id = dbo.instructors.id INNER JOIN
                      dbo.classes ON dbo.attendances.class_id = dbo.classes.id
GROUP BY dbo.locations.name, dbo.attendances.class_date, dbo.instructors.lastname, dbo.instructors.firstname, dbo.classes.name
ORDER BY location, dbo.attendances.class_date
GO
/****** Object:  Table [dbo].[payment_types]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[payment_types](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[name] [nvarchar](16) NOT NULL,
	[ordinal] [tinyint] NULL,
	[active] [bit] NULL,
 CONSTRAINT [PK_payment_types] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[purchases_full_info]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[purchases_full_info]
AS
SELECT     TOP (100) PERCENT dbo.students.lastname, dbo.students.firstname, dbo.class_purchases.purchased_on, dbo.class_purchases.quantity, 
                      dbo.payment_types.name AS method, dbo.locations.name AS location, dbo.instructors.lastname + ', ' + dbo.instructors.firstname AS instructor, 
                      dbo.classes.name AS class, dbo.class_purchases.source_ip
FROM         dbo.class_purchases INNER JOIN
                      dbo.students ON dbo.class_purchases.student_id = dbo.students.id INNER JOIN
                      dbo.payment_types ON dbo.class_purchases.payment_type_id = dbo.payment_types.id LEFT OUTER JOIN
                      dbo.locations ON dbo.class_purchases.location_id = dbo.locations.id LEFT OUTER JOIN
                      dbo.instructors ON dbo.class_purchases.instructor_id = dbo.instructors.id LEFT OUTER JOIN
                      dbo.classes ON dbo.class_purchases.class_id = dbo.classes.id
ORDER BY dbo.students.lastname, dbo.students.firstname, dbo.class_purchases.purchased_on DESC
GO
/****** Object:  View [dbo].[purchase_duplicates]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[purchase_duplicates]
AS
SELECT     TOP (100) PERCENT dbo.students.lastname + ', ' + dbo.students.firstname AS student, dbo.class_purchases.purchased_on, dbo.class_purchases.quantity, 
                      dbo.payment_types.name AS method, COUNT(*) AS counter
FROM         dbo.class_purchases INNER JOIN
                      dbo.students ON dbo.class_purchases.student_id = dbo.students.id INNER JOIN
                      dbo.payment_types ON dbo.class_purchases.payment_type_id = dbo.payment_types.id
GROUP BY dbo.students.lastname + ', ' + dbo.students.firstname, dbo.class_purchases.purchased_on, dbo.class_purchases.quantity, dbo.payment_types.name
HAVING      (COUNT(*) > 1)
ORDER BY dbo.class_purchases.purchased_on DESC
GO
/****** Object:  View [dbo].[cash_collected]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*GROUP BY location*/
CREATE VIEW [dbo].[cash_collected]
AS
SELECT     location, SUM(CASE quantity WHEN 1 THEN 15 WHEN 4 THEN 50 WHEN 8 THEN 80 WHEN 12 THEN 100 END) AS cash
FROM         dbo.purchases_full_info
WHERE     (method = 'Cash') AND (location IS NOT NULL) AND (location <> 'Z-Office Use Only') AND (purchased_on >= DATEADD(day, - 7, GETDATE()))
GROUP BY location
GO
/****** Object:  View [dbo].[students_who_owe]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[students_who_owe]
AS
SELECT        TOP (100) PERCENT lastname + ', ' + firstname AS name, balance
FROM            dbo.student_balances
WHERE        (balance < 0)
ORDER BY lastname, firstname
GO
/****** Object:  View [dbo].[students_with_balances_over_6mths]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* AND (dbo.attendances.id IS NULL)*/
CREATE VIEW [dbo].[students_with_balances_over_6mths]
AS
SELECT        TOP (100) PERCENT id, firstname, lastname, balance
FROM            dbo.student_balances
WHERE        (id NOT IN
                             (SELECT DISTINCT student_id
                               FROM            dbo.class_purchases
                               WHERE        (purchased_on >= DATEADD(m, - 6, GETDATE())))) AND (id NOT IN
                             (SELECT DISTINCT student_id
                               FROM            dbo.attendances
                               WHERE        (class_date >= DATEADD(m, - 6, GETDATE())))) AND (balance > 0)
ORDER BY lastname, firstname
GO
/****** Object:  View [dbo].[NorthHillsQtrlyAttendances]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[NorthHillsQtrlyAttendances]
AS
SELECT        SUM(students) AS attendances_last_quarter
FROM            dbo.attendances_location
WHERE        (location = 'North Hills') AND (class_date BETWEEN '10/1/2017' AND '12/31/2017')
GO
/****** Object:  Index [IX_attendance_session]    Script Date: 7/14/2018 9:41:31 AM ******/
CREATE NONCLUSTERED INDEX [IX_attendance_session] ON [dbo].[attendances]
(
	[instructor_id] ASC,
	[class_id] ASC,
	[location_id] ASC,
	[class_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_class_purchases_date]    Script Date: 7/14/2018 9:41:31 AM ******/
CREATE NONCLUSTERED INDEX [IX_class_purchases_date] ON [dbo].[class_purchases]
(
	[purchased_on] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_class_purchases_student]    Script Date: 7/14/2018 9:41:31 AM ******/
CREATE NONCLUSTERED INDEX [IX_class_purchases_student] ON [dbo].[class_purchases]
(
	[student_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_classes_active]    Script Date: 7/14/2018 9:41:31 AM ******/
CREATE NONCLUSTERED INDEX [IX_classes_active] ON [dbo].[classes]
(
	[active] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_classes_name]    Script Date: 7/14/2018 9:41:31 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_classes_name] ON [dbo].[classes]
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_instructors_active]    Script Date: 7/14/2018 9:41:31 AM ******/
CREATE NONCLUSTERED INDEX [IX_instructors_active] ON [dbo].[instructors]
(
	[active] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_instructors_lastname]    Script Date: 7/14/2018 9:41:31 AM ******/
CREATE NONCLUSTERED INDEX [IX_instructors_lastname] ON [dbo].[instructors]
(
	[lastname] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_locations_active]    Script Date: 7/14/2018 9:41:31 AM ******/
CREATE NONCLUSTERED INDEX [IX_locations_active] ON [dbo].[locations]
(
	[active] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_locations_name]    Script Date: 7/14/2018 9:41:31 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_locations_name] ON [dbo].[locations]
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_payment_types]    Script Date: 7/14/2018 9:41:31 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_payment_types] ON [dbo].[payment_types]
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_students_active]    Script Date: 7/14/2018 9:41:31 AM ******/
CREATE NONCLUSTERED INDEX [IX_students_active] ON [dbo].[students]
(
	[active] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_students_firstname]    Script Date: 7/14/2018 9:41:31 AM ******/
CREATE NONCLUSTERED INDEX [IX_students_firstname] ON [dbo].[students]
(
	[firstname] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_students_lastname]    Script Date: 7/14/2018 9:41:31 AM ******/
CREATE NONCLUSTERED INDEX [IX_students_lastname] ON [dbo].[students]
(
	[lastname] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_subscriber_email]    Script Date: 7/14/2018 9:41:31 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_subscriber_email] ON [dbo].[subscribers]
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_subscriber_firstname]    Script Date: 7/14/2018 9:41:31 AM ******/
CREATE NONCLUSTERED INDEX [IX_subscriber_firstname] ON [dbo].[subscribers]
(
	[firstname] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_subscriber_lastname]    Script Date: 7/14/2018 9:41:31 AM ******/
CREATE NONCLUSTERED INDEX [IX_subscriber_lastname] ON [dbo].[subscribers]
(
	[lastname] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_subscriber_opt_out]    Script Date: 7/14/2018 9:41:31 AM ******/
CREATE NONCLUSTERED INDEX [IX_subscriber_opt_out] ON [dbo].[subscribers]
(
	[opt_out] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[attendances] ADD  CONSTRAINT [DF_attendances_id]  DEFAULT (newid()) FOR [id]
GO
ALTER TABLE [dbo].[attendances] ADD  CONSTRAINT [DF_attendances_attended]  DEFAULT (getdate()) FOR [class_date]
GO
ALTER TABLE [dbo].[class_purchases] ADD  CONSTRAINT [DF_class_purchases_id]  DEFAULT (newid()) FOR [id]
GO
ALTER TABLE [dbo].[class_purchases] ADD  CONSTRAINT [DF_class_purchases_purchased_on]  DEFAULT (getdate()) FOR [purchased_on]
GO
ALTER TABLE [dbo].[classes] ADD  CONSTRAINT [DF_classes_id]  DEFAULT (newid()) FOR [id]
GO
ALTER TABLE [dbo].[classes] ADD  CONSTRAINT [DF_classes_active]  DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [dbo].[instructors] ADD  CONSTRAINT [DF_instructors_id_1]  DEFAULT (newid()) FOR [id]
GO
ALTER TABLE [dbo].[instructors] ADD  CONSTRAINT [DF_instructors_active_1]  DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [dbo].[locations] ADD  CONSTRAINT [DF_locations_id]  DEFAULT (newid()) FOR [id]
GO
ALTER TABLE [dbo].[locations] ADD  CONSTRAINT [DF_locations_active]  DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [dbo].[payment_types] ADD  CONSTRAINT [DF_payment_types_id]  DEFAULT (newid()) FOR [id]
GO
ALTER TABLE [dbo].[payment_types] ADD  CONSTRAINT [DF_payment_types_active]  DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [dbo].[students] ADD  CONSTRAINT [DF_students_id]  DEFAULT (newid()) FOR [id]
GO
ALTER TABLE [dbo].[students] ADD  CONSTRAINT [DF_students_active]  DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [dbo].[subscribers] ADD  CONSTRAINT [DF_subscribers_id]  DEFAULT (newid()) FOR [id]
GO
ALTER TABLE [dbo].[subscribers] ADD  CONSTRAINT [DF_subscribers_opt_out]  DEFAULT ((0)) FOR [opt_out]
GO
ALTER TABLE [dbo].[attendances]  WITH CHECK ADD  CONSTRAINT [FK_attendances_classes] FOREIGN KEY([class_id])
REFERENCES [dbo].[classes] ([id])
GO
ALTER TABLE [dbo].[attendances] CHECK CONSTRAINT [FK_attendances_classes]
GO
ALTER TABLE [dbo].[attendances]  WITH CHECK ADD  CONSTRAINT [FK_attendances_instructors] FOREIGN KEY([instructor_id])
REFERENCES [dbo].[instructors] ([id])
GO
ALTER TABLE [dbo].[attendances] CHECK CONSTRAINT [FK_attendances_instructors]
GO
ALTER TABLE [dbo].[attendances]  WITH CHECK ADD  CONSTRAINT [FK_attendances_locations] FOREIGN KEY([location_id])
REFERENCES [dbo].[locations] ([id])
GO
ALTER TABLE [dbo].[attendances] CHECK CONSTRAINT [FK_attendances_locations]
GO
ALTER TABLE [dbo].[attendances]  WITH CHECK ADD  CONSTRAINT [FK_attendances_students] FOREIGN KEY([student_id])
REFERENCES [dbo].[students] ([id])
GO
ALTER TABLE [dbo].[attendances] CHECK CONSTRAINT [FK_attendances_students]
GO
ALTER TABLE [dbo].[class_purchases]  WITH CHECK ADD  CONSTRAINT [FK_class_purchases_payment_types] FOREIGN KEY([payment_type_id])
REFERENCES [dbo].[payment_types] ([id])
GO
ALTER TABLE [dbo].[class_purchases] CHECK CONSTRAINT [FK_class_purchases_payment_types]
GO
ALTER TABLE [dbo].[class_purchases]  WITH CHECK ADD  CONSTRAINT [FK_class_purchases_students] FOREIGN KEY([student_id])
REFERENCES [dbo].[students] ([id])
GO
ALTER TABLE [dbo].[class_purchases] CHECK CONSTRAINT [FK_class_purchases_students]
GO
/****** Object:  StoredProcedure [dbo].[sp_contact_us]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_contact_us]
	@firstname nvarchar(20),
	@lastname nvarchar(20),
	@email nvarchar(50),
	@opt_out bit = 0
AS
BEGIN
	UPDATE [shy].[dbo].[subscribers] SET firstname = @firstname, lastname = @lastname, opt_out = @opt_out WHERE email = @email;
	IF @@ROWCOUNT = 0
	BEGIN
		INSERT INTO [shy].[dbo].[subscribers] (firstname, lastname, email, opt_out) VALUES (@firstname, @lastname, @email, @opt_out);
	END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_history]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_history]
	(
	@transaction_type CHAR(1),
	@id uniqueidentifier
	)
AS
	/* SET NOCOUNT ON */
	IF @transaction_type = 'P'
		DELETE FROM class_purchases WHERE id = @id 
	ELSE
		DELETE FROM attendances WHERE id = @id
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_student]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_student]
	@id uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @num_purchases int;
	DECLARE @num_attendances int;
	DECLARE @total int;

	SELECT @num_purchases = COUNT(*) FROM class_purchases WHERE student_id = @id;
	SELECT @num_attendances = COUNT(*) FROM attendances WHERE student_id = @id;
	SELECT @total = @num_attendances + @num_purchases;

	SET NOCOUNT OFF;

	IF @total = 0
	BEGIN
		DELETE FROM students WHERE id = @id;
	END

END
GO
/****** Object:  StoredProcedure [dbo].[sp_show_history]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nate Stuyvesant
-- Create date: 11/9/2009
-- Description:	Show the history for a particular student
-- =============================================
CREATE PROCEDURE [dbo].[sp_show_history] 
	-- Add the parameters for the stored procedure here
	(@student_id uniqueidentifier)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @history TABLE 
	(
		id UNIQUEIDENTIFIER,
		ord INT IDENTITY(1,1),
		transaction_type CHAR(1),
		transaction_date datetime,
		what NVARCHAR(256),
		quantity INT,
		instructor_id UNIQUEIDENTIFIER,
		class_id UNIQUEIDENTIFIER,
		location_id UNIQUEIDENTIFIER,
		payment_type_id UNIQUEIDENTIFIER
	)
	
	INSERT INTO @history (id,transaction_type,transaction_date,what,quantity,instructor_id,class_id,location_id,payment_type_id)
		SELECT
			class_purchases.id,
			'P',
			class_purchases.purchased_on AS [transaction_date],
			'<span class="text-success">Purchased</span> ' + LTRIM(STR(class_purchases.quantity)) + ' class pass (' + payment_types.name + ')' AS what,
			class_purchases.quantity,
			ISNULL(instructor_id,'{f6609ffa-1814-4405-b359-140a4bfee954}'),
			ISNULL(class_id,'{22f89403-6871-4201-9eb1-014872f61238}'),
			ISNULL(location_id,'{65afdb35-fffc-420f-8d39-2e587cd8e558}'),
			ISNULL(payment_type_id,'{3f9b38fc-48c9-4c1b-a71f-516b3b602b13}')
		FROM
			class_purchases INNER JOIN
			payment_types ON class_purchases.payment_type_id = payment_types.id
		WHERE
			class_purchases.student_id = @student_id
	UNION ALL
		SELECT
			attendances.id,
			'A',
			CONVERT(datetime,attendances.class_date) AS [transaction_date],
			'<span class="text-danger">Attended</span> ' + classes.name + ' (' + locations.name + '/' + instructors.lastname + ')' AS what,
			- 1 AS quantity,
			ISNULL(instructor_id,'{f6609ffa-1814-4405-b359-140a4bfee954}'),
			ISNULL(class_id,'{22f89403-6871-4201-9eb1-014872f61238}'),
			ISNULL(location_id,'{65afdb35-fffc-420f-8d39-2e587cd8e558}'),
			'{3f9b38fc-48c9-4c1b-a71f-516b3b602b13}'
		FROM
			attendances INNER JOIN
			classes ON attendances.class_id = classes.id INNER JOIN
			instructors ON attendances.instructor_id = instructors.id INNER JOIN
			locations ON attendances.location_id = locations.id
		WHERE
			attendances.student_id = @student_id
	ORDER BY
		[transaction_date] DESC

	SELECT
		transaction_type,
		id,
		b.transaction_date AS [transaction_date],
		b.what AS [Description],
		b.quantity AS [Quantity],
		(SELECT SUM(a.quantity) FROM @history AS a WHERE
			a.ord >= b.ord) AS Balance,
		instructor_id,
		class_id,
		location_id,
		payment_type_id
	FROM
		@history AS b
	ORDER BY
		transaction_date DESC

END
GO
/****** Object:  StoredProcedure [dbo].[sp_update_history]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_update_history]
	(
	@transaction_type CHAR(1),
	@id uniqueidentifier,
	@transaction_date DATE,
	@instructor_id UNIQUEIDENTIFIER,
	@location_id UNIQUEIDENTIFIER,
	@class_id UNIQUEIDENTIFIER,
	@quantity smallint,
	@payment_type_id UNIQUEIDENTIFIER
	)
AS
	/* SET NOCOUNT ON */
	IF @transaction_type = 'P'
		UPDATE class_purchases
			SET
				purchased_on = @transaction_date,
				instructor_id = @instructor_id,
				location_id = @location_id,
				class_id = @class_id,
				quantity = @quantity,
				payment_type_id = @payment_type_id
			WHERE id = @id 
	ELSE
		UPDATE attendances
			SET
				class_date = @transaction_date,
				instructor_id = @instructor_id,
				location_id = @location_id,
				class_id = @class_id
			WHERE id = @id

	RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_zero_old_passes]    Script Date: 7/14/2018 9:41:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_zero_old_passes]
AS
	-- Get rid of balances for students who have not purchased a class card in 12 months
	
	-- Define cutoff as 6 months ago
	DECLARE @cutoff DATETIME;
	SET @cutoff = DATEADD(m, - 12, GETDATE());
	
	-- Create temp table of active students with their balance
	SELECT
		id, balance
	INTO #StudentBalances
	FROM
		dbo.student_balances WHERE balance > 0;
	
	-- Eliminate students who bought a card within the last 6 months
	DELETE FROM #StudentBalances WHERE id IN (SELECT DISTINCT student_id FROM dbo.class_purchases WHERE purchased_on >= @cutoff);
	
	INSERT INTO dbo.class_purchases (student_id, quantity, payment_type_id, location_id, instructor_id, class_id)
	SELECT
		id,
		- balance,
		'd31914ca-2044-4a81-b6b8-d994fa91eebf' as payment_type_id,
		'65afdb35-fffc-420f-8d39-2e587cd8e558' AS location_id,
		'02299f3d-a39f-4b57-b72d-9368029fe391' AS instructor_id,
		'b8e952e6-17c5-46b9-b2ea-0f0f69870cc9' AS class_id
	FROM
		#StudentBalances;
						
	RETURN
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Subscriber''s GUID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'subscribers', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'First name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'subscribers', @level2type=N'COLUMN',@level2name=N'firstname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'subscribers', @level2type=N'COLUMN',@level2name=N'lastname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Telephone number' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'subscribers', @level2type=N'COLUMN',@level2name=N'phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Email address' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'subscribers', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Street address' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'subscribers', @level2type=N'COLUMN',@level2name=N'address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'City' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'subscribers', @level2type=N'COLUMN',@level2name=N'city'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'State' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'subscribers', @level2type=N'COLUMN',@level2name=N'state'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ZIP code' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'subscribers', @level2type=N'COLUMN',@level2name=N'zipcode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Do not email this person' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'subscribers', @level2type=N'COLUMN',@level2name=N'opt_out'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for subscriber list' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'subscribers', @level2type=N'CONSTRAINT',@level2name=N'PK_subscriber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Index for subscriber''s email address - must be unique' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'subscribers', @level2type=N'INDEX',@level2name=N'IX_subscriber_email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Index for subscriber''s first name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'subscribers', @level2type=N'INDEX',@level2name=N'IX_subscriber_firstname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Index for subscriber''s last name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'subscribers', @level2type=N'INDEX',@level2name=N'IX_subscriber_lastname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Index for whether subscriber wants to receive email' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'subscribers', @level2type=N'INDEX',@level2name=N'IX_subscriber_opt_out'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[30] 4[20] 2[21] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "attendances"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "instructors"
            Begin Extent = 
               Top = 6
               Left = 227
               Bottom = 114
               Right = 378
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "students"
            Begin Extent = 
               Top = 6
               Left = 416
               Bottom = 114
               Right = 567
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "locations"
            Begin Extent = 
               Top = 6
               Left = 605
               Bottom = 99
               Right = 756
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "classes"
            Begin Extent = 
               Top = 6
               Left = 794
               Bottom = 99
               Right = 945
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'attendances_full_info'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'     Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'attendances_full_info'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'attendances_full_info'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[21] 2[14] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "attendances"
            Begin Extent = 
               Top = 14
               Left = 287
               Bottom = 176
               Right = 454
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "locations"
            Begin Extent = 
               Top = 6
               Left = 653
               Bottom = 148
               Right = 820
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "instructors"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 205
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "classes"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 207
               Right = 205
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'attendances_location'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'  End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'attendances_location'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'attendances_location'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[21] 2[13] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "attendances"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "students"
            Begin Extent = 
               Top = 6
               Left = 227
               Bottom = 114
               Right = 378
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'attendees'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'attendees'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[27] 4[15] 2[16] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "purchases_full_info"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 283
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1590
         Width = 1005
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'cash_collected'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'cash_collected'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "attendances"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 205
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "instructors"
            Begin Extent = 
               Top = 6
               Left = 243
               Bottom = 114
               Right = 410
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "students"
            Begin Extent = 
               Top = 6
               Left = 448
               Bottom = 114
               Right = 615
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "locations"
            Begin Extent = 
               Top = 6
               Left = 653
               Bottom = 99
               Right = 820
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "classes"
            Begin Extent = 
               Top = 102
               Left = 653
               Bottom = 195
               Right = 820
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
 ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'class_counts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'        Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'class_counts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'class_counts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[21] 4[12] 2[8] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[28] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4[29] 3) )"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3) )"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 5
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "subscribers"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 4980
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Email List'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Email List'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -192
         Left = 0
      End
      Begin Tables = 
         Begin Table = "class_purchases"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 217
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "students"
            Begin Extent = 
               Top = 19
               Left = 415
               Bottom = 149
               Right = 585
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 11
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'free_classes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'free_classes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[8] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "students_who_go_to_NH"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 102
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "subscriber_zipcodes"
            Begin Extent = 
               Top = 42
               Left = 269
               Bottom = 138
               Right = 439
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 12
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'NH_zipcodes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'NH_zipcodes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "attendances_location"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 3015
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'NorthHillsQtrlyAttendances'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'NorthHillsQtrlyAttendances'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[12] 2[19] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "class_purchases"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 218
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "students"
            Begin Extent = 
               Top = 6
               Left = 256
               Bottom = 114
               Right = 423
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "payment_types"
            Begin Extent = 
               Top = 6
               Left = 461
               Bottom = 114
               Right = 628
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 2490
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'purchase_duplicates'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'purchase_duplicates'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[20] 2[13] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[25] 2[34] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[25] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 2
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "class_purchases"
            Begin Extent = 
               Top = 12
               Left = 406
               Bottom = 229
               Right = 571
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "students"
            Begin Extent = 
               Top = 0
               Left = 189
               Bottom = 108
               Right = 340
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "payment_types"
            Begin Extent = 
               Top = 27
               Left = 703
               Bottom = 135
               Right = 854
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "locations"
            Begin Extent = 
               Top = 71
               Left = 27
               Bottom = 164
               Right = 178
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "instructors"
            Begin Extent = 
               Top = 143
               Left = 170
               Bottom = 251
               Right = 321
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "classes"
            Begin Extent = 
               Top = 156
               Left = 712
               Bottom = 249
               Right = 863
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
        ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'purchases_full_info'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' Width = 1665
         Width = 2595
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'purchases_full_info'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'purchases_full_info'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "students_who_go_to_SD"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 102
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "subscriber_zipcodes"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 102
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SD_zipcodes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SD_zipcodes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "students_who_go_to_SH"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 102
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "subscriber_zipcodes"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 102
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SH_zipcodes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SH_zipcodes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[14] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "students_who_go_to_SS"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 102
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "subscriber_zipcodes"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 183
               Right = 453
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SS_zipcodes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SS_zipcodes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[16] 2[17] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "students"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 151
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'student_balances'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'student_balances'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[18] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "student"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 203
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "purchases"
            Begin Extent = 
               Top = 127
               Left = 392
               Bottom = 257
               Right = 571
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "attendances"
            Begin Extent = 
               Top = 6
               Left = 621
               Bottom = 182
               Right = 813
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'students_purchased_attended'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'students_purchased_attended'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "students"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 172
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "locations"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 183
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "attendances"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 209
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 2610
         Width = 2550
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'students_schools'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'students_schools'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[15] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "students"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "attendances"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "locations"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 168
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'students_who_go_to_NH'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'students_who_go_to_NH'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "students"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "attendances"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "locations"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 119
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'students_who_go_to_SD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'students_who_go_to_SD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[15] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "students"
            Begin Extent = 
               Top = 67
               Left = 39
               Bottom = 203
               Right = 209
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "attendances"
            Begin Extent = 
               Top = 0
               Left = 293
               Bottom = 186
               Right = 463
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "locations"
            Begin Extent = 
               Top = 51
               Left = 544
               Bottom = 164
               Right = 714
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'students_who_go_to_SH'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'students_who_go_to_SH'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[32] 4[29] 2[11] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "student_balances"
            Begin Extent = 
               Top = 6
               Left = 227
               Bottom = 136
               Right = 397
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 2955
         Width = 915
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'students_who_owe'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'students_who_owe'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[25] 4[15] 2[35] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -288
         Left = 0
      End
      Begin Tables = 
         Begin Table = "student_balances"
            Begin Extent = 
               Top = 294
               Left = 38
               Bottom = 424
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 2160
         Width = 1500
         Width = 2115
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'students_with_balances_over_6mths'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'students_with_balances_over_6mths'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "subscribers"
            Begin Extent = 
               Top = 18
               Left = 119
               Bottom = 148
               Right = 289
            End
            DisplayFlags = 280
            TopColumn = 5
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 13
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'subscriber_zipcodes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'subscriber_zipcodes'
GO
USE [master]
GO
ALTER DATABASE [shy] SET  READ_WRITE 
GO
