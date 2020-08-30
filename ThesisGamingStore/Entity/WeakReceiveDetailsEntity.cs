using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ThesisGamingStore.Entity
{
    public class WeakReceiveDetailsEntity
    {
        public string RecOID { get; set; }
        public string OrdID { get; set; }
        public string OrdNo { get; set; }
        public string OrdDate { get; set; }
        public string AmountRec { get; set; }
        public string EmpID { get; set; }
        public string EmpName { get; set; }
        public decimal TotalCost { get; set; }
        public string OrdStatus { get; set; }
        public string OrdEnabled { get; set; }
        public string OffID { get; set; }
        public int OfdNo { get; set; }
        public string PrdID { get; set; }
        // public int Amount { get; set; }
        public decimal Cost { get; set; }
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