using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using FrontEnd.Models;
using Microsoft.Extensions.Configuration;
using System.Net.Http;
using Newtonsoft.Json;
using Common.Models;

namespace FrontEnd.Controllers
{
    public class HomeController : Controller
    {
        private readonly IConfiguration config;
        private readonly HttpClient client;

        public HomeController(IConfiguration config, HttpClient client)
        {
            this.config = config;
            this.client = client;
        }

        public async Task<IActionResult> Index()
        {
            HttpResponseMessage response = await this.client.GetAsync(this.config["APIGatewayCustomersURI"]);
            response.EnsureSuccessStatusCode();
            string json = await response.Content.ReadAsStringAsync();
            var contacts = JsonConvert.DeserializeObject<List<Contact>>(json);

            return View(contacts);
        }

        public IActionResult About()
        {
            ViewData["Message"] = "Your application description page.";

            return View();
        }

        public IActionResult Contact()
        {
            ViewData["Message"] = "Your contact page.";

            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
