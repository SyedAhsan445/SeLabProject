USE [master]
GO
/****** Object:  Database [ClothXDb]    Script Date: 26/11/2023 9:37:17 am ******/
CREATE DATABASE [ClothXDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ClothXDb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ClothXDb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ClothXDb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ClothXDb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [ClothXDb] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ClothXDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ClothXDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ClothXDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ClothXDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ClothXDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ClothXDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [ClothXDb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ClothXDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ClothXDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ClothXDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ClothXDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ClothXDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ClothXDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ClothXDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ClothXDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ClothXDb] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ClothXDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ClothXDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ClothXDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ClothXDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ClothXDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ClothXDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ClothXDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ClothXDb] SET RECOVERY FULL 
GO
ALTER DATABASE [ClothXDb] SET  MULTI_USER 
GO
ALTER DATABASE [ClothXDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ClothXDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ClothXDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ClothXDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ClothXDb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ClothXDb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'ClothXDb', N'ON'
GO
ALTER DATABASE [ClothXDb] SET QUERY_STORE = ON
GO
ALTER DATABASE [ClothXDb] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [ClothXDb]
GO
/****** Object:  Schema [Audit]    Script Date: 26/11/2023 9:37:17 am ******/
CREATE SCHEMA [Audit]
GO
/****** Object:  UserDefinedFunction [dbo].[GetCurrentUser]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Function to get the current user (for auditing purposes)
CREATE FUNCTION [dbo].[GetCurrentUser]()
RETURNS NVARCHAR(128)
AS
BEGIN
    RETURN SUSER_NAME();
END;
GO
/****** Object:  Table [Audit].[AspNetUsers_Audit]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Audit].[AspNetUsers_Audit](
	[AuditId] [int] IDENTITY(1,1) NOT NULL,
	[AuditDate] [datetime] NULL,
	[AuditUser] [nvarchar](128) NULL,
	[AuditOperation] [nvarchar](10) NULL,
	[Id] [nvarchar](128) NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NULL,
	[TwoFactorEnabled] [bit] NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NULL,
	[AccessFailedCount] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[AuditId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Audit].[ClientOrderIdeaImages_Audit]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Audit].[ClientOrderIdeaImages_Audit](
	[AuditId] [int] IDENTITY(1,1) NOT NULL,
	[AuditDate] [datetime] NULL,
	[AuditUser] [nvarchar](128) NULL,
	[AuditOperation] [nvarchar](10) NULL,
	[Id] [int] NULL,
	[OrderId] [int] NULL,
	[ImagePath] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[AuditId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Audit].[ClientOrders_Audit]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Audit].[ClientOrders_Audit](
	[AuditId] [int] IDENTITY(1,1) NOT NULL,
	[AuditDate] [datetime] NULL,
	[AuditUser] [nvarchar](128) NULL,
	[AuditOperation] [nvarchar](10) NULL,
	[Id] [int] NULL,
	[Title] [nvarchar](255) NULL,
	[Description] [nvarchar](max) NULL,
	[isPaid] [bit] NULL,
	[isConfirmed] [bit] NULL,
	[isDelivered] [bit] NULL,
	[ClientId] [int] NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [datetime] NULL,
	[UpdatedOn] [datetime] NULL,
	[isActive] [bit] NULL,
	[Measurements] [nvarchar](200) NULL,
	[OrderType] [int] NULL,
	[Price] [int] NULL,
	[Deadline] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[AuditId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Audit].[FeatureGroups_Audit]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Audit].[FeatureGroups_Audit](
	[AuditId] [int] IDENTITY(1,1) NOT NULL,
	[AuditDate] [datetime] NULL,
	[AuditUser] [nvarchar](128) NULL,
	[AuditOperation] [nvarchar](10) NULL,
	[Id] [int] NULL,
	[Name] [nvarchar](100) NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [nvarchar](100) NULL,
	[UpdatedOn] [datetime] NULL,
	[isActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[AuditId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Audit].[Features_Audit]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Audit].[Features_Audit](
	[AuditId] [int] IDENTITY(1,1) NOT NULL,
	[AuditDate] [datetime] NULL,
	[AuditUser] [nvarchar](128) NULL,
	[AuditOperation] [nvarchar](10) NULL,
	[Id] [int] NULL,
	[Name] [nvarchar](100) NULL,
	[Description] [nvarchar](max) NULL,
	[FeatureGroupId] [int] NULL,
	[Price] [int] NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [nvarchar](100) NULL,
	[UpdatedOn] [datetime] NULL,
	[isActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[AuditId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Audit].[Lookup_Audit]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Audit].[Lookup_Audit](
	[AuditId] [int] IDENTITY(1,1) NOT NULL,
	[AuditDate] [datetime] NULL,
	[AuditUser] [nvarchar](128) NULL,
	[AuditOperation] [nvarchar](10) NULL,
	[Id] [int] NULL,
	[Category] [nvarchar](50) NULL,
	[Value] [nvarchar](100) NULL,
	[displayOrder] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[AuditId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Audit].[OrderFeatures_Audit]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Audit].[OrderFeatures_Audit](
	[AuditId] [int] IDENTITY(1,1) NOT NULL,
	[AuditDate] [datetime] NULL,
	[AuditUser] [nvarchar](128) NULL,
	[AuditOperation] [nvarchar](10) NULL,
	[Id] [int] NULL,
	[OrderId] [int] NULL,
	[FeatureId] [int] NULL,
	[isActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[AuditId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Audit].[ProductCategory_Audit]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Audit].[ProductCategory_Audit](
	[AuditId] [int] IDENTITY(1,1) NOT NULL,
	[AuditDate] [datetime] NULL,
	[AuditUser] [nvarchar](128) NULL,
	[AuditOperation] [nvarchar](10) NULL,
	[Id] [int] NULL,
	[Name] [nvarchar](50) NULL,
	[Price] [int] NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [nvarchar](100) NULL,
	[UpdatedOn] [datetime] NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[AuditId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Audit].[Review_Audit]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Audit].[Review_Audit](
	[AuditId] [int] IDENTITY(1,1) NOT NULL,
	[AuditDate] [datetime] NULL,
	[AuditUser] [nvarchar](128) NULL,
	[AuditOperation] [nvarchar](10) NULL,
	[Id] [int] NULL,
	[Message] [nvarchar](max) NULL,
	[UserId] [int] NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [nvarchar](100) NULL,
	[Response] [nvarchar](max) NULL,
	[ResponseAddedOn] [datetime] NULL,
	[Rating] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[AuditId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Audit].[TailorProjectImages_Audit]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Audit].[TailorProjectImages_Audit](
	[AuditId] [int] IDENTITY(1,1) NOT NULL,
	[AuditDate] [datetime] NULL,
	[AuditUser] [nvarchar](128) NULL,
	[AuditOperation] [nvarchar](10) NULL,
	[Id] [int] NULL,
	[ProjectId] [int] NULL,
	[ImagePath] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[AuditId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Audit].[TailorProjects_Audit]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Audit].[TailorProjects_Audit](
	[AuditId] [int] IDENTITY(1,1) NOT NULL,
	[AuditDate] [datetime] NULL,
	[AuditUser] [nvarchar](128) NULL,
	[AuditOperation] [nvarchar](10) NULL,
	[Id] [int] NULL,
	[Title] [nvarchar](255) NULL,
	[Description] [nvarchar](max) NULL,
	[ProductCategoryId] [int] NULL,
	[AddedOn] [datetime] NULL,
	[UpdatedOn] [datetime] NULL,
	[AddedBy] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
	[ImagePath] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[AuditId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Audit].[UserProfile_Audit]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Audit].[UserProfile_Audit](
	[AuditId] [int] IDENTITY(1,1) NOT NULL,
	[AuditDate] [datetime] NULL,
	[AuditUser] [nvarchar](128) NULL,
	[AuditOperation] [nvarchar](10) NULL,
	[Id] [int] NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[Address] [nvarchar](255) NULL,
	[IsApproved] [bit] NULL,
	[AddedOn] [datetime] NULL,
	[IsActive] [bit] NULL,
	[UpdatedOn] [datetime] NULL,
	[UserId] [nvarchar](128) NULL,
	[ImagePath] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[AuditId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [varchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [varchar](128) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [varchar](128) NOT NULL,
 CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserTokens](
	[UserId] [nvarchar](128) NOT NULL,
	[LoginProvider] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientOrderIdeaImages]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientOrderIdeaImages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[ImagePath] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_ClientOrderIdeaImages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientOrders]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientOrders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[isPaid] [bit] NOT NULL,
	[isConfirmed] [bit] NOT NULL,
	[isDelivered] [bit] NOT NULL,
	[ClientId] [int] NOT NULL,
	[AddedBy] [nvarchar](50) NOT NULL,
	[AddedOn] [datetime] NOT NULL,
	[UpdatedOn] [datetime] NULL,
	[isActive] [bit] NULL,
	[Measurements] [nvarchar](200) NULL,
	[OrderType] [int] NOT NULL,
	[Price] [int] NULL,
	[Deadline] [datetime] NOT NULL,
 CONSTRAINT [PK_ClientOrders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FeatureGroups]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FeatureGroups](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[AddedOn] [datetime] NOT NULL,
	[AddedBy] [nvarchar](100) NOT NULL,
	[UpdatedOn] [datetime] NULL,
	[isActive] [bit] NULL,
 CONSTRAINT [PK_FeatureGroups] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Features]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Features](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[FeatureGroupId] [int] NOT NULL,
	[Price] [int] NOT NULL,
	[AddedOn] [datetime] NOT NULL,
	[AddedBy] [nvarchar](100) NOT NULL,
	[UpdatedOn] [datetime] NULL,
	[isActive] [bit] NULL,
 CONSTRAINT [PK_Features] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Log]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Log](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MachineName] [nvarchar](50) NOT NULL,
	[Logged] [datetime] NOT NULL,
	[Level] [nvarchar](50) NOT NULL,
	[Message] [nvarchar](max) NOT NULL,
	[Logger] [nvarchar](250) NULL,
	[Exception] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.Log] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lookup]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lookup](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Category] [nvarchar](50) NOT NULL,
	[Value] [nvarchar](100) NOT NULL,
	[displayOrder] [int] NULL,
 CONSTRAINT [PK_Lookup] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderFeatures]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderFeatures](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[FeatureId] [int] NOT NULL,
	[isActive] [bit] NULL,
 CONSTRAINT [PK_OrderFeatures] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prevelige]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prevelige](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_Prevelige] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductCategory]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCategory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Price] [int] NOT NULL,
	[AddedOn] [datetime] NOT NULL,
	[AddedBy] [nvarchar](100) NOT NULL,
	[UpdatedOn] [datetime] NOT NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_ProductCategory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Review]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Review](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Message] [nvarchar](max) NOT NULL,
	[UserId] [int] NOT NULL,
	[AddedOn] [datetime] NOT NULL,
	[AddedBy] [nvarchar](100) NOT NULL,
	[Response] [nvarchar](max) NULL,
	[ResponseAddedOn] [datetime] NULL,
	[Rating] [int] NULL,
 CONSTRAINT [PK_Review] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RolePrevelige]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RolePrevelige](
	[RoleId] [varchar](128) NOT NULL,
	[PreveligeId] [int] NOT NULL,
 CONSTRAINT [PK_RolePrevelige] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC,
	[PreveligeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TailorProjectImages]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TailorProjectImages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[ImagePath] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_TailorProjectImages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TailorProjects]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TailorProjects](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[ProductCategoryId] [int] NOT NULL,
	[AddedOn] [datetime] NOT NULL,
	[UpdatedOn] [datetime] NULL,
	[AddedBy] [nvarchar](50) NOT NULL,
	[isActive] [bit] NULL,
	[ImagePath] [nvarchar](max) NULL,
 CONSTRAINT [PK_TailorProjects] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserProfile]    Script Date: 26/11/2023 9:37:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserProfile](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NULL,
	[Address] [nvarchar](255) NULL,
	[isApproved] [bit] NOT NULL,
	[AddedOn] [datetime] NOT NULL,
	[isActive] [bit] NOT NULL,
	[UpdatedOn] [datetime] NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ImagePath] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](20) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'Tailor', N'Tailor', N'TAILOR', N'b774609b-159e-4d8e-be25-ff55c2bebf85')
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'User', N'User', N'USER', N'64e751c0-a067-4c2d-b1b5-f7fdef57413e')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'6ba4c070-b4e0-4eee-93fa-53e65ccdf503', N'User')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'e49a103c-d8f8-4c7d-9241-fbbf5ee91ef8', N'Tailor')
GO
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'6ba4c070-b4e0-4eee-93fa-53e65ccdf503', N'client1@gmail.com', N'CLIENT1@GMAIL.COM', N'client1@gmail.com', N'CLIENT1@GMAIL.COM', 1, N'AQAAAAEAACcQAAAAELRZldMKMlQWJZFz/b/GTkURVBLrrVrlhxZUn4Fd3vB9xpVRGoF/5wZ1jrRlyx+Q3Q==', N'RE46X277V5F2CZHQHBO2FVZZ2PZKAEPP', N'd5ff3367-5bfd-49af-88c4-6329187eff1d', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'e49a103c-d8f8-4c7d-9241-fbbf5ee91ef8', N'admin@admin.com', N'ADMIN@ADMIN.COM', N'admin@admin.com', N'ADMIN@ADMIN.COM', 1, N'AQAAAAEAACcQAAAAEPS0QM2cIlIB0XPjcJgzXG7hzX0LKrgX1HlYuoc9D72BgwtF/I+3udq7YnaZZFOQ8g==', N'IV4GMDNZJYGJHJ7OVWEVXEUI6BYTGJ2O', N'd1814c23-1415-4f1e-a539-04b5af50d333', NULL, 0, 0, NULL, 1, 0)
GO
SET IDENTITY_INSERT [dbo].[ClientOrderIdeaImages] ON 

INSERT [dbo].[ClientOrderIdeaImages] ([Id], [OrderId], [ImagePath]) VALUES (1, 1, N'/Images\ProjectImages\3ef4f503-9ddc-46e9-a012-f068b067fef9.png')
INSERT [dbo].[ClientOrderIdeaImages] ([Id], [OrderId], [ImagePath]) VALUES (2, 1, N'/Images\ProjectImages\034314fc-162f-48ac-905a-e083ab51f01d.png')
INSERT [dbo].[ClientOrderIdeaImages] ([Id], [OrderId], [ImagePath]) VALUES (3, 2, N'/Images\ProjectImages\4f6dc0e1-8f5f-4bd7-88ff-cc5adb3c8581.png')
SET IDENTITY_INSERT [dbo].[ClientOrderIdeaImages] OFF
GO
SET IDENTITY_INSERT [dbo].[ClientOrders] ON 

INSERT [dbo].[ClientOrders] ([Id], [Title], [Description], [isPaid], [isConfirmed], [isDelivered], [ClientId], [AddedBy], [AddedOn], [UpdatedOn], [isActive], [Measurements], [OrderType], [Price], [Deadline]) VALUES (1, N'fwceb', N'<p>rc7f sbccb tc cfdgvg.</p>', 1, 1, 1, 2, N'admin@admin.com', CAST(N'2023-10-15T15:39:03.013' AS DateTime), CAST(N'2023-10-17T05:38:40.357' AS DateTime), 1, N'bvfu', 3, 1500, CAST(N'2023-10-25T20:43:13.020' AS DateTime))
INSERT [dbo].[ClientOrders] ([Id], [Title], [Description], [isPaid], [isConfirmed], [isDelivered], [ClientId], [AddedBy], [AddedOn], [UpdatedOn], [isActive], [Measurements], [OrderType], [Price], [Deadline]) VALUES (2, N'My First Order', N'<p>Just use this for testing</p>', 1, 1, 0, 2, N'admin@admin.com', CAST(N'2023-10-16T20:47:38.473' AS DateTime), CAST(N'2023-10-30T18:00:50.857' AS DateTime), 1, N'92x18x6', 1, 800, CAST(N'2023-10-25T20:43:13.020' AS DateTime))
SET IDENTITY_INSERT [dbo].[ClientOrders] OFF
GO
SET IDENTITY_INSERT [dbo].[FeatureGroups] ON 

INSERT [dbo].[FeatureGroups] ([Id], [Name], [AddedOn], [AddedBy], [UpdatedOn], [isActive]) VALUES (1, N'Karhai', CAST(N'2023-10-15T11:50:27.330' AS DateTime), N'system', CAST(N'2023-10-23T09:37:50.010' AS DateTime), 1)
INSERT [dbo].[FeatureGroups] ([Id], [Name], [AddedOn], [AddedBy], [UpdatedOn], [isActive]) VALUES (2, N'Designing', CAST(N'2023-10-15T11:50:27.330' AS DateTime), N'system', CAST(N'2023-10-15T11:50:27.330' AS DateTime), 1)
INSERT [dbo].[FeatureGroups] ([Id], [Name], [AddedOn], [AddedBy], [UpdatedOn], [isActive]) VALUES (3, N'Hi 2', CAST(N'2023-10-23T09:40:52.063' AS DateTime), N'admin@admin.com', CAST(N'2023-10-30T19:46:59.677' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[FeatureGroups] OFF
GO
SET IDENTITY_INSERT [dbo].[Features] ON 

INSERT [dbo].[Features] ([Id], [Name], [Description], [FeatureGroupId], [Price], [AddedOn], [AddedBy], [UpdatedOn], [isActive]) VALUES (1, N'No Karhai', NULL, 1, 101, CAST(N'2023-10-15T11:49:06.540' AS DateTime), N'system', CAST(N'2023-10-23T10:27:48.020' AS DateTime), 1)
INSERT [dbo].[Features] ([Id], [Name], [Description], [FeatureGroupId], [Price], [AddedOn], [AddedBy], [UpdatedOn], [isActive]) VALUES (2, N'With Karhai', N'', 1, 500, CAST(N'2023-10-15T11:49:06.540' AS DateTime), N'system', CAST(N'2023-10-23T10:19:43.060' AS DateTime), 1)
INSERT [dbo].[Features] ([Id], [Name], [Description], [FeatureGroupId], [Price], [AddedOn], [AddedBy], [UpdatedOn], [isActive]) VALUES (3, N'No Designing', N'', 2, 100, CAST(N'2023-10-15T11:49:06.540' AS DateTime), N'system', CAST(N'2023-10-15T11:49:06.540' AS DateTime), 1)
INSERT [dbo].[Features] ([Id], [Name], [Description], [FeatureGroupId], [Price], [AddedOn], [AddedBy], [UpdatedOn], [isActive]) VALUES (4, N'With Designing', N'', 2, 500, CAST(N'2023-10-15T11:49:06.540' AS DateTime), N'system', CAST(N'2023-10-15T11:49:06.540' AS DateTime), 1)
INSERT [dbo].[Features] ([Id], [Name], [Description], [FeatureGroupId], [Price], [AddedOn], [AddedBy], [UpdatedOn], [isActive]) VALUES (5, N'test', N'g ', 1, 81, CAST(N'2023-10-23T10:30:16.043' AS DateTime), N'admin@admin.com', CAST(N'2023-10-30T17:53:36.530' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Features] OFF
GO
SET IDENTITY_INSERT [dbo].[Log] ON 

INSERT [dbo].[Log] ([Id], [MachineName], [Logged], [Level], [Message], [Logger], [Exception]) VALUES (1, N'UMAIR', CAST(N'2023-11-04T09:29:42.517' AS DateTime), N'Error', N'Unexpected occurred in ClothX.Controllers.HomeController''s Services method.', N'ClothX.Services.ErrorLogger', N'')
INSERT [dbo].[Log] ([Id], [MachineName], [Logged], [Level], [Message], [Logger], [Exception]) VALUES (2, N'UMAIR', CAST(N'2023-11-06T13:29:36.563' AS DateTime), N'Error', N'Unexpected occurred in ClothX.Controllers.HomeController''s Services method.', N'ClothX.Services.ErrorLogger', N'')
SET IDENTITY_INSERT [dbo].[Log] OFF
GO
SET IDENTITY_INSERT [dbo].[Lookup] ON 

INSERT [dbo].[Lookup] ([Id], [Category], [Value], [displayOrder]) VALUES (1, N'GENDER', N'Male', 1)
INSERT [dbo].[Lookup] ([Id], [Category], [Value], [displayOrder]) VALUES (2, N'GENDER', N'Female', 2)
SET IDENTITY_INSERT [dbo].[Lookup] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderFeatures] ON 

INSERT [dbo].[OrderFeatures] ([Id], [OrderId], [FeatureId], [isActive]) VALUES (1, 1, 2, 1)
INSERT [dbo].[OrderFeatures] ([Id], [OrderId], [FeatureId], [isActive]) VALUES (2, 1, 4, 1)
INSERT [dbo].[OrderFeatures] ([Id], [OrderId], [FeatureId], [isActive]) VALUES (3, 2, 1, 0)
INSERT [dbo].[OrderFeatures] ([Id], [OrderId], [FeatureId], [isActive]) VALUES (4, 2, 3, 1)
INSERT [dbo].[OrderFeatures] ([Id], [OrderId], [FeatureId], [isActive]) VALUES (5, 2, 2, 1)
SET IDENTITY_INSERT [dbo].[OrderFeatures] OFF
GO
SET IDENTITY_INSERT [dbo].[Prevelige] ON 

INSERT [dbo].[Prevelige] ([Id], [Name], [Description]) VALUES (1, N'ClientOrders', NULL)
INSERT [dbo].[Prevelige] ([Id], [Name], [Description]) VALUES (2, N'FeatureGroups', NULL)
INSERT [dbo].[Prevelige] ([Id], [Name], [Description]) VALUES (3, N'Feature', NULL)
INSERT [dbo].[Prevelige] ([Id], [Name], [Description]) VALUES (4, N'Users', NULL)
INSERT [dbo].[Prevelige] ([Id], [Name], [Description]) VALUES (5, N'Feedback.Manage', NULL)
INSERT [dbo].[Prevelige] ([Id], [Name], [Description]) VALUES (6, N'MyOrders', NULL)
INSERT [dbo].[Prevelige] ([Id], [Name], [Description]) VALUES (7, N'Feedback.Add', NULL)
INSERT [dbo].[Prevelige] ([Id], [Name], [Description]) VALUES (8, N'ProductTypes', NULL)
INSERT [dbo].[Prevelige] ([Id], [Name], [Description]) VALUES (9, N'TailorProjects', NULL)
SET IDENTITY_INSERT [dbo].[Prevelige] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductCategory] ON 

INSERT [dbo].[ProductCategory] ([Id], [Name], [Price], [AddedOn], [AddedBy], [UpdatedOn], [IsActive]) VALUES (1, N'Gents', 200, CAST(N'2023-10-16T20:51:52.627' AS DateTime), N'system', CAST(N'2023-10-18T14:58:24.817' AS DateTime), 1)
INSERT [dbo].[ProductCategory] ([Id], [Name], [Price], [AddedOn], [AddedBy], [UpdatedOn], [IsActive]) VALUES (2, N'Ladies', 300, CAST(N'2023-10-16T20:51:52.627' AS DateTime), N'system', CAST(N'2023-10-16T20:51:52.627' AS DateTime), 1)
INSERT [dbo].[ProductCategory] ([Id], [Name], [Price], [AddedOn], [AddedBy], [UpdatedOn], [IsActive]) VALUES (3, N'Kids', 500, CAST(N'2023-10-16T20:51:52.627' AS DateTime), N'system', CAST(N'2023-10-16T20:51:52.627' AS DateTime), 1)
INSERT [dbo].[ProductCategory] ([Id], [Name], [Price], [AddedOn], [AddedBy], [UpdatedOn], [IsActive]) VALUES (4, N'Gents Coat', 5000, CAST(N'2023-10-18T14:56:59.023' AS DateTime), N'admin@admin.com', CAST(N'2023-10-18T14:58:26.597' AS DateTime), 1)
INSERT [dbo].[ProductCategory] ([Id], [Name], [Price], [AddedOn], [AddedBy], [UpdatedOn], [IsActive]) VALUES (5, N'Hello', 700, CAST(N'2023-10-19T23:16:09.117' AS DateTime), N'admin@admin.com', CAST(N'2023-10-19T23:16:14.147' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[ProductCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[Review] ON 

INSERT [dbo].[Review] ([Id], [Message], [UserId], [AddedOn], [AddedBy], [Response], [ResponseAddedOn], [Rating]) VALUES (1, N'This is testing', 2, CAST(N'2023-10-25T17:58:51.553' AS DateTime), N'admin@admin.com', N'This is testing Response', CAST(N'2023-10-25T18:00:36.370' AS DateTime), 5)
SET IDENTITY_INSERT [dbo].[Review] OFF
GO
INSERT [dbo].[RolePrevelige] ([RoleId], [PreveligeId]) VALUES (N'Tailor', 1)
INSERT [dbo].[RolePrevelige] ([RoleId], [PreveligeId]) VALUES (N'Tailor', 2)
INSERT [dbo].[RolePrevelige] ([RoleId], [PreveligeId]) VALUES (N'Tailor', 3)
INSERT [dbo].[RolePrevelige] ([RoleId], [PreveligeId]) VALUES (N'Tailor', 4)
INSERT [dbo].[RolePrevelige] ([RoleId], [PreveligeId]) VALUES (N'Tailor', 5)
INSERT [dbo].[RolePrevelige] ([RoleId], [PreveligeId]) VALUES (N'Tailor', 8)
INSERT [dbo].[RolePrevelige] ([RoleId], [PreveligeId]) VALUES (N'Tailor', 9)
INSERT [dbo].[RolePrevelige] ([RoleId], [PreveligeId]) VALUES (N'User', 6)
INSERT [dbo].[RolePrevelige] ([RoleId], [PreveligeId]) VALUES (N'User', 7)
GO
SET IDENTITY_INSERT [dbo].[TailorProjectImages] ON 

INSERT [dbo].[TailorProjectImages] ([Id], [ProjectId], [ImagePath]) VALUES (1, 1, N'/Images\ProjectImages\8da2eefa-b994-429e-93d7-e7754b3c3e95.png')
INSERT [dbo].[TailorProjectImages] ([Id], [ProjectId], [ImagePath]) VALUES (2, 1, N'/Images\ProjectImages\8819a5eb-a9ae-42e4-9a89-0d8127274b66.png')
SET IDENTITY_INSERT [dbo].[TailorProjectImages] OFF
GO
SET IDENTITY_INSERT [dbo].[TailorProjects] ON 

INSERT [dbo].[TailorProjects] ([Id], [Title], [Description], [ProductCategoryId], [AddedOn], [UpdatedOn], [AddedBy], [isActive], [ImagePath]) VALUES (1, N'My First Project ', N'<p>this is just used for testing first Project Add and Edit</p>', 1, CAST(N'2023-10-15T10:11:49.297' AS DateTime), CAST(N'2023-10-15T10:34:03.513' AS DateTime), N'admin@admin.com', 1, N'/Images\ProjectImages\3caa6138-a82c-4e4e-8da1-4eb38a963835.png')
SET IDENTITY_INSERT [dbo].[TailorProjects] OFF
GO
SET IDENTITY_INSERT [dbo].[UserProfile] ON 

INSERT [dbo].[UserProfile] ([Id], [FirstName], [LastName], [Address], [isApproved], [AddedOn], [isActive], [UpdatedOn], [UserId], [ImagePath], [PhoneNumber]) VALUES (2, N'Umair', N'Noor', N'ver', 1, CAST(N'2023-10-14T00:00:00.000' AS DateTime), 1, CAST(N'2023-10-14T00:00:00.000' AS DateTime), N'e49a103c-d8f8-4c7d-9241-fbbf5ee91ef8', N'/Images\UserImages\55f49959-619a-488d-932d-4e7b2732eece.jpeg', N'345')
INSERT [dbo].[UserProfile] ([Id], [FirstName], [LastName], [Address], [isApproved], [AddedOn], [isActive], [UpdatedOn], [UserId], [ImagePath], [PhoneNumber]) VALUES (3, N'Client1', NULL, NULL, 1, CAST(N'2023-10-17T00:00:00.000' AS DateTime), 1, CAST(N'2023-10-17T00:00:00.000' AS DateTime), N'6ba4c070-b4e0-4eee-93fa-53e65ccdf503', NULL, NULL)
SET IDENTITY_INSERT [dbo].[UserProfile] OFF
GO
ALTER TABLE [Audit].[AspNetUsers_Audit] ADD  DEFAULT (getdate()) FOR [AuditDate]
GO
ALTER TABLE [Audit].[AspNetUsers_Audit] ADD  DEFAULT ([dbo].[GetCurrentUser]()) FOR [AuditUser]
GO
ALTER TABLE [Audit].[ClientOrderIdeaImages_Audit] ADD  DEFAULT (getdate()) FOR [AuditDate]
GO
ALTER TABLE [Audit].[ClientOrderIdeaImages_Audit] ADD  DEFAULT ([dbo].[GetCurrentUser]()) FOR [AuditUser]
GO
ALTER TABLE [Audit].[ClientOrders_Audit] ADD  DEFAULT (getdate()) FOR [AuditDate]
GO
ALTER TABLE [Audit].[ClientOrders_Audit] ADD  DEFAULT ([dbo].[GetCurrentUser]()) FOR [AuditUser]
GO
ALTER TABLE [Audit].[FeatureGroups_Audit] ADD  DEFAULT (getdate()) FOR [AuditDate]
GO
ALTER TABLE [Audit].[FeatureGroups_Audit] ADD  DEFAULT ([dbo].[GetCurrentUser]()) FOR [AuditUser]
GO
ALTER TABLE [Audit].[Features_Audit] ADD  DEFAULT (getdate()) FOR [AuditDate]
GO
ALTER TABLE [Audit].[Features_Audit] ADD  DEFAULT ([dbo].[GetCurrentUser]()) FOR [AuditUser]
GO
ALTER TABLE [Audit].[Lookup_Audit] ADD  DEFAULT (getdate()) FOR [AuditDate]
GO
ALTER TABLE [Audit].[Lookup_Audit] ADD  DEFAULT ([dbo].[GetCurrentUser]()) FOR [AuditUser]
GO
ALTER TABLE [Audit].[OrderFeatures_Audit] ADD  DEFAULT (getdate()) FOR [AuditDate]
GO
ALTER TABLE [Audit].[OrderFeatures_Audit] ADD  DEFAULT ([dbo].[GetCurrentUser]()) FOR [AuditUser]
GO
ALTER TABLE [Audit].[ProductCategory_Audit] ADD  DEFAULT (getdate()) FOR [AuditDate]
GO
ALTER TABLE [Audit].[ProductCategory_Audit] ADD  DEFAULT ([dbo].[GetCurrentUser]()) FOR [AuditUser]
GO
ALTER TABLE [Audit].[Review_Audit] ADD  DEFAULT (getdate()) FOR [AuditDate]
GO
ALTER TABLE [Audit].[Review_Audit] ADD  DEFAULT ([dbo].[GetCurrentUser]()) FOR [AuditUser]
GO
ALTER TABLE [Audit].[TailorProjectImages_Audit] ADD  DEFAULT (getdate()) FOR [AuditDate]
GO
ALTER TABLE [Audit].[TailorProjectImages_Audit] ADD  DEFAULT ([dbo].[GetCurrentUser]()) FOR [AuditUser]
GO
ALTER TABLE [Audit].[TailorProjects_Audit] ADD  DEFAULT (getdate()) FOR [AuditDate]
GO
ALTER TABLE [Audit].[TailorProjects_Audit] ADD  DEFAULT ([dbo].[GetCurrentUser]()) FOR [AuditUser]
GO
ALTER TABLE [Audit].[UserProfile_Audit] ADD  DEFAULT (getdate()) FOR [AuditDate]
GO
ALTER TABLE [Audit].[UserProfile_Audit] ADD  DEFAULT ([dbo].[GetCurrentUser]()) FOR [AuditUser]
GO
ALTER TABLE [dbo].[ClientOrders] ADD  CONSTRAINT [DF_ClientOrders_isPaid]  DEFAULT ((0)) FOR [isPaid]
GO
ALTER TABLE [dbo].[ClientOrders] ADD  CONSTRAINT [DF_ClientOrders_isConfirmed]  DEFAULT ((0)) FOR [isConfirmed]
GO
ALTER TABLE [dbo].[ClientOrders] ADD  CONSTRAINT [DF_ClientOrders_isDelivered]  DEFAULT ((0)) FOR [isDelivered]
GO
ALTER TABLE [dbo].[ClientOrders] ADD  CONSTRAINT [DF_ClientOrders_isActive]  DEFAULT ((1)) FOR [isActive]
GO
ALTER TABLE [dbo].[Features] ADD  CONSTRAINT [DF_Features_isActive]  DEFAULT ((1)) FOR [isActive]
GO
ALTER TABLE [dbo].[OrderFeatures] ADD  CONSTRAINT [DF_OrderFeatures_isActive]  DEFAULT ((1)) FOR [isActive]
GO
ALTER TABLE [dbo].[ProductCategory] ADD  CONSTRAINT [DF_ProductCategory_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[TailorProjects] ADD  CONSTRAINT [DF_TailorProjects_isActive]  DEFAULT ((1)) FOR [isActive]
GO
ALTER TABLE [dbo].[UserProfile] ADD  CONSTRAINT [DF_UserProfile_isApproved]  DEFAULT ((0)) FOR [isApproved]
GO
ALTER TABLE [dbo].[UserProfile] ADD  CONSTRAINT [DF_UserProfile_isActive]  DEFAULT ((1)) FOR [isActive]
GO
ALTER TABLE [dbo].[AspNetRoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetRoleClaims] CHECK CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetRoles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetRoles]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetUsers] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetUsers]
GO
ALTER TABLE [dbo].[AspNetUserTokens]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserTokens] CHECK CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[ClientOrderIdeaImages]  WITH CHECK ADD  CONSTRAINT [FK_ClientOrderIdeaImages_ClientOrders] FOREIGN KEY([OrderId])
REFERENCES [dbo].[ClientOrders] ([Id])
GO
ALTER TABLE [dbo].[ClientOrderIdeaImages] CHECK CONSTRAINT [FK_ClientOrderIdeaImages_ClientOrders]
GO
ALTER TABLE [dbo].[ClientOrders]  WITH CHECK ADD  CONSTRAINT [FK_ClientOrders_ProductCategory] FOREIGN KEY([OrderType])
REFERENCES [dbo].[ProductCategory] ([Id])
GO
ALTER TABLE [dbo].[ClientOrders] CHECK CONSTRAINT [FK_ClientOrders_ProductCategory]
GO
ALTER TABLE [dbo].[ClientOrders]  WITH CHECK ADD  CONSTRAINT [FK_ClientOrders_UserProfile] FOREIGN KEY([ClientId])
REFERENCES [dbo].[UserProfile] ([Id])
GO
ALTER TABLE [dbo].[ClientOrders] CHECK CONSTRAINT [FK_ClientOrders_UserProfile]
GO
ALTER TABLE [dbo].[Features]  WITH CHECK ADD  CONSTRAINT [FK_Features_FeatureGroups] FOREIGN KEY([FeatureGroupId])
REFERENCES [dbo].[FeatureGroups] ([Id])
GO
ALTER TABLE [dbo].[Features] CHECK CONSTRAINT [FK_Features_FeatureGroups]
GO
ALTER TABLE [dbo].[OrderFeatures]  WITH CHECK ADD  CONSTRAINT [FK_OrderFeatures_ClientOrders] FOREIGN KEY([OrderId])
REFERENCES [dbo].[ClientOrders] ([Id])
GO
ALTER TABLE [dbo].[OrderFeatures] CHECK CONSTRAINT [FK_OrderFeatures_ClientOrders]
GO
ALTER TABLE [dbo].[OrderFeatures]  WITH CHECK ADD  CONSTRAINT [FK_OrderFeatures_Features] FOREIGN KEY([FeatureId])
REFERENCES [dbo].[Features] ([Id])
GO
ALTER TABLE [dbo].[OrderFeatures] CHECK CONSTRAINT [FK_OrderFeatures_Features]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_UserProfile] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserProfile] ([Id])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_Review_UserProfile]
GO
ALTER TABLE [dbo].[RolePrevelige]  WITH CHECK ADD  CONSTRAINT [FK_RolePrevelige_AspNetRoles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
GO
ALTER TABLE [dbo].[RolePrevelige] CHECK CONSTRAINT [FK_RolePrevelige_AspNetRoles]
GO
ALTER TABLE [dbo].[RolePrevelige]  WITH CHECK ADD  CONSTRAINT [FK_RolePrevelige_Prevelige] FOREIGN KEY([PreveligeId])
REFERENCES [dbo].[Prevelige] ([Id])
GO
ALTER TABLE [dbo].[RolePrevelige] CHECK CONSTRAINT [FK_RolePrevelige_Prevelige]
GO
ALTER TABLE [dbo].[TailorProjectImages]  WITH CHECK ADD  CONSTRAINT [FK_TailorProjectImages_TailorProjects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[TailorProjects] ([Id])
GO
ALTER TABLE [dbo].[TailorProjectImages] CHECK CONSTRAINT [FK_TailorProjectImages_TailorProjects]
GO
ALTER TABLE [dbo].[TailorProjects]  WITH CHECK ADD  CONSTRAINT [FK_TailorProjects_ProductCategory] FOREIGN KEY([ProductCategoryId])
REFERENCES [dbo].[ProductCategory] ([Id])
GO
ALTER TABLE [dbo].[TailorProjects] CHECK CONSTRAINT [FK_TailorProjects_ProductCategory]
GO
ALTER TABLE [dbo].[UserProfile]  WITH CHECK ADD  CONSTRAINT [FK_UserProfile_AspNetUsers] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[UserProfile] CHECK CONSTRAINT [FK_UserProfile_AspNetUsers]
GO
/****** Object:  Trigger [dbo].[tr_AspNetUsers_Audit]    Script Date: 26/11/2023 9:37:18 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create a trigger for the AspNetUsers table (UPDATE, DELETE only)
CREATE TRIGGER [dbo].[tr_AspNetUsers_Audit]
ON [dbo].[AspNetUsers]
AFTER UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
    BEGIN
        -- Capture DELETE operation
        INSERT INTO Audit.AspNetUsers_Audit (AuditOperation, Id, UserName, NormalizedUserName, Email, NormalizedEmail, EmailConfirmed, PasswordHash, SecurityStamp, ConcurrencyStamp, PhoneNumber, PhoneNumberConfirmed, TwoFactorEnabled, LockoutEnd, LockoutEnabled, AccessFailedCount)
        SELECT 'DELETE', Id, UserName, NormalizedUserName, Email, NormalizedEmail, EmailConfirmed, PasswordHash, SecurityStamp, ConcurrencyStamp, PhoneNumber, PhoneNumberConfirmed, TwoFactorEnabled, LockoutEnd, LockoutEnabled, AccessFailedCount FROM deleted;
    END;

    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        -- Capture UPDATE operation
        INSERT INTO Audit.AspNetUsers_Audit (AuditOperation, Id, UserName, NormalizedUserName, Email, NormalizedEmail, EmailConfirmed, PasswordHash, SecurityStamp, ConcurrencyStamp, PhoneNumber, PhoneNumberConfirmed, TwoFactorEnabled, LockoutEnd, LockoutEnabled, AccessFailedCount)
        SELECT 'UPDATE', d.Id, d.UserName, d.NormalizedUserName, d.Email, d.NormalizedEmail, d.EmailConfirmed, d.PasswordHash, d.SecurityStamp, d.ConcurrencyStamp, d.PhoneNumber, d.PhoneNumberConfirmed, d.TwoFactorEnabled, d.LockoutEnd, d.LockoutEnabled, d.AccessFailedCount
        FROM deleted d
        WHERE EXISTS (SELECT * FROM inserted i WHERE i.Id = d.Id);
    END;
END;
GO
ALTER TABLE [dbo].[AspNetUsers] ENABLE TRIGGER [tr_AspNetUsers_Audit]
GO
/****** Object:  Trigger [dbo].[tr_ClientOrderIdeaImages_Audit]    Script Date: 26/11/2023 9:37:19 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Create a trigger for the ClientOrderIdeaImages table (UPDATE, DELETE only)
CREATE TRIGGER [dbo].[tr_ClientOrderIdeaImages_Audit]
ON [dbo].[ClientOrderIdeaImages]
AFTER UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
    BEGIN
        -- Capture DELETE operation
        INSERT INTO Audit.ClientOrderIdeaImages_Audit (AuditOperation, Id, OrderId, ImagePath)
        SELECT 'DELETE', Id, OrderId, ImagePath FROM deleted;
    END;

    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        -- Capture UPDATE operation
        INSERT INTO Audit.ClientOrderIdeaImages_Audit (AuditOperation, Id, OrderId, ImagePath)
        SELECT 'UPDATE', d.Id, d.OrderId, d.ImagePath
        FROM deleted d
        WHERE EXISTS (SELECT * FROM inserted i WHERE i.Id = d.Id);
    END;
END;
GO
ALTER TABLE [dbo].[ClientOrderIdeaImages] ENABLE TRIGGER [tr_ClientOrderIdeaImages_Audit]
GO
/****** Object:  Trigger [dbo].[tr_ClientOrders_Audit]    Script Date: 26/11/2023 9:37:19 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Create a trigger for the ClientOrders table (UPDATE, DELETE only)
CREATE TRIGGER [dbo].[tr_ClientOrders_Audit]
ON [dbo].[ClientOrders]
AFTER UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
    BEGIN
        -- Capture DELETE operation
        INSERT INTO Audit.ClientOrders_Audit (AuditOperation, Id, Title, Description, isPaid, isConfirmed, isDelivered, ClientId, AddedBy, AddedOn, UpdatedOn, isActive, Measurements, OrderType, Price, Deadline)
        SELECT 'DELETE', Id, Title, Description, isPaid, isConfirmed, isDelivered, ClientId, AddedBy, AddedOn, UpdatedOn, isActive, Measurements, OrderType, Price, Deadline FROM deleted;
    END;

    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        -- Capture UPDATE operation
        INSERT INTO Audit.ClientOrders_Audit (AuditOperation, Id, Title, Description, isPaid, isConfirmed, isDelivered, ClientId, AddedBy, AddedOn, UpdatedOn, isActive, Measurements, OrderType, Price, Deadline)
        SELECT 'UPDATE', d.Id, d.Title, d.Description, d.isPaid, d.isConfirmed, d.isDelivered, d.ClientId, d.AddedBy, d.AddedOn, d.UpdatedOn, d.isActive, d.Measurements, d.OrderType, d.Price, d.Deadline
        FROM deleted d
        WHERE EXISTS (SELECT * FROM inserted i WHERE i.Id = d.Id);
    END;
END;
GO
ALTER TABLE [dbo].[ClientOrders] ENABLE TRIGGER [tr_ClientOrders_Audit]
GO
/****** Object:  Trigger [dbo].[tr_FeatureGroups_Audit]    Script Date: 26/11/2023 9:37:19 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Create a trigger for the FeatureGroups table (UPDATE, DELETE only)
CREATE TRIGGER [dbo].[tr_FeatureGroups_Audit]
ON [dbo].[FeatureGroups]
AFTER UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
    BEGIN
        -- Capture DELETE operation
        INSERT INTO Audit.FeatureGroups_Audit (AuditOperation, Id, Name, AddedOn, AddedBy, UpdatedOn, isActive)
        SELECT 'DELETE', Id, Name, AddedOn, AddedBy, UpdatedOn, isActive FROM deleted;
    END;

    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        -- Capture UPDATE operation
        INSERT INTO Audit.FeatureGroups_Audit (AuditOperation, Id, Name, AddedOn, AddedBy, UpdatedOn, isActive)
        SELECT 'UPDATE', d.Id, d.Name, d.AddedOn, d.AddedBy, d.UpdatedOn, d.isActive
        FROM deleted d
        WHERE EXISTS (SELECT * FROM inserted i WHERE i.Id = d.Id);
    END;
END;
GO
ALTER TABLE [dbo].[FeatureGroups] ENABLE TRIGGER [tr_FeatureGroups_Audit]
GO
/****** Object:  Trigger [dbo].[tr_Features_Audit]    Script Date: 26/11/2023 9:37:20 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Create a trigger for the Features table (UPDATE, DELETE only)
CREATE TRIGGER [dbo].[tr_Features_Audit]
ON [dbo].[Features]
AFTER UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
    BEGIN
        -- Capture DELETE operation
        INSERT INTO Audit.Features_Audit (AuditOperation, Id, Name, Description, FeatureGroupId, Price, AddedOn, AddedBy, UpdatedOn, isActive)
        SELECT 'DELETE', Id, Name, Description, FeatureGroupId, Price, AddedOn, AddedBy, UpdatedOn, isActive FROM deleted;
    END;

    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        -- Capture UPDATE operation
        INSERT INTO Audit.Features_Audit (AuditOperation, Id, Name, Description, FeatureGroupId, Price, AddedOn, AddedBy, UpdatedOn, isActive)
        SELECT 'UPDATE', d.Id, d.Name, d.Description, d.FeatureGroupId, d.Price, d.AddedOn, d.AddedBy, d.UpdatedOn, d.isActive
        FROM deleted d
        WHERE EXISTS (SELECT * FROM inserted i WHERE i.Id = d.Id);
    END;
END;
GO
ALTER TABLE [dbo].[Features] ENABLE TRIGGER [tr_Features_Audit]
GO
/****** Object:  Trigger [dbo].[tr_Lookup_Audit]    Script Date: 26/11/2023 9:37:20 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Create a trigger for the Lookup table (UPDATE, DELETE only)
CREATE TRIGGER [dbo].[tr_Lookup_Audit]
ON [dbo].[Lookup]
AFTER UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
    BEGIN
        -- Capture DELETE operation
        INSERT INTO Audit.Lookup_Audit (AuditOperation, Id, Category, Value, displayOrder)
        SELECT 'DELETE', Id, Category, Value, displayOrder FROM deleted;
    END;

    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        -- Capture UPDATE operation
        INSERT INTO Audit.Lookup_Audit (AuditOperation, Id, Category, Value, displayOrder)
        SELECT 'UPDATE', d.Id, d.Category, d.Value, d.displayOrder
        FROM deleted d
        WHERE EXISTS (SELECT * FROM inserted i WHERE i.Id = d.Id);
    END;
END;
GO
ALTER TABLE [dbo].[Lookup] ENABLE TRIGGER [tr_Lookup_Audit]
GO
/****** Object:  Trigger [dbo].[tr_OrderFeatures_Audit]    Script Date: 26/11/2023 9:37:20 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Create a trigger for the OrderFeatures table (UPDATE, DELETE only)
CREATE TRIGGER [dbo].[tr_OrderFeatures_Audit]
ON [dbo].[OrderFeatures]
AFTER UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
    BEGIN
        -- Capture DELETE operation
        INSERT INTO Audit.OrderFeatures_Audit (AuditOperation, Id, OrderId, FeatureId, isActive)
        SELECT 'DELETE', Id, OrderId, FeatureId, isActive FROM deleted;
    END;

    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        -- Capture UPDATE operation
        INSERT INTO Audit.OrderFeatures_Audit (AuditOperation, Id, OrderId, FeatureId, isActive)
        SELECT 'UPDATE', d.Id, d.OrderId, d.FeatureId, d.isActive
        FROM deleted d
        WHERE EXISTS (SELECT * FROM inserted i WHERE i.Id = d.Id);
    END;
END;
GO
ALTER TABLE [dbo].[OrderFeatures] ENABLE TRIGGER [tr_OrderFeatures_Audit]
GO
/****** Object:  Trigger [dbo].[tr_ProductCategory_Audit]    Script Date: 26/11/2023 9:37:20 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Create a trigger for the ProductCategory table (UPDATE, DELETE only)
CREATE TRIGGER [dbo].[tr_ProductCategory_Audit]
ON [dbo].[ProductCategory]
AFTER UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
    BEGIN
        -- Capture DELETE operation
        INSERT INTO Audit.ProductCategory_Audit (AuditOperation, Id, Name, Price, AddedOn, AddedBy, UpdatedOn, IsActive)
        SELECT 'DELETE', Id, Name, Price, AddedOn, AddedBy, UpdatedOn, IsActive FROM deleted;
    END;

    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        -- Capture UPDATE operation
        INSERT INTO Audit.ProductCategory_Audit (AuditOperation, Id, Name, Price, AddedOn, AddedBy, UpdatedOn, IsActive)
        SELECT 'UPDATE', d.Id, d.Name, d.Price, d.AddedOn, d.AddedBy, d.UpdatedOn, d.IsActive
        FROM deleted d
        WHERE EXISTS (SELECT * FROM inserted i WHERE i.Id = d.Id);
    END;
END;
GO
ALTER TABLE [dbo].[ProductCategory] ENABLE TRIGGER [tr_ProductCategory_Audit]
GO
/****** Object:  Trigger [dbo].[tr_Review_Audit]    Script Date: 26/11/2023 9:37:20 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Create a trigger for the Review table (UPDATE, DELETE only)
CREATE TRIGGER [dbo].[tr_Review_Audit]
ON [dbo].[Review]
AFTER UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
    BEGIN
        -- Capture DELETE operation
        INSERT INTO Audit.Review_Audit (AuditOperation, Id, Message, UserId, AddedOn, AddedBy, Response, ResponseAddedOn, Rating)
        SELECT 'DELETE', Id, Message, UserId, AddedOn, AddedBy, Response, ResponseAddedOn, Rating FROM deleted;
    END;

    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        -- Capture UPDATE operation
        INSERT INTO Audit.Review_Audit (AuditOperation, Id, Message, UserId, AddedOn, AddedBy, Response, ResponseAddedOn, Rating)
        SELECT 'UPDATE', d.Id, d.Message, d.UserId, d.AddedOn, d.AddedBy, d.Response, d.ResponseAddedOn, d.Rating
        FROM deleted d
        WHERE EXISTS (SELECT * FROM inserted i WHERE i.Id = d.Id);
    END;
END;
GO
ALTER TABLE [dbo].[Review] ENABLE TRIGGER [tr_Review_Audit]
GO
/****** Object:  Trigger [dbo].[tr_TailorProjectImages_Audit]    Script Date: 26/11/2023 9:37:20 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Create a trigger for the TailorProjectImages table (UPDATE, DELETE only)
CREATE TRIGGER [dbo].[tr_TailorProjectImages_Audit]
ON [dbo].[TailorProjectImages]
AFTER UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
    BEGIN
        -- Capture DELETE operation
        INSERT INTO Audit.TailorProjectImages_Audit (AuditOperation, Id, ProjectId, ImagePath)
        SELECT 'DELETE', Id, ProjectId, ImagePath FROM deleted;
    END;

    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        -- Capture UPDATE operation
        INSERT INTO Audit.TailorProjectImages_Audit (AuditOperation, Id, ProjectId, ImagePath)
        SELECT 'UPDATE', d.Id, d.ProjectId, d.ImagePath
        FROM deleted d
        WHERE EXISTS (SELECT * FROM inserted i WHERE i.Id = d.Id);
    END;
END;
GO
ALTER TABLE [dbo].[TailorProjectImages] ENABLE TRIGGER [tr_TailorProjectImages_Audit]
GO
/****** Object:  Trigger [dbo].[tr_TailorProjects_Audit]    Script Date: 26/11/2023 9:37:20 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Create a trigger for the TailorProjects table (UPDATE, DELETE only)
CREATE TRIGGER [dbo].[tr_TailorProjects_Audit]
ON [dbo].[TailorProjects]
AFTER UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
    BEGIN
        -- Capture DELETE operation
        INSERT INTO Audit.TailorProjects_Audit (AuditOperation, Id, Title, Description, ProductCategoryId, AddedOn, UpdatedOn, AddedBy, IsActive, ImagePath)
        SELECT 'DELETE', Id, Title, Description, ProductCategoryId, AddedOn, UpdatedOn, AddedBy, IsActive, ImagePath FROM deleted;
    END;

    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        -- Capture UPDATE operation
        INSERT INTO Audit.TailorProjects_Audit (AuditOperation, Id, Title, Description, ProductCategoryId, AddedOn, UpdatedOn, AddedBy, IsActive, ImagePath)
        SELECT 'UPDATE', d.Id, d.Title, d.Description, d.ProductCategoryId, d.AddedOn, d.UpdatedOn, d.AddedBy, d.IsActive, d.ImagePath
        FROM deleted d
        WHERE EXISTS (SELECT * FROM inserted i WHERE i.Id = d.Id);
    END;
END;
GO
ALTER TABLE [dbo].[TailorProjects] ENABLE TRIGGER [tr_TailorProjects_Audit]
GO
/****** Object:  Trigger [dbo].[tr_UserProfile_Audit]    Script Date: 26/11/2023 9:37:20 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create a trigger for the UserProfile table (UPDATE, DELETE only)
CREATE TRIGGER [dbo].[tr_UserProfile_Audit]
ON [dbo].[UserProfile]
AFTER UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
    BEGIN
        -- Capture DELETE operation
        INSERT INTO Audit.UserProfile_Audit (AuditOperation, Id, FirstName, LastName, Address, IsApproved, AddedOn, IsActive, UpdatedOn, UserId, ImagePath, PhoneNumber)
        SELECT 'DELETE', Id, FirstName, LastName, Address, IsApproved, AddedOn, IsActive, UpdatedOn, UserId, ImagePath, PhoneNumber FROM deleted;
    END;

    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        -- Capture UPDATE operation
        INSERT INTO Audit.UserProfile_Audit (AuditOperation, Id, FirstName, LastName, Address, IsApproved, AddedOn, IsActive, UpdatedOn, UserId, ImagePath, PhoneNumber)
        SELECT 'UPDATE', d.Id, d.FirstName, d.LastName, d.Address, d.IsApproved, d.AddedOn, d.IsActive, d.UpdatedOn, d.UserId, d.ImagePath, d.PhoneNumber
        FROM deleted d
        WHERE EXISTS (SELECT * FROM inserted i WHERE i.Id = d.Id);
    END;
END;
GO
ALTER TABLE [dbo].[UserProfile] ENABLE TRIGGER [tr_UserProfile_Audit]
GO
USE [master]
GO
ALTER DATABASE [ClothXDb] SET  READ_WRITE 
GO
