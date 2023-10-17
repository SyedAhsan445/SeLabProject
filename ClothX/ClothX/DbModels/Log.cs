using System;
using System.Collections.Generic;

namespace ClothX.DbModels
{
    public partial class Log
    {
        public int Id { get; set; }
        public DateTime? Date { get; set; }
        public string? Level { get; set; }
        public string? Message { get; set; }
        public string? Machinename { get; set; }
        public string? Logger { get; set; }
    }
}
