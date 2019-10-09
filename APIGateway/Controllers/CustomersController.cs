using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using Common.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;

namespace APIGateway.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CustomersController : ControllerBase
    {
        private readonly IConfiguration config;
        private readonly HttpClient client;

        public CustomersController(IConfiguration config, HttpClient client)
        {
            this.config = config;
            this.client = client;
        }

        // GET: api/Customers
        [HttpGet]
        public async Task<IEnumerable<Contact>> Get()
        {
            var CoreContactsAPIURI = "http://coreapi/api/contacts";
            if (!string.IsNullOrEmpty(this.config["CoreContactsAPIURI"]))
                CoreContactsAPIURI = this.config["CoreContactsAPIURI"];
            HttpResponseMessage response = await this.client.GetAsync(CoreContactsAPIURI);
            response.EnsureSuccessStatusCode();
            string json = await response.Content.ReadAsStringAsync();
            var contacts = JsonConvert.DeserializeObject<List<Contact>>(json);
            return contacts;
        }

        // GET: api/Customers/5
        [HttpGet("{id}", Name = "Get")]
        public async Task<Contact> Get(int id)
        {
            HttpResponseMessage response = await this.client.GetAsync(this.config["customerUIR"]+"/"+id.ToString());
            response.EnsureSuccessStatusCode();
            string json = await response.Content.ReadAsStringAsync();
            var contacts = JsonConvert.DeserializeObject<Contact>(json);
            return contacts;
        }

        // POST: api/Customers
        [HttpPost]
        public void Post([FromBody] string value)
        {
        }

        // PUT: api/Customers/5
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
