using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ThesisGamingStore.Models
{
    public partial class SupplierModel
    {
        public SupplierModel()
        {
            this.Phones = new HashSet<SUPPLIER_PHONE>();
        }

        public string SupID { get; set; }
        [Required]
        [Remote("doesSupNameExist", "Supplier", HttpMethod = "POST", ErrorMessage = "Supplier name already exists. Please enter a different supplier name.")]
        [Display(Name = "Supplier name")]
        public string SupName { get; set; }

        [Display(Name = "Supplier Address ")]
        public string SubAddress { get; set; }
        public string SubEnabled { get; set; }

     
        public virtual ICollection<SUPPLIER_PHONE> Phones { get; set; }
        internal void CreatePhoneNumbers(int count = 1)
        {
            for (int i = 0; i < count; i++)
            {
                Phones.Add(new SUPPLIER_PHONE());
            }
        }
    }
}