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
    
    public partial class RECEIVEORDER_DTA
    {
        public RECEIVEORDER_DTA()
        {
            this.PRODUCTLOT = new HashSet<PRODUCTLOT>();
        }
    
        public string RecOID { get; set; }
        public int RecONo { get; set; }
        public string OrdID { get; set; }
        public int OrdNo { get; set; }
        public int AmountRec { get; set; }
    
        public virtual ORDER_PRODUCT_DTA ORDER_PRODUCT_DTA { get; set; }
        public virtual ICollection<PRODUCTLOT> PRODUCTLOT { get; set; }
        public virtual RECEIVEORDER RECEIVEORDER { get; set; }
    }
}