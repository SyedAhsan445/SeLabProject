using ClothX.DbModels;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ClothX.Controllers
{
	public class FeatureController : Controller
	{
		public IActionResult Index()
		{
			ClothXDbContext db = new ClothXDbContext();
			var features = db.FeatureGroups.ToList();
			return View(features);
		}

		public IActionResult Create(int Id = 0)
		{
			ViewBag.Id = Id;
			if (Id != 0)
			{
				ClothXDbContext db = new ClothXDbContext();
				var feature = db.FeatureGroups.Find(Id);
				return PartialView("FeatureGroupCreateEditPartialView", feature);
			}
			return PartialView("FeatureGroupCreateEditPartialView");
		}
		[HttpPost]
		public IActionResult Create(FeatureGroup model)
		{
			ClothXDbContext db = new ClothXDbContext();
			if (model.Id == 0)
			{
				model.AddedOn = DateTime.Now;
				model.AddedBy = User.Identity.Name;
				model.UpdatedOn = DateTime.Now;
				model.IsActive = true;

				db.FeatureGroups.Add(model);
				db.SaveChanges();
			}
			else
			{
				var existing = db.FeatureGroups.Find(model.Id);
				existing.Name = model.Name;
				existing.UpdatedOn = DateTime.Now;

				db.FeatureGroups.Update(existing);
				db.SaveChanges();
			}

			return RedirectToAction(nameof(Index));

		}

		public async Task<IActionResult> Delete(int? id)
		{
			if (id == null)
			{
				return NotFound();
			}
			ClothXDbContext db = new ClothXDbContext();
			var featureGroup = await db.FeatureGroups
				.FirstOrDefaultAsync(m => m.Id == id);
			if (featureGroup == null)
			{
				return NotFound();
			}

			featureGroup.IsActive = !featureGroup.IsActive;
			featureGroup.UpdatedOn = DateTime.Now;
			db.FeatureGroups.Update(featureGroup);
			db.SaveChanges();

			return RedirectToAction(nameof(Index));
		}

		public async Task<IActionResult> Details(int? id)
		{
			if (id == null)
			{
				return NotFound();
			}
			ClothXDbContext db = new ClothXDbContext();
			var featureGroup = await db.FeatureGroups.FirstOrDefaultAsync(m => m.Id == id);
			if (featureGroup == null)
			{
				return NotFound();
			}


			return View(featureGroup);
		}
		[HttpGet]
		public IActionResult CreateFeature(string Id = "")
		{
			var ids = Id.Split(".");
			ViewBag.FeatureGroupId = Convert.ToInt32(ids[0]);
			ViewBag.Id = ids.Length == 2 ? Convert.ToInt32(ids[1]) : 0;
			if (ids.Length == 2)
			{
				if (ids[1] != "0")
				{
					ClothXDbContext db = new ClothXDbContext();
					var feature = db.Features.Find(Convert.ToInt32(ids[1]));
					return PartialView("FeatureCreateEditPartialView", feature);
				}
			}

			return PartialView("FeatureCreateEditPartialView");
		}

		public IActionResult CreateFeature(Feature model)
		{
			ClothXDbContext db = new ClothXDbContext();
			if (model.Id == 0)
			{
				model.AddedOn = DateTime.Now;
				model.AddedBy = User.Identity.Name;
				model.UpdatedOn = DateTime.Now;
				model.IsActive = true;

				db.Features.Add(model);
				db.SaveChanges();
			}
			else
			{
				var existing = db.Features.Find(model.Id);
				existing.Name = model.Name;
				existing.Description = model.Description;
				existing.Price = model.Price;
				existing.UpdatedOn = DateTime.Now;

				db.Features.Update(existing);
				db.SaveChanges();
			}

			return RedirectToAction(nameof(Details), new { id = model.FeatureGroupId });
		}

		public async Task<IActionResult> DeleteFeature(int? id)
		{
			if (id == null)
			{
				return NotFound();
			}
			ClothXDbContext db = new ClothXDbContext();
			var feature = await db.Features
				.FirstOrDefaultAsync(m => m.Id == id);
			if (feature == null)
			{
				return NotFound();
			}

			feature.IsActive = !feature.IsActive;
			feature.UpdatedOn = DateTime.Now;
			db.Features.Update(feature);
			db.SaveChanges();

			return RedirectToAction(nameof(Details), new { id = feature.FeatureGroupId });
		}
	}
}
