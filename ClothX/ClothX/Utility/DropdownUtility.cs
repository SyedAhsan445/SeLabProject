using ClothX.Constants;
using ClothX.DbModels;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace ClothX.Utility
{
	public class DropdownUtility
	{
		private static DropdownUtility _instance;

		public static DropdownUtility Instance
		{
			get
			{
				if (_instance == null)
					_instance = new DropdownUtility();
				return _instance;
			}
		}

		private DropdownUtility() { }


		public List<SelectListItem> TailorProjectCategoryDropdown()
		{
			ClothXDbContext db = new ClothXDbContext();
			var lst = db.ProductCategories.Select(a => new SelectListItem()
			{
				Text = a.Name,
				Value = a.Id + ""
			}).ToList();
			return lst;
		}
	}
}
