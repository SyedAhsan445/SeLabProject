using ClothX.DbModels;

namespace ClothX.ViewModels
{
	public class TailorProjectViewModel
	{
		public int Id { get; set; }
		public string Title { get; set; } = null!;
		public string? Description { get; set; }
		public int ProductCategoryId { get; set; }
		public DateTime AddedOn { get; set; }
		public DateTime? UpdatedOn { get; set; }
		public string AddedBy { get; set; } = null!;
		public bool? IsActive { get; set; }
		public string? ImagePath { get; set; }

		public string CategoryName { get; set; } = null!;

		public IFormFile? image { get; set; }

		public IFormFileCollection? projectImages { get; set; }
		public virtual ICollection<TailorProjectImage> TailorProjectImages { get; set; }
	}
}
