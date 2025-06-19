using Microsoft.AspNetCore.Mvc;

namespace HospitalHub_Portal.Controllers
{
    public class UserController : Controller
    {
        public IActionResult UserList()
        {
            return View();
        }
    }
}
