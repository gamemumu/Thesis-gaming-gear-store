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
    
    public partial class PRODUCT
    {
        public PRODUCT()
        {
            this.OFFERDETAIL = new HashSet<OFFERDETAIL>();
            this.PHOTO = new HashSet<PHOTO>();
            this.PRODUCTLOT = new HashSet<PRODUCTLOT>();
            this.PRODUCTSUPPLIER = new HashSet<PRODUCTSUPPLIER>();
            this.SELLPRODUCT_DTA = new HashSet<SELLPRODUCT_DTA>();
            this.PROMOTION = new HashSet<PROMOTION>();
        }
    
        public string PrdID { get; set; }
        public string Description { get; set; }
        public int Waranty { get; set; }
        public int ReorderPoint { get; set; }
        public decimal Price { get; set; }
        public string PrdStatus { get; set; }
        public string ClrID { get; set; }
        public string TypeProductID { get; set; }
        public string BrandID { get; set; }
        public string PrdEnabled { get; set; }
        public string SerialStatus { get; set; }
        public int StockQuantity { get; set; }
        public int TempStock { get; set; }
    
        public virtual BRAND BRAND { get; set; }
        public virtual COLOR COLOR { get; set; }
        public virtual ICollection<OFFERDETAIL> OFFERDETAIL { get; set; }
        public virtual ICollection<PHOTO> PHOTO { get; set; }
        public virtual TYPEPRODUCT TYPEPRODUCT { get; set; }
        public virtual ICollection<PRODUCTLOT> PRODUCTLOT { get; set; }
        public virtual ICollection<PRODUCTSUPPLIER> PRODUCTSUPPLIER { get; set; }
        public virtual ICollection<SELLPRODUCT_DTA> SELLPRODUCT_DTA { get; set; }
        public virtual ICollection<PROMOTION> PROMOTION { get; set; }
    }
}
