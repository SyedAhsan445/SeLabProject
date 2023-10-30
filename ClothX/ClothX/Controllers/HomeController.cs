using ClothX.DbModels;
using ClothX.Models;
using ClothX.Services;
using ClothX.Utility;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;

namespace ClothX.Controllers
{
	public class HomeController : Controller
	{
		private readonly ILogger<HomeController> _logger;

		public HomeController(ILogger<HomeController> logger)
		{
			_logger = logger;
		}

		public async Task<IActionResult> Index()
		{
			List<TailorProject> tailorProjects = new List<TailorProject>();
			try
			{
				tailorProjects = await TailorProjectsUtility.Instance.getTailorProjects();
				tailorProjects = tailorProjects.Where(x => x.IsActive == true).ToList().OrderByDescending(obj => obj.AddedOn).Take(3).ToList();
			}
			catch (Exception ex)
			{
				ErrorLogger.Instance.ErrorLoggingFunction(ex.Message, this.ToString());
			}
			ViewBag.TailorProjects = tailorProjects;
			return View();
		}

		public IActionResult Privacy()
		{
			//ErrorLogger.Instance.ErrorLoggingFunction("Unexpected", this.ToString());
			return View();
		}

		public IActionResult Feedback(string url)
		{
			//ViewBag.CurrentUrl = url;
			ViewData["CurrentUrl"] = url;
			return PartialView("FeedbackPartialView");
		}

		[ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
		public IActionResult Error()
		{
			return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
		}
	}
}