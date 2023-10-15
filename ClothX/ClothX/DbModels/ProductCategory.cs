using System;
using System.Collections.Generic;

namespace ClothX.DbModels
{
    public partial class ProductCategory
    {
        public ProductCategory()
        {
            TailorProjects = new HashSet<TailorProject>();
        }

        public int Id { get; set; }
        public string Name { get; set; } = null!;

        public virtual ICollection<TailorProject> TailorProjects { get; set; }
    }
}
