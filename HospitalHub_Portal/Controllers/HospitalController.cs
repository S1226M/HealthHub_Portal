using Microsoft.AspNetCore.Mvc;

namespace YourProject.Controllers
{
    public class HospitalController : Controller
    {
        public IActionResult HospitalList()
        {
            // Fetch hospitals from database
            return View();
        }
    }
}