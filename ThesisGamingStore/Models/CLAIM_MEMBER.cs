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
    
    public partial class CLAIM_MEMBER
    {
        public CLAIM_MEMBER()
        {
            this.CLAIM_MEMBER_DTA = new HashSet<CLAIM_MEMBER_DTA>();
        }
    
        public string MClmID { get; set; }
        public System.DateTime MClmDate { get; set; }
        public string MClmStatus { get; set; }
        public string EmpID { get; set; }
    
        public virtual ICollection<CLAIM_MEMBER_DTA> CLAIM_MEMBER_DTA { get; set; }
        public virtual EMPLOYEE EMPLOYEE { get; set; }
    }
}