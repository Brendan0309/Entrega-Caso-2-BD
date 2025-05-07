# Entrega-Caso-2-BD

Nombre de los integrantes

-Brendan Ramírez Campos

<hr>

Diseño Actualizado de la base de datos: [DIagrama de la base final.pdf](https://github.com/user-attachments/files/20075204/DIagrama.de.la.base.final.pdf)

Script de Creación de la base de datos:
-Archivo .SQL [UploUSE [master]
GO
/****** Object:  Database [caipiDb]    Script Date: 4/25/2025 9:22:59 PM ******/
CREATE DATABASE [caipiDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'caipiDb', FILENAME = N'E:\Bases de datos 1, tercer semestre\Entregable 2\caipiDb.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'caipiDb_log', FILENAME = N'E:\Bases de datos 1, tercer semestre\Entregable 2\caipiDb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [caipiDb] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [caipiDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [caipiDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [caipiDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [caipiDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [caipiDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [caipiDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [caipiDb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [caipiDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [caipiDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [caipiDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [caipiDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [caipiDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [caipiDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [caipiDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [caipiDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [caipiDb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [caipiDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [caipiDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [caipiDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [caipiDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [caipiDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [caipiDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [caipiDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [caipiDb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [caipiDb] SET  MULTI_USER 
GO
ALTER DATABASE [caipiDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [caipiDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [caipiDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [caipiDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [caipiDb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [caipiDb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'caipiDb', N'ON'
GO
ALTER DATABASE [caipiDb] SET QUERY_STORE = ON
GO
ALTER DATABASE [caipiDb] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [caipiDb]
GO
/****** Object:  Table [dbo].[caip_DealMedia]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caip_DealMedia](
	[dealMediaId] [int] NOT NULL,
	[partnerDealId] [int] NOT NULL,
	[mediaFileId] [int] NOT NULL,
 CONSTRAINT [PK_caip_DealMedia] PRIMARY KEY CLUSTERED 
(
	[dealMediaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_adresses]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_adresses](
	[adressId] [int] IDENTITY(1,1) NOT NULL,
	[line1] [varchar](200) NOT NULL,
	[line2] [varchar](200) NULL,
	[zipcode] [varchar](9) NOT NULL,
	[geoposition] [geography] NOT NULL,
	[cityId] [int] NOT NULL,
 CONSTRAINT [PK_caipi_adresses] PRIMARY KEY CLUSTERED 
(
	[adressId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_BenefitRestrictions]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_BenefitRestrictions](
	[benefitRestrictionId] [int] NOT NULL,
	[restrictionDesc] [varchar](200) NOT NULL,
	[maxAmount] [varchar](10) NOT NULL,
	[scheduleId] [int] NOT NULL,
	[isActive] [bit] NOT NULL,
	[dealBenefitDetalId] [int] NOT NULL,
	[dateRestriction] [int] NOT NULL,
 CONSTRAINT [PK_caipi_BenefitRestrictions] PRIMARY KEY CLUSTERED 
(
	[benefitRestrictionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_Cities]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_Cities](
	[cityId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](60) NOT NULL,
	[stateId] [int] NOT NULL,
 CONSTRAINT [PK_caipi_Cities] PRIMARY KEY CLUSTERED 
(
	[cityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_CompanyRoles]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_CompanyRoles](
	[companyRoleId] [int] NOT NULL,
	[roleName] [varchar](30) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_ContacInfoPerson]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_ContacInfoPerson](
	[value] [varchar](100) NOT NULL,
	[enabled] [bit] NOT NULL,
	[lastUpdate] [datetime] NOT NULL,
	[contactInfoTypeId] [int] NULL,
	[personId] [int] NULL,
	[metodoId] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_contactInfoInstituciones]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_contactInfoInstituciones](
	[value] [varchar](100) NOT NULL,
	[enabled] [bit] NOT NULL,
	[lastUpdate] [datetime] NOT NULL,
	[contacInfoTypeId] [int] IDENTITY(1,1) NOT NULL,
	[institucionesId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_ContactInfoTypes]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_ContactInfoTypes](
	[contactInfoTypeId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](20) NOT NULL,
 CONSTRAINT [PK_caipi_ContactInfoTypes] PRIMARY KEY CLUSTERED 
(
	[contactInfoTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_Countries]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_Countries](
	[countryId] [tinyint] IDENTITY(1,1) NOT NULL,
	[name] [varchar](60) NOT NULL,
	[currencyId] [int] NOT NULL,
 CONSTRAINT [PK_caipi_Countries] PRIMARY KEY CLUSTERED 
(
	[countryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_Currencies]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_Currencies](
	[currencyid] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](45) NOT NULL,
	[acronym] [varchar](3) NOT NULL,
	[symbol] [char](1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[currencyid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_CurrencyConversions]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_CurrencyConversions](
	[conversionid] [int] IDENTITY(1,1) NOT NULL,
	[startdate] [date] NOT NULL,
	[enddate] [date] NULL,
	[exchangeRate] [decimal](10, 6) NOT NULL,
	[enabled] [bit] NULL,
	[currentExchangeRate] [bit] NULL,
	[currencyid_source] [int] NOT NULL,
	[currencyid_destiny] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[conversionid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_dateRestriction]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_dateRestriction](
	[dateRestrictionId] [int] NOT NULL,
	[startdate] [date] NOT NULL,
	[endDate] [date] NULL,
 CONSTRAINT [PK_caipi_dateRestriction] PRIMARY KEY CLUSTERED 
(
	[dateRestrictionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_DealBenefitTypes]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_DealBenefitTypes](
	[dealBenefitTypesId] [int] NOT NULL,
	[name] [varchar](50) NOT NULL,
	[description] [varchar](100) NOT NULL,
	[isActive] [bit] NOT NULL,
 CONSTRAINT [PK_caipi_DealBenefitDetails] PRIMARY KEY CLUSTERED 
(
	[dealBenefitTypesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_distribution]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_distribution](
	[distributionId] [int] NOT NULL,
	[enabled] [bit] NOT NULL,
	[checksum] [varbinary](200) NOT NULL,
	[subTypeId] [int] NOT NULL,
	[pagoId] [int] NOT NULL,
 CONSTRAINT [PK_caipi_distribution] PRIMARY KEY CLUSTERED 
(
	[distributionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_featureName]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_featureName](
	[featureNameId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
 CONSTRAINT [PK_caipi_featureName] PRIMARY KEY CLUSTERED 
(
	[featureNameId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_featurePrice]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_featurePrice](
	[featurePriceId] [int] IDENTITY(1,1) NOT NULL,
	[featurePriceTypeId] [int] NOT NULL,
	[originalPrice] [int] NOT NULL,
	[discountValue] [int] NOT NULL,
	[solturaPercent] [decimal](3, 2) NOT NULL,
	[userPrice] [int] NOT NULL,
	[userPriceivi] [int] NOT NULL,
	[partnerDealId] [int] NOT NULL,
 CONSTRAINT [PK_caipi_contractDiscounts] PRIMARY KEY CLUSTERED 
(
	[featurePriceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_featurePriceTypes]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_featurePriceTypes](
	[featurePriceTypesid] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](25) NOT NULL,
 CONSTRAINT [PK_caipi_contractDiscountTypes] PRIMARY KEY CLUSTERED 
(
	[featurePriceTypesid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_Features]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_Features](
	[featureId] [int] IDENTITY(1,1) NOT NULL,
	[featureNameId] [int] NOT NULL,
	[value] [varchar](100) NOT NULL,
	[enabled] [bit] NOT NULL,
	[featureTypeId] [int] NOT NULL,
	[institucionesid] [int] NOT NULL,
	[featurePriceId] [int] NOT NULL,
 CONSTRAINT [PK_caipi_Features] PRIMARY KEY CLUSTERED 
(
	[featureId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_featuresPerPlan]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_featuresPerPlan](
	[featuresPerPlanId] [int] IDENTITY(1,1) NOT NULL,
	[enabled] [bit] NOT NULL,
	[featureId] [int] NOT NULL,
	[planId] [int] NOT NULL,
 CONSTRAINT [PK_caipi_featuresPerPlan] PRIMARY KEY CLUSTERED 
(
	[featuresPerPlanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_FeaturesType]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_FeaturesType](
	[featureTypeId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[enabled] [bit] NOT NULL,
 CONSTRAINT [PK_caipi_FeaturesType] PRIMARY KEY CLUSTERED 
(
	[featureTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_Instituciones]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_Instituciones](
	[institucioneId] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](60) NOT NULL,
	[creationDate] [datetime] NOT NULL,
	[enabled] [bit] NOT NULL,
	[adressId] [int] NULL,
 CONSTRAINT [PK_caipi_Instituciones] PRIMARY KEY CLUSTERED 
(
	[institucioneId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_Languages]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_Languages](
	[languageId] [int] NOT NULL,
	[name] [varchar](30) NOT NULL,
	[culture] [varchar](5) NOT NULL,
	[countryId] [tinyint] NOT NULL,
 CONSTRAINT [PK_caipi_Languages] PRIMARY KEY CLUSTERED 
(
	[languageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_Log]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_Log](
	[logId] [int] NOT NULL,
	[description] [varchar](100) NOT NULL,
	[postTime] [datetime] NOT NULL,
	[computer] [varchar](45) NOT NULL,
	[username] [varchar](45) NOT NULL,
	[trace] [text] NULL,
	[reference1] [bigint] NULL,
	[reference2] [bigint] NULL,
	[value1] [bigint] NULL,
	[value2] [bigint] NULL,
	[checksum] [varbinary](250) NULL,
 CONSTRAINT [PK_caipi_Log] PRIMARY KEY CLUSTERED 
(
	[logId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_LogSeverity]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_LogSeverity](
	[logSeverityId] [int] NOT NULL,
	[name] [varchar](50) NOT NULL,
	[logId] [int] NOT NULL,
 CONSTRAINT [PK_caipi_LogSeverity] PRIMARY KEY CLUSTERED 
(
	[logSeverityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_LogSources]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_LogSources](
	[logSourceId] [int] NOT NULL,
	[name] [varchar](50) NOT NULL,
	[logId] [int] NOT NULL,
 CONSTRAINT [PK_caipi_LogSources] PRIMARY KEY CLUSTERED 
(
	[logSourceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_LogTypes]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_LogTypes](
	[logtypeId] [int] NOT NULL,
	[name] [varchar](50) NOT NULL,
	[ref1Desc] [varchar](50) NULL,
	[ref2Desc] [varchar](50) NULL,
	[val1Desc] [varchar](50) NULL,
	[val2Desc] [varchar](50) NULL,
	[logId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_MediaFiles]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_MediaFiles](
	[mediaFileId] [int] IDENTITY(1,1) NOT NULL,
	[url] [varchar](100) NOT NULL,
	[deleted] [bit] NOT NULL,
	[reference] [varchar](250) NOT NULL,
	[generationDate] [datetime] NOT NULL,
	[mediaTypeId] [int] NOT NULL,
 CONSTRAINT [PK_caipi_MediaFiles] PRIMARY KEY CLUSTERED 
(
	[mediaFileId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_MediaTypes]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_MediaTypes](
	[mediaTypeId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](30) NOT NULL,
	[playerImp] [varchar](60) NOT NULL,
 CONSTRAINT [PK_caipi_MediaTypes] PRIMARY KEY CLUSTERED 
(
	[mediaTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_MediosDisponibles]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_MediosDisponibles](
	[pagoMedioId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[token] [varbinary](250) NOT NULL,
	[expTokenDate] [date] NOT NULL,
	[maskAccount] [varchar](45) NOT NULL,
	[callbackURLget] [varchar](100) NOT NULL,
	[callBackPost] [varchar](100) NOT NULL,
	[callBackRedirect] [varchar](100) NOT NULL,
	[userId] [int] NOT NULL,
	[metodoPagoId] [int] NOT NULL,
	[configurationJSON] [nvarchar](max) NULL,
 CONSTRAINT [PK_caipi_MediosDisponibles] PRIMARY KEY CLUSTERED 
(
	[pagoMedioId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_MetodosDePago]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_MetodosDePago](
	[metodoPagoId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](17) NOT NULL,
	[apiURL] [varchar](60) NOT NULL,
	[secretKey] [varbinary](250) NOT NULL,
	[llave] [varbinary](128) NOT NULL,
	[logoIconURL] [varchar](45) NULL,
	[enabled] [bit] NOT NULL,
	[templateJSON] [nvarchar](max) NULL,
 CONSTRAINT [PK_caipi_MetodosDePago] PRIMARY KEY CLUSTERED 
(
	[metodoPagoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_Modules]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_Modules](
	[moduleId] [int] NOT NULL,
	[name] [varchar](40) NOT NULL,
	[languajeId] [int] NOT NULL,
 CONSTRAINT [PK_caipi_Modules] PRIMARY KEY CLUSTERED 
(
	[moduleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_NotificationMedia]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_NotificationMedia](
	[notificationMediaId] [int] NOT NULL,
	[name] [varchar](30) NOT NULL,
 CONSTRAINT [PK_caipi_NotificationMedia] PRIMARY KEY CLUSTERED 
(
	[notificationMediaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_Notifications]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_Notifications](
	[notificationId] [int] NOT NULL,
	[sentDate] [datetime] NOT NULL,
	[title] [varchar](100) NOT NULL,
	[description] [varchar](200) NULL,
	[notificationStatusId] [int] NOT NULL,
	[notificationMediaId] [int] NOT NULL,
	[sendUserId] [int] NOT NULL,
	[receiveUserId] [int] NOT NULL,
 CONSTRAINT [PK_caipi_Notifications] PRIMARY KEY CLUSTERED 
(
	[notificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_NotificationStatus]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_NotificationStatus](
	[notificationStatusId] [int] NOT NULL,
	[name] [varchar](45) NOT NULL,
 CONSTRAINT [PK_caipi_NotificationStatus] PRIMARY KEY CLUSTERED 
(
	[notificationStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_Pagos]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_Pagos](
	[pagoId] [int] NOT NULL,
	[pagoMedioId] [int] NOT NULL,
	[metodoPagoId] [int] NOT NULL,
	[personId] [int] NOT NULL,
	[monto] [float] NOT NULL,
	[actualMonto] [float] NOT NULL,
	[result] [varbinary](250) NOT NULL,
	[auth] [varbinary](300) NOT NULL,
	[chargeToken] [varbinary](250) NOT NULL,
	[error] [varchar](60) NULL,
	[fecha] [datetime] NOT NULL,
	[checksum] [varbinary](128) NOT NULL,
	[exchangeRate] [float] NOT NULL,
	[convertedAmount] [float] NOT NULL,
	[moduleId] [int] NOT NULL,
	[currencyId] [int] NOT NULL,
	[scheduleId] [int] NULL,
 CONSTRAINT [PK_caipi_Pagos] PRIMARY KEY CLUSTERED 
(
	[pagoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_pagosFeatures]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_pagosFeatures](
	[pagosFeaturesId] [int] NOT NULL,
	[featuresId] [int] NOT NULL,
	[distibutionId] [int] NOT NULL,
	[scheduleId] [int] NOT NULL,
 CONSTRAINT [PK_caipi_pagoInstituciones] PRIMARY KEY CLUSTERED 
(
	[pagosFeaturesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_partnerDealBenefits]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_partnerDealBenefits](
	[partnerDealBenefitsId] [int] NOT NULL,
	[partnerDealId] [int] NOT NULL,
	[dealBenefitTypesid] [int] NOT NULL,
	[starDate] [date] NOT NULL,
	[endDate] [date] NULL,
	[planId] [int] NOT NULL,
	[limit] [int] NOT NULL,
	[userId] [int] NOT NULL,
 CONSTRAINT [PK_caipi_partnerDealBenefits] PRIMARY KEY CLUSTERED 
(
	[partnerDealBenefitsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_PartnerDeals]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_PartnerDeals](
	[partnerDealId] [int] IDENTITY(1,1) NOT NULL,
	[institucioneId] [int] NOT NULL,
	[sealDate] [date] NOT NULL,
	[isActive] [bit] NOT NULL,
	[dealDescription] [text] NOT NULL,
 CONSTRAINT [PK_caipi_PartnerDeals] PRIMARY KEY CLUSTERED 
(
	[partnerDealId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_PartnerObligations]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_PartnerObligations](
	[partnerObligationId] [int] NOT NULL,
	[pledgedAmount] [decimal](16, 2) NULL,
	[currencyId] [int] NULL,
	[minValue] [int] NULL,
	[minValueDsc] [int] NULL,
	[isActicve] [bit] NOT NULL,
	[startDate] [date] NOT NULL,
	[endDate] [date] NULL,
	[obligationDesc] [varchar](100) NOT NULL,
	[partnerDealId] [int] NOT NULL,
	[lastUpdate] [date] NOT NULL,
 CONSTRAINT [PK_caipi_PartnerObligations] PRIMARY KEY CLUSTERED 
(
	[partnerObligationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_PartnerObligationsStorage]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_PartnerObligationsStorage](
	[storageId] [int] NOT NULL,
	[partnerObligationId] [int] NOT NULL,
 CONSTRAINT [PK_caipi_PartnerObligationsStorage] PRIMARY KEY CLUSTERED 
(
	[storageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_Permissions]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_Permissions](
	[permissionId] [int] NOT NULL,
	[description] [varchar](50) NOT NULL,
	[code] [varchar](10) NOT NULL,
	[moduleId] [int] NOT NULL,
 CONSTRAINT [PK_caipi_Permissions] PRIMARY KEY CLUSTERED 
(
	[permissionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_Personas]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_Personas](
	[personId] [int] IDENTITY(1,1) NOT NULL,
	[firstName] [varchar](45) NOT NULL,
	[lastname] [varchar](60) NOT NULL,
	[birthdate] [date] NOT NULL,
 CONSTRAINT [PK_caipi_Personas] PRIMARY KEY CLUSTERED 
(
	[personId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_PlanLimits]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_PlanLimits](
	[planLimitId] [int] NOT NULL,
	[limit_people] [tinyint] NOT NULL,
	[limit] [int] NOT NULL,
	[featureId] [int] NOT NULL,
	[planPerUserId] [int] NOT NULL,
	[description] [varchar](50) NULL,
 CONSTRAINT [PK_caipi_PlanLimits] PRIMARY KEY CLUSTERED 
(
	[planLimitId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_planPerUser]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_planPerUser](
	[planPerUserId] [int] IDENTITY(1,1) NOT NULL,
	[adquisitionDate] [date] NOT NULL,
	[expirationDate] [date] NOT NULL,
	[enabled] [bit] NOT NULL,
	[planId] [int] NOT NULL,
	[userId] [int] NOT NULL,
 CONSTRAINT [PK_caipi_planPerEntity] PRIMARY KEY CLUSTERED 
(
	[planPerUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_planPrices]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_planPrices](
	[planPriceId] [int] IDENTITY(1,1) NOT NULL,
	[amount] [decimal](10, 2) NOT NULL,
	[postTime] [datetime] NOT NULL,
	[endDate] [datetime] NULL,
	[recurrencyType] [int] NOT NULL,
	[current] [bit] NOT NULL,
	[planId] [int] NOT NULL,
 CONSTRAINT [PK_caipi_planPrices] PRIMARY KEY CLUSTERED 
(
	[planPriceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_plans]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_plans](
	[planId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[description] [varchar](200) NOT NULL,
	[periodStart] [date] NOT NULL,
	[periodEnd] [date] NOT NULL,
	[enabled] [bit] NOT NULL,
	[imgURL] [varchar](100) NULL,
 CONSTRAINT [PK_caipi_plans] PRIMARY KEY CLUSTERED 
(
	[planId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_Redeem]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_Redeem](
	[redeemId] [int] NOT NULL,
	[enable] [bit] NOT NULL,
	[frame_name] [varchar](30) NULL,
	[deleted] [bit] NOT NULL,
	[redeemStatusId] [int] NOT NULL,
	[dateExpired] [datetime] NULL,
	[dateStart] [datetime] NOT NULL,
	[usesQuantity] [tinyint] NOT NULL,
	[mediaFileId] [int] NOT NULL,
	[amountFee] [decimal](10, 2) NOT NULL,
	[suscriptionId] [int] NOT NULL,
	[redeemMethodsId] [int] NOT NULL,
 CONSTRAINT [PK_caipi_Redeem] PRIMARY KEY CLUSTERED 
(
	[redeemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_RedeemLog]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_RedeemLog](
	[redeemLogId] [int] NOT NULL,
	[userId] [int] NOT NULL,
	[redeemId] [int] NOT NULL,
	[trace] [int] NOT NULL,
	[reference1] [bigint] NULL,
	[reference2] [bigint] NULL,
	[value1] [bigint] NULL,
	[value2] [bigint] NULL,
	[checksum] [varbinary](200) NOT NULL,
	[posttime] [timestamp] NOT NULL,
	[description] [varchar](100) NOT NULL,
	[redeemTypeId] [int] NOT NULL,
	[redeemLogTypesId] [int] NOT NULL,
	[featureId] [int] NOT NULL,
 CONSTRAINT [PK_caipi_RedeemLog] PRIMARY KEY CLUSTERED 
(
	[redeemLogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_redeemLogTypes]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_redeemLogTypes](
	[redeemLogTypesId] [int] NOT NULL,
	[description] [varchar](100) NOT NULL,
	[name] [varchar](60) NOT NULL,
	[referenceDesc1] [varchar](50) NOT NULL,
	[referenceDesc2] [varchar](50) NOT NULL,
	[value1Desc] [varchar](50) NOT NULL,
	[vallue2Desc] [varchar](50) NOT NULL,
 CONSTRAINT [PK_caipi_redeemLogTypes] PRIMARY KEY CLUSTERED 
(
	[redeemLogTypesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_redeemMethods]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_redeemMethods](
	[redeemMethodsId] [int] NOT NULL,
	[callBackURL] [varchar](250) NOT NULL,
	[jsonRequest] [varchar](max) NOT NULL,
	[enable] [bit] NOT NULL,
	[apikey] [varbinary](250) NOT NULL,
	[name] [varchar](30) NOT NULL,
	[deleted] [bit] NOT NULL,
 CONSTRAINT [PK_caipi_redeemMethods] PRIMARY KEY CLUSTERED 
(
	[redeemMethodsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_redeemStatus]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_redeemStatus](
	[redeemStatusId] [int] NOT NULL,
	[name] [varchar](30) NOT NULL,
	[enable] [bit] NOT NULL,
 CONSTRAINT [PK_caipi_redeemStatus] PRIMARY KEY CLUSTERED 
(
	[redeemStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_redeemTypes]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_redeemTypes](
	[redeemTypeId] [int] NOT NULL,
	[name] [varchar](30) NOT NULL,
 CONSTRAINT [PK_caipi_redeemTypes] PRIMARY KEY CLUSTERED 
(
	[redeemTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_Renewal]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_Renewal](
	[renewalId] [int] NOT NULL,
	[partnerDealId] [int] NOT NULL,
	[confirmation] [bit] NOT NULL,
	[estado] [varchar](100) NOT NULL,
	[startDate] [date] NOT NULL,
	[endDate] [date] NULL,
	[sealDate] [date] NOT NULL,
 CONSTRAINT [PK_caipi_Renewal] PRIMARY KEY CLUSTERED 
(
	[renewalId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_RestrictionAdresses]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_RestrictionAdresses](
	[restricionAdressId] [int] NOT NULL,
	[benefitRestrictionId] [int] NOT NULL,
	[cityId] [int] NULL,
	[stateId] [int] NULL,
	[countryId] [int] NULL,
	[area] [geography] NULL,
	[enabled] [bit] NOT NULL,
	[dateRestrictionId] [int] NOT NULL,
 CONSTRAINT [PK_caipi_RestrictionAdresses] PRIMARY KEY CLUSTERED 
(
	[restricionAdressId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_RolePermission]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_RolePermission](
	[rolePermissionId] [int] NOT NULL,
	[enabled] [bit] NOT NULL,
	[daleted] [bit] NOT NULL,
	[lastUpdate] [datetime] NOT NULL,
	[username] [varchar](50) NOT NULL,
	[checksum] [varbinary](250) NOT NULL,
	[permissionId] [int] NOT NULL,
	[roleId] [int] NOT NULL,
 CONSTRAINT [PK_caipi_RolePermission] PRIMARY KEY CLUSTERED 
(
	[rolePermissionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_Roles]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_Roles](
	[roleId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](30) NOT NULL,
 CONSTRAINT [PK_caipi_Roles] PRIMARY KEY CLUSTERED 
(
	[roleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_ScheduleDetails]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_ScheduleDetails](
	[scheduleDetailsId] [int] IDENTITY(1,1) NOT NULL,
	[deleted] [bit] NOT NULL,
	[baseDate] [date] NOT NULL,
	[datePart] [int] NOT NULL,
	[lastExecution] [datetime] NULL,
	[nextExecution] [datetime] NULL,
	[scheduleId] [int] NOT NULL,
 CONSTRAINT [PK_caipi_ScheduleDetails] PRIMARY KEY CLUSTERED 
(
	[scheduleDetailsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_Schedules]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_Schedules](
	[scheduleId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](45) NOT NULL,
	[recurrencyType] [int] NOT NULL,
	[repeat] [bit] NOT NULL,
 CONSTRAINT [PK_caipi_Schedules] PRIMARY KEY CLUSTERED 
(
	[scheduleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_States]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_States](
	[stateId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](60) NOT NULL,
	[countryId] [tinyint] NOT NULL,
 CONSTRAINT [PK_caipi_States] PRIMARY KEY CLUSTERED 
(
	[stateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_subTypes]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_subTypes](
	[subTypeId] [int] NOT NULL,
	[porcentaje] [decimal](3, 2) NOT NULL,
	[detalle] [varchar](100) NOT NULL,
 CONSTRAINT [PK_caipi_subTypes] PRIMARY KEY CLUSTERED 
(
	[subTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_translations]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_translations](
	[translationId] [int] NOT NULL,
	[code] [varchar](5) NOT NULL,
	[caption] [varchar](100) NOT NULL,
	[enabled] [bit] NOT NULL,
	[languageId] [int] NOT NULL,
 CONSTRAINT [PK_caipi_translations] PRIMARY KEY CLUSTERED 
(
	[translationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_UserAdresses]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_UserAdresses](
	[enabled] [bit] NOT NULL,
	[userId] [int] NOT NULL,
	[adressId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_UserMediaFiles]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_UserMediaFiles](
	[userid] [int] NOT NULL,
	[mediaFiledd] [int] NOT NULL,
	[uploadTime] [datetime] NULL,
 CONSTRAINT [PK_UserMediaFiles] PRIMARY KEY CLUSTERED 
(
	[userid] ASC,
	[mediaFiledd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_userPermissions]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_userPermissions](
	[userPermissionsId] [int] NOT NULL,
	[enabled] [bit] NOT NULL,
	[deleted] [bit] NULL,
	[lastUpdate] [datetime] NOT NULL,
	[username] [varchar](50) NOT NULL,
	[checksum] [varbinary](250) NOT NULL,
	[permissionId] [int] NOT NULL,
	[userId] [int] NOT NULL,
 CONSTRAINT [PK_caipi_userPermissions] PRIMARY KEY CLUSTERED 
(
	[userPermissionsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_UserRoles]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_UserRoles](
	[lastUpdate] [datetime] NOT NULL,
	[username] [varchar](50) NOT NULL,
	[checksum] [varbinary](250) NOT NULL,
	[enabled] [bit] NOT NULL,
	[deleted] [bit] NOT NULL,
	[userId] [int] NOT NULL,
	[roleId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caipi_Users]    Script Date: 4/25/2025 9:22:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caipi_Users](
	[userId] [int] IDENTITY(1,1) NOT NULL,
	[password] [varbinary](250) NOT NULL,
	[enabled] [bit] NOT NULL,
	[userCompanyId] [int] NULL,
	[personId] [int] NOT NULL,
 CONSTRAINT [PK_caipi_Users] PRIMARY KEY CLUSTERED 
(
	[userId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_CurrencyConversion_Dates]    Script Date: 4/25/2025 9:22:59 PM ******/
CREATE NONCLUSTERED INDEX [IX_CurrencyConversion_Dates] ON [dbo].[caipi_CurrencyConversions]
(
	[startdate] ASC,
	[enddate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CurrencyConversion_Destiny]    Script Date: 4/25/2025 9:22:59 PM ******/
CREATE NONCLUSTERED INDEX [IX_CurrencyConversion_Destiny] ON [dbo].[caipi_CurrencyConversions]
(
	[currencyid_destiny] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CurrencyConversion_Source]    Script Date: 4/25/2025 9:22:59 PM ******/
CREATE NONCLUSTERED INDEX [IX_CurrencyConversion_Source] ON [dbo].[caipi_CurrencyConversions]
(
	[currencyid_source] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[caipi_CurrencyConversions] ADD  DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[caipi_CurrencyConversions] ADD  DEFAULT ((0)) FOR [currentExchangeRate]
GO
ALTER TABLE [dbo].[caipi_UserMediaFiles] ADD  DEFAULT (getdate()) FOR [uploadTime]
GO
ALTER TABLE [dbo].[caip_DealMedia]  WITH CHECK ADD  CONSTRAINT [FK_caip_DealMedia_caipi_MediaFiles] FOREIGN KEY([mediaFileId])
REFERENCES [dbo].[caipi_MediaFiles] ([mediaFileId])
GO
ALTER TABLE [dbo].[caip_DealMedia] CHECK CONSTRAINT [FK_caip_DealMedia_caipi_MediaFiles]
GO
ALTER TABLE [dbo].[caip_DealMedia]  WITH CHECK ADD  CONSTRAINT [FK_caip_DealMedia_caipi_PartnerDeals] FOREIGN KEY([partnerDealId])
REFERENCES [dbo].[caipi_PartnerDeals] ([partnerDealId])
GO
ALTER TABLE [dbo].[caip_DealMedia] CHECK CONSTRAINT [FK_caip_DealMedia_caipi_PartnerDeals]
GO
ALTER TABLE [dbo].[caipi_adresses]  WITH CHECK ADD  CONSTRAINT [FK_caipi_adresses_caipi_Cities] FOREIGN KEY([cityId])
REFERENCES [dbo].[caipi_Cities] ([cityId])
GO
ALTER TABLE [dbo].[caipi_adresses] CHECK CONSTRAINT [FK_caipi_adresses_caipi_Cities]
GO
ALTER TABLE [dbo].[caipi_BenefitRestrictions]  WITH CHECK ADD  CONSTRAINT [FK_caipi_BenefitRestrictions_caipi_dateRestriction] FOREIGN KEY([dateRestriction])
REFERENCES [dbo].[caipi_dateRestriction] ([dateRestrictionId])
GO
ALTER TABLE [dbo].[caipi_BenefitRestrictions] CHECK CONSTRAINT [FK_caipi_BenefitRestrictions_caipi_dateRestriction]
GO
ALTER TABLE [dbo].[caipi_BenefitRestrictions]  WITH CHECK ADD  CONSTRAINT [FK_caipi_BenefitRestrictions_caipi_DealBenefitDetails] FOREIGN KEY([dealBenefitDetalId])
REFERENCES [dbo].[caipi_DealBenefitTypes] ([dealBenefitTypesId])
GO
ALTER TABLE [dbo].[caipi_BenefitRestrictions] CHECK CONSTRAINT [FK_caipi_BenefitRestrictions_caipi_DealBenefitDetails]
GO
ALTER TABLE [dbo].[caipi_BenefitRestrictions]  WITH CHECK ADD  CONSTRAINT [FK_caipi_BenefitRestrictions_caipi_Schedules] FOREIGN KEY([scheduleId])
REFERENCES [dbo].[caipi_Schedules] ([scheduleId])
GO
ALTER TABLE [dbo].[caipi_BenefitRestrictions] CHECK CONSTRAINT [FK_caipi_BenefitRestrictions_caipi_Schedules]
GO
ALTER TABLE [dbo].[caipi_Cities]  WITH CHECK ADD  CONSTRAINT [FK_caipi_Cities_caipi_States] FOREIGN KEY([stateId])
REFERENCES [dbo].[caipi_States] ([stateId])
GO
ALTER TABLE [dbo].[caipi_Cities] CHECK CONSTRAINT [FK_caipi_Cities_caipi_States]
GO
ALTER TABLE [dbo].[caipi_ContacInfoPerson]  WITH CHECK ADD  CONSTRAINT [FK_caipi_ContacInfoPerson_caipi_ContactInfoTypes] FOREIGN KEY([contactInfoTypeId])
REFERENCES [dbo].[caipi_ContactInfoTypes] ([contactInfoTypeId])
GO
ALTER TABLE [dbo].[caipi_ContacInfoPerson] CHECK CONSTRAINT [FK_caipi_ContacInfoPerson_caipi_ContactInfoTypes]
GO
ALTER TABLE [dbo].[caipi_ContacInfoPerson]  WITH CHECK ADD  CONSTRAINT [FK_caipi_ContacInfoPerson_caipi_Personas] FOREIGN KEY([personId])
REFERENCES [dbo].[caipi_Personas] ([personId])
GO
ALTER TABLE [dbo].[caipi_ContacInfoPerson] CHECK CONSTRAINT [FK_caipi_ContacInfoPerson_caipi_Personas]
GO
ALTER TABLE [dbo].[caipi_contactInfoInstituciones]  WITH CHECK ADD  CONSTRAINT [FK_caipi_contactInfoInstituciones_caipi_ContactInfoTypes] FOREIGN KEY([contacInfoTypeId])
REFERENCES [dbo].[caipi_ContactInfoTypes] ([contactInfoTypeId])
GO
ALTER TABLE [dbo].[caipi_contactInfoInstituciones] CHECK CONSTRAINT [FK_caipi_contactInfoInstituciones_caipi_ContactInfoTypes]
GO
ALTER TABLE [dbo].[caipi_contactInfoInstituciones]  WITH CHECK ADD  CONSTRAINT [FK_caipi_contactInfoInstituciones_caipi_Instituciones] FOREIGN KEY([institucionesId])
REFERENCES [dbo].[caipi_Instituciones] ([institucioneId])
GO
ALTER TABLE [dbo].[caipi_contactInfoInstituciones] CHECK CONSTRAINT [FK_caipi_contactInfoInstituciones_caipi_Instituciones]
GO
ALTER TABLE [dbo].[caipi_contactInfoInstituciones]  WITH CHECK ADD  CONSTRAINT [FK_caipi_contactInfoInstituciones_caipi_Instituciones1] FOREIGN KEY([institucionesId])
REFERENCES [dbo].[caipi_Instituciones] ([institucioneId])
GO
ALTER TABLE [dbo].[caipi_contactInfoInstituciones] CHECK CONSTRAINT [FK_caipi_contactInfoInstituciones_caipi_Instituciones1]
GO
ALTER TABLE [dbo].[caipi_Countries]  WITH CHECK ADD  CONSTRAINT [FK_caipi_Countries_caipi_Currencies] FOREIGN KEY([currencyId])
REFERENCES [dbo].[caipi_Currencies] ([currencyid])
GO
ALTER TABLE [dbo].[caipi_Countries] CHECK CONSTRAINT [FK_caipi_Countries_caipi_Currencies]
GO
ALTER TABLE [dbo].[caipi_CurrencyConversions]  WITH CHECK ADD  CONSTRAINT [FK_CurrencyConversion_Destiny] FOREIGN KEY([currencyid_destiny])
REFERENCES [dbo].[caipi_Currencies] ([currencyid])
GO
ALTER TABLE [dbo].[caipi_CurrencyConversions] CHECK CONSTRAINT [FK_CurrencyConversion_Destiny]
GO
ALTER TABLE [dbo].[caipi_CurrencyConversions]  WITH CHECK ADD  CONSTRAINT [FK_CurrencyConversion_Source] FOREIGN KEY([currencyid_source])
REFERENCES [dbo].[caipi_Currencies] ([currencyid])
GO
ALTER TABLE [dbo].[caipi_CurrencyConversions] CHECK CONSTRAINT [FK_CurrencyConversion_Source]
GO
ALTER TABLE [dbo].[caipi_distribution]  WITH CHECK ADD  CONSTRAINT [FK_caipi_distribution_caipi_Pagos] FOREIGN KEY([pagoId])
REFERENCES [dbo].[caipi_Pagos] ([pagoId])
GO
ALTER TABLE [dbo].[caipi_distribution] CHECK CONSTRAINT [FK_caipi_distribution_caipi_Pagos]
GO
ALTER TABLE [dbo].[caipi_distribution]  WITH CHECK ADD  CONSTRAINT [FK_caipi_distribution_caipi_subTypes] FOREIGN KEY([subTypeId])
REFERENCES [dbo].[caipi_subTypes] ([subTypeId])
GO
ALTER TABLE [dbo].[caipi_distribution] CHECK CONSTRAINT [FK_caipi_distribution_caipi_subTypes]
GO
ALTER TABLE [dbo].[caipi_featurePrice]  WITH CHECK ADD  CONSTRAINT [FK_caipi_contractDiscounts_caipi_contractDiscountTypes] FOREIGN KEY([featurePriceTypeId])
REFERENCES [dbo].[caipi_featurePriceTypes] ([featurePriceTypesid])
GO
ALTER TABLE [dbo].[caipi_featurePrice] CHECK CONSTRAINT [FK_caipi_contractDiscounts_caipi_contractDiscountTypes]
GO
ALTER TABLE [dbo].[caipi_featurePrice]  WITH CHECK ADD  CONSTRAINT [FK_caipi_featurePrice_caipi_PartnerDeals] FOREIGN KEY([partnerDealId])
REFERENCES [dbo].[caipi_PartnerDeals] ([partnerDealId])
GO
ALTER TABLE [dbo].[caipi_featurePrice] CHECK CONSTRAINT [FK_caipi_featurePrice_caipi_PartnerDeals]
GO
ALTER TABLE [dbo].[caipi_Features]  WITH CHECK ADD  CONSTRAINT [FK_caipi_Features_caipi_featureName] FOREIGN KEY([featureNameId])
REFERENCES [dbo].[caipi_featureName] ([featureNameId])
GO
ALTER TABLE [dbo].[caipi_Features] CHECK CONSTRAINT [FK_caipi_Features_caipi_featureName]
GO
ALTER TABLE [dbo].[caipi_Features]  WITH CHECK ADD  CONSTRAINT [FK_caipi_Features_caipi_featurePrice] FOREIGN KEY([featurePriceId])
REFERENCES [dbo].[caipi_featurePrice] ([featurePriceId])
GO
ALTER TABLE [dbo].[caipi_Features] CHECK CONSTRAINT [FK_caipi_Features_caipi_featurePrice]
GO
ALTER TABLE [dbo].[caipi_Features]  WITH CHECK ADD  CONSTRAINT [FK_caipi_Features_caipi_FeaturesType] FOREIGN KEY([featureTypeId])
REFERENCES [dbo].[caipi_FeaturesType] ([featureTypeId])
GO
ALTER TABLE [dbo].[caipi_Features] CHECK CONSTRAINT [FK_caipi_Features_caipi_FeaturesType]
GO
ALTER TABLE [dbo].[caipi_Features]  WITH CHECK ADD  CONSTRAINT [FK_caipi_Features_caipi_Instituciones] FOREIGN KEY([institucionesid])
REFERENCES [dbo].[caipi_Instituciones] ([institucioneId])
GO
ALTER TABLE [dbo].[caipi_Features] CHECK CONSTRAINT [FK_caipi_Features_caipi_Instituciones]
GO
ALTER TABLE [dbo].[caipi_featuresPerPlan]  WITH CHECK ADD  CONSTRAINT [FK_caipi_featuresPerPlan_caipi_Features] FOREIGN KEY([featureId])
REFERENCES [dbo].[caipi_Features] ([featureId])
GO
ALTER TABLE [dbo].[caipi_featuresPerPlan] CHECK CONSTRAINT [FK_caipi_featuresPerPlan_caipi_Features]
GO
ALTER TABLE [dbo].[caipi_featuresPerPlan]  WITH CHECK ADD  CONSTRAINT [FK_caipi_featuresPerPlan_caipi_plans] FOREIGN KEY([planId])
REFERENCES [dbo].[caipi_plans] ([planId])
GO
ALTER TABLE [dbo].[caipi_featuresPerPlan] CHECK CONSTRAINT [FK_caipi_featuresPerPlan_caipi_plans]
GO
ALTER TABLE [dbo].[caipi_Instituciones]  WITH CHECK ADD  CONSTRAINT [FK_caipi_Instituciones_caipi_adresses] FOREIGN KEY([adressId])
REFERENCES [dbo].[caipi_adresses] ([adressId])
GO
ALTER TABLE [dbo].[caipi_Instituciones] CHECK CONSTRAINT [FK_caipi_Instituciones_caipi_adresses]
GO
ALTER TABLE [dbo].[caipi_Languages]  WITH CHECK ADD  CONSTRAINT [FK_caipi_Languages_caipi_Countries] FOREIGN KEY([countryId])
REFERENCES [dbo].[caipi_Countries] ([countryId])
GO
ALTER TABLE [dbo].[caipi_Languages] CHECK CONSTRAINT [FK_caipi_Languages_caipi_Countries]
GO
ALTER TABLE [dbo].[caipi_LogSeverity]  WITH CHECK ADD  CONSTRAINT [FK_caipi_LogSeverity_caipi_Log] FOREIGN KEY([logId])
REFERENCES [dbo].[caipi_Log] ([logId])
GO
ALTER TABLE [dbo].[caipi_LogSeverity] CHECK CONSTRAINT [FK_caipi_LogSeverity_caipi_Log]
GO
ALTER TABLE [dbo].[caipi_LogSources]  WITH CHECK ADD  CONSTRAINT [FK_caipi_LogSources_caipi_Log] FOREIGN KEY([logId])
REFERENCES [dbo].[caipi_Log] ([logId])
GO
ALTER TABLE [dbo].[caipi_LogSources] CHECK CONSTRAINT [FK_caipi_LogSources_caipi_Log]
GO
ALTER TABLE [dbo].[caipi_LogTypes]  WITH CHECK ADD  CONSTRAINT [FK_caipi_LogTypes_caipi_Log] FOREIGN KEY([logId])
REFERENCES [dbo].[caipi_Log] ([logId])
GO
ALTER TABLE [dbo].[caipi_LogTypes] CHECK CONSTRAINT [FK_caipi_LogTypes_caipi_Log]
GO
ALTER TABLE [dbo].[caipi_MediaFiles]  WITH CHECK ADD  CONSTRAINT [FK_caipi_MediaFiles_caipi_MediaTypes] FOREIGN KEY([mediaTypeId])
REFERENCES [dbo].[caipi_MediaTypes] ([mediaTypeId])
GO
ALTER TABLE [dbo].[caipi_MediaFiles] CHECK CONSTRAINT [FK_caipi_MediaFiles_caipi_MediaTypes]
GO
ALTER TABLE [dbo].[caipi_MediosDisponibles]  WITH CHECK ADD  CONSTRAINT [FK_caipi_MediosDisponibles_caipi_MetodosDePago] FOREIGN KEY([metodoPagoId])
REFERENCES [dbo].[caipi_MetodosDePago] ([metodoPagoId])
GO
ALTER TABLE [dbo].[caipi_MediosDisponibles] CHECK CONSTRAINT [FK_caipi_MediosDisponibles_caipi_MetodosDePago]
GO
ALTER TABLE [dbo].[caipi_MediosDisponibles]  WITH CHECK ADD  CONSTRAINT [FK_caipi_MediosDisponibles_caipi_Users] FOREIGN KEY([userId])
REFERENCES [dbo].[caipi_Users] ([userId])
GO
ALTER TABLE [dbo].[caipi_MediosDisponibles] CHECK CONSTRAINT [FK_caipi_MediosDisponibles_caipi_Users]
GO
ALTER TABLE [dbo].[caipi_Modules]  WITH CHECK ADD  CONSTRAINT [FK_caipi_Modules_caipi_Languages] FOREIGN KEY([languajeId])
REFERENCES [dbo].[caipi_Languages] ([languageId])
GO
ALTER TABLE [dbo].[caipi_Modules] CHECK CONSTRAINT [FK_caipi_Modules_caipi_Languages]
GO
ALTER TABLE [dbo].[caipi_Notifications]  WITH CHECK ADD  CONSTRAINT [FK_caipi_Notifications_caipi_NotificationMedia] FOREIGN KEY([notificationMediaId])
REFERENCES [dbo].[caipi_NotificationMedia] ([notificationMediaId])
GO
ALTER TABLE [dbo].[caipi_Notifications] CHECK CONSTRAINT [FK_caipi_Notifications_caipi_NotificationMedia]
GO
ALTER TABLE [dbo].[caipi_Notifications]  WITH CHECK ADD  CONSTRAINT [FK_caipi_Notifications_caipi_NotificationStatus] FOREIGN KEY([notificationStatusId])
REFERENCES [dbo].[caipi_NotificationStatus] ([notificationStatusId])
GO
ALTER TABLE [dbo].[caipi_Notifications] CHECK CONSTRAINT [FK_caipi_Notifications_caipi_NotificationStatus]
GO
ALTER TABLE [dbo].[caipi_Notifications]  WITH CHECK ADD  CONSTRAINT [FK_caipi_Notifications_caipi_Users] FOREIGN KEY([sendUserId])
REFERENCES [dbo].[caipi_Users] ([userId])
GO
ALTER TABLE [dbo].[caipi_Notifications] CHECK CONSTRAINT [FK_caipi_Notifications_caipi_Users]
GO
ALTER TABLE [dbo].[caipi_Notifications]  WITH CHECK ADD  CONSTRAINT [FK_caipi_Notifications_caipi_Users1] FOREIGN KEY([receiveUserId])
REFERENCES [dbo].[caipi_Users] ([userId])
GO
ALTER TABLE [dbo].[caipi_Notifications] CHECK CONSTRAINT [FK_caipi_Notifications_caipi_Users1]
GO
ALTER TABLE [dbo].[caipi_Pagos]  WITH CHECK ADD  CONSTRAINT [FK_caipi_Pagos_caipi_Currencies] FOREIGN KEY([currencyId])
REFERENCES [dbo].[caipi_Currencies] ([currencyid])
GO
ALTER TABLE [dbo].[caipi_Pagos] CHECK CONSTRAINT [FK_caipi_Pagos_caipi_Currencies]
GO
ALTER TABLE [dbo].[caipi_Pagos]  WITH CHECK ADD  CONSTRAINT [FK_caipi_Pagos_caipi_MediosDisponibles] FOREIGN KEY([pagoMedioId])
REFERENCES [dbo].[caipi_MediosDisponibles] ([pagoMedioId])
GO
ALTER TABLE [dbo].[caipi_Pagos] CHECK CONSTRAINT [FK_caipi_Pagos_caipi_MediosDisponibles]
GO
ALTER TABLE [dbo].[caipi_Pagos]  WITH CHECK ADD  CONSTRAINT [FK_caipi_Pagos_caipi_MetodosDePago] FOREIGN KEY([metodoPagoId])
REFERENCES [dbo].[caipi_MetodosDePago] ([metodoPagoId])
GO
ALTER TABLE [dbo].[caipi_Pagos] CHECK CONSTRAINT [FK_caipi_Pagos_caipi_MetodosDePago]
GO
ALTER TABLE [dbo].[caipi_Pagos]  WITH CHECK ADD  CONSTRAINT [FK_caipi_Pagos_caipi_Modules] FOREIGN KEY([moduleId])
REFERENCES [dbo].[caipi_Modules] ([moduleId])
GO
ALTER TABLE [dbo].[caipi_Pagos] CHECK CONSTRAINT [FK_caipi_Pagos_caipi_Modules]
GO
ALTER TABLE [dbo].[caipi_Pagos]  WITH CHECK ADD  CONSTRAINT [FK_caipi_Pagos_caipi_Schedules] FOREIGN KEY([scheduleId])
REFERENCES [dbo].[caipi_Schedules] ([scheduleId])
GO
ALTER TABLE [dbo].[caipi_Pagos] CHECK CONSTRAINT [FK_caipi_Pagos_caipi_Schedules]
GO
ALTER TABLE [dbo].[caipi_pagosFeatures]  WITH CHECK ADD  CONSTRAINT [FK_caipi_pagoInstituciones_caipi_distribution] FOREIGN KEY([distibutionId])
REFERENCES [dbo].[caipi_distribution] ([distributionId])
GO
ALTER TABLE [dbo].[caipi_pagosFeatures] CHECK CONSTRAINT [FK_caipi_pagoInstituciones_caipi_distribution]
GO
ALTER TABLE [dbo].[caipi_pagosFeatures]  WITH CHECK ADD  CONSTRAINT [FK_caipi_pagoInstituciones_caipi_Schedules] FOREIGN KEY([scheduleId])
REFERENCES [dbo].[caipi_Schedules] ([scheduleId])
GO
ALTER TABLE [dbo].[caipi_pagosFeatures] CHECK CONSTRAINT [FK_caipi_pagoInstituciones_caipi_Schedules]
GO
ALTER TABLE [dbo].[caipi_pagosFeatures]  WITH CHECK ADD  CONSTRAINT [FK_caipi_pagosFeatures_caipi_Features] FOREIGN KEY([featuresId])
REFERENCES [dbo].[caipi_Features] ([featureId])
GO
ALTER TABLE [dbo].[caipi_pagosFeatures] CHECK CONSTRAINT [FK_caipi_pagosFeatures_caipi_Features]
GO
ALTER TABLE [dbo].[caipi_partnerDealBenefits]  WITH CHECK ADD  CONSTRAINT [FK_caipi_partnerDealBenefits_caipi_DealBenefitDetails] FOREIGN KEY([dealBenefitTypesid])
REFERENCES [dbo].[caipi_DealBenefitTypes] ([dealBenefitTypesId])
GO
ALTER TABLE [dbo].[caipi_partnerDealBenefits] CHECK CONSTRAINT [FK_caipi_partnerDealBenefits_caipi_DealBenefitDetails]
GO
ALTER TABLE [dbo].[caipi_partnerDealBenefits]  WITH CHECK ADD  CONSTRAINT [FK_caipi_partnerDealBenefits_caipi_PartnerDeals] FOREIGN KEY([partnerDealId])
REFERENCES [dbo].[caipi_PartnerDeals] ([partnerDealId])
GO
ALTER TABLE [dbo].[caipi_partnerDealBenefits] CHECK CONSTRAINT [FK_caipi_partnerDealBenefits_caipi_PartnerDeals]
GO
ALTER TABLE [dbo].[caipi_partnerDealBenefits]  WITH CHECK ADD  CONSTRAINT [FK_caipi_partnerDealBenefits_caipi_plans] FOREIGN KEY([planId])
REFERENCES [dbo].[caipi_plans] ([planId])
GO
ALTER TABLE [dbo].[caipi_partnerDealBenefits] CHECK CONSTRAINT [FK_caipi_partnerDealBenefits_caipi_plans]
GO
ALTER TABLE [dbo].[caipi_partnerDealBenefits]  WITH CHECK ADD  CONSTRAINT [FK_caipi_partnerDealBenefits_caipi_Users] FOREIGN KEY([userId])
REFERENCES [dbo].[caipi_Users] ([userId])
GO
ALTER TABLE [dbo].[caipi_partnerDealBenefits] CHECK CONSTRAINT [FK_caipi_partnerDealBenefits_caipi_Users]
GO
ALTER TABLE [dbo].[caipi_PartnerDeals]  WITH CHECK ADD  CONSTRAINT [FK_caipi_PartnerDeals_caipi_Instituciones] FOREIGN KEY([institucioneId])
REFERENCES [dbo].[caipi_Instituciones] ([institucioneId])
GO
ALTER TABLE [dbo].[caipi_PartnerDeals] CHECK CONSTRAINT [FK_caipi_PartnerDeals_caipi_Instituciones]
GO
ALTER TABLE [dbo].[caipi_PartnerObligations]  WITH CHECK ADD  CONSTRAINT [FK_caipi_PartnerObligations_caipi_Currencies] FOREIGN KEY([currencyId])
REFERENCES [dbo].[caipi_Currencies] ([currencyid])
GO
ALTER TABLE [dbo].[caipi_PartnerObligations] CHECK CONSTRAINT [FK_caipi_PartnerObligations_caipi_Currencies]
GO
ALTER TABLE [dbo].[caipi_PartnerObligations]  WITH CHECK ADD  CONSTRAINT [FK_caipi_PartnerObligations_caipi_PartnerDeals] FOREIGN KEY([partnerDealId])
REFERENCES [dbo].[caipi_PartnerDeals] ([partnerDealId])
GO
ALTER TABLE [dbo].[caipi_PartnerObligations] CHECK CONSTRAINT [FK_caipi_PartnerObligations_caipi_PartnerDeals]
GO
ALTER TABLE [dbo].[caipi_PartnerObligationsStorage]  WITH CHECK ADD  CONSTRAINT [FK_caipi_PartnerObligationsStorage_caipi_PartnerObligations] FOREIGN KEY([partnerObligationId])
REFERENCES [dbo].[caipi_PartnerObligations] ([partnerObligationId])
GO
ALTER TABLE [dbo].[caipi_PartnerObligationsStorage] CHECK CONSTRAINT [FK_caipi_PartnerObligationsStorage_caipi_PartnerObligations]
GO
ALTER TABLE [dbo].[caipi_Permissions]  WITH CHECK ADD  CONSTRAINT [FK_caipi_Permissions_caipi_Modules] FOREIGN KEY([moduleId])
REFERENCES [dbo].[caipi_Modules] ([moduleId])
GO
ALTER TABLE [dbo].[caipi_Permissions] CHECK CONSTRAINT [FK_caipi_Permissions_caipi_Modules]
GO
ALTER TABLE [dbo].[caipi_PlanLimits]  WITH CHECK ADD  CONSTRAINT [FK_caipi_PlanLimits_caipi_Features] FOREIGN KEY([featureId])
REFERENCES [dbo].[caipi_Features] ([featureId])
GO
ALTER TABLE [dbo].[caipi_PlanLimits] CHECK CONSTRAINT [FK_caipi_PlanLimits_caipi_Features]
GO
ALTER TABLE [dbo].[caipi_PlanLimits]  WITH CHECK ADD  CONSTRAINT [FK_caipi_PlanLimits_caipi_planPerEntity] FOREIGN KEY([planPerUserId])
REFERENCES [dbo].[caipi_planPerUser] ([planPerUserId])
GO
ALTER TABLE [dbo].[caipi_PlanLimits] CHECK CONSTRAINT [FK_caipi_PlanLimits_caipi_planPerEntity]
GO
ALTER TABLE [dbo].[caipi_planPerUser]  WITH CHECK ADD  CONSTRAINT [FK_caipi_planPerEntity_caipi_Users] FOREIGN KEY([userId])
REFERENCES [dbo].[caipi_Users] ([userId])
GO
ALTER TABLE [dbo].[caipi_planPerUser] CHECK CONSTRAINT [FK_caipi_planPerEntity_caipi_Users]
GO
ALTER TABLE [dbo].[caipi_planPerUser]  WITH CHECK ADD  CONSTRAINT [FK_caipi_planPerUser_caipi_plans] FOREIGN KEY([planId])
REFERENCES [dbo].[caipi_plans] ([planId])
GO
ALTER TABLE [dbo].[caipi_planPerUser] CHECK CONSTRAINT [FK_caipi_planPerUser_caipi_plans]
GO
ALTER TABLE [dbo].[caipi_planPrices]  WITH CHECK ADD  CONSTRAINT [FK_caipi_planPrices_caipi_plans] FOREIGN KEY([planId])
REFERENCES [dbo].[caipi_plans] ([planId])
GO
ALTER TABLE [dbo].[caipi_planPrices] CHECK CONSTRAINT [FK_caipi_planPrices_caipi_plans]
GO
ALTER TABLE [dbo].[caipi_Redeem]  WITH CHECK ADD  CONSTRAINT [FK_caipi_Redeem_caipi_MediaFiles] FOREIGN KEY([mediaFileId])
REFERENCES [dbo].[caipi_MediaFiles] ([mediaFileId])
GO
ALTER TABLE [dbo].[caipi_Redeem] CHECK CONSTRAINT [FK_caipi_Redeem_caipi_MediaFiles]
GO
ALTER TABLE [dbo].[caipi_Redeem]  WITH CHECK ADD  CONSTRAINT [FK_caipi_Redeem_caipi_redeemMethods] FOREIGN KEY([redeemMethodsId])
REFERENCES [dbo].[caipi_redeemMethods] ([redeemMethodsId])
GO
ALTER TABLE [dbo].[caipi_Redeem] CHECK CONSTRAINT [FK_caipi_Redeem_caipi_redeemMethods]
GO
ALTER TABLE [dbo].[caipi_Redeem]  WITH CHECK ADD  CONSTRAINT [FK_caipi_Redeem_caipi_redeemStatus] FOREIGN KEY([redeemStatusId])
REFERENCES [dbo].[caipi_redeemStatus] ([redeemStatusId])
GO
ALTER TABLE [dbo].[caipi_Redeem] CHECK CONSTRAINT [FK_caipi_Redeem_caipi_redeemStatus]
GO
ALTER TABLE [dbo].[caipi_RedeemLog]  WITH CHECK ADD  CONSTRAINT [FK_caipi_RedeemLog_caipi_Features] FOREIGN KEY([featureId])
REFERENCES [dbo].[caipi_Features] ([featureId])
GO
ALTER TABLE [dbo].[caipi_RedeemLog] CHECK CONSTRAINT [FK_caipi_RedeemLog_caipi_Features]
GO
ALTER TABLE [dbo].[caipi_RedeemLog]  WITH CHECK ADD  CONSTRAINT [FK_caipi_RedeemLog_caipi_Redeem] FOREIGN KEY([redeemId])
REFERENCES [dbo].[caipi_Redeem] ([redeemId])
GO
ALTER TABLE [dbo].[caipi_RedeemLog] CHECK CONSTRAINT [FK_caipi_RedeemLog_caipi_Redeem]
GO
ALTER TABLE [dbo].[caipi_RedeemLog]  WITH CHECK ADD  CONSTRAINT [FK_caipi_RedeemLog_caipi_RedeemLog] FOREIGN KEY([trace])
REFERENCES [dbo].[caipi_RedeemLog] ([redeemLogId])
GO
ALTER TABLE [dbo].[caipi_RedeemLog] CHECK CONSTRAINT [FK_caipi_RedeemLog_caipi_RedeemLog]
GO
ALTER TABLE [dbo].[caipi_RedeemLog]  WITH CHECK ADD  CONSTRAINT [FK_caipi_RedeemLog_caipi_redeemLogTypes] FOREIGN KEY([redeemLogTypesId])
REFERENCES [dbo].[caipi_redeemLogTypes] ([redeemLogTypesId])
GO
ALTER TABLE [dbo].[caipi_RedeemLog] CHECK CONSTRAINT [FK_caipi_RedeemLog_caipi_redeemLogTypes]
GO
ALTER TABLE [dbo].[caipi_RedeemLog]  WITH CHECK ADD  CONSTRAINT [FK_caipi_RedeemLog_caipi_redeemTypes] FOREIGN KEY([redeemTypeId])
REFERENCES [dbo].[caipi_redeemTypes] ([redeemTypeId])
GO
ALTER TABLE [dbo].[caipi_RedeemLog] CHECK CONSTRAINT [FK_caipi_RedeemLog_caipi_redeemTypes]
GO
ALTER TABLE [dbo].[caipi_RedeemLog]  WITH CHECK ADD  CONSTRAINT [FK_caipi_RedeemLog_caipi_Users] FOREIGN KEY([userId])
REFERENCES [dbo].[caipi_Users] ([userId])
GO
ALTER TABLE [dbo].[caipi_RedeemLog] CHECK CONSTRAINT [FK_caipi_RedeemLog_caipi_Users]
GO
ALTER TABLE [dbo].[caipi_Renewal]  WITH CHECK ADD  CONSTRAINT [FK_caipi_Renewal_caipi_PartnerDeals] FOREIGN KEY([partnerDealId])
REFERENCES [dbo].[caipi_PartnerDeals] ([partnerDealId])
GO
ALTER TABLE [dbo].[caipi_Renewal] CHECK CONSTRAINT [FK_caipi_Renewal_caipi_PartnerDeals]
GO
ALTER TABLE [dbo].[caipi_RestrictionAdresses]  WITH CHECK ADD  CONSTRAINT [FK_caipi_RestrictionAdresses_caipi_BenefitRestrictions] FOREIGN KEY([benefitRestrictionId])
REFERENCES [dbo].[caipi_BenefitRestrictions] ([benefitRestrictionId])
GO
ALTER TABLE [dbo].[caipi_RestrictionAdresses] CHECK CONSTRAINT [FK_caipi_RestrictionAdresses_caipi_BenefitRestrictions]
GO
ALTER TABLE [dbo].[caipi_RestrictionAdresses]  WITH CHECK ADD  CONSTRAINT [FK_caipi_RestrictionAdresses_caipi_dateRestriction] FOREIGN KEY([dateRestrictionId])
REFERENCES [dbo].[caipi_dateRestriction] ([dateRestrictionId])
GO
ALTER TABLE [dbo].[caipi_RestrictionAdresses] CHECK CONSTRAINT [FK_caipi_RestrictionAdresses_caipi_dateRestriction]
GO
ALTER TABLE [dbo].[caipi_RolePermission]  WITH CHECK ADD  CONSTRAINT [FK_caipi_RolePermission_caipi_Permissions] FOREIGN KEY([permissionId])
REFERENCES [dbo].[caipi_Permissions] ([permissionId])
GO
ALTER TABLE [dbo].[caipi_RolePermission] CHECK CONSTRAINT [FK_caipi_RolePermission_caipi_Permissions]
GO
ALTER TABLE [dbo].[caipi_RolePermission]  WITH CHECK ADD  CONSTRAINT [FK_caipi_RolePermission_caipi_Roles] FOREIGN KEY([roleId])
REFERENCES [dbo].[caipi_Roles] ([roleId])
GO
ALTER TABLE [dbo].[caipi_RolePermission] CHECK CONSTRAINT [FK_caipi_RolePermission_caipi_Roles]
GO
ALTER TABLE [dbo].[caipi_ScheduleDetails]  WITH CHECK ADD  CONSTRAINT [FK_caipi_ScheduleDetails_caipi_Schedules] FOREIGN KEY([scheduleId])
REFERENCES [dbo].[caipi_Schedules] ([scheduleId])
GO
ALTER TABLE [dbo].[caipi_ScheduleDetails] CHECK CONSTRAINT [FK_caipi_ScheduleDetails_caipi_Schedules]
GO
ALTER TABLE [dbo].[caipi_States]  WITH CHECK ADD  CONSTRAINT [FK_caipi_States_caipi_Countries] FOREIGN KEY([countryId])
REFERENCES [dbo].[caipi_Countries] ([countryId])
GO
ALTER TABLE [dbo].[caipi_States] CHECK CONSTRAINT [FK_caipi_States_caipi_Countries]
GO
ALTER TABLE [dbo].[caipi_translations]  WITH CHECK ADD  CONSTRAINT [FK_caipi_translations_caipi_Languages] FOREIGN KEY([languageId])
REFERENCES [dbo].[caipi_Languages] ([languageId])
GO
ALTER TABLE [dbo].[caipi_translations] CHECK CONSTRAINT [FK_caipi_translations_caipi_Languages]
GO
ALTER TABLE [dbo].[caipi_UserAdresses]  WITH CHECK ADD  CONSTRAINT [FK_caipi_UserAdresses_caipi_adresses] FOREIGN KEY([adressId])
REFERENCES [dbo].[caipi_adresses] ([adressId])
GO
ALTER TABLE [dbo].[caipi_UserAdresses] CHECK CONSTRAINT [FK_caipi_UserAdresses_caipi_adresses]
GO
ALTER TABLE [dbo].[caipi_UserAdresses]  WITH CHECK ADD  CONSTRAINT [FK_caipi_UserAdresses_caipi_Users] FOREIGN KEY([userId])
REFERENCES [dbo].[caipi_Users] ([userId])
GO
ALTER TABLE [dbo].[caipi_UserAdresses] CHECK CONSTRAINT [FK_caipi_UserAdresses_caipi_Users]
GO
ALTER TABLE [dbo].[caipi_UserMediaFiles]  WITH CHECK ADD  CONSTRAINT [FK_UserMediaFiles_MediaFiles] FOREIGN KEY([mediaFiledd])
REFERENCES [dbo].[caipi_MediaFiles] ([mediaFileId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[caipi_UserMediaFiles] CHECK CONSTRAINT [FK_UserMediaFiles_MediaFiles]
GO
ALTER TABLE [dbo].[caipi_UserMediaFiles]  WITH CHECK ADD  CONSTRAINT [FK_UserMediaFiles_Users] FOREIGN KEY([userid])
REFERENCES [dbo].[caipi_Users] ([userId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[caipi_UserMediaFiles] CHECK CONSTRAINT [FK_UserMediaFiles_Users]
GO
ALTER TABLE [dbo].[caipi_userPermissions]  WITH CHECK ADD  CONSTRAINT [FK_caipi_userPermissions_caipi_Permissions] FOREIGN KEY([permissionId])
REFERENCES [dbo].[caipi_Permissions] ([permissionId])
GO
ALTER TABLE [dbo].[caipi_userPermissions] CHECK CONSTRAINT [FK_caipi_userPermissions_caipi_Permissions]
GO
ALTER TABLE [dbo].[caipi_userPermissions]  WITH CHECK ADD  CONSTRAINT [FK_caipi_userPermissions_caipi_Users] FOREIGN KEY([userId])
REFERENCES [dbo].[caipi_Users] ([userId])
GO
ALTER TABLE [dbo].[caipi_userPermissions] CHECK CONSTRAINT [FK_caipi_userPermissions_caipi_Users]
GO
ALTER TABLE [dbo].[caipi_UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_caipi_UserRoles_caipi_Roles] FOREIGN KEY([roleId])
REFERENCES [dbo].[caipi_Roles] ([roleId])
GO
ALTER TABLE [dbo].[caipi_UserRoles] CHECK CONSTRAINT [FK_caipi_UserRoles_caipi_Roles]
GO
ALTER TABLE [dbo].[caipi_UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_caipi_UserRoles_caipi_Users] FOREIGN KEY([userId])
REFERENCES [dbo].[caipi_Users] ([userId])
GO
ALTER TABLE [dbo].[caipi_UserRoles] CHECK CONSTRAINT [FK_caipi_UserRoles_caipi_Users]
GO
ALTER TABLE [dbo].[caipi_Users]  WITH CHECK ADD  CONSTRAINT [FK_caipi_Users_caipi_Personas] FOREIGN KEY([personId])
REFERENCES [dbo].[caipi_Personas] ([personId])
GO
ALTER TABLE [dbo].[caipi_Users] CHECK CONSTRAINT [FK_caipi_Users_caipi_Personas]
GO
ALTER TABLE [dbo].[caipi_CurrencyConversions]  WITH CHECK ADD  CONSTRAINT [CHK_DifferentCurrencies] CHECK  (([currencyid_source]<>[currencyid_destiny]))
GO
ALTER TABLE [dbo].[caipi_CurrencyConversions] CHECK CONSTRAINT [CHK_DifferentCurrencies]
GO
ALTER TABLE [dbo].[caipi_CurrencyConversions]  WITH CHECK ADD  CONSTRAINT [CHK_ValidDateRange] CHECK  (([enddate] IS NULL OR [startdate]<=[enddate]))
GO
ALTER TABLE [dbo].[caipi_CurrencyConversions] CHECK CONSTRAINT [CHK_ValidDateRange]
GO
USE [master]
GO
ALTER DATABASE [caipiDb] SET  READ_WRITE 
GO
ading ScriptCreacion.sql…]()


