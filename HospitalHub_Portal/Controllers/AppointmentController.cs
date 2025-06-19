using Microsoft.AspNetCore.Mvc;

namespace HospitalHub_Portal.Controllers
{
    public class AppointmentController : Controller
    {
        public IActionResult AppointmentList()
        {
            return View();
        }
    }
}
