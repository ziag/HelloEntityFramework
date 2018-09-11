using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Objects;
using System.Data;

namespace HelloEntityFramework
{
    public partial class Modele
    {  // un message dans le fichier modele
        partial void OnContextCreated()
        {
            SavingChanges += new EventHandler(Modele_SavingChanges);
        }

        void Modele_SavingChanges(object sender, EventArgs e)
        {
            var entitésAjoutees = ((ObjectContext)sender).ObjectStateManager.GetObjectStateEntries(EntityState.Added);

            foreach (ObjectStateEntry entry in entitésAjoutees)
            {
                if (!entry.IsRelationship)
                    Console.WriteLine(String.Format("Ajout d'une entité de type {0}", entry.Entity.GetType().ToString()));
            }
        }
    }
}
