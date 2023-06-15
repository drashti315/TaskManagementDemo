USE [master]
GO
/****** Object:  Database [TaskManagement]    Script Date: 6/15/2023 1:38:25 PM ******/
CREATE DATABASE [TaskManagement]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TaskManagement', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\TaskManagement.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TaskManagement_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\TaskManagement_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [TaskManagement] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TaskManagement].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TaskManagement] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TaskManagement] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TaskManagement] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TaskManagement] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TaskManagement] SET ARITHABORT OFF 
GO
ALTER DATABASE [TaskManagement] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TaskManagement] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TaskManagement] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TaskManagement] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TaskManagement] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TaskManagement] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TaskManagement] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TaskManagement] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TaskManagement] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TaskManagement] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TaskManagement] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TaskManagement] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TaskManagement] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TaskManagement] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TaskManagement] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TaskManagement] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TaskManagement] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TaskManagement] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TaskManagement] SET  MULTI_USER 
GO
ALTER DATABASE [TaskManagement] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TaskManagement] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TaskManagement] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TaskManagement] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TaskManagement] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TaskManagement] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [TaskManagement] SET QUERY_STORE = OFF
GO
USE [TaskManagement]
GO
/****** Object:  Table [dbo].[TaskDetails]    Script Date: 6/15/2023 1:38:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaskDetails](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[TaskName] [nvarchar](200) NULL,
	[TaskDescription] [nvarchar](max) NULL,
	[TaskStatusId] [int] NULL,
 CONSTRAINT [PK__TaskDeta__3214EC0755AE4D32] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaskStatus]    Script Date: 6/15/2023 1:38:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaskStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[TaskStatus] ON 

INSERT [dbo].[TaskStatus] ([Id], [Status]) VALUES (1, N'New')
INSERT [dbo].[TaskStatus] ([Id], [Status]) VALUES (2, N'In Progress')
INSERT [dbo].[TaskStatus] ([Id], [Status]) VALUES (3, N'Completed')
SET IDENTITY_INSERT [dbo].[TaskStatus] OFF
GO
/****** Object:  StoredProcedure [dbo].[usp_AddTaskDetail]    Script Date: 6/15/2023 1:38:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*--------------------------------------------------------------------------------------------------------------------------------------
* 	Procedure Name		: [dbo].[usp_AddTaskDetail]   
* 	Comments			: 14-06-2023 | Drashti Raval | Add task detail
----------------------------------------------------------------------------------------------------------------------------------------*/

CREATE PROCEDURE [dbo].[usp_AddTaskDetail]  
@Name nvarchar(200),
@Description nvarchar(MAX),
@Status int 
AS  
BEGIN  

	SET NOCOUNT ON;  
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	insert into TaskDetails
	Values (@Name,@Description,@Status)
END  
GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteTaskDetail]    Script Date: 6/15/2023 1:38:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*--------------------------------------------------------------------------------------------------------------------------------------
* 	Procedure Name		: [dbo].[GetInvoiceIds]   
* 	Comments			: 14-06-2023 | Drashti Raval | Delete task detail
----------------------------------------------------------------------------------------------------------------------------------------*/

CREATE PROCEDURE [dbo].[usp_DeleteTaskDetail]  
@Id int
AS  
BEGIN  

	SET NOCOUNT ON;  
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	Delete from TaskDetails where Id = @Id
END  
GO
/****** Object:  StoredProcedure [dbo].[usp_GetAllTaskDetails]    Script Date: 6/15/2023 1:38:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*--------------------------------------------------------------------------------------------------------------------------------------
* 	Procedure Name		: [dbo].[GetAllTaskDetails]   
* 	Comments			: 14-06-2023 | Drashti Raval | Get task details
----------------------------------------------------------------------------------------------------------------------------------------
*   Test Execution	    : 			exec GetAllTaskDetails				
*/--------------------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[usp_GetAllTaskDetails]  
AS  
BEGIN  

	SET NOCOUNT ON;  
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	select td.TaskName as Name,
	td.[TaskDescription] as Description,
	ts.Status as StatusName,
	td.Id,
	ts.Id as Status
	from TaskDetails td
	inner join TaskStatus ts on td.[TaskStatusId] = ts.Id
END  
GO
/****** Object:  StoredProcedure [dbo].[usp_GetTaskDetailsById]    Script Date: 6/15/2023 1:38:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*--------------------------------------------------------------------------------------------------------------------------------------
* 	Procedure Name		: [dbo].[usp_GetTaskDetailsById]   
* 	Comments			: 14-06-2023 | Drashti Raval | Get task details by id
----------------------------------------------------------------------------------------------------------------------------------------
*   Test Execution	    : 			exec usp_GetTaskDetailsById 5				
*/--------------------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[usp_GetTaskDetailsById]  
@Id int 
AS  
BEGIN  

	SET NOCOUNT ON;  
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	select td.TaskName as Name,
	td.[TaskDescription] as Description,
	ts.Status as StatusName,
	td.Id,
	ts.Id as Status
	from TaskDetails td
	inner join TaskStatus ts on td.[TaskStatusId] = ts.Id
	where td.Id = @Id
END  
GO
/****** Object:  StoredProcedure [dbo].[usp_GetTaskStatusDetails]    Script Date: 6/15/2023 1:38:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*--------------------------------------------------------------------------------------------------------------------------------------
* 	Procedure Name		: [dbo].[usp_GetTaskStatusDetails]   
* 	Comments			: 14-06-2023 | Drashti Raval | Get task details
----------------------------------------------------------------------------------------------------------------------------------------
*   Test Execution	    : 			exec GetTaskStatusDetails				
*/--------------------------------------------------------------------------------------------------------------------------------------
Create PROCEDURE [dbo].[usp_GetTaskStatusDetails]  
AS  
BEGIN  

	SET NOCOUNT ON;  
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	select * from TaskStatus
END  
GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateTaskDetail]    Script Date: 6/15/2023 1:38:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*--------------------------------------------------------------------------------------------------------------------------------------
* 	Procedure Name		: [dbo].[usp_UpdateTaskDetail]   
* 	Comments			: 14-06-2023 | Drashti Raval | Update task detail
----------------------------------------------------------------------------------------------------------------------------------------*/				

CREATE PROCEDURE [dbo].[usp_UpdateTaskDetail]  
@Name nvarchar(200),
@Description nvarchar(MAX),
@Status int ,
@Id bigint
AS  
BEGIN  

	SET NOCOUNT ON;  
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	update TaskDetails
	set [TaskName] =@Name,
	[TaskDescription] = @Description,
	[TaskStatusId]= @Status 
	where Id = @Id
END  
GO
USE [master]
GO
ALTER DATABASE [TaskManagement] SET  READ_WRITE 
GO
