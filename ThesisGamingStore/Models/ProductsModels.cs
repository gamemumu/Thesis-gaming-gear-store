using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ThesisGamingStore.Models
{
    public class ProductModel
    {
        public IEnumerable<SelectListItem> _Types { get; set; }
        public IEnumerable<SelectListItem> _Trads { get; set; }
        public IEnumerable<SelectListItem> _Colors { get; set; }
        public IEnumerable<SelectListItem> _SerialStatus { get; set; }
        public string SerialStatus { get; set; }
        public string PrdID { get; set; }
        public string Description { get; set; }
        public int amount { get; set; }

        [RegularExpression(@"[0-9]*$", ErrorMessage = "Please enter a valid number ")]
        [DataType(DataType.PhoneNumber)]
        public int Waranty { get; set; }
        public string PrdEnabled { get; set; }
        public string Filepath { get; set; }
        public string PrdStatus { get; set; }
        public int ReorderPoint { get; set; }
        public decimal Price { get; set; }
        public decimal SellPrice { get; set; }
        public string PsUpdate { get; set; }
        //[Required]
        [Display(Name = "Photo")]
        [DataType(DataType.ImageUrl)]
        //[StringLength(1024)]
        public HttpPostedFileBase[] Photo { get; set; }

        // ค่าจากตารางอื่น เอาไว้ Map ตอนแสดงออกมาเป็น List
        public string TrdID { get; set; }   public string TrdName { get; set; }
        public string BrandID { get; set; }  public string BrandName { get; set; }
        public string ClrID { get; set; } public string ClrName { get; set; }
        public string TypeProductID { get; set; }  public string TypeName { get; set; }
        public string check { get; set; }
        public string SupID { get; set; }     public string SupName { get; set; }  public string SubAddress { get; set; }
    }
    public class ProductLotModel
    {
        public string LotID { get; set; }
        public string PrdID { get; set; }
        public int Amount { get; set; }
      //  public int ReorderPoint { get; set; }
        public decimal Cost { get; set; }
       // public decimal Price { get; set; }
        public DateTime OrderDate { get; set; } //System.DateTime.Now.ToShortDateString()
        public string LotEnabled { get; set; }

    }
    public class ColorModel
    {
        public string ClrID { get; set; }
        [Required]
        [Remote("doesColorNameExist", "Products", HttpMethod = "POST", ErrorMessage = "Color name already exists. Please enter a different color name.")]
        [Display(Name = "Color Name")]
        public string ClrName { get; set; }
        public string ClrEnabled { get; set; }
    }
    public class BrandModel
    {
        public string BrandID { get; set; }
        [Required]
        [Remote("doesBrandNameExist", "Products", HttpMethod = "POST", ErrorMessage = "Brand name already exists. Please enter a different brand name.")]
        [Display(Name = "Brand Name")]
        [Editable(true)]
        public string BrandName { get; set; }
        public string TrdID { get; set; }
        public string TrdName { get; set; }
        public string BrandEnabled { get; set; }

    }
    public class TypeproductModel
    {
        public string TypeProductID { get; set; }
        [Required]
        [Remote("doesTyeProductNameExist", "Products", HttpMethod = "POST", ErrorMessage = "Type of product name already exists. Please enter a different type of product name.")]
        [Display(Name = "Type of product Name")]
        public string TypeName { get; set; }
        public string TypeEnabled { get; set; }
    }
    public class TradmarkModel
    {
        public string TrdID { get; set; }
        [Required]
        [Remote("doesTradNameExist", "Products", HttpMethod = "POST", ErrorMessage = "Tradmark name already exists. Please enter a different tradmark name.")]
        [Display(Name = "Tradmak Name")]
        public string TrdName { get; set; }
        public string TrdEnabled { get; set; }
    }
    public class PhotoModel
    {
        public string PhotoID { get; set; }
        public string Photo { get; set; }
        [Required]
        [Remote("doesPhotoNameExist", "Products", HttpMethod = "POST", ErrorMessage = "Photo name already exists. Please enter a different photo name.")]
        [Display(Name = "Photo Name")]
        public string PhotoName { get; set; }
        public string PhotoEnabled { get; set; }
    }
    public class ProductSup
    {
        public string PrdID { get; set; }
        public string SupID { get; set; }
        public string Price { get; set; }
        public DateTime PsUpdate { get; set; }
    }
}