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
    
    public partial class PRODUCTSUPPLIER
    {
        public string SupID { get; set; }
        public string PrdID { get; set; }
        public decimal Price { get; set; }
        public Nullable<System.DateTime> PsUpdate { get; set; }
    
        public virtual PRODUCT PRODUCT { get; set; }
        public virtual SUPPLIER SUPPLIER { get; set; }
    }
}