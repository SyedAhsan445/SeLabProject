using ClothX.CustomAttributes;
using ClothX.DbModels;
using ClothX.Services;
using ClothX.Utility;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ClothX.Controllers
{
    public class FeedbackController : Controller
    {
        [HttpPost]
        [ClothXPermissionAuthorize("Feedback.Add")]
        public async Task<IActionResult> Create(Review model, IFormCollection form)
        {
            try
            {
                ClothXDbContext db = new ClothXDbContext();
                int userId = UserUtility.Instance.getUserProfileId(User.Identity.Name);
                model.UserId = userId;
                model.AddedOn = DateTime.Now;
                model.AddedBy = User.Identity.Name;
                _ = int.TryParse(form["rate"], out int r);

                model.Rating = r;
                await db.Reviews.AddAsync(model);
                await db.SaveChangesAsync();
                return Redirect(form["CurrentUrl"]);
            }
            catch (Exception ex)
            {
                ErrorLogger.Instance.ErrorLoggingFunction(ex.Message, this.ToString());

                return RedirectToAction("ServerError", "Error");
            }
        }

        [ClothXPermissionAuthorize("Feedback.Manage")]
        public async Task<IActionResult> Index()
        {
            try
            {
                ClothXDbContext db = new ClothXDbContext();
                List<Review> reviews = await db.Reviews.ToListAsync();
                return View(reviews);
            }
            catch (Exception ex)
            {
                ErrorLogger.Instance.ErrorLoggingFunction(ex.Message, this.ToString());

                return RedirectToAction("ServerError", "Error");
            }
        }
        [ClothXPermissionAuthorize("Feedback.Manage")]
        public async Task<IActionResult> Info(int Id)
        {
            try
            {
                ClothXDbContext db = new ClothXDbContext();
                ViewBag.Id = Id;
                Review review = await db.Reviews.FindAsync(Id);
                return PartialView("FeedbackinfoPartialView", review);
            }
            catch (Exception ex)
            {
                ErrorLogger.Instance.ErrorLoggingFunction(ex.Message, this.ToString());

                return RedirectToAction("ServerError", "Error");
            }
        }
        [ClothXPermissionAuthorize("Feedback.Manage")]
        public async Task<IActionResult> Respond(Review model)
        {
            try
            {
                ClothXDbContext db = new ClothXDbContext();
                Review review = await db.Reviews.Where(x => x.Id == model.Id).FirstOrDefaultAsync();

                review.Response = model.Response;
                review.ResponseAddedOn = DateTime.Now;

                db.Reviews.Update(review);
                await db.SaveChangesAsync();

                await MailSenderService.Instance.SendEmailOnFeedbackResponse(review);

                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                ErrorLogger.Instance.ErrorLoggingFunction(ex.Message, this.ToString());

                return RedirectToAction("ServerError", "Error");
            }
        }
    }
}
