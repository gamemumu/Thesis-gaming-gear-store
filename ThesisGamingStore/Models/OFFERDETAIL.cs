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
    
    public partial class OFFERDETAIL
    {
        public OFFERDETAIL()
        {
            this.ORDER_PRODUCT_DTA = new HashSet<ORDER_PRODUCT_DTA>();
        }
    
        public string OffID { get; set; }
        public int OfdNo { get; set; }
        public string PrdID { get; set; }
        public int AmountPost { get; set; }
        public int AmountApprove { get; set; }
        public decimal Cost { get; set; }
        public string OfdEnabled { get; set; }
    
        public virtual OFFER OFFER { get; set; }
        public virtual PRODUCT PRODUCT { get; set; }
        public virtual ICollection<ORDER_PRODUCT_DTA> ORDER_PRODUCT_DTA { get; set; }
    }
}
