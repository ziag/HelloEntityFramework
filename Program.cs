/****************************************************************************************
 * 
 * Introduction à Entity Framwork
 * De Paul Musso (http://pmusso.developpez.com/)
 * Blog : http://populnet.blogspot.com/
 * Url : http://pmusso.developpez.com/tutoriels/dotnet/entity-framework/introduction
 * Code Source
 * 
 ***************************************************************************************/

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Objects;
using System.Data;
using System.Data.SqlClient;
using System.Data.Common;
using System.Xml.Serialization;
using System.IO;

namespace HelloEntityFramework
{
    class Program
    {
        static void Main(string[] args)
        {
            // Exemples de Selection (SQL : SELECT)
            SelectLinQ();
            SelectQueryBuilder();
            SelectEntitySQL();
            SelectEntitySQL_ID_IPN();
            SelectEtWhereLinQ();

            SelectAvecInclude();
            SelectAvecChargementDifféré();

            // Exemples d'insertion de données (SQL : INSERT)
            Insert();
            UndoInsert(); // à supprimer

            // Exemples de suppression de données (SQL : DELETE)
            Delete();
            UndoDelete(); // à supprimer

            // Exemples de mise à jour de données (SQL : UPDATE)
            Update();
            DéfinirRelation();
            UndoUpdate();

            // Appel de procédure stockée
            AppelProcédureStockée();

            /************ Objet ObjectContext ************/
            DétacherEntité();
            AttacherEntité();
            MiseAJourEntité();
            UndoMiseAJourEntité();
            RefreshEntité();
            Transaction();
            DeleteTransaction();

            // Exemples de serialisation
            SerialisationXML();
            DeserialisationXML();

            Console.ReadKey();
        }



        #region Operations CRUD

        public static void SelectLinQ()
        {
            CartoucheExemple("Select avec LinQ");

            // Initialisation du contexte
            using (Modele bdd = new Modele())
            {
                // Définition de la requête LinQ
                var requete = from publication in bdd.Publication
                              select publication;

                // Execution de la requête
                requete.ToList().ForEach(p => Console.WriteLine("Publication : ID = {0} | Titre = {1}", p.Id, p.Titre));
            }

            FinExemple();
        }

        public static void SelectEtWhereLinQ()
        {
            CartoucheExemple("Select et Where avec LinQ");

            // Initialisation du contexte
            using (Modele bdd = new Modele())
            {
                // Définition de la requête LinQ
                var requete = from publication in bdd.Publication
                              where publication.Titre.Contains("C#")
                              select publication;

                // Execution de la requête
                //Console.WriteLine(((ObjectQuery<Publication>)requete).ToTraceString());
                requete.ToList().ForEach(p => Console.WriteLine("Publication : ID = {0} | Titre = {1}", p.Id, p.Titre));
            }

            FinExemple();
        }

        public static void SelectEntitySQL()
        {
            CartoucheExemple("Select avec Entity SQL");

            // Initialisation du contexte
            using (Modele bdd = new Modele())
            {
                // Définition de la requête avec Entity SQL
                string chaineRequete = "SELECT VALUE p FROM Publication AS p";

                // Définition de la requête de type ObjectQuery<Publication>
                ObjectQuery<Publication> requete = new ObjectQuery<Publication>(chaineRequete, bdd, MergeOption.NoTracking);

                // Execution de la requête Entity SQL
                requete.ToList().ForEach(p => Console.WriteLine("Publication : ID = {0} | Titre = {1}", p.Id, p.Titre));
            }

            FinExemple();
        }

        public static void SelectEntitySQL_ID_IPN()
        {
            CartoucheExemple("Select avec Entity SQL ID IPN");

            // Initialisation du contexte
            using (Modele bdd = new Modele())
            {
                // Définition de la requête avec Entity SQL
                string chaineRequete = "SELECT VALUE n FROM Numero AS n";

                // Définition de la requête de type ObjectQuery<ArtistiID_IPN>
                ObjectQuery<Numero> requete = new ObjectQuery<Numero>(chaineRequete, bdd, MergeOption.NoTracking).Top("10");

                // Execution de la requête Entity SQL
                requete.ToList().ForEach(n => Console.WriteLine("Numéro : id = {0} | IDx = {1} | IPN = {2}", n.id, n.IDx, n.ipn));
            }

            FinExemple();
        }

