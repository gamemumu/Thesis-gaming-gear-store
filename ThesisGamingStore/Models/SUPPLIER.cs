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
    
    public partial class SUPPLIER
    {
        public SUPPLIER()
        {
            this.CLAIMORDER = new HashSet<CLAIMORDER>();
            this.OFFER = new HashSet<OFFER>();
            this.ORDER_PRODUCT = new HashSet<ORDER_PRODUCT>();
            this.PRODUCTSUPPLIER = new HashSet<PRODUCTSUPPLIER>();
            this.SUPPLIER_PHONE = new HashSet<SUPPLIER_PHONE>();
        }
    
        public string SupID { get; set; }
        public string SupName { get; set; }
        public string SubAddress { get; set; }
        public string SubEnabled { get; set; }
    
        public virtual ICollection<CLAIMORDER> CLAIMORDER { get; set; }
        public virtual ICollection<OFFER> OFFER { get; set; }
        public virtual ICollection<ORDER_PRODUCT> ORDER_PRODUCT { get; set; }
        public virtual ICollection<PRODUCTSUPPLIER> PRODUCTSUPPLIER { get; set; }
        public virtual ICollection<SUPPLIER_PHONE> SUPPLIER_PHONE { get; set; }
    }
}
