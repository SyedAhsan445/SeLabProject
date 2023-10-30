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


        public List<SelectListItem> TailorProjectCategoryDropdown(bool withPrice = false)
        {
            ClothXDbContext db = new ClothXDbContext();
            var lst = db.ProductCategories.Where(x=>x.IsActive==true).Select(a => new SelectListItem()
            {
                Text = a.Name + (withPrice == true ? " - " + a.Price + "Rs" : ""),
                Value = a.Id + ""
            }).ToList();
            return lst;
        }
    }
}