        public static void SelectQueryBuilder()
        {
            CartoucheExemple("Select avec les méthodes du contexte");

            // Initialisation du contexte
            using (Modele bdd = new Modele())
            {
                // Définition de la requête de type ObjectQuery<Publication>
                var requete = bdd.Publication.SelectValue<Publication>("it");

                // Execution de la requête
                requete.ToList().ForEach(p => Console.WriteLine("Publication : ID = {0} | Titre = {1}", p.Id, p.Titre));
            }

            FinExemple();
        }

        public static void SelectAvecInclude()
        {
            CartoucheExemple("Requête utilisant la méthode Include pour charger les associations");

            using (Modele bdd = new Modele())
            {

                var requete = from publication in bdd.Publication.Include("Auteur").Include("Editeur") select publication;

                requete.ToList().ForEach((Publication p) =>
                {
                    Console.WriteLine("Publication : ID = {0} | Titre = {1}", p.Id, p.Titre);

                    Console.WriteLine("    Editeur : ID = {0} | Nom = {1}", p.Editeur.Id, p.Editeur.Nom);

                    p.Auteur.ToList().ForEach(a => Console.WriteLine("     Auteur : ID = {0} | Nom = {1} {2}", a.Id, a.Prenom, a.Nom));
                });
            }

            FinExemple();
        }


        private static void SelectAvecChargementDifféré()
        {
            CartoucheExemple("Requête utilisant le chargement différé");

            using (Modele bdd = new Modele())
            {
                var requete = from publication in bdd.Publication select publication;

                requete.ToList().ForEach((Publication p) =>
                {
                    Console.WriteLine("Publication : ID = {0} | Titre = {1}", p.Id, p.Titre);

                    if (!p.EditeurReference.IsLoaded)
                        p.EditeurReference.Load();

                    Console.WriteLine("    Editeur : ID = {0} | Nom = {1}", p.Editeur.Id, p.Editeur.Nom);

                    if (!p.Auteur.IsLoaded)
                        p.Auteur.Load();

                    p.Auteur.ToList().ForEach(a => Console.WriteLine("     Auteur : ID = {0} | Nom = {1} {2}", a.Id, a.Prenom, a.Nom));
                });
            }
            FinExemple();
        }


        public static void Insert()
        {
            CartoucheExemple("Ajout de données avec LinQ");

            using (Modele bdd = new Modele())
            {
                EditeurInformatique OReilly = new EditeurInformatique()
                {
                    Nom = "OReilly",
                    NombreLivresInfoEdites = 1800
                };

                bdd.AddToEditeur(OReilly);
                bdd.SaveChanges();
            }

            FinExemple();
        }

        public static void Delete()
        {
            CartoucheExemple("Suppression de données");

            using (Modele bdd = new Modele())
            {
                var requete = from c in bdd.Client
                              where c.Nom == "Oliver"
                              select c;

                var client = requete.First();

                if (client != null)
                {
                    bdd.DeleteObject(client);
                    bdd.SaveChanges();
                }
            }

            FinExemple();
        }

        public static void Update()
        {
            CartoucheExemple("Mise à jour de données");

            using (Modele bdd = new Modele())
            {
                Client client = (from c in bdd.Client
                                 where c.Nom == "Oliver"
                                 select c).FirstOrDefault();
                if (client != null)
                {
                    client.Ville = "Bruxelles";
                    client.Pays = "Belgique";
                    bdd.SaveChanges();
                }
            }

            FinExemple();
        }

        public static void DéfinirRelation()
        {
            CartoucheExemple("Mise à jour d'une relation");

            using (Modele bdd = new Modele())
            {
                Emprunt emprunt = new Emprunt()
                {
                    Client = bdd.Client.First(),
                    DateDebut = DateTime.Now,
                    Exemplaire = bdd.Exemplaire.First()
                };
                bdd.AddToEmprunt(emprunt);
                bdd.SaveChanges();
            }

            FinExemple();
        }

