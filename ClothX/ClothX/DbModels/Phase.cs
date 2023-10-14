using System;
using System.Collections.Generic;

namespace ClothX.DbModels
{
    public partial class Phase
    {
        public Phase()
        {
            InversePreviousPhase = new HashSet<Phase>();
            OrderPhases = new HashSet<OrderPhase>();
        }

        public int Id { get; set; }
        public string PhaseName { get; set; } = null!;
        public int? PreviousPhaseId { get; set; }

        public virtual Phase? PreviousPhase { get; set; }
        public virtual ICollection<Phase> InversePreviousPhase { get; set; }
        public virtual ICollection<OrderPhase> OrderPhases { get; set; }
    }
}
