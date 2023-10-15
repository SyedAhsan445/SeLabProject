using ClothX.Constants;
using ClothX.DbModels;
using ClothX.Services;
using ClothX.ViewModels;
using Microsoft.EntityFrameworkCore;

namespace ClothX.Utility
{
    public class TailorProjectsUtility
    {
        private static TailorProjectsUtility _instance;
        private static ClothXDbContext db;

        public static TailorProjectsUtility Instance
        {
            get
            {
                if (_instance == null)
                    _instance = new TailorProjectsUtility();
                if (db == null)
                    db = new ClothXDbContext();
                return _instance;
            }
        }

        private TailorProjectsUtility() { }


        public async Task<List<TailorProject>> getTailorProjects()
        {
            var projects = await db.TailorProjects.ToListAsync();
            return projects;
        }

        private TailorProjectViewModel getViewModel(TailorProject project)
        {
            TailorProjectViewModel model = new TailorProjectViewModel();
            model.Id = project.Id;
            model.Title = project.Title;
            model.Description = project.Description;
            model.ImagePath = project.ImagePath;
            model.AddedBy = project.AddedBy;
            model.AddedOn = project.AddedOn;
            model.UpdatedOn = project.UpdatedOn;
            model.ProductCategoryId = project.ProductCategoryId;
            model.CategoryName = project.ProductCategory.Name;
            model.IsActive = project.IsActive;
            model.Reviews = project.Reviews;
            model.TailorProjectImages = project.TailorProjectImages;

            return model;
        }

        public async Task<TailorProjectViewModel?> getProject(int id)
        {
            var dbProject = await db.TailorProjects.Where(x => x.Id == id).FirstOrDefaultAsync();
            if (dbProject == null)
            {
                return null;
            }
            return getViewModel(dbProject);
        }

        public async Task<TailorProject?> getProjectDbModel(int id)
        {
            var dbProject = await db.TailorProjects.Where(x => x.Id == id).FirstOrDefaultAsync();
            if (dbProject == null)
            {
                return null;
            }
            return dbProject;
        }

        public async Task ActiveInActiveProject(int projectId)
        {
            var proj = await db.TailorProjects.Where(x => x.Id == projectId).FirstOrDefaultAsync();
            proj.IsActive = !proj.IsActive;
            proj.UpdatedOn = DateTime.Now;
            db.TailorProjects.Update(proj);
            await db.SaveChangesAsync();
        }

        public TailorProject GetDbModel(TailorProjectViewModel proj)
        {
            TailorProject model = new TailorProject();
            model.Title = proj.Title;
            model.Description = proj.Description;
            model.AddedOn = proj.AddedOn;
            model.AddedBy = proj.AddedBy;
            model.UpdatedOn = proj.UpdatedOn;
            model.IsActive = proj.IsActive;
            model.ProductCategoryId = proj.ProductCategoryId;
            return model;
        }

        public async Task AddTailorProject(TailorProjectViewModel proj, string username, IWebHostEnvironment webHost)
        {
            var model = GetDbModel(proj);
            model.IsActive = true;
            model.AddedOn = DateTime.Now;
            model.UpdatedOn = DateTime.Now;
            model.AddedBy = username;
            List<FilePathEnum> filepath = new()
            {
                FilePathEnum.Images,
                FilePathEnum.ProjectImages
            };
            model.ImagePath = await UploadFileService.Instance.UploadFile(proj.image, filepath, webHost);

            await db.TailorProjects.AddAsync(model);
            await db.SaveChangesAsync();

            foreach (var s in proj.projectImages)
            {
                TailorProjectImage img = new TailorProjectImage();
                img.ProjectId = model.Id;
                img.ImagePath = await UploadFileService.Instance.UploadFile(s, filepath, webHost);

                await db.TailorProjectImages.AddAsync(img);
                await db.SaveChangesAsync();
            }

        }


        public async Task EditTailorProject(TailorProjectViewModel proj, string username, IWebHostEnvironment webHost)
        {
            var dbModel = await db.TailorProjects.Where(x => x.Id == proj.Id).FirstOrDefaultAsync();
            dbModel.Title = proj.Title;
            dbModel.Description = proj.Description;
            dbModel.ProductCategoryId = proj.ProductCategoryId;
            dbModel.UpdatedOn = DateTime.Now;
            List<FilePathEnum> filepath = new()
            {
                FilePathEnum.Images,
                FilePathEnum.ProjectImages
            };
            if (proj.ImagePath != null)
            {
                dbModel.ImagePath = await UploadFileService.Instance.UploadFile(proj.image, filepath, webHost);
            }

            db.TailorProjects.Update(dbModel);
            await db.SaveChangesAsync();

            if (proj.projectImages != null)
            {
                foreach (var s in proj.projectImages)
                {
                    TailorProjectImage img = new TailorProjectImage();
                    img.ProjectId = dbModel.Id;
                    img.ImagePath = await UploadFileService.Instance.UploadFile(s, filepath, webHost);

                    await db.TailorProjectImages.AddAsync(img);
                    await db.SaveChangesAsync();
                }
            }

        }
    }
}