        public static void UndoInsert()
        {
            using (Modele bdd = new Modele())
            {
                var OReilly = (from editeur in bdd.Editeur
                               where editeur.Nom == "OReilly"
                               select editeur).FirstOrDefault();

                if (OReilly != null)
                {
                    bdd.DeleteObject(OReilly);
                    bdd.SaveChanges();
                }
            }
        }

        public static void UndoUpdate()
        {
            using (Modele bdd = new Modele())
            {
                Client client = (from c in bdd.Client
                                 where c.Nom == "Oliver"
                                 select c).FirstOrDefault();
                if (client != null)
                {
                    client.Ville = "CartonVille";
                    client.Pays = "France";
                    bdd.SaveChanges();
                }


                bdd.Emprunt.ToList().ForEach(e => bdd.DeleteObject(e));
                bdd.SaveChanges();
            }
        }


        public static void UndoDelete()
        {
            using (Modele bdd = new Modele())
            {
                Client client = new Client()
                {
                    Nom = "Oliver",
                    Prenom = "Bernard",
                    Pays = "France",
                    Rue = "102 impasse fauche",
                    CodePostal = "10293",
                    Telephone = "0229374029",
                    Ville = "CartonVille"
                };

                bdd.AddToClient(client);
                bdd.SaveChanges();
            }
        }

        public static void AppelProcédureStockée()
        {
            CartoucheExemple("Appel de la procédure stockée GetAuteurs");

            using (Modele bdd = new Modele())
            {
                var requete = bdd.GetAuteurs();
                requete.ToList().ForEach(a => Console.WriteLine("Auteur : ID = {0}, Nom = {1}, Prenom = {2}", a.Id, a.Nom, a.Prenom));
            }

            FinExemple();
        }

        #endregion

        #region Personnalisation
        /*
         * Pour les exemples de personalisation, voir les fichiers Client.cs et Modele.cs
         */
        #endregion

        #region Serialisation

        public static void SerialisationXML()
        {
            CartoucheExemple("Serialisation d'un client au format XML");

            using (Modele bdd = new Modele())
            {
                var client = bdd.Client.First();

                XmlSerializer serialiseur = new XmlSerializer(typeof(Client));
                TextWriter textWriter = new StreamWriter("client.xml");
                serialiseur.Serialize(textWriter, client);
                textWriter.Close();
            }

            FinExemple();
        }

        public static void DeserialisationXML()
        {
            CartoucheExemple("Désérialisation d'un client contenu dans un fichier XML");

            XmlSerializer serialiseur = new XmlSerializer(typeof(Client));

            TextReader textReader = new StreamReader("client.xml");
            Client client = (Client)serialiseur.Deserialize(textReader);
            textReader.Close();

            Console.WriteLine(client.ToString());

            FinExemple();
        }

        #endregion

        #region Relations avec le contexte

        public static void DétacherEntité()
        {
            CartoucheExemple("Détacher une entité du contexte");

            using (Modele bdd = new Modele())
            {
                var client = (from c in bdd.Client
                              where c.Nom == "Oliver"
                              select c).FirstOrDefault();

                if (client != null)
                {
                    bdd.Detach(client);
                }
            }

            FinExemple();
        }

        public static void AttacherEntité()
        {
            CartoucheExemple("Attacher une entité du contexte\n");

            using (Modele bdd = new Modele())
            {
                // Récupérer et détacher un objet pour l'exemple
                var client = (from c in bdd.Client
                              where c.Nom == "Oliver"
                              select c).FirstOrDefault();

                if (client != null)
                {
                    bdd.Detach(client);
                }

                // Attacher un objet au contexte
                bdd.Attach(client);
            }

            FinExemple();
        }

