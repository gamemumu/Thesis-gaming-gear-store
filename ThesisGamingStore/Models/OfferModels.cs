using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ThesisGamingStore.Models
{
    public class OfferModel
    {
        public string OffID { get; set; }
        public string EmpID { get; set; }
        public string EmpName { get; set; }
        public string SupID { get; set; }
        public string SupName { get; set; }
        public string OffDate { get; set; }
        public string OffStatus { get; set; }
        public string OffEnabled { get; set; }
        public string EmpApprove { get; set; }
    }
    public class OfferDetailModel
    {
        //public int OfdNo { get; set; }
        //public string OffID { get; set; }
        //public string PrdID { get; set; }
        //public Int16 AmountPost { get; set; }
        //public Int16 AmountApprove { get; set; }
        //public decimal Cost { get; set; }
        //public string OfdEnabled { get; set; }

        //// ค่าจากตารางอื่น เอาไว้ Map ตอนแสดงออกมาเป็น List
        //public string TrdID { get; set; }   public string TrdName { get; set; }
        //public string BrandID { get; set; }  public string BrandName { get; set; }
        //public string ClrID { get; set; } public string ClrName { get; set; }
        //public string TypeProductID { get; set; }  public string TypeName { get; set; }

        public int OfdNo { get; set; }
        public string OffID { get; set; }
        public string PrdID { get; set; }
        public int AmountPost { get; set; }
        public int AmountApprove { get; set; }
        public decimal Cost { get; set; }
        public string OfdEnabled {get; set;}

        // ค่าจากตารางอื่น เอาไว้ Map ตอนแสดงออกมาเป็น List
        public string TrdID { get; set; }   public string TrdName { get; set; }
        public string BrandID { get; set; }  public string BrandName { get; set; }
        public string ClrID { get; set; } public string ClrName { get; set; }
        public string TypeProductID { get; set; }  public string TypeName { get; set; }
        public string Description { get; set; }
        public int Waranty { get; set; }
        public string PrdEnabled { get; set; }
        public string SupID { get; set; }
        public string SupName { get; set; }
        public string SubAddress { get; set; }
    }
}