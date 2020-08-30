using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ThesisGamingStore.Entity
{
    public class OfferEntity
    {
      public string OffID {get; set;}
      public string EmpID {get; set;}
      public string EmpName { get; set; }
      public string SupID {get; set;}
      public string SupName { get; set; }
      public string OffDate { get; set; } 
      public string OffStatus {get; set;} 
      public string OffEnabled {get; set;}
      public string EmpApprove { get; set; }

    }
   
}