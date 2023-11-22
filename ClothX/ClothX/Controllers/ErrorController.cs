using Microsoft.AspNetCore.Mvc;

namespace ClothX.Controllers
{
    public class ErrorController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult ServerError()
        {
            return View();
        }
    }
}
