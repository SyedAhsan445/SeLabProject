using ClothX.Constants;
using ClothX.DbModels;
using System.Security.Claims;

namespace ClothX.Utility
{
	public class UserUtility
	{
		private static UserUtility _instance;

		public static UserUtility Instance
		{
			get
			{
				if (_instance == null)
					_instance = new UserUtility();
				return _instance;
			}
		}

		private UserUtility() { }

		public string GetLayout(ClaimsPrincipal? User)
		{
			string layout = "~/Views/Shared/_Layout.cshtml";
			//string dashboardLayout = "~/Views/Shared/_LayoutDashboard.cshtml";
			//if (User == null)
			//{
			//	return layout;
			//}
			//if (User.IsInRole(RoleType.Tailor.ToString()))
			//{
			//	return layout;
			//}

			return layout;
		}

		public bool HasAuthority(string permission, ClaimsPrincipal? User)
		{
			if (User != null)
			{
				if (User.IsInRole(RoleType.Tailor.ToString()))
				{
					return true;
				}
			}
			return false;
		}

		public int getUserProfileId(string username)
		{
			ClothXDbContext db = new ClothXDbContext();
			var dbUser = db.AspNetUsers.Where(x => x.UserName == username).FirstOrDefault();
			return dbUser.UserProfiles.FirstOrDefault().Id;
		}
	}
}
