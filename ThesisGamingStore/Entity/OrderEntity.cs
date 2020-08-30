using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ThesisGamingStore.Entity
{
    public class OrderEntity
    {
        public string OrdID { get; set; }
        public string SupID { get; set; }
        public string SupName { get; set; }
        public string EmpID { get; set; }
        public string EmpName { get; set; }
        public string OrdDate { get; set; }
        public decimal TotalCost { get; set; }
        public string OrdStatus { get; set; }
        public string OrdEnabled { get; set; }
    }
}