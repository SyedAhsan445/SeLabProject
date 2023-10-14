using System;
using System.Collections.Generic;

namespace ClothX.DbModels
{
    public partial class Feature
    {
        public int Id { get; set; }
        public string Name { get; set; } = null!;
        public string Description { get; set; } = null!;
        public int FeatureGroupId { get; set; }
        public int Price { get; set; }

        public virtual FeatureGroup FeatureGroup { get; set; } = null!;
    }
}
