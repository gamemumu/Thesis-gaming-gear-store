using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ThesisGamingStore.DataAccess;
using ThesisGamingStore.DataAccess.Core;
using ThesisGamingStore.Models;

namespace ThesisGamingStore.Controllers
{
    public class ShippingController : Controller
    {
        //
        // GET: /Shipping/
        gamingstoreEntities db = new gamingstoreEntities();
        private ISellDao _sellRepository;
        public ShippingController() : this(new SqlSellProduct()) { }
        public ShippingController(SqlSellProduct _sellRepository)
        {
            this._sellRepository = _sellRepository;
        }
        #region View
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult AboutUs()
        {
            return View();
        }
        public ActionResult SolutionShipping()
        {
            return View();
        }
        public ActionResult SolutionPayMent()
        {
            return View();
        }
        public ActionResult Error404()
        {
            return View();
        }
        public ActionResult Cart()
        {
            if (Session["cart"] != null)
                return View();
            return View("Index", "Shipping");
        }
        public ActionResult CheckOut()
        {
            if (Session["MEmail"] == null && Session["MemID"] == null)
                return RedirectToAction("mLogin", "Member");
            else if (Session["cart"] != null) {
                var temp = Session["MemID"].ToString();
                var objUser = db.MEMBER.Where(m => m.MemID == temp).FirstOrDefault();
                Session["MFname"] = objUser.MFname;
                Session["MLname"] = objUser.MLname;
                Session["MAddress"] = objUser.MAddress;
                return View();
            }
            return RedirectToAction("Error404", "Shipping");
        }
        [HttpPost]
        public ActionResult CheckOut(string name,string lname,string address)
        {
            if (Session["MEmail"] != null && Session["MemID"] != null && Session["cart"] != null){
                SELLPRODUCT model = new SELLPRODUCT();
                decimal subtotal = 0;
                var memID = Session["MemID"].ToString();
                foreach (var item in (List<Item>)Session["cart"])
                {
                    var check = db.PRODUCT.Where(x => x.PrdID == item.Product.PrdID).FirstOrDefault().TempStock >= item.Quantity;
                    if (check)
                    {
                        model.SELLPRODUCT_DTA.Add(new SELLPRODUCT_DTA()
                        {
                            PrdID = item.Product.PrdID,
                            SpdAmount = item.Quantity
                            ,
                            SpdPrice = item.Product.Price - (item.Product.Price * (decimal.Parse(item.Discount) / 100))
                            ,
                            Discount = Int32.Parse(item.Discount)
                        });
                        subtotal += ((item.Product.Price - (item.Product.Price * (decimal.Parse(item.Discount) / 100))) * item.Quantity);
                    }
                    else
                    {
                        Session["cart"] = null;
                        return Json(new { success = false }, JsonRequestBehavior.AllowGet);
                    }
                }
                model.SlpSum = (subtotal + (subtotal*(decimal.Parse("0.07"))))+100;
                if (name.Length > 0 && lname.Length > 0 && address.Length > 0)
                {
                    model.FnameRec = name; model.LnameRec = lname; model.AdressRec = address;
                    model.MemID = memID; model.SlpDate = DateTime.Now;
                }
                else
                {
                    model.FnameRec = Session["MFname"].ToString(); model.LnameRec = Session["MLname"].ToString(); model.AdressRec = Session["MAddress"].ToString();
                    model.MemID = memID; model.SlpDate = DateTime.Now;
                }
                if (_sellRepository.InsertSellProduct(model)) {
                    Session["cart"] = null;
                    return Json(new { success = true }, JsonRequestBehavior.AllowGet);
                }
                return Json(new { success = false }, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Error404", "Shipping");
        }
        #endregion View

        #region manageCart
        private int isExisting(string id)
        {
            List<Item> cart = (List<Item>)Session["cart"];
            for (int i = 0; i < cart.Count; i++)
                if (cart[i].Product.PrdID == id)
                    return i;
            return -1;
        }
        public ActionResult AddtoCart(string id)
        {
            //ดึงข้อมูล โปรโมชั่น
            var promotion = db.PRODUCT
                .Where(x => x.PrdEnabled == "0" && x.PROMOTION.Count > 0 && x.PROMOTION.FirstOrDefault().ProMEndDate >= DateTime.Now && x.PROMOTION.FirstOrDefault().ProMStartDate <= DateTime.Now&& x.PrdID == id)
                .ToList();
             // .Where(x => x.PrdEnabled == "0" && x.PROMOTION.Count > 0 && x.PROMOTION.FirstOrDefault().ProMEndDate >= DateTime.Now && x.PrdID == id).ToList();
            //var QuntityInStock = db.PRODUCTLOT.Where(x => x.PrdID == id).GroupBy(p => new { p.Amount }).Select(g => new { g.Key.Amount }).ToList();
            var QuntityStock = Int32.Parse(db.PRODUCT.Where(p => p.PrdID == id).FirstOrDefault().TempStock.ToString());
            if (Session["cart"] == null)
            {
                List<Item> cart = new List<Item>();
                if (promotion.Count > 0)
                    cart.Add(new Item(db.PRODUCT.Find(id), 1, promotion.FirstOrDefault().PROMOTION.FirstOrDefault().Discount.ToString(), QuntityStock));
                else
                    cart.Add(new Item(db.PRODUCT.Find(id), 1, "0", QuntityStock));
                Session["cart"] = cart;
            }
            else
            {
                List<Item> cart = (List<Item>)Session["cart"];
                int index = isExisting(id);
                if (index == -1)
                {
                    if (promotion.Count > 0)
                        cart.Add(new Item(db.PRODUCT.Find(id), 1, promotion.FirstOrDefault().PROMOTION.FirstOrDefault().Discount.ToString(), QuntityStock));
                    else
                        cart.Add(new Item(db.PRODUCT.Find(id), 1, "0", QuntityStock));
                }
                else if (cart[index].QuntityInStock >= (cart[index].Quantity + 1))
                    cart[index].Quantity++;
                Session["cart"] = cart;
            }
            return PartialView("~/Views/Shipping/_CartMini.ascx", Session["cart"]);
        }
        public ActionResult DeleteCart(string id, string Status)
        {
            int index = isExisting(id);
            List<Item> cart = (List<Item>)Session["cart"];
            cart.RemoveAt(index);
            Session["cart"] = cart;
            if (cart.Count == 0)
            {
                Session["cart"] = null;
                return Json(false, JsonRequestBehavior.AllowGet);
            }
            if (Status.Equals("ConfirmCheckOut"))
                return PartialView("~/Views/Shipping/_CheckOut.ascx", Session["cart"]);
            return PartialView("~/Views/Shipping/_Cart.ascx", Session["cart"]);
        }
        public ActionResult Quantity(string id, bool flag,string Status)
        {
            // flag :true = Inc  and false = Dec
            if (Session["cart"] != null)
            {
                List<Item> cart = (List<Item>)Session["cart"];
                int index = isExisting(id);
                if (flag && cart[index].QuntityInStock >= (cart[index].Quantity +1))
                    cart[index].Quantity++;
                else
                {
                    if (cart[index].Quantity != 1 && flag != true)
                        cart[index].Quantity--;
                }
                Session["cart"] = cart;
            }
            if (Status.Equals("ConfirmCheckOut"))
                return PartialView("~/Views/Shipping/_CheckOut.ascx", Session["cart"]);
            return PartialView("~/Views/Shipping/_Cart.ascx", Session["cart"]);
        }
        public ActionResult getSessionCart(string Status)
        {
            if (Session["cart"] != null) 
            {
                List<Item> cart = (List<Item>)Session["cart"];
                Session["cart"] = cart;
            }
            if (Status.Equals("ConfirmCheckOut"))
                return PartialView("~/Views/Shipping/_CheckOut.ascx", Session["cart"]);
            return PartialView("~/Views/Shipping/_Cart.ascx", Session["cart"]);
        }
        public ActionResult ClearCart()
        {
            Session["cart"] = null;
            return PartialView("~/Views/Shipping/_CartMini.ascx", Session["cart"]);
        }
        public ActionResult JsonFeaturesItems()
        {
            //เช็คจำนวนสินค้าใน Lot
            var lot = db.PRODUCTLOT
                  .GroupBy(pl => new { pl.PrdID })
                  .Select(g => new { g.Key.PrdID, Amount = g.Sum(s => s.Amount) })
                .ToList();
            var lot_id = lot.Select(l => l.PrdID).ToList();

            //ดึงข้อมูล โปรโมชั่น
            var promotion = db.PRODUCT
              .Where(x => x.PrdEnabled == "0" && x.PROMOTION.Count > 0 && x.PROMOTION.FirstOrDefault().ProMEndDate >= DateTime.Now && x.PROMOTION.FirstOrDefault().ProMStartDate <= DateTime.Now)
              .Select(g => new
              {
                  g.BRAND.TRADEMARK.TrdName,
                  g.BRAND.BrandID,
                  g.BRAND.BrandName,
                  g.PrdID,
                  g.Price,
                  g.PHOTO.FirstOrDefault().Photo1,
                  g.PROMOTION.FirstOrDefault().Discount,
                  g.PROMOTION.FirstOrDefault().ProMID,
                  g.TempStock,
            //      Status = lot_id.Contains(g.PrdID) ? true : false,
                  Status = g.TempStock > 0 ? true : false,
              })
             // .Take(6)
              .ToList();

            //ดึงข้อมูลสินค้า ขายดี กับสินค้าใหม่
            var Prd_pro = promotion.Select(x => x.PrdID).ToList(); // เอาไว้เช็ค ไอดีสินค้า ไม่ให้ตรงกับสินค้าที่มีโปรโมชั่นแล้ว
            var result = (from tr in db.TRADEMARK
                          join b in db.BRAND on tr.TrdID equals b.TrdID
                          join pd in db.PRODUCT on b.BrandID equals pd.BrandID
                          join ph in db.PHOTO on pd.PrdID equals ph.PrdID
                          where (pd.PrdStatus.Equals("สินค้าใหม่") || pd.PrdStatus.Equals("สินค้าขายดี")) && ph.PhotoID == 1 && pd.PrdEnabled.Equals("0")
                          && !Prd_pro.Contains(pd.PrdID)
                          orderby pd.PrdStatus
                          select new
                          {
                              tr.TrdName,
                              b.BrandName,
                              pd.PrdID,
                              pd.Price,
                              pd.PrdStatus,
                              ph.Photo1,
                              pd.TempStock,
                          //    Status = lot_id.Contains(pd.PrdID) ? true : false
                              Status = pd.TempStock > 0 ? true : false,
                          })
        //                  .Take(12 - promotion.Count())
                          .ToList();

            var recommended = (from tr in db.TRADEMARK
                               join b in db.BRAND on tr.TrdID equals b.TrdID
                               join pd in db.PRODUCT on b.BrandID equals pd.BrandID
                               join ph in db.PHOTO on pd.PrdID equals ph.PrdID
                               where (pd.PrdStatus.Equals("สินค้าแนะนำ")) && ph.PhotoID == 1 && pd.PrdEnabled.Equals("0") && !Prd_pro.Contains(pd.PrdID)
                               orderby pd.PrdID
                               select new
                               {
                                   tr.TrdName,
                                   b.BrandName,
                                   pd.PrdID,
                                   pd.Price,
                                   pd.PrdStatus,
                                   ph.Photo1,
                                   pd.TempStock,
                                //   Status = lot_id.Contains(pd.PrdID) ? true : false
                                   Status = pd.TempStock > 0 ? true : false,
                               }).ToList();

            var genericResult = new { Results = result, Promotion = promotion, Recommended = recommended };
            return Json(genericResult, JsonRequestBehavior.AllowGet);

        }
        //public ActionResult JsonRecommendedItems()
        //{
        //    //เช็คจำนวนสินค้าใน Lot
        //    var lot = db.PRODUCTLOT
        //          .GroupBy(pl => new { pl.PrdID })
        //          .Select(g => new { g.Key.PrdID, Amount = g.Sum(s => s.Amount) })
        //        .ToList();
        //    var lot_id = lot.Select(l => l.PrdID).ToList();
        //    //ดึงข้อมูล โปรโมชั่น
        //    var promotion = db.PRODUCT
        //      .Where(x => x.PrdEnabled == "0" && x.PROMOTION.Count > 0 && x.PROMOTION.FirstOrDefault().ProMEndDate >= DateTime.Now)
        //      .Select(g => new
        //      {
        //          g.BRAND.TRADEMARK.TrdName,
        //          g.BRAND.BrandID,
        //          g.BRAND.BrandName,
        //          g.PrdID,
        //          g.Price,
        //          g.PHOTO.FirstOrDefault().Photo1,
        //          g.PROMOTION.FirstOrDefault().Discount,
        //          g.PROMOTION.FirstOrDefault().ProMID,
        //          Status = lot_id.Contains(g.PrdID) ? true : false
        //      }).ToList();
        //    var Prd_pro = promotion.Select(x => x.PrdID).ToList();
        //    return Json(null, JsonRequestBehavior.AllowGet);
        //}
        public ActionResult JsonCategory()
        {
            var result = (from p in db.PRODUCT
                          join b in db.BRAND on p.BrandID equals b.BrandID
                          join tr in db.TRADEMARK on b.TrdID equals tr.TrdID
                          join ty in db.TYPEPRODUCT on p.TypeProductID equals ty.TypeProductID
                          where ty.TypeEnabled.Equals("0")
                          group ty by new { ty.TypeProductID, ty.TypeName, tr.TrdName, tr.TrdID } into _ty
                          orderby _ty.Key.TypeName ascending
                          select new
                          {
                              _ty.Key.TypeProductID,
                              _ty.Key.TypeName,
                              _ty.Key.TrdID,
                              _ty.Key.TrdName
                          }).ToList();
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult JsonBrand()
        {
            var result = db.PRODUCT
                .Where(x => x.PrdEnabled == "0")
                .GroupBy(p => new { p.BRAND.TRADEMARK.TrdName,p.BRAND.TrdID })
                .Select(g => new { g.Key.TrdID, g.Key.TrdName, Count = g.Count() })
                .ToList();
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult JsonDataType(string TypeProductID,string TrdID)
        {
            //เช็คจำนวนสินค้าใน Lot
            var lot = db.PRODUCTLOT
                  .GroupBy(pl => new { pl.PrdID })
                  .Select(g => new { g.Key.PrdID, Amount = g.Sum(s => s.Amount) })
                .ToList();
            var lot_id = lot.Select(l => l.PrdID).ToList();

            //ดึงข้อมูล โปรโมชั่น
            var promotion = db.PRODUCT
             // .Where(x => x.PrdEnabled == "0" && x.PROMOTION.Count > 0 && x.PROMOTION.FirstOrDefault().ProMEndDate >= DateTime.Now
             .Where(x => x.PrdEnabled == "0" && x.PROMOTION.Count > 0 && x.PROMOTION.FirstOrDefault().ProMEndDate >= DateTime.Now && x.PROMOTION.FirstOrDefault().ProMStartDate <= DateTime.Now
              && x.BRAND.TrdID == TrdID && x.TypeProductID == TypeProductID)
              .Select(g => new
              {
                  g.BRAND.TRADEMARK.TrdName,
                  g.BRAND.BrandID,
                  g.BRAND.BrandName,
                  g.PrdID,
                  g.Price,
                  g.PHOTO.FirstOrDefault().Photo1,
                  g.PROMOTION.FirstOrDefault().Discount,
                  g.PROMOTION.FirstOrDefault().ProMID,
                  g.TempStock,
                  //      Status = lot_id.Contains(g.PrdID) ? true : false,
                  Status = g.TempStock > 0 ? true : false,
              })
                // .Take(6)
              .ToList();

            //ดึงข้อมูลสินค้า ขายดี กับสินค้าใหม่
            var Prd_pro = promotion.Select(x => x.PrdID).ToList(); // เอาไว้เช็ค ไอดีสินค้า ไม่ให้ตรงกับสินค้าที่มีโปรโมชั่นแล้ว
            var result = (from tr in db.TRADEMARK
                          join b in db.BRAND on tr.TrdID equals b.TrdID
                          join pd in db.PRODUCT on b.BrandID equals pd.BrandID
                          join ph in db.PHOTO on pd.PrdID equals ph.PrdID
                          where (pd.PrdStatus.Equals("สินค้าใหม่") || pd.PrdStatus.Equals("สินค้าขายดี")) && ph.PhotoID == 1 && pd.PrdEnabled.Equals("0")
                          && !Prd_pro.Contains(pd.PrdID) && pd.BRAND.TrdID == TrdID && pd.TypeProductID == TypeProductID
                          orderby pd.PrdStatus
                          select new
                          {
                              tr.TrdName,
                              b.BrandName,
                              pd.PrdID,
                              pd.Price,
                              pd.PrdStatus,
                              ph.Photo1,
                              pd.TempStock,
                              Status = pd.TempStock > 0 ? true : false,
                          })
                          .ToList();
            var Oldresult = (from tr in db.TRADEMARK
                             join b in db.BRAND on tr.TrdID equals b.TrdID
                             join pd in db.PRODUCT on b.BrandID equals pd.BrandID
                             join ph in db.PHOTO on pd.PrdID equals ph.PrdID
                             where (pd.PrdStatus.Equals("สินค้าเก่า") || pd.PrdStatus.Equals("สินค้าแนะนำ")) && ph.PhotoID == 1 && pd.PrdEnabled.Equals("0")
                             && !Prd_pro.Contains(pd.PrdID) && pd.BRAND.TrdID == TrdID && pd.TypeProductID == TypeProductID
                             orderby pd.PrdStatus
                             select new
                             {
                                 tr.TrdName,
                                 b.BrandName,
                                 pd.PrdID,
                                 pd.Price,
                                 pd.PrdStatus,
                                 ph.Photo1,
                                 pd.TempStock,
                                 Status = pd.TempStock > 0 ? true : false,
                             })
                          .ToList();
            var genericResult = new { Results = result, Promotion = promotion, Oldresult = Oldresult };
            return Json(genericResult, JsonRequestBehavior.AllowGet);

        }
        public ActionResult JsonDataBrand(string TrdID)
        {
            //เช็คจำนวนสินค้าใน Lot
            var lot = db.PRODUCTLOT
                  .GroupBy(pl => new { pl.PrdID })
                  .Select(g => new { g.Key.PrdID, Amount = g.Sum(s => s.Amount) })
                .ToList();
            var lot_id = lot.Select(l => l.PrdID).ToList();

            //ดึงข้อมูล โปรโมชั่น
            var promotion = db.PRODUCT
             // .Where(x => x.PrdEnabled == "0" && x.PROMOTION.Count > 0 && x.PROMOTION.FirstOrDefault().ProMEndDate >= DateTime.Now
              .Where(x => x.PrdEnabled == "0" && x.PROMOTION.Count > 0 && x.PROMOTION.FirstOrDefault().ProMEndDate >= DateTime.Now && x.PROMOTION.FirstOrDefault().ProMStartDate <= DateTime.Now
              && x.BRAND.TrdID == TrdID)
              .Select(g => new
              {
                  g.BRAND.TRADEMARK.TrdName,
                  g.BRAND.BrandID,
                  g.BRAND.BrandName,
                  g.PrdID,
                  g.Price,
                  g.PHOTO.FirstOrDefault().Photo1,
                  g.PROMOTION.FirstOrDefault().Discount,
                  g.PROMOTION.FirstOrDefault().ProMID,
                  g.TempStock,
                  //      Status = lot_id.Contains(g.PrdID) ? true : false,
                  Status = g.TempStock > 0 ? true : false,
              })
                // .Take(6)
              .ToList();

            //ดึงข้อมูลสินค้า ขายดี กับสินค้าใหม่
            var Prd_pro = promotion.Select(x => x.PrdID).ToList(); // เอาไว้เช็ค ไอดีสินค้า ไม่ให้ตรงกับสินค้าที่มีโปรโมชั่นแล้ว
            var result = (from tr in db.TRADEMARK
                          join b in db.BRAND on tr.TrdID equals b.TrdID
                          join pd in db.PRODUCT on b.BrandID equals pd.BrandID
                          join ph in db.PHOTO on pd.PrdID equals ph.PrdID
                          where (pd.PrdStatus.Equals("สินค้าใหม่") || pd.PrdStatus.Equals("สินค้าขายดี")) && ph.PhotoID == 1 && pd.PrdEnabled.Equals("0")
                          && !Prd_pro.Contains(pd.PrdID) && pd.BRAND.TrdID == TrdID
                          orderby pd.PrdStatus
                          select new
                          {
                              tr.TrdName,
                              b.BrandName,
                              pd.PrdID,
                              pd.Price,
                              pd.PrdStatus,
                              ph.Photo1,
                              pd.TempStock,
                              Status = pd.TempStock > 0 ? true : false,
                          })
                          .ToList();
            var Oldresult = (from tr in db.TRADEMARK
                          join b in db.BRAND on tr.TrdID equals b.TrdID
                          join pd in db.PRODUCT on b.BrandID equals pd.BrandID
                          join ph in db.PHOTO on pd.PrdID equals ph.PrdID
                          where (pd.PrdStatus.Equals("สินค้าเก่า") || pd.PrdStatus.Equals("สินค้าแนะนำ")) && ph.PhotoID == 1 && pd.PrdEnabled.Equals("0")
                          && !Prd_pro.Contains(pd.PrdID) && pd.BRAND.TrdID == TrdID
                          orderby pd.PrdStatus
                          select new
                          {
                              tr.TrdName,
                              b.BrandName,
                              pd.PrdID,
                              pd.Price,
                              pd.PrdStatus,
                              ph.Photo1,
                              pd.TempStock,
                              Status = pd.TempStock > 0 ? true : false,
                          })
                          .ToList();
            var genericResult = new { Results = result, Promotion = promotion, Oldresult = Oldresult };
            return Json(genericResult, JsonRequestBehavior.AllowGet);
        }
        public JsonResult JsonCartCount()
        {
            if (Session["cart"] == null)
            {
                return Json(0, JsonRequestBehavior.AllowGet);
            }
            else
            {
                List<Item> cart = (List<Item>)Session["cart"];
                return Json(cart.Count, JsonRequestBehavior.AllowGet);
            }
        }
        #endregion manageCart

        #region Search
        public ActionResult JsonSearchType(string Name)
        {
            //เช็คจำนวนสินค้าใน Lot
            var lot = db.PRODUCTLOT
                  .GroupBy(pl => new { pl.PrdID })
                  .Select(g => new { g.Key.PrdID, Amount = g.Sum(s => s.Amount) })
                .ToList();
            var lot_id = lot.Select(l => l.PrdID).ToList();

            //ดึงข้อมูล โปรโมชั่น
            var promotion = db.PRODUCT
                // .Where(x => x.PrdEnabled == "0" && x.PROMOTION.Count > 0 && x.PROMOTION.FirstOrDefault().ProMEndDate >= DateTime.Now
             .Where(x => x.PrdEnabled == "0" && x.PROMOTION.Count > 0 && x.PROMOTION.FirstOrDefault().ProMEndDate >= DateTime.Now && x.PROMOTION.FirstOrDefault().ProMStartDate <= DateTime.Now
              && x.TYPEPRODUCT.TypeName.Contains(Name))
              .Select(g => new
              {
                  g.BRAND.TRADEMARK.TrdName,
                  g.BRAND.BrandID,
                  g.BRAND.BrandName,
                  g.PrdID,
                  g.Price,
                  g.PHOTO.FirstOrDefault().Photo1,
                  g.PROMOTION.FirstOrDefault().Discount,
                  g.PROMOTION.FirstOrDefault().ProMID,
                  g.TempStock,
                  //      Status = lot_id.Contains(g.PrdID) ? true : false,
                  Status = g.TempStock > 0 ? true : false,
              })
                // .Take(6)
              .ToList();

            //ดึงข้อมูลสินค้า ขายดี กับสินค้าใหม่
            var Prd_pro = promotion.Select(x => x.PrdID).ToList(); // เอาไว้เช็ค ไอดีสินค้า ไม่ให้ตรงกับสินค้าที่มีโปรโมชั่นแล้ว
            var result = (from tr in db.TRADEMARK
                          join b in db.BRAND on tr.TrdID equals b.TrdID
                          join pd in db.PRODUCT on b.BrandID equals pd.BrandID
                          join ph in db.PHOTO on pd.PrdID equals ph.PrdID
                          where (pd.PrdStatus.Equals("สินค้าใหม่") || pd.PrdStatus.Equals("สินค้าขายดี")) && ph.PhotoID == 1 && pd.PrdEnabled.Equals("0")
                          && !Prd_pro.Contains(pd.PrdID) && pd.TYPEPRODUCT.TypeName.Contains(Name)
                          orderby pd.PrdStatus
                          select new
                          {
                              tr.TrdName,
                              b.BrandName,
                              pd.PrdID,
                              pd.Price,
                              pd.PrdStatus,
                              ph.Photo1,
                              pd.TempStock,
                              Status = pd.TempStock > 0 ? true : false,
                          })
                          .ToList();
            var Oldresult = (from tr in db.TRADEMARK
                             join b in db.BRAND on tr.TrdID equals b.TrdID
                             join pd in db.PRODUCT on b.BrandID equals pd.BrandID
                             join ph in db.PHOTO on pd.PrdID equals ph.PrdID
                             where (pd.PrdStatus.Equals("สินค้าเก่า") || pd.PrdStatus.Equals("สินค้าแนะนำ")) && ph.PhotoID == 1 && pd.PrdEnabled.Equals("0")
                             && !Prd_pro.Contains(pd.PrdID) && pd.TYPEPRODUCT.TypeName.Contains(Name)
                             orderby pd.PrdStatus
                             select new
                             {
                                 tr.TrdName,
                                 b.BrandName,
                                 pd.PrdID,
                                 pd.Price,
                                 pd.PrdStatus,
                                 ph.Photo1,
                                 pd.TempStock,
                                 Status = pd.TempStock > 0 ? true : false,
                             })
                          .ToList();
            var genericResult = new { Results = result, Promotion = promotion, Oldresult = Oldresult };
            return Json(genericResult, JsonRequestBehavior.AllowGet);

        }

        public ActionResult JsonSearchTrd(string Name)
        {
            //เช็คจำนวนสินค้าใน Lot
            var lot = db.PRODUCTLOT
                  .GroupBy(pl => new { pl.PrdID })
                  .Select(g => new { g.Key.PrdID, Amount = g.Sum(s => s.Amount) })
                .ToList();
            var lot_id = lot.Select(l => l.PrdID).ToList();

            //ดึงข้อมูล โปรโมชั่น
            var promotion = db.PRODUCT
                // .Where(x => x.PrdEnabled == "0" && x.PROMOTION.Count > 0 && x.PROMOTION.FirstOrDefault().ProMEndDate >= DateTime.Now
             .Where(x => x.PrdEnabled == "0" && x.PROMOTION.Count > 0 && x.PROMOTION.FirstOrDefault().ProMEndDate >= DateTime.Now && x.PROMOTION.FirstOrDefault().ProMStartDate <= DateTime.Now
              && x.BRAND.TRADEMARK.TrdName.Contains(Name))
              .Select(g => new
              {
                  g.BRAND.TRADEMARK.TrdName,
                  g.BRAND.BrandID,
                  g.BRAND.BrandName,
                  g.PrdID,
                  g.Price,
                  g.PHOTO.FirstOrDefault().Photo1,
                  g.PROMOTION.FirstOrDefault().Discount,
                  g.PROMOTION.FirstOrDefault().ProMID,
                  g.TempStock,
                  //      Status = lot_id.Contains(g.PrdID) ? true : false,
                  Status = g.TempStock > 0 ? true : false,
              })
                // .Take(6)
              .ToList();

            //ดึงข้อมูลสินค้า ขายดี กับสินค้าใหม่
            var Prd_pro = promotion.Select(x => x.PrdID).ToList(); // เอาไว้เช็ค ไอดีสินค้า ไม่ให้ตรงกับสินค้าที่มีโปรโมชั่นแล้ว
            var result = (from tr in db.TRADEMARK
                          join b in db.BRAND on tr.TrdID equals b.TrdID
                          join pd in db.PRODUCT on b.BrandID equals pd.BrandID
                          join ph in db.PHOTO on pd.PrdID equals ph.PrdID
                          where (pd.PrdStatus.Equals("สินค้าใหม่") || pd.PrdStatus.Equals("สินค้าขายดี")) && ph.PhotoID == 1 && pd.PrdEnabled.Equals("0")
                          && !Prd_pro.Contains(pd.PrdID) && pd.BRAND.TRADEMARK.TrdName.Contains(Name)
                          orderby pd.PrdStatus
                          select new
                          {
                              tr.TrdName,
                              b.BrandName,
                              pd.PrdID,
                              pd.Price,
                              pd.PrdStatus,
                              ph.Photo1,
                              pd.TempStock,
                              Status = pd.TempStock > 0 ? true : false,
                          })
                          .ToList();
            var Oldresult = (from tr in db.TRADEMARK
                             join b in db.BRAND on tr.TrdID equals b.TrdID
                             join pd in db.PRODUCT on b.BrandID equals pd.BrandID
                             join ph in db.PHOTO on pd.PrdID equals ph.PrdID
                             where (pd.PrdStatus.Equals("สินค้าเก่า") || pd.PrdStatus.Equals("สินค้าแนะนำ")) && ph.PhotoID == 1 && pd.PrdEnabled.Equals("0")
                             && !Prd_pro.Contains(pd.PrdID) && pd.BRAND.TRADEMARK.TrdName.Contains(Name)
                             orderby pd.PrdStatus
                             select new
                             {
                                 tr.TrdName,
                                 b.BrandName,
                                 pd.PrdID,
                                 pd.Price,
                                 pd.PrdStatus,
                                 ph.Photo1,
                                 pd.TempStock,
                                 Status = pd.TempStock > 0 ? true : false,
                             })
                          .ToList();
            var genericResult = new { Results = result, Promotion = promotion, Oldresult = Oldresult };
            return Json(genericResult, JsonRequestBehavior.AllowGet);
        }
        public ActionResult JsonSearchBrand(string Name)
        {
            //เช็คจำนวนสินค้าใน Lot
            var lot = db.PRODUCTLOT
                  .GroupBy(pl => new { pl.PrdID })
                  .Select(g => new { g.Key.PrdID, Amount = g.Sum(s => s.Amount) })
                .ToList();
            var lot_id = lot.Select(l => l.PrdID).ToList();

            //ดึงข้อมูล โปรโมชั่น
            var promotion = db.PRODUCT
                // .Where(x => x.PrdEnabled == "0" && x.PROMOTION.Count > 0 && x.PROMOTION.FirstOrDefault().ProMEndDate >= DateTime.Now
              .Where(x => x.PrdEnabled == "0" && x.PROMOTION.Count > 0 && x.PROMOTION.FirstOrDefault().ProMEndDate >= DateTime.Now && x.PROMOTION.FirstOrDefault().ProMStartDate <= DateTime.Now
              && x.BRAND.BrandName.Contains(Name))
              .Select(g => new
              {
                  g.BRAND.TRADEMARK.TrdName,
                  g.BRAND.BrandID,
                  g.BRAND.BrandName,
                  g.PrdID,
                  g.Price,
                  g.PHOTO.FirstOrDefault().Photo1,
                  g.PROMOTION.FirstOrDefault().Discount,
                  g.PROMOTION.FirstOrDefault().ProMID,
                  g.TempStock,
                  //      Status = lot_id.Contains(g.PrdID) ? true : false,
                  Status = g.TempStock > 0 ? true : false,
              })
                // .Take(6)
              .ToList();

            //ดึงข้อมูลสินค้า ขายดี กับสินค้าใหม่
            var Prd_pro = promotion.Select(x => x.PrdID).ToList(); // เอาไว้เช็ค ไอดีสินค้า ไม่ให้ตรงกับสินค้าที่มีโปรโมชั่นแล้ว
            var result = (from tr in db.TRADEMARK
                          join b in db.BRAND on tr.TrdID equals b.TrdID
                          join pd in db.PRODUCT on b.BrandID equals pd.BrandID
                          join ph in db.PHOTO on pd.PrdID equals ph.PrdID
                          where (pd.PrdStatus.Equals("สินค้าใหม่") || pd.PrdStatus.Equals("สินค้าขายดี")) && ph.PhotoID == 1 && pd.PrdEnabled.Equals("0")
                          && !Prd_pro.Contains(pd.PrdID) && pd.BRAND.BrandName.Contains(Name)
                          orderby pd.PrdStatus
                          select new
                          {
                              tr.TrdName,
                              b.BrandName,
                              pd.PrdID,
                              pd.Price,
                              pd.PrdStatus,
                              ph.Photo1,
                              pd.TempStock,
                              Status = pd.TempStock > 0 ? true : false,
                          })
                          .ToList();
            var Oldresult = (from tr in db.TRADEMARK
                             join b in db.BRAND on tr.TrdID equals b.TrdID
                             join pd in db.PRODUCT on b.BrandID equals pd.BrandID
                             join ph in db.PHOTO on pd.PrdID equals ph.PrdID
                             where (pd.PrdStatus.Equals("สินค้าเก่า") || pd.PrdStatus.Equals("สินค้าแนะนำ")) && ph.PhotoID == 1 && pd.PrdEnabled.Equals("0")
                             && !Prd_pro.Contains(pd.PrdID) && pd.BRAND.BrandName.Contains(Name)
                             orderby pd.PrdStatus
                             select new
                             {
                                 tr.TrdName,
                                 b.BrandName,
                                 pd.PrdID,
                                 pd.Price,
                                 pd.PrdStatus,
                                 ph.Photo1,
                                 pd.TempStock,
                                 Status = pd.TempStock > 0 ? true : false,
                             })
                          .ToList();
            var genericResult = new { Results = result, Promotion = promotion, Oldresult = Oldresult };
            return Json(genericResult, JsonRequestBehavior.AllowGet);
        }
        public ActionResult JsonSearchClr(string Name)
        {
            //เช็คจำนวนสินค้าใน Lot
            var lot = db.PRODUCTLOT
                  .GroupBy(pl => new { pl.PrdID })
                  .Select(g => new { g.Key.PrdID, Amount = g.Sum(s => s.Amount) })
                .ToList();
            var lot_id = lot.Select(l => l.PrdID).ToList();

            //ดึงข้อมูล โปรโมชั่น
            var promotion = db.PRODUCT
                // .Where(x => x.PrdEnabled == "0" && x.PROMOTION.Count > 0 && x.PROMOTION.FirstOrDefault().ProMEndDate >= DateTime.Now
             .Where(x => x.PrdEnabled == "0" && x.PROMOTION.Count > 0 && x.PROMOTION.FirstOrDefault().ProMEndDate >= DateTime.Now && x.PROMOTION.FirstOrDefault().ProMStartDate <= DateTime.Now
              && x.COLOR.ClrName.Contains(Name))
              .Select(g => new
              {
                  g.BRAND.TRADEMARK.TrdName,
                  g.BRAND.BrandID,
                  g.BRAND.BrandName,
                  g.PrdID,
                  g.Price,
                  g.PHOTO.FirstOrDefault().Photo1,
                  g.PROMOTION.FirstOrDefault().Discount,
                  g.PROMOTION.FirstOrDefault().ProMID,
                  g.TempStock,
                  //      Status = lot_id.Contains(g.PrdID) ? true : false,
                  Status = g.TempStock > 0 ? true : false,
              })
                // .Take(6)
              .ToList();

            //ดึงข้อมูลสินค้า ขายดี กับสินค้าใหม่
            var Prd_pro = promotion.Select(x => x.PrdID).ToList(); // เอาไว้เช็ค ไอดีสินค้า ไม่ให้ตรงกับสินค้าที่มีโปรโมชั่นแล้ว
            var result = (from tr in db.TRADEMARK
                          join b in db.BRAND on tr.TrdID equals b.TrdID
                          join pd in db.PRODUCT on b.BrandID equals pd.BrandID
                          join ph in db.PHOTO on pd.PrdID equals ph.PrdID
                          where (pd.PrdStatus.Equals("สินค้าใหม่") || pd.PrdStatus.Equals("สินค้าขายดี")) && ph.PhotoID == 1 && pd.PrdEnabled.Equals("0")
                          && !Prd_pro.Contains(pd.PrdID) && pd.COLOR.ClrName.Contains(Name)
                          orderby pd.PrdStatus
                          select new
                          {
                              tr.TrdName,
                              b.BrandName,
                              pd.PrdID,
                              pd.Price,
                              pd.PrdStatus,
                              ph.Photo1,
                              pd.TempStock,
                              Status = pd.TempStock > 0 ? true : false,
                          })
                          .ToList();
            var Oldresult = (from tr in db.TRADEMARK
                             join b in db.BRAND on tr.TrdID equals b.TrdID
                             join pd in db.PRODUCT on b.BrandID equals pd.BrandID
                             join ph in db.PHOTO on pd.PrdID equals ph.PrdID
                             where (pd.PrdStatus.Equals("สินค้าเก่า") || pd.PrdStatus.Equals("สินค้าแนะนำ")) && ph.PhotoID == 1 && pd.PrdEnabled.Equals("0")
                             && !Prd_pro.Contains(pd.PrdID) && pd.COLOR.ClrName.Contains(Name)
                             orderby pd.PrdStatus
                             select new
                             {
                                 tr.TrdName,
                                 b.BrandName,
                                 pd.PrdID,
                                 pd.Price,
                                 pd.PrdStatus,
                                 ph.Photo1,
                                 pd.TempStock,
                                 Status = pd.TempStock > 0 ? true : false,
                             })
                          .ToList();
            var genericResult = new { Results = result, Promotion = promotion, Oldresult = Oldresult };
            return Json(genericResult, JsonRequestBehavior.AllowGet);
        }
        #endregion Search
    }
}