        public static void MiseAJourEntité()
        {
            CartoucheExemple("Mettre à jour une entité détaché (mais déjà existante dans la base de données)");

            using (Modele bdd = new Modele())
            {
                // Récupérer et détacher un objet pour l'exemple
                var client = (from c in bdd.Client
                              where c.Nom == "Oliver"
                              select c).FirstOrDefault();

                if (client != null)
                {
                    bdd.Detach(client);
                }

                client.Nom = "Jacky";

                // Extraction et création de la clé de l'entité
                EntityKey key = bdd.CreateEntityKey("Client", client);

                // Essaie de récupèrer l'entité originale à partir de sa clé
                object clientOriginal;
                if (bdd.TryGetObjectByKey(key, out clientOriginal))
                {
                    // Applique les modifications de l'entité détaché comportant des modifications
                    bdd.ApplyPropertyChanges(
                        key.EntitySetName, client);
                }

                bdd.SaveChanges();
            }

            FinExemple();
        }

        public static void UndoMiseAJourEntité()
        {
            using (Modele bdd = new Modele())
            {
                // Récupérer et détacher un objet pour l'exemple
                var client = (from c in bdd.Client
                              where c.Nom == "Jacky"
                              select c).FirstOrDefault();

                client.Nom = "Oliver";

                bdd.SaveChanges();
            }
        }

        #endregion

        #region Acces Concurrentiel

        public static void RefreshEntité()
        {
            CartoucheExemple("Récupérer une entité en cas de conflit (Accès concurrentiel)");

            using (Modele bdd = new Modele())
            {
                Client client = null;
                try
                {
                    client = (from c in bdd.Client
                              where c.Nom == "Oliver"
                              select c).FirstOrDefault();

                    simulerAccesConcurrentiel(bdd.Connection.DataSource);

                    client.Prenom = "Fabrice";
                    bdd.SaveChanges();

                    Console.WriteLine("Aucun conflit");
                }
                catch (OptimisticConcurrencyException exp)
                {
                    Console.WriteLine("Conflit détecté. Message : {0}", exp.Message);

                    bdd.Refresh(RefreshMode.StoreWins, client);
                    bdd.SaveChanges();
                }
            }

            FinExemple();
        }

        private static void simulerAccesConcurrentiel(string pDataSource)
        {   // helloentityfx
            using (SqlConnection connexion = new SqlConnection("Data Source=" + pDataSource + ";Initial Catalog=maintenanceDB;Integrated Security=SSPI;"))
            {
                connexion.Open();

                string strCmd = "UPDATE Client SET Prenom = 'Johnny' WHERE Nom = 'Oliver'";
                SqlCommand command = new SqlCommand(strCmd, connexion);
                command.ExecuteNonQuery();

                connexion.Close();
            }
        }

        #endregion

        #region Transactions

        public static void Transaction()
        {
            CartoucheExemple("Transaction explicite");

            int nbEssai = 3;
            bool transactionExecutee = false;

            using (Modele bdd = new Modele())
            {
                while (nbEssai > 0 && !transactionExecutee)
                {
                    try
                    {
                        Client client = new Client()
                        {
                            Nom = "Musso",
                            Prenom = "Paul"
                        };

                        bdd.AddToClient(client);
                        bdd.SaveChanges(false);
                        transactionExecutee = true;
                    }
                    catch (UpdateException exp)
                    {
                        Console.WriteLine("Erreur détectée : {0}", exp.Message);
                        nbEssai--;
                    }
                }
                if (transactionExecutee)
                    bdd.AcceptAllChanges();
            }

            FinExemple();
        }

        public static void DeleteTransaction()
        {
            CartoucheExemple("Suppression de la transaction");

            using (Modele bdd = new Modele())
            {
                var requete = from c in bdd.Client
                              where c.Prenom == "Paul"
                              select c;

                //var client = requete.First();

                var clients = requete.ToList();

                foreach (var client in clients)
                {
                    if (client != null)
                    {
                        bdd.DeleteObject(client);
                        bdd.SaveChanges();
                    }

                }
            }

            FinExemple();
        }
        #endregion


        public static void CartoucheExemple(string texte)
        {
            Console.WriteLine("*********************************************************************");
            Console.WriteLine(texte);
            Console.WriteLine("*********************************************************************");
            Console.WriteLine();
        }

        public static void FinExemple()
        {
            Console.WriteLine();
            Console.WriteLine();
        }
    }
}
