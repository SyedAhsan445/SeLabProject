using Microsoft.AspNetCore.Mvc;

namespace ClothX.Controllers
{
	public class FeedbackController : Controller
	{
		public IActionResult Index()
		{
			return View();
		}
	}
}
