USE [helloentityfx]
GO

/* General */
INSERT INTO Client VALUES ('Barthelemy','Pacha','France','77 avenue de la gamelle','31010','0628054512','FishyVille');
INSERT INTO Client VALUES ('Loupo','Boby','France','12 rue de la colombette','02010','0928054517','DreamCity');
INSERT INTO Client VALUES ('Oliver','Bernard','France','102 impasse fauche','10293','0229374029','CartonVille');

/* Informatique */
INSERT INTO Auteur VALUES ('MacDonald','Matthew');
INSERT INTO Auteur VALUES ('Bukovics','Bruce');
INSERT INTO Auteur VALUES ('Noel','Michael');
INSERT INTO Auteur VALUES ('Spence','Colin');
INSERT INTO Auteur VALUES ('Skeet','Jon');

INSERT INTO Editeur VALUES ('Apress');
INSERT INTO Editeur VALUES ('Manning');
INSERT INTO Editeur VALUES ('Sams');

INSERT INTO EditeurInformatique VALUES (1,1500);
INSERT INTO EditeurInformatique VALUES (2,500);
INSERT INTO EditeurInformatique VALUES (3,1000);

INSERT INTO Publication (IdEditeur, Titre, Type, Url) VALUES (1,'Pro WPF in C# 2008','0',null);
INSERT INTO Publication (IdEditeur, Titre, Type, Url) VALUES (1,'Pro WF','0',null);
INSERT INTO Publication (IdEditeur, Titre, Type, Url) VALUES (3,'Microsoft Sharepoint 2007 Unleashed','0',null);
INSERT INTO Publication (IdEditeur, Titre, Type, Url) VALUES (2,'C# in depth','0',null);

INSERT INTO Publi_Auteur VALUES (1,1);
INSERT INTO Publi_Auteur VALUES (2,2);
INSERT INTO Publi_Auteur VALUES (3,3);
INSERT INTO Publi_Auteur VALUES (4,3);
INSERT INTO Publi_Auteur VALUES (5,4);

INSERT INTO Exemplaire VALUES (1,'12/07/2008');
INSERT INTO Exemplaire VALUES (2,'02/04/2008');
INSERT INTO Exemplaire VALUES (3,'27/06/2007');

/* Psychologie */
INSERT INTO Auteur VALUES ('Bruner','Jerome');

INSERT INTO Editeur VALUES ('georg Eshel');

INSERT INTO EditeurPsychologie VALUES (4,200);

INSERT INTO Publication (IdEditeur, Titre, Type, Url) VALUES (4,'car la culture donne forme a l esprit','0',null);

INSERT INTO Publi_Auteur VALUES (6,5);

INSERT INTO Exemplaire VALUES (5,'19/02/2006');

/* Bande dessinée */
INSERT INTO Auteur VALUES ('Ragache','Catherine');
INSERT INTO Auteur VALUES ('Laverdet','Marcel');

INSERT INTO Editeur VALUES ('Hachette jeunesse');

INSERT INTO EditeurBD VALUES (5,5200);

INSERT INTO Publication (IdEditeur, Titre, Type, Url) VALUES (5,'La création du monde','0',null);

INSERT INTO Publi_Auteur VALUES (7,6);
INSERT INTO Publi_Auteur VALUES (8,6);

INSERT INTO Exemplaire VALUES (6,'23/11/1996');
