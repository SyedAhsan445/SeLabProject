using ClothX.Constants;
using ClothX.DbModels;
using ClothX.Services;
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ClothX.Controllers
{
	public class UserController : Controller
	{
		private readonly IWebHostEnvironment webHost;

		public UserController(IWebHostEnvironment webHost)
		{
			this.webHost = webHost;
		}

		public IActionResult Index()
		{
			ClothXDbContext db = new ClothXDbContext();
			var dbUsers = db.UserProfiles.ToList();
			return View(dbUsers);
		}

		public IActionResult ApprovalStatusChange(int id)
		{
			ClothXDbContext db = new ClothXDbContext();
			var dbUser = db.UserProfiles.Where(x => x.Id == id).FirstOrDefault();
			dbUser.IsApproved = !dbUser.IsApproved;
			db.UserProfiles.Update(dbUser);
			db.SaveChanges();
			return RedirectToAction("Index");
		}

		public async Task<IActionResult> Profile()
		{
			ClothXDbContext db = new ClothXDbContext();
			var dbUsers = await db.AspNetUsers.Where(x => x.UserName == User.Identity.Name).ToListAsync();

			var _user = dbUsers.FirstOrDefault().UserProfiles.FirstOrDefault();

			return View(_user);
		}

		[HttpPost]
		public async Task<IActionResult> UpdateProfile(IFormCollection form)
		{
			ClothXDbContext db = new ClothXDbContext();
			int Id = int.Parse(form["Id"]);

			var _user = await db.UserProfiles.Where(x => x.Id == Id).FirstOrDefaultAsync();

			_user.FirstName = form["FirstName"];
			_user.LastName = form["LastName"];
			_user.PhoneNumber = form["PhoneNumber"];
			_user.Address = form["Address"];

			if (form.Files.Any(x => x.Name == "ProfileImage"))
			{
				List<FilePathEnum> filepath = new()
				{
					FilePathEnum.Images,
					FilePathEnum.UserImages
				};
				var s = form.Files.Where(x => x.Name == "ProfileImage").FirstOrDefault();
				_user.ImagePath = await UploadFileService.Instance.UploadFile(s, filepath, webHost);

			}

			db.UserProfiles.Update(_user);
			await db.SaveChangesAsync();

			return RedirectToAction("Profile");
		}

	}
}
