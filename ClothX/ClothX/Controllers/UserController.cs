using ClothX.DbModels;
using Microsoft.AspNetCore.Mvc;

namespace ClothX.Controllers
{
	public class UserController : Controller
	{
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
	}
}
