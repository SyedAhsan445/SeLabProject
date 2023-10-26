using ClothX.DbModels;

namespace ClothX.ViewModels
{
	public class ClientOrderViewModel
	{
		public ClientOrderViewModel()
		{
			ClientOrderIdeaImages = new HashSet<ClientOrderIdeaImage>();
			OrderFeatures = new HashSet<OrderFeature>();
		}
		public int Id { get; set; }
		public string Title { get; set; } = null!;
		public string? Description { get; set; }
		public bool IsPaid { get; set; }
		public bool IsConfirmed { get; set; }
		public bool IsDelivered { get; set; }
		public int ClientId { get; set; }
		public string AddedBy { get; set; } = null!;
		public DateTime AddedOn { get; set; }
		public DateTime? UpdatedOn { get; set; }
		public bool? IsActive { get; set; }
		public string? Measurements { get; set; }
		public int OrderType { get; set; }
		public DateTime Deadline { get; set; }

		public IFormFileCollection? ideaImages { get; set; }

		public virtual UserProfile Client { get; set; } = null!;
		public virtual ICollection<ClientOrderIdeaImage> ClientOrderIdeaImages { get; set; }
		public virtual ICollection<OrderFeature> OrderFeatures { get; set; }
	}
}
