using System;
using System.Collections.Generic;

namespace ClothX.DbModels
{
    public partial class OrderPhase
    {
        public int Id { get; set; }
        public int OrderId { get; set; }
        public int PhaseId { get; set; }
        public DateTime AddedOn { get; set; }
        public DateTime? UpdatedOn { get; set; }
        public string AddedBy { get; set; } = null!;

        public virtual ClientOrder Order { get; set; } = null!;
        public virtual Phase Phase { get; set; } = null!;
    }
}
