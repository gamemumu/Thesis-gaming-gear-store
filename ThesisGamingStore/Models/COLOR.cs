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
    
    public partial class COLOR
    {
        public COLOR()
        {
            this.PRODUCT = new HashSet<PRODUCT>();
        }
    
        public string ClrID { get; set; }
        public string ClrName { get; set; }
        public string ClrEnabled { get; set; }
    
        public virtual ICollection<PRODUCT> PRODUCT { get; set; }
    }
}
