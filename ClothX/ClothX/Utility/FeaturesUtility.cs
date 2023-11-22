using ClothX.DbModels;
using Microsoft.EntityFrameworkCore;

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

        public List<FeatureGroup> GetFeatures()
        {
            ClothXDbContext db = new ClothXDbContext();
            var features = db.FeatureGroups.ToList();
            return features;
        }


        public FeatureGroup? FindFeatureGroup(int Id)
        {
            ClothXDbContext db = new ClothXDbContext();
            var feature = db.FeatureGroups.Find(Id);
            return feature;
        }

        public void EditFeatureGroup(FeatureGroup model)
        {
            ClothXDbContext db = new ClothXDbContext();
            var existing = db.FeatureGroups.Find(model.Id);
            existing.Name = model.Name;
            existing.UpdatedOn = DateTime.Now;

            db.FeatureGroups.Update(existing);
            db.SaveChanges();
        }

        public async Task DeleteFeatureGroup(int? id)
        {
            ClothXDbContext db = new ClothXDbContext();
            var featureGroup = await db.FeatureGroups
                .FirstOrDefaultAsync(m => m.Id == id);


            featureGroup.IsActive = !featureGroup.IsActive;
            featureGroup.UpdatedOn = DateTime.Now;
            db.FeatureGroups.Update(featureGroup);
            db.SaveChanges();
        }

        public Feature? FindFeature(int id)
        {
            ClothXDbContext db = new ClothXDbContext();
            var feature = db.Features.Find(id);
            return feature;
        }

        public void EditFeature(Feature model)
        {
            ClothXDbContext db = new ClothXDbContext();
            var existing = db.Features.Find(model.Id);
            existing.Name = model.Name;
            existing.Description = model.Description;
            existing.Price = model.Price;
            existing.UpdatedOn = DateTime.Now;

            db.Features.Update(existing);
            db.SaveChanges();
        }

        public void Addfeature(Feature model, string username)
        {
            ClothXDbContext db = new ClothXDbContext();
            model.AddedOn = DateTime.Now;
            model.AddedBy = username;
            model.UpdatedOn = DateTime.Now;
            model.IsActive = true;

            db.Features.Add(model);
            db.SaveChanges();
        }


        public async Task<Feature?> DeleteFeature(int? id)
        {
            ClothXDbContext db = new ClothXDbContext();
            var feature = await db.Features
                .FirstOrDefaultAsync(m => m.Id == id);
            feature.IsActive = !feature.IsActive;
            feature.UpdatedOn = DateTime.Now;
            db.Features.Update(feature);
            db.SaveChanges();
            return feature;
        }

        public void AddFeatureGroup(FeatureGroup model, string username)
        {
            ClothXDbContext db = new ClothXDbContext();
            model.AddedOn = DateTime.Now;
            model.AddedBy = username;
            model.UpdatedOn = DateTime.Now;
            model.IsActive = true;

            db.FeatureGroups.Add(model);
            db.SaveChanges();
        }

        public List<FeatureGroup> getFeatureGroups()
        {
            ClothXDbContext db = new ClothXDbContext();
            var featureGroups = db.FeatureGroups.Where(x => x.IsActive == true).ToList();
            featureGroups = featureGroups.Where(x => x.Features.Any(x => x.IsActive == true)).ToList();
            return featureGroups;
        }
    }
}
