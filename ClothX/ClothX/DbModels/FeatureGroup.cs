using System;
using System.Collections.Generic;

namespace ClothX.DbModels
{
    public partial class FeatureGroup
    {
        public FeatureGroup()
        {
            Features = new HashSet<Feature>();
        }

        public int Id { get; set; }
        public string Name { get; set; } = null!;

        public virtual ICollection<Feature> Features { get; set; }
    }
}
