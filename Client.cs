using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace HelloEntityFramework
{
    public partial class Client
    {
        public Client()
        {
        }

        partial void OnPrenomChanging(string value)
        {
            Console.WriteLine("La propriété Prenom(valeur : {0}) de {1} va contenir la valeur {2}", Prenom, this.ToString(), value);
        }

        partial void OnPrenomChanged()
        {
            Console.WriteLine("La propriété Prenom(valeur : {0}) de {1} a été changée", Prenom, this.ToString());
        }

        public override string ToString()
        {
            StringBuilder strBuilder = new StringBuilder();
            strBuilder.Append("Client : ");
            strBuilder.Append("Nom = ");
            strBuilder.Append(Nom);
            strBuilder.Append("Prenom = ");
            strBuilder.Append(Prenom);
            return strBuilder.ToString();
        }
    }
}
