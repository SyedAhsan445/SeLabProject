using System;
using System.Collections.Generic;

namespace ClothX.DbModels
{
    public partial class ProductCategory
    {
        public int Id { get; set; }
        public string Name { get; set; } = null!;
    }
}
