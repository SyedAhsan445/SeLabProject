using ClothX.DbModels;

namespace ClothX.Utility
{
    public class FeaturesUtility
    {
        private static FeaturesUtility _instance;

        public static FeaturesUtility Instance
        {
            get
            {
                if (_instance == null)
                    _instance = new FeaturesUtility();
                return _instance;
            }
        }

        private FeaturesUtility() { }

        public List<FeatureGroup> getFeatureGroups()
        {
            ClothXDbContext db = new ClothXDbContext();
            var featureGroups = db.FeatureGroups.Where(x => x.IsActive == true).ToList();
            featureGroups = featureGroups.Where(x => x.Features.Any(x => x.IsActive == true)).ToList();
            return featureGroups;
        }
    }
}
