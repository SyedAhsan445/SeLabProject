using ClothX.CustomAttributes;
using ClothX.DbModels;
using ClothX.Services;
using ClothX.Utility;
using Microsoft.AspNetCore.Http.Features;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Org.BouncyCastle.Bcpg.Sig;

namespace ClothX.Controllers
{
    public class FeatureController : Controller
    {
        [ClothXPermissionAuthorize("FeatureGroups")]
        public IActionResult Index()
        {
            try
            {
                List<FeatureGroup> features = FeaturesUtility.Instance.GetFeatures();
                return View(features);
            }
            catch (Exception ex)
            {
                ErrorLogger.Instance.ErrorLoggingFunction(ex.Message, this.ToString());

                return RedirectToAction("ServerError", "Error");
            }
        }



        [ClothXPermissionAuthorize("FeatureGroups")]
        public IActionResult Create(int Id = 0)
        {
            try
            {
                ViewBag.Id = Id;
                if (Id != 0)
                {
                    FeatureGroup? feature = FeaturesUtility.Instance.FindFeatureGroup(Id);
                    return PartialView("FeatureGroupCreateEditPartialView", feature);
                }
                return PartialView("FeatureGroupCreateEditPartialView");
            }
            catch (Exception ex)
            {
                ErrorLogger.Instance.ErrorLoggingFunction(ex.Message, this.ToString());

                return RedirectToAction("ServerError", "Error");
            }

        }
        [HttpPost]
        [ClothXPermissionAuthorize("FeatureGroups")]
        public IActionResult Create(FeatureGroup model)
        {
            try
            {
                if (model.Id == 0)
                {
                    FeaturesUtility.Instance.AddFeatureGroup(model, User.Identity.Name);
                }
                else
                {
                    FeaturesUtility.Instance.EditFeatureGroup(model);
                }

                return RedirectToAction(nameof(Index));
            }
            catch (Exception ex)
            {
                ErrorLogger.Instance.ErrorLoggingFunction(ex.Message, this.ToString());

                return RedirectToAction("ServerError", "Error");
            }
        }



        [ClothXPermissionAuthorize("FeatureGroups")]
        public async Task<IActionResult> Delete(int? id)
        {
            try
            {
                if (id == null)
                {
                    return NotFound();
                }

                await FeaturesUtility.Instance.DeleteFeatureGroup(id);

                return RedirectToAction(nameof(Index));
            }
            catch (Exception ex)
            {
                ErrorLogger.Instance.ErrorLoggingFunction(ex.Message, this.ToString());

                return RedirectToAction("ServerError", "Error");
            }
        }

        [ClothXPermissionAuthorize("Feature")]
        public async Task<IActionResult> Details(int? id)
        {
            try
            {
                if (id == null)
                {
                    return NotFound();
                }
                var featureGroup = FeaturesUtility.Instance.FindFeatureGroup((int)id);
                if (featureGroup == null)
                {
                    return NotFound();
                }


                return View(featureGroup);
            }
            catch (Exception ex)
            {
                ErrorLogger.Instance.ErrorLoggingFunction(ex.Message, this.ToString());

                return RedirectToAction("ServerError", "Error");
            }
        }
        [HttpGet]
        [ClothXPermissionAuthorize("Feature")]
        public IActionResult CreateFeature(string Id = "")
        {
            try
            {
                var ids = Id.Split(".");
                ViewBag.FeatureGroupId = Convert.ToInt32(ids[0]);
                ViewBag.Id = ids.Length == 2 ? Convert.ToInt32(ids[1]) : 0;
                if (ids.Length == 2)
                {
                    if (ids[1] != "0")
                    {
                        Feature? feature = FeaturesUtility.Instance.FindFeature(Convert.ToInt32(ids[1]));
                        if (feature == null)
                        {
                            return NotFound();
                        }
                        return PartialView("FeatureCreateEditPartialView", feature);
                    }
                }

                return PartialView("FeatureCreateEditPartialView");
            }
            catch (Exception ex)
            {
                ErrorLogger.Instance.ErrorLoggingFunction(ex.Message, this.ToString());

                return RedirectToAction("ServerError", "Error");
            }
        }



        [ClothXPermissionAuthorize("Feature")]
        public IActionResult CreateFeature(Feature model)
        {
            try
            {
                if (model.Id == 0)
                {
                    FeaturesUtility.Instance.Addfeature(model, User.Identity.Name);
                }
                else
                {
                    FeaturesUtility.Instance.EditFeature(model);
                }

                return RedirectToAction(nameof(Details), new { id = model.FeatureGroupId });
            }
            catch (Exception ex)
            {
                ErrorLogger.Instance.ErrorLoggingFunction(ex.Message, this.ToString());

                return RedirectToAction("ServerError", "Error");
            }
        }



        [ClothXPermissionAuthorize("Feature")]
        public async Task<IActionResult> DeleteFeature(int? id)
        {
            try
            {
                if (id == null)
                {
                    return NotFound();
                }

                Feature? feature = await FeaturesUtility.Instance.DeleteFeature(id);

                return RedirectToAction(nameof(Details), new { id = feature.FeatureGroupId });
            }
            catch (Exception ex)
            {
                ErrorLogger.Instance.ErrorLoggingFunction(ex.Message, this.ToString());

                return RedirectToAction("ServerError", "Error");
            }
        }


    }
}
