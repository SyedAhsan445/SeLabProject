﻿using System;
using System.Collections.Generic;

namespace ClothX.DbModels
{
    public partial class TailorProject
    {
        public TailorProject()
        {
            Reviews = new HashSet<Review>();
            TailorProjectImages = new HashSet<TailorProjectImage>();
        }

        public int Id { get; set; }
        public string Title { get; set; } = null!;
        public string? Description { get; set; }
        public int ProductCategoryId { get; set; }
        public DateTime AddedOn { get; set; }
        public DateTime? UpdatedOn { get; set; }
        public string AddedBy { get; set; } = null!;
        public bool? IsActive { get; set; }
        public string? ImagePath { get; set; }

        public virtual ICollection<Review> Reviews { get; set; }
        public virtual ICollection<TailorProjectImage> TailorProjectImages { get; set; }
    }
}
