using ClothX.Constants;
using ClothX.DbModels;
using ClothX.Services;
using ClothX.ViewModels;

namespace ClothX.Utility
{
	public class OrderUtility
	{
		private static OrderUtility _instance;

		public static OrderUtility Instance
		{
			get
			{
				if (_instance == null)
					_instance = new OrderUtility();
				return _instance;
			}
		}

		private OrderUtility() { }

		public List<ClientOrder> getClientsOrders(string username = "")
		{
			ClothXDbContext db = new ClothXDbContext();
			var orders = db.ClientOrders.ToList();
			int userId = 0;
			if (username != "")
			{
				userId = UserUtility.Instance.getUserProfileId(username);
				orders = orders.Where(x => x.ClientId == userId).ToList();
			}
			return orders;
		}

		public ClientOrder getDbModel(ClientOrderViewModel model)
		{
			ClientOrder dbModel = new ClientOrder();
			dbModel.Title = model.Title;
			dbModel.Description = model.Description;
			dbModel.Measurements = model.Measurements;
			dbModel.OrderType = model.OrderType;
			dbModel.Price = 0;
			dbModel.Deadline = model.Deadline;
			return dbModel;
		}

		public ClientOrderViewModel getViewModel(int orderId)
		{
			ClothXDbContext db = new ClothXDbContext();
			var dbModel = db.ClientOrders.Where(x => x.Id == orderId).FirstOrDefault();

			ClientOrderViewModel model = new ClientOrderViewModel();
			model.Title = dbModel.Title;
			model.Description = dbModel.Description;
			model.Measurements = dbModel.Measurements;
			model.OrderType = dbModel.OrderType;
			model.OrderFeatures = dbModel.OrderFeatures;
			model.Deadline = dbModel.Deadline;
			model.ClientOrderIdeaImages = dbModel.ClientOrderIdeaImages;
			model.Price = dbModel.Price == null ? 0 : (int)dbModel.Price;
			model.Id = dbModel.Id;
			model.IsPaid = dbModel.IsPaid;
			model.IsConfirmed = dbModel.IsConfirmed;
			model.IsDelivered = dbModel.IsDelivered;
			model.ClientId = dbModel.ClientId;
			model.AddedBy = dbModel.AddedBy;
			model.AddedOn = dbModel.AddedOn;
			model.UpdatedOn = dbModel.UpdatedOn;
			model.IsActive = dbModel.IsActive;


			return model;
		}

		public async Task AddClientOrder(ClientOrderViewModel model, string username, IWebHostEnvironment webHost, IFormCollection form)
		{
			ClothXDbContext db = new ClothXDbContext();
			ClientOrder dbModel = getDbModel(model);
			int userId = UserUtility.Instance.getUserProfileId(username);
			dbModel.ClientId = userId;
			dbModel.AddedOn = DateTime.Now;
			dbModel.AddedBy = username;
			dbModel.UpdatedOn = DateTime.Now;
			dbModel.IsActive = true;
			dbModel.IsConfirmed = false;
			dbModel.IsDelivered = false;
			db.ClientOrders.Add(dbModel);
			db.SaveChanges();

			List<FilePathEnum> filepath = new()
			{
				FilePathEnum.Images,
				FilePathEnum.ProjectImages
			};

			if (model.ideaImages != null)
			{
				foreach (var s in model.ideaImages)
				{
					ClientOrderIdeaImage img = new ClientOrderIdeaImage();
					img.OrderId = dbModel.Id;
					img.ImagePath = await UploadFileService.Instance.UploadFile(s, filepath, webHost);

					await db.ClientOrderIdeaImages.AddAsync(img);
					await db.SaveChangesAsync();
				}
			}

			var features = FeaturesUtility.Instance.getFeatureGroups();

			int featuresPrice = 0;

			foreach (var fg in features)
			{
				if (!string.IsNullOrEmpty(form["Feature-" + fg.Id]))
				{
					int v = int.Parse(form["Feature-" + fg.Id]);

					OrderFeature of = new OrderFeature();
					of.OrderId = dbModel.Id;
					of.FeatureId = v;
					of.IsActive = true;
					db.OrderFeatures.Add(of);
					db.SaveChanges();


					featuresPrice += db.Features.Where(x => x.Id == v).FirstOrDefault().Price;
				}
			}

			dbModel.Price += db.ProductCategories.Where(x => x.Id == model.OrderType).FirstOrDefault().Price;
			dbModel.Price += featuresPrice;

			db.ClientOrders.Update(dbModel);
			db.SaveChanges();

		}

		public async Task EditClientOrder(ClientOrderViewModel model, string username, IWebHostEnvironment webHost, IFormCollection form)
		{
			ClothXDbContext db = new ClothXDbContext();
			ClientOrder clientOrder = db.ClientOrders.Where(x => x.Id == model.Id).FirstOrDefault();
			clientOrder.Title = model.Title;
			clientOrder.Description = model.Description;
			clientOrder.Measurements = model.Measurements;
			clientOrder.OrderType = model.OrderType;
			clientOrder.Deadline = model.Deadline;
			clientOrder.Price = 0;
			clientOrder.UpdatedOn = DateTime.Now;
			db.ClientOrders.Update(clientOrder);
			db.SaveChanges();

			List<FilePathEnum> filepath = new()
			{
				FilePathEnum.Images,
				FilePathEnum.ProjectImages
			};

			if (model.ideaImages != null)
			{
				foreach (var s in model.ideaImages)
				{
					ClientOrderIdeaImage img = new ClientOrderIdeaImage();
					img.OrderId = clientOrder.Id;
					img.ImagePath = await UploadFileService.Instance.UploadFile(s, filepath, webHost);

					await db.ClientOrderIdeaImages.AddAsync(img);
					await db.SaveChangesAsync();
				}
			}

			var features = FeaturesUtility.Instance.getFeatureGroups();

			int featuresPrice = 0;

			foreach (var of in clientOrder.OrderFeatures)
			{
				of.IsActive = false;
				db.OrderFeatures.Update(of);
				db.SaveChanges();
			}

			foreach (var fg in features)
			{
				if (!string.IsNullOrEmpty(form["Feature-" + fg.Id]))
				{
					int v = int.Parse(form["Feature-" + fg.Id]);

					if (clientOrder.OrderFeatures.Any(x => x.FeatureId == v))
					{
						var existingFeature = clientOrder.OrderFeatures.Where(x => x.FeatureId == v).FirstOrDefault();
						existingFeature.IsActive = true;
						db.OrderFeatures.Update(existingFeature);
						db.SaveChanges();
					}
					else
					{
						OrderFeature of = new OrderFeature();
						of.OrderId = clientOrder.Id;
						of.FeatureId = v;
						of.IsActive = true;
						db.OrderFeatures.Add(of);
						db.SaveChanges();
					}




					featuresPrice += db.Features.Where(x => x.Id == v).FirstOrDefault().Price;
				}
			}

			clientOrder.Price += db.ProductCategories.Where(x => x.Id == model.OrderType).FirstOrDefault().Price;
			clientOrder.Price += featuresPrice;

			db.ClientOrders.Update(clientOrder);
			db.SaveChanges();

		}

		public void CHangeOrderStatus(int OrderId)
		{
			ClothXDbContext db = new ClothXDbContext();
			var dbModel = db.ClientOrders.Where(x => x.Id == OrderId).FirstOrDefault();
			dbModel.IsActive = !dbModel.IsActive;
			dbModel.UpdatedOn = DateTime.Now;
			db.ClientOrders.Update(dbModel);
			db.SaveChanges();
		}
	}
}
