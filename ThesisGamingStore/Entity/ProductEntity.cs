using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ThesisGamingStore.Entity
{
    public class ProductEntity
    {
        public string SerialStatus { get; set; }
        public string PrdID { get; set; }
        public string Filepath { get; set; }
        public string Description { get; set; }
        public int Waranty { get; set; }
        public int ReorderPoint { get; set; }
        public string PrdStatus { get; set; }
        public decimal Price { get; set; }
        public decimal SellPrice { get; set; }
        public string PrdEnabled { get; set; }
        public string PsUpdate { get; set; }

        // ค่าจากตารางอื่น เอาไว้ Map ตอนแสดงออกมาเป็น List
        public string TrdID { get; set; }   public string TrdName { get; set; }
        public string BrandID { get; set; }  public string BrandName { get; set; }
        public string ClrID { get; set; } public string ClrName { get; set; }
        public string TypeProductID { get; set; }  public string TypeName { get; set; }
        public string SupID { get; set; }     public string SupName { get; set; }  public string SubAddress { get; set; }
        public int amount { get; set; }

    } 
    public class ProductLotEntity{
        public string LotID { get; set; }
        public string PrdID { get; set; }
        public int Amount { get; set; }
         public int ReorderPoint { get; set; }
        public decimal Cost { get; set; }
        public decimal Price { get; set; }
        public DateTime OrderDate { get; set; } //System.DateTime.Now.ToShortDateString()
        public string LotEnabled { get; set; }
        
    }
    public class ColorEntity
    {
        public string ClrID { get; set; }
        public string ClrName { get; set; }
        public string ClrEnabled { get; set; }
    }
    public class BrandEntity
    {
        public string BrandID { get; set; }
        public string BrandName { get; set; }
        public string TrdID { get; set; }
        public string TrdName { get; set; }
        public string BrandEnabled { get; set; }

    }
    public class TypeproductEntity
    {
        public string TypeProductID { get; set; }
        public string TypeName { get; set; }
        public string TypeEnabled { get; set; }
    }
    public class TradmarkEntity{
        public string TrdID { get; set; }
        public string TrdName { get; set; }
        public string TrdEnabled { get; set; }
    }
    public class PhotoEntity 
    {
        public int PhotoID { get; set; }
        public string  PrdID { get; set; }
        public string Photo { get; set; }
        public string PhotoEnabled { get; set; }
    }
}