using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace ThesisGamingStore.Models
{
    public class _Payment
    {
        public string SlpID { get; set; }
        public string BnkAccNumber { get; set; }
        public int PayNo { get; set; }
        public System.DateTime PayDate { get; set; }
        public decimal PayPrice { get; set; }
        public string PayImg { get; set; }

        public virtual BANK BANK { get; set; }
        public virtual SELLPRODUCT SELLPRODUCT { get; set; }
        [DataType(DataType.ImageUrl)]
        public HttpPostedFileBase Photo { get; set; }
    }
}