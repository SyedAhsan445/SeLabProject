using ClothX.CustomAttributes;
using ClothX.DbModels;
using ClothX.Services;
using ClothX.Utility;
using ClothX.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace ClothX.Controllers
{
    public class OrderController : Controller
    {
        private readonly IWebHostEnvironment _webHostEnvironment;

        public OrderController(IWebHostEnvironment webHostEnvironment)
        {
            _webHostEnvironment = webHostEnvironment;
        }
        [ClothXPermissionAuthorize("ClientOrders")]
        public IActionResult ClientOrders()
        {
            try
            {
                var orders = OrderUtility.Instance.getClientsOrders();
                orders = orders.Where(x => x.IsActive == true).ToList();
                ViewBag.IsMyOrders = false;
                return View(orders);
            }
            catch (Exception ex)
            {
                ErrorLogger.Instance.ErrorLoggingFunction(ex.Message, this.ToString());

                return RedirectToAction("ServerError", "Error");
            }
        }

        [ClothXPermissionAuthorize("MyOrders")]
        public IActionResult MyOrders()
        {
            try
            {
                var orders = OrderUtility.Instance.getClientsOrders(User.Identity.Name);
                ViewBag.IsMyOrders = true;
                return View(orders);
            }
            catch (Exception ex)
            {
                ErrorLogger.Instance.ErrorLoggingFunction(ex.Message, this.ToString());

                return RedirectToAction("ServerError", "Error");
            }
        }
        [Authorize]
        public IActionResult Preview(int Id)
        {
            try
            {
                ClothXDbContext db = new ClothXDbContext();
                var order = db.ClientOrders.Where(x => x.Id == Id).FirstOrDefault();
                return View(order);
            }
            catch (Exception ex)
            {
                ErrorLogger.Instance.ErrorLoggingFunction(ex.Message, this.ToString());

                return RedirectToAction("ServerError", "Error");
            }
        }


        [ClothXPermissionAuthorize("MyOrders")]
        public IActionResult PlaceOrder(int Order = 0)
        {
            try
            {
                ViewBag.OrderId = Order;
                ViewBag.ProjectCategory = DropdownUtility.Instance.TailorProjectCategoryDropdown(true);
                ViewBag.Features = FeaturesUtility.Instance.getFeatureGroups();
                ViewBag.OrderFeatures = new List<OrderFeature>();

                ClothXDbContext db = new ClothXDbContext();
                var dbUser = db.AspNetUsers.Where(x => x.UserName == User.Identity.Name).FirstOrDefault();

                var _user = dbUser.UserProfiles.FirstOrDefault();

                if (String.IsNullOrEmpty(_user.Address) || String.IsNullOrEmpty(_user.PhoneNumber))
                {
                    return RedirectToAction("Profile", "User");
                }

                var previousOrders = dbUser.UserProfiles.FirstOrDefault().ClientOrders;
                List<string> measurements = new List<string>();

                foreach (var o in previousOrders)
                {
                    measurements.Add(o.Measurements);
                }

                ViewBag.PreMeasurement = measurements;

                if (Order != 0)
                {
                    var order = OrderUtility.Instance.getViewModel(Order);
                    List<SelectListItem> categoryItems = DropdownUtility.Instance.TailorProjectCategoryDropdown(true);
                    foreach (var item in categoryItems)
                    {
                        if (item.Value == order.OrderType.ToString())
                        {
                            item.Selected = true;
                            break;
                        }
                    }
                    ViewBag.ProjectCategory = categoryItems;
                    ViewBag.OrderFeatures = order.OrderFeatures;
                    return View(order);
                }

                return View();
            }
            catch (Exception ex)
            {
                ErrorLogger.Instance.ErrorLoggingFunction(ex.Message, this.ToString());

                return RedirectToAction("ServerError", "Error");
            }
        }
        [HttpPost]
        [ClothXPermissionAuthorize("MyOrders")]
        public async Task<IActionResult> PlaceOrder(ClientOrderViewModel model, IFormCollection form)
        {
            try
            {
                if (model.Id == 0)
                {
                    await OrderUtility.Instance.AddClientOrder(model, User.Identity.Name, _webHostEnvironment, form);
                }
                else
                {
                    await OrderUtility.Instance.EditClientOrder(model, User.Identity.Name, _webHostEnvironment, form);
                }

                return RedirectToAction("MyOrders");
            }
            catch (Exception ex)
            {
                ErrorLogger.Instance.ErrorLoggingFunction(ex.Message, this.ToString());

                return RedirectToAction("ServerError", "Error");
            }
        }
        [ClothXPermissionAuthorize("MyOrders")]
        public async Task<IActionResult> Delete(int Order)
        {
            try
            {
                OrderUtility.Instance.CHangeOrderStatus(Order);
                return RedirectToAction("MyOrders");
            }
            catch (Exception ex)
            {
                ErrorLogger.Instance.ErrorLoggingFunction(ex.Message, this.ToString());

                return RedirectToAction("ServerError", "Error");
            }
        }
        // -1 for Payment Returning
        // 0 for Order Cancel
        // 1 for payment Confirmed
        // 2 for Order Confirmed(Started Working)
        // 3 for Order Delivered(Order Complated)
        [ClothXPermissionAuthorize("ClientOrders")]
        public async Task<IActionResult> ChangeOrderStatus(int Order, int Status)
        {
            try
            {
                ClothXDbContext db = new ClothXDbContext();
                var clientOrder = db.ClientOrders.Where(x => x.Id == Order).FirstOrDefault();
                if (Status == -1)
                {
                    clientOrder.IsPaid = false;
                    clientOrder.IsConfirmed = false;
                    clientOrder.IsDelivered = false;
                }
                else if (Status == 0)
                {
                    clientOrder.IsPaid = false;
                    clientOrder.IsConfirmed = false;
                    clientOrder.IsDelivered = false;
                    clientOrder.IsActive = false;
                }
                else if (Status == 1)
                {
                    clientOrder.IsPaid = true;
                }
                else if (Status == 2)
                {
                    clientOrder.IsConfirmed = true;
                }
                else if (Status == 3)
                {
                    clientOrder.IsDelivered = true;
                }
                clientOrder.UpdatedOn = DateTime.Now;

                db.ClientOrders.Update(clientOrder);
                db.SaveChanges();
                return RedirectToAction("ClientOrders");
            }
            catch (Exception ex)
            {
                ErrorLogger.Instance.ErrorLoggingFunction(ex.Message, this.ToString());

                return RedirectToAction("ServerError", "Error");
            }
        }
    }
}
