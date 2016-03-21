USE MASTER  
GO  

-- If the database already exists, drop it  
IF EXISTS(SELECT * FROM sysdatabases WHERE name='helloentityfx')  
DROP DATABASE [helloentityfx]  

GO
/****** Objet :  Database [helloentityfx]    Date de génération du script : 10/21/2008 00:33:08 ******/
CREATE DATABASE [helloentityfx]

GO
EXEC dbo.sp_dbcmptlevel @dbname=N'helloentityfx', @new_cmptlevel=90
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [helloentityfx].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [helloentityfx] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [helloentityfx] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [helloentityfx] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [helloentityfx] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [helloentityfx] SET ARITHABORT OFF 
GO
ALTER DATABASE [helloentityfx] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [helloentityfx] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [helloentityfx] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [helloentityfx] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [helloentityfx] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [helloentityfx] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [helloentityfx] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [helloentityfx] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [helloentityfx] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [helloentityfx] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [helloentityfx] SET  ENABLE_BROKER 
GO
ALTER DATABASE [helloentityfx] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [helloentityfx] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [helloentityfx] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [helloentityfx] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [helloentityfx] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [helloentityfx] SET  READ_WRITE 
GO
ALTER DATABASE [helloentityfx] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [helloentityfx] SET  MULTI_USER 
GO
ALTER DATABASE [helloentityfx] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [helloentityfx] SET DB_CHAINING OFF 

USE [helloentityfx]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Auteur]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Auteur](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nom] [varchar](50) NULL,
	[Prenom] [varchar](50) NULL,
 CONSTRAINT [PK_Auteur] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Editeur]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Editeur](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nom] [varchar](50) NULL,
 CONSTRAINT [PK_Editeur] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Client]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Client](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nom] [varchar](50) NULL,
	[Prenom] [varchar](50) NULL,
	[Pays] [varchar](50) NULL,
	[Rue] [varchar](100) NULL,
	[CodePostal] [char](5) NULL,
	[Telephone] [char](10) NULL,
	[Ville] [varchar](50) NULL,
 CONSTRAINT [PK_Client] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EditeurBD]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[EditeurBD](
	[Id] [int] NOT NULL,
	[NombreBDEditees] [int] NULL,
 CONSTRAINT [PK_EditeurBD] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EditeurInformatique]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[EditeurInformatique](
	[Id] [int] NOT NULL,
	[NombreLivresInfoEdites] [int] NULL,
 CONSTRAINT [PK_EditeurInformatique] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EditeurPsychologie]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[EditeurPsychologie](
	[Id] [int] NOT NULL,
	[NombrePubliPsyEditees] [int] NULL,
 CONSTRAINT [PK_EditeurPsychologie] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Publi_Auteur]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Publi_Auteur](
	[IdAuteur] [int] NOT NULL,
	[IdPublication] [int] NOT NULL,
 CONSTRAINT [PK_Publi_Auteur] PRIMARY KEY CLUSTERED 
(
	[IdAuteur] ASC,
	[IdPublication] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Publication]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Publication](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdEditeur] [int] NOT NULL,
	[Titre] [varchar](50) NULL,
	[Type] [int] NOT NULL,
	[Url] [varchar](255),
 CONSTRAINT [PK_Livre] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Exemplaire]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Exemplaire](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdPublication] [int] NOT NULL,
	[DateAchat] [datetime] NOT NULL
 CONSTRAINT [PK_Exemplaire] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Emprunt]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Emprunt](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdClient] [int] NOT NULL,
	[IdExemplaire] [int] NOT NULL,
	[DateDebut] [datetime] NOT NULL,
	[DateFin] [datetime] NULL,
 CONSTRAINT [PK_Emprunt] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Publi_Auteur_Auteur]') AND parent_object_id = OBJECT_ID(N'[dbo].[Publi_Auteur]'))
ALTER TABLE [dbo].[Publi_Auteur]  WITH CHECK ADD  CONSTRAINT [FK_Publi_Auteur_Auteur] FOREIGN KEY([IdAuteur])
REFERENCES [dbo].[Auteur] ([Id])
GO
ALTER TABLE [dbo].[Publi_Auteur] CHECK CONSTRAINT [FK_Publi_Auteur_Auteur]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Publi_Auteur_Publication]') AND parent_object_id = OBJECT_ID(N'[dbo].[Publi_Auteur]'))
ALTER TABLE [dbo].[Publi_Auteur]  WITH CHECK ADD  CONSTRAINT [FK_Publi_Auteur_Publication] FOREIGN KEY([IdPublication])
REFERENCES [dbo].[Publication] ([Id])
GO
ALTER TABLE [dbo].[Publi_Auteur] CHECK CONSTRAINT [FK_Publi_Auteur_Publication]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Publication_Editeur]') AND parent_object_id = OBJECT_ID(N'[dbo].[Publication]'))
ALTER TABLE [dbo].[Publication]  WITH CHECK ADD  CONSTRAINT [FK_Publication_Editeur] FOREIGN KEY([IdEditeur])
REFERENCES [dbo].[Editeur] ([Id])
GO
ALTER TABLE [dbo].[Publication] CHECK CONSTRAINT [FK_Publication_Editeur]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Exemplaire_Publication]') AND parent_object_id = OBJECT_ID(N'[dbo].[Exemplaire]'))
ALTER TABLE [dbo].[Exemplaire]  WITH CHECK ADD  CONSTRAINT [FK_Exemplaire_Publication] FOREIGN KEY([IdPublication])
REFERENCES [dbo].[Publication] ([Id])
GO
ALTER TABLE [dbo].[Exemplaire] CHECK CONSTRAINT [FK_Exemplaire_Publication]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Emprunt_Client]') AND parent_object_id = OBJECT_ID(N'[dbo].[Emprunt]'))
ALTER TABLE [dbo].[Emprunt]  WITH CHECK ADD  CONSTRAINT [FK_Emprunt_Client] FOREIGN KEY([IdClient])
REFERENCES [dbo].[Client] ([Id])
GO
ALTER TABLE [dbo].[Emprunt] CHECK CONSTRAINT [FK_Emprunt_Client]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Emprunt_Exemplaire]') AND parent_object_id = OBJECT_ID(N'[dbo].[Emprunt]'))
ALTER TABLE [dbo].[Emprunt]  WITH CHECK ADD  CONSTRAINT [FK_Emprunt_Exemplaire] FOREIGN KEY([IdExemplaire])
REFERENCES [dbo].[Exemplaire] ([Id])
GO
ALTER TABLE [dbo].[Emprunt] CHECK CONSTRAINT [FK_Emprunt_Exemplaire]

