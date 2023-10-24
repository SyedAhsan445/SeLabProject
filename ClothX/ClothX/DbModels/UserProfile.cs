using System;
using System.Collections.Generic;

namespace ClothX.DbModels
{
    public partial class UserProfile
    {
        public UserProfile()
        {
            ChatMessageSentByNavigations = new HashSet<ChatMessage>();
            ChatMessageSentToNavigations = new HashSet<ChatMessage>();
            ClientOrders = new HashSet<ClientOrder>();
            Reviews = new HashSet<Review>();
        }

        public int Id { get; set; }
        public string FirstName { get; set; } = null!;
        public string? LastName { get; set; }
        public int? Gender { get; set; }
        public string? Address { get; set; }
        public bool IsApproved { get; set; }
        public DateTime AddedOn { get; set; }
        public bool? IsActive { get; set; }
        public DateTime UpdatedOn { get; set; }
        public string UserId { get; set; } = null!;
        public string? ImagePath { get; set; }

        public virtual Lookup? GenderNavigation { get; set; }
        public virtual AspNetUser User { get; set; } = null!;
        public virtual ICollection<ChatMessage> ChatMessageSentByNavigations { get; set; }
        public virtual ICollection<ChatMessage> ChatMessageSentToNavigations { get; set; }
        public virtual ICollection<ClientOrder> ClientOrders { get; set; }
        public virtual ICollection<Review> Reviews { get; set; }
    }
}
