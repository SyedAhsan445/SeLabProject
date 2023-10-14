using ClothX.Constants;
using ClothX.DbModels;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace ClothX.Utility
{
    public class LookupUtility
    {
        private static LookupUtility _instance;

        public static LookupUtility Instance
        {
            get
            {
                if (_instance == null)
                    _instance = new LookupUtility();
                return _instance;
            }
        }

        private LookupUtility() { }

        public List<SelectListItem> getSelectList(LookupCategory category)
        {
            ClothXDbContext db = new ClothXDbContext();
            var lst = db.Lookups.Where(x => x.Category.ToUpper() == category.ToString().ToUpper()).Select(a => new SelectListItem()
            {
                Text = a.Value,
                Value = a.Id + ""
            }).ToList();
            return lst;
        }

        public string getValue(int id)
        {
            if (id == 0)
            {
                return "";
            }
            ClothXDbContext db = new ClothXDbContext();
            string value = db.Lookups.Where(x => x.Id == id).FirstOrDefault().Value;
            return value;
        }

        public int getId(string value)
        {
            ClothXDbContext db = new ClothXDbContext();
            int id = db.Lookups.Where(x => x.Value == value).FirstOrDefault().Id;
            return id;
        }

        public int GetFirstObjectId(LookupCategory category)
        {
            ClothXDbContext db = new ClothXDbContext();
            int id = db.Lookups.Where(x => x.Category.ToUpper() == category.ToString().ToUpper()).FirstOrDefault().Id;
            return id;
        }
    }
}
