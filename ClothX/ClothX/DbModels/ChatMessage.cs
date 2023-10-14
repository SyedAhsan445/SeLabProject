using System;
using System.Collections.Generic;

namespace ClothX.DbModels
{
    public partial class ChatMessage
    {
        public int Id { get; set; }
        public string Message { get; set; } = null!;
        public int SentBy { get; set; }
        public int SentTo { get; set; }
        public bool? IsSeen { get; set; }
        public DateTime AddedOn { get; set; }
        public string AddedBy { get; set; } = null!;
        public DateTime? UpdatedOn { get; set; }
        public bool? IsActive { get; set; }

        public virtual UserProfile SentByNavigation { get; set; } = null!;
        public virtual UserProfile SentToNavigation { get; set; } = null!;
    }
}
