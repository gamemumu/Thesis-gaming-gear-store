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
    
    public partial class CLAIM_MEMBER_DTA
    {
        public CLAIM_MEMBER_DTA()
        {
            this.CLAIMORDER_DTA = new HashSet<CLAIMORDER_DTA>();
        }
    
        public string MClmID { get; set; }
        public string SlpID { get; set; }
        public int SlpNo { get; set; }
        public string SrlID { get; set; }
        public string PrdID { get; set; }
        public string LotNo { get; set; }
        public string MClmProp { get; set; }
    
        public virtual CLAIM_MEMBER CLAIM_MEMBER { get; set; }
        public virtual SELLPRODUCT_DTA_SERIA SELLPRODUCT_DTA_SERIA { get; set; }
        public virtual ICollection<CLAIMORDER_DTA> CLAIMORDER_DTA { get; set; }
    }
}