GO
USE [helloentityfx]
GO
/****** Objet :  StoredProcedure [dbo].[GetAuteurs]    Date de génération du script : 11/19/2008 11:46:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetAuteurs] 
AS
    SELECT [Id],[Nom],[Prenom], [Rue], [CodePostal], [Ville], [TelephoneFixe], [TelephoneMobile]
    FROM Auteur
	LEFT JOIN CoordonneesAuteur 
	ON Auteur.Id=CoordonneesAuteur.IdAuteur





GO

USE [helloentityfx]
GO
/****** Objet :  StoredProcedure [dbo].[CreerClient]    Date de génération du script : 11/11/2008 22:49:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreerClient] 
   @Nom varchar(50),
   @Prenom varchar(50),
   @Pays varchar(50),
   @Rue varchar(100),
   @CodePostal char(5),
   @Telephone char(10),
   @Ville varchar(50)
   
AS

INSERT INTO [dbo].[Client]
           (
            [Nom]
           ,[Prenom]
           ,[Pays]
           ,[Rue]
           ,[CodePostal]
           ,[Telephone]
           ,[Ville])
     VALUES
		(@Nom,
		 @Prenom,
		 @Pays,
	     @Rue,
	     @CodePostal,
	     @Telephone,
		 @Ville)

select Id
 from [dbo].[Client]
 where Id = scope_identity()

GO

USE [helloentityfx]
GO
/****** Objet :  StoredProcedure [dbo].[MAJClient]    Date de génération du script : 11/11/2008 22:49:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MAJClient] 
   @Id int,
   @Nom varchar(50),
   @Prenom varchar(50),
   @Pays varchar(50),
   @Rue varchar(100),
   @CodePostal char(5),
   @Telephone char(10),
   @Ville varchar(50)
   
AS

UPDATE [dbo].[Client]
     
SET
		Nom = @Nom,
		Prenom = @Prenom,
		Pays = @Pays,
	    Rue = @Rue,
	    CodePostal = @CodePostal,
	    Telephone = @Telephone,
		Ville = @Ville

WHERE
	Id = @Id

GO

USE [helloentityfx]
GO
/****** Objet :  StoredProcedure [dbo].[SupprimerClient]    Date de génération du script : 11/11/2008 22:50:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SupprimerClient] 
   @Id int
   
AS

DELETE FROM [dbo].[Client]
       WHERE Id = @Id;

GO

USE [helloentityfx]
GO
/****** Objet :  View [dbo].[VueLivres]    Date de génération du script : 11/13/2008 14:20:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VueLivres]
AS
SELECT     dbo.Publication.Id AS [Id Publication], dbo.Publication.Titre AS [Titre Livre], dbo.Editeur.Nom AS Editeur, COUNT(dbo.Exemplaire.Id) AS Exemplaires
FROM         dbo.Publication INNER JOIN
                      dbo.Editeur ON dbo.Publication.IdEditeur = dbo.Editeur.Id INNER JOIN
                      dbo.Exemplaire ON dbo.Publication.Id = dbo.Exemplaire.IdPublication
GROUP BY dbo.Publication.Titre, dbo.Editeur.Nom, dbo.Publication.Id

GO

USE [helloentityfx]
GO
/****** Objet :  Table [dbo].[CoordonneesAuteur]    Date de génération du script : 11/19/2008 11:30:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CoordonneesAuteur](
	[IdAuteur] [int] NOT NULL,
	[Rue] [varchar](50) COLLATE French_CI_AS NULL,
	[Ville] [varchar](50) COLLATE French_CI_AS NULL,
	[CodePostal] [char](5) COLLATE French_CI_AS NULL,
	[TelephoneFixe] [char](10) COLLATE French_CI_AS NULL,
	[TelephoneMobile] [char](10) COLLATE French_CI_AS NULL,
 CONSTRAINT [PK_CoordonnéesAuteur] PRIMARY KEY CLUSTERED 
(
	[IdAuteur] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[CoordonneesAuteur]  WITH CHECK ADD  CONSTRAINT [FK_CoordonneesAuteur_Auteur] FOREIGN KEY([IdAuteur])
REFERENCES [dbo].[Auteur] ([Id])
GO
ALTER TABLE [dbo].[CoordonneesAuteur] CHECK CONSTRAINT [FK_CoordonneesAuteur_Auteur]