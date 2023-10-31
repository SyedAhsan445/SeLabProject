using ClothX.DbModels;
using ClothX.Services;
using ClothX.Utility;
using ClothX.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;

namespace ClothX.Controllers
{
	public class ProjectController : Controller
	{
		private readonly IWebHostEnvironment _webHostEnvironment;

		public ProjectController(IWebHostEnvironment webHostEnvironment)
		{
			_webHostEnvironment = webHostEnvironment;
		}

		public async Task<IActionResult> Index()
		{
			List<TailorProject> tailorProjects = new List<TailorProject>();
			try
			{
				tailorProjects = await TailorProjectsUtility.Instance.getActiveTailorProjects();
			}
			catch (Exception ex)
			{
				ErrorLogger.Instance.ErrorLoggingFunction(ex.Message, this.ToString());
			}
			return View(tailorProjects);
		}

		[Authorize(Roles = "Tailor")]
		public async Task<IActionResult> Manage()
		{
			List<TailorProject> tailorProjects = new List<TailorProject>();
			try
			{
				tailorProjects = await TailorProjectsUtility.Instance.getTailorProjects();
			}
			catch (Exception ex)
			{
				ErrorLogger.Instance.ErrorLoggingFunction(ex.Message, this.ToString());
			}
			return View(tailorProjects);
		}

		[HttpGet]
		[Authorize(Roles = "Tailor")]
		public async Task<IActionResult> AddEdit(int Project = 0)
		{

			try
			{
				ViewBag.ProjectCategory = DropdownUtility.Instance.TailorProjectCategoryDropdown();
				ViewBag.ProjectId = Project;
				if (Project == 0)
				{
					return View();
				}
				var viewModel = await TailorProjectsUtility.Instance.getProject(Project);
				return View(viewModel);
			}
			catch (Exception ex)
			{
				ErrorLogger.Instance.ErrorLoggingFunction(ex.Message, this.ToString());
				return StatusCode(404);
			}

		}
		[HttpPost]
		[Authorize(Roles = "Tailor")]
		public async Task<IActionResult> AddEdit(TailorProjectViewModel model, IFormCollection form)
		{

			try
			{
				if (model.Id == 0)
				{
					await TailorProjectsUtility.Instance.AddTailorProject(model, User.Identity.Name, _webHostEnvironment);
				}
				else
				{
					await TailorProjectsUtility.Instance.EditTailorProject(model, User.Identity.Name, _webHostEnvironment);
				}
			}
			catch (Exception ex)
			{
				ErrorLogger.Instance.ErrorLoggingFunction(ex.Message, this.ToString());
			}
			return RedirectToAction("Index");
		}
		[Authorize(Roles = "Tailor")]
		public async Task<IActionResult> Delete(int id)
		{
			try
			{
				await TailorProjectsUtility.Instance.ActiveInActiveProject(id);
			}
			catch (Exception ex)
			{
				ErrorLogger.Instance.ErrorLoggingFunction(ex.Message, this.ToString());
			}

			return RedirectToAction("Index");
		}

		public async Task<IActionResult> Details(int Project)
		{
			try
			{
				var model = await TailorProjectsUtility.Instance.getProjectDbModel(Project);
				if (model == null)
				{
					throw new Exception("Project with Id= " + Project + " doesnot exists.");
				}
				return View(model);
			}
			catch (Exception ex)
			{
				ErrorLogger.Instance.ErrorLoggingFunction(ex.Message, this.ToString());
			}

			return RedirectToAction("Index");
		}
	}
}
