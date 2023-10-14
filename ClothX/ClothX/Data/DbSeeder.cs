using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using ClothX;
using ClothX.DbModels;
using ClothX.Constants;

namespace ClothX.Data
{
    public static class DbSeeder
    {

        public static async Task SeedRolesAndAdminAsync(IServiceProvider service)
        {
            var userManager = service.GetService<UserManager<IdentityUser>>();
            var roleManager = service.GetService<RoleManager<IdentityRole>>();
            await roleManager.CreateAsync(new IdentityRole(RoleType.Tailor.ToString()));
            await roleManager.CreateAsync(new IdentityRole(RoleType.User.ToString()));

            UserProfile userProfile = new UserProfile();
            ClothXDbContext db = new ClothXDbContext();



            IUserStore<IdentityUser> _userStore = new UserStore<IdentityUser>(db);

            var user = Activator.CreateInstance<IdentityUser>();




            user.EmailConfirmed = true;
            user.Email = "admin@admin.com";
            user.UserName = "admin";

            var userInDb = await userManager.FindByEmailAsync(user.Email);
            if (userInDb == null)
            {
                var result = await userManager.CreateAsync(user, "admin@123");
                await userManager.AddToRoleAsync(user, RoleType.Tailor.ToString());
                string userId = db.AspNetUsers.Where(x => x.Email == user.Email && x.PasswordHash == user.PasswordHash).FirstOrDefault().Id;
                userProfile.UserId = userId;
                userProfile.FirstName = "Umair";
                userProfile.LastName = "Noor";
                userProfile.AddedOn = DateTime.Today.Date;
                userProfile.Gender = db.Lookups.Where(x => x.Value == "Male").FirstOrDefault().Id;
                userProfile.IsApproved = true;
                userProfile.IsActive = true;
                userProfile.UpdatedOn = DateTime.Today.Date;
                db.UserProfiles.Add(userProfile);
                await db.SaveChangesAsync();
            }
        }
    }
}
