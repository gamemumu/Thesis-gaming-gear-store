//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ThesisGamingStore.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class PROMOTION
    {
        public PROMOTION()
        {
            this.PRODUCT = new HashSet<PRODUCT>();
        }
    
        public string ProMID { get; set; }
        public System.DateTime ProMStartDate { get; set; }
        public System.DateTime ProMEndDate { get; set; }
        public int Discount { get; set; }
        public string ProMEnabled { get; set; }
    
        public virtual ICollection<PRODUCT> PRODUCT { get; set; }
    }
}
