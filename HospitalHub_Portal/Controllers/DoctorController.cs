using Microsoft.AspNetCore.Mvc;

namespace HospitalHub_Portal.Controllers
{
    public class DoctorController : Controller
    {
        public IActionResult DoctorList()
        {
            return View();
        }
    }
}
