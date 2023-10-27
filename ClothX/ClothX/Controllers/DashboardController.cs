using Microsoft.AspNetCore.Mvc;

namespace ClothX.Controllers
{
	public class DashboardController : Controller
	{
		public IActionResult Index()
		{
			return View();
		}
	}
}
