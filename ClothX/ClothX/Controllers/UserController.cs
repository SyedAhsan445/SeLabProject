using ClothX.Constants;
using ClothX.CustomAttributes;
using ClothX.DbModels;
using ClothX.Services;
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Authorization;
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
        [ClothXPermissionAuthorize("Users")]
        public IActionResult Index()
        {
            try
            {
                ClothXDbContext db = new ClothXDbContext();
                var dbUsers = db.UserProfiles.ToList();
                return View(dbUsers);
            }
            catch (Exception ex)
            {
                ErrorLogger.Instance.ErrorLoggingFunction(ex.Message, this.ToString());

                return RedirectToAction("ServerError", "Error");
            }
        }
        [ClothXPermissionAuthorize("Users")]
        public IActionResult ApprovalStatusChange(int id)
        {
            try
            {
                ClothXDbContext db = new ClothXDbContext();
                var dbUser = db.UserProfiles.Where(x => x.Id == id).FirstOrDefault();
                dbUser.IsApproved = !dbUser.IsApproved;
                db.UserProfiles.Update(dbUser);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                ErrorLogger.Instance.ErrorLoggingFunction(ex.Message, this.ToString());

                return RedirectToAction("ServerError", "Error");
            }
        }
        [Authorize]
        public async Task<IActionResult> Profile()
        {
            try
            {
                ClothXDbContext db = new ClothXDbContext();
                var dbUsers = await db.AspNetUsers.Where(x => x.UserName == User.Identity.Name).ToListAsync();

                var _user = dbUsers.FirstOrDefault().UserProfiles.FirstOrDefault();

                return View(_user);
            }
            catch (Exception ex)
            {
                ErrorLogger.Instance.ErrorLoggingFunction(ex.Message, this.ToString());

                return RedirectToAction("ServerError", "Error");
            }
        }

        [HttpPost]
        [Authorize]
        public async Task<IActionResult> UpdateProfile(IFormCollection form)
        {
            try
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
            catch (Exception ex)
            {
                ErrorLogger.Instance.ErrorLoggingFunction(ex.Message, this.ToString());

                return RedirectToAction("ServerError", "Error");
            }
        }

    }
}
