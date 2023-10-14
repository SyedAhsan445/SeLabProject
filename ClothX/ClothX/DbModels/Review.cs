using System;
using System.Collections.Generic;

namespace ClothX.DbModels
{
    public partial class Review
    {
        public Review()
        {
            ReviewResponses = new HashSet<ReviewResponse>();
        }

        public int Id { get; set; }
        public string Message { get; set; } = null!;
        public int TailorProjectId { get; set; }
        public int UserId { get; set; }
        public DateTime AddedOn { get; set; }
        public string AddedBy { get; set; } = null!;
        public bool? IsActive { get; set; }
        public DateTime? UpdatedOn { get; set; }

        public virtual TailorProject TailorProject { get; set; } = null!;
        public virtual UserProfile User { get; set; } = null!;
        public virtual ICollection<ReviewResponse> ReviewResponses { get; set; }
    }
}
