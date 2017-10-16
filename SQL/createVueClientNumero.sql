USE [maintenanceDB]
GO

/****** Object:  View [dbo].[vClientNumero]    Script Date: 2017-10-16 15:23:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[vClientNumero]

as


SELECT  n.id
      ,[IDx]
      ,[ipn]
      ,c.Nom, c.Prenom 

FROM [maintenanceDB].[dbo].[Numero] as n

INNER JOIN   Client as c 
	on n.id = c.Id 
GO

