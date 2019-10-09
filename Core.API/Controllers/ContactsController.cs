using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Common.Models;
using DataAccess.Repositories;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Core.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ContactsController : ControllerBase
    {
        private readonly IRepository<int, Contact> repository;

        public ContactsController(IRepository<int,Contact> repository)
        {
            this.repository = repository;
        }

        // GET: api/Contacts
        [HttpGet]
        public IEnumerable<Contact> Get()
        {
            return this.repository.Get();
        }

        // GET: api/Contacts/5
        [HttpGet("{id}", Name = "Get")]
        public IActionResult Get(int id)
        {
            var contact = this.repository.Get(id);

            if (contact is null)
                return NotFound();

            return Ok(contact);
            
        }

        // POST: api/Contacts
        [HttpPost]
        public void Post([FromBody] string value)
        {
        }

        // PUT: api/Contacts/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE: api/ApiWithActions/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}
