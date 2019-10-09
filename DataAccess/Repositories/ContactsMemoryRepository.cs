using Common.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Repositories
{
    public class ContactsMemoryRepository : IRepository<int, Contact>
    {
        private static List<Contact> contacts = new List<Contact>();

        public ContactsMemoryRepository()
        {
            contacts.Add(new Contact
            {
                Id = 1,
                LastName = "Doe",
                FirstName = "Jane",
                Email = "jane.doe@company.com",
                Phone = "(999)999-9999"
            });
            contacts.Add(new Contact
            {
                Id = 2,
                LastName = "Cortez",
                FirstName = "Ramon",
                Email = "ramon.cortez@company.com",
                Phone = "(999)999-9991"
            });
        }

        public IEnumerable<Contact> Get()
        {
            return contacts;
        }

        public Contact Get(int id)
        {
            return contacts.FirstOrDefault(c => c.Id == id);
        }
    }
}
