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
    
    public partial class CLAIMORDER
    {
        public CLAIMORDER()
        {
            this.CLAIMORDER_DTA = new HashSet<CLAIMORDER_DTA>();
        }
    
        public string SupID { get; set; }
        public string EmpID { get; set; }
        public string ClmID { get; set; }
        public System.DateTime ClmDate { get; set; }
        public string ClmStatus { get; set; }
        public string ClmEnabeld { get; set; }
    
        public virtual ICollection<CLAIMORDER_DTA> CLAIMORDER_DTA { get; set; }
        public virtual EMPLOYEE EMPLOYEE { get; set; }
        public virtual SUPPLIER SUPPLIER { get; set; }
    }
}
