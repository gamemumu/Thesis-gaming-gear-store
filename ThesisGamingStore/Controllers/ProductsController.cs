using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Mvc;
using ThesisGamingStore.Code;
using ThesisGamingStore.DataAccess;
using ThesisGamingStore.DataAccess.Core;
using ThesisGamingStore.Models;

namespace ThesisGamingStore.Controllers
{
    public class ProductsController : Controller
    {
        #region Constructor
        private IProductDao _proRepository;
        private IProductLotDao _proLotRepository;
        private IColorDao _colorRepository;
        private IBrandDao _brandRepository;
        private ITypeproductDao _typeRepository;
        private ITradmarkDao _tradRepository;
        private IOfferDao _offerRepository;
        public ProductsController() :
            this(new SqlProduct(), new SqlProductLot(), new SqlColor(), new SqlBrand(), new SqlTypeproduct(), new SqlTradmark(), new SqlOffer()
              )
        {
        }
        public ProductsController(SqlProduct proRepository, SqlProductLot proLotRepository, SqlColor colorRepository,
            SqlBrand brandRepository, SqlTypeproduct typeRepository, SqlTradmark tradRepository,SqlOffer offerRepository)
        {
            this._proRepository = proRepository;
            this._proLotRepository = proLotRepository;
            this._colorRepository = colorRepository;
            this._brandRepository = brandRepository;
            this._typeRepository = typeRepository;
            this._tradRepository = tradRepository;
            this._offerRepository = offerRepository;
        }
        #endregion Constructor

        //
        // GET: /Products/
        #region Tradmark
        [HttpGet]
        public ActionResult TradmarkCreate()
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                return View();
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }

        [HttpPost]
        public ActionResult TradmarkCreate(TradmarkModel model)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                if (ModelState.IsValid)
                {
                    _tradRepository.InsertTradmark(Mapper.ToDto(model));
                    ViewBag.StatusMessage = "Success";
                    return RedirectToAction("ListTradmark");
                }
                ModelState.AddModelError("", "Please complete the following information !");
                return View();
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }

        }
        public ActionResult ListTradmark()
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                var result = _tradRepository.ListTradmark();
                return View(Mapper.ToDto(result));
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        public JsonResult JsonListTradmark()
        {
            var result = _tradRepository.ListTradmark();
            return Json(result, JsonRequestBehavior.AllowGet);

        }
        [HttpGet]
        public ActionResult EditTradmark(string TrdID)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                var result = _tradRepository.GetTradmark(TrdID);
                return View(Mapper.ToDto(result));
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }

        }
        [HttpPost]
        public ActionResult EditTradmark(TradmarkModel model)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                if (ModelState.IsValid)
                {
                    if (_tradRepository.UpdateTradmark(Mapper.ToDto(model)) == true)
                    {
                        return RedirectToAction("ListTradmark");
                    }
                }
                return View(model);
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }

        public ActionResult DeleteTradmark(string TrdID)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                var result = _tradRepository.GetTradmark(TrdID);
                return View(Mapper.ToDto(result));
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        [HttpPost]
        public ActionResult DeleteTradmark(TradmarkModel model)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                var result = _tradRepository.DeleteTradmark(model.TrdID);
                return RedirectToAction("ListTradmark");
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        [HttpPost]
        public JsonResult doesTradNameExist(string TrdName)
        {
            // string CurrentURL = System.Web.HttpContext.Current.Request.UrlReferrer.LocalPath.Substring(10);
            string CurrentURL = System.Web.HttpContext.Current.Request.UrlReferrer.Segments[2]; //ดูหน้าเพจว่าอยู่หน้า CREATE or EDIT
            if (CurrentURL.Equals("EditTradmark"))
            {
                //ถ้า อยู่ในหน้า EDIT จะเช็คจากไอดีอื่นว่ามีชื่ออื่นซ้ำไหมถ้าไม่ใช่ ID ตัวเอง
                string Id = System.Web.HttpContext.Current.Request.UrlReferrer.Query.Split('=')[1];
                bool unique = _tradRepository.CheckNameUnique(TrdName.Replace(" ", string.Empty), Id);
                if (unique)
                {
                    return Json("The tradmark name has been taken", JsonRequestBehavior.AllowGet);
                }
                return Json(true, JsonRequestBehavior.AllowGet);
            }
            else
            {
                //กรณีสร้างใหม่ไม่มี ID ให้เช็คจะตรวจสอบชื่อจากทุกอัน
                bool unique = _tradRepository.CheckNameUnique(TrdName.Replace(" ", string.Empty), "CREATE");
                if (unique)
                {
                    return Json("The tradmark name has been taken", JsonRequestBehavior.AllowGet);
                }
                return Json(true, JsonRequestBehavior.AllowGet);
            }
        }
        #endregion Tradmark

        #region Brand
        [HttpGet]
        public ActionResult BrandCreate()
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                return View();
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }

        [HttpPost]
        public ActionResult BrandCreate(BrandModel model)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                if (ModelState.IsValid)
                {
                    _brandRepository.InsertBrand(Mapper.ToDto(model));
                    ViewBag.StatusMessage = "Success";
                    return RedirectToAction("ListBrand");
                }
                ModelState.AddModelError("", "Please complete the following information !");
                return View();
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        public ActionResult ListBrand()
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                var result = _brandRepository.ListBrandAll();
                return View(Mapper.ToDto(result));
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        public JsonResult JsonListBrand()
        {
            var result = _brandRepository.ListBrand();
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public JsonResult JsonListBrandCheckProduct()
        {
            var result = _brandRepository.ListBrand();
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public JsonResult JsonListBrandCheckProductEdit()
        {
            var result = _brandRepository.ListBrandEdit(Session["BRAND"].ToString());
            var all = new { Result = result, Selected = Session["BRAND"].ToString() };
            return Json(all, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult JsonListBrandSupID(string id)
        {
            var result = _brandRepository.ListBrand(id);
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult EditBrand(string BrandID)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                var result = _brandRepository.GetBrand(BrandID);
                return View(Mapper.ToDto(result));
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        [HttpPost]
        public ActionResult EditBrand(BrandModel model)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                if (ModelState.IsValid)
                {
                    if (_brandRepository.UpdateBrand(Mapper.ToDto(model)) == true)
                    {
                        return RedirectToAction("ListBrand");
                    }
                }
                return View(model);
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }

        public ActionResult DeleteBrand(string BrandID)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                var result = _brandRepository.GetBrand(BrandID);
                return View(Mapper.ToDto(result));
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }

        }
        [HttpPost]
        public ActionResult DeleteBrand(BrandModel model)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                var result = _brandRepository.DeleteBrand(model.BrandID);
                return RedirectToAction("ListBrand");
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }

        [HttpPost]
        public JsonResult doesBrandNameExist(string BrandName)
        {
            // string CurrentURL = System.Web.HttpContext.Current.Request.UrlReferrer.LocalPath.Substring(10);


            string CurrentURL = System.Web.HttpContext.Current.Request.UrlReferrer.Segments[2]; //ดูหน้าเพจว่าอยู่หน้า CREATE or EDIT
            if (CurrentURL.Equals("EditBrand"))
            {
                //ถ้า อยู่ในหน้า EDIT จะเช็คจากไอดีอื่นว่ามีชื่ออื่นซ้ำไหมถ้าไม่ใช่ ID ตัวเอง
                string Id = System.Web.HttpContext.Current.Request.UrlReferrer.Query.Split('=')[1];
                bool unique = _brandRepository.CheckNameUnique(BrandName.Replace(" ", string.Empty), Id);
                if (unique)
                {
                    return Json("The brand name has been taken", JsonRequestBehavior.AllowGet);
                }
                return Json(true, JsonRequestBehavior.AllowGet);
            }
            else
            {
                //กรณีสร้างใหม่ไม่มี ID ให้เช็คจะตรวจสอบชื่อจากทุกอัน
                bool unique = _brandRepository.CheckNameUnique(BrandName.Replace(" ", string.Empty), "CREATE");
                if (unique)
                {
                    return Json("The brand name has been taken", JsonRequestBehavior.AllowGet);
                }
                return Json(true, JsonRequestBehavior.AllowGet);
            }
        }
        #endregion Brand

        #region Color
        [HttpGet]
        public ActionResult ColorCreate()
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                return View();
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }

        [HttpPost]
        public ActionResult ColorCreate(ColorModel model)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                if (ModelState.IsValid)
                {
                    _colorRepository.InsertColor(Mapper.ToDto(model));
                    ViewBag.StatusMessage = "Success";
                    return RedirectToAction("ListColor");
                }
                ModelState.AddModelError("", "Please complete the following information !");
                return View();
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        public ActionResult ListColor()
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                var result = _colorRepository.ListColor();
                return View(Mapper.ToDto(result));
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        public JsonResult JsonListColor()
        {
            var result = _colorRepository.ListColor();
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        [HttpGet]
        public ActionResult EditColor(string ClrID)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                var result = _colorRepository.GetColor(ClrID);
                return View(Mapper.ToDto(result));
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        [HttpPost]
        public ActionResult EditColor(ColorModel model)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                if (ModelState.IsValid)
                {
                    if (_colorRepository.UpdateColor(Mapper.ToDto(model)) == true)
                    {
                        return RedirectToAction("ListColor");
                    }
                }
                return View(model);
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }

        }

        public ActionResult DeleteColor(string ClrID)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                var result = _colorRepository.GetColor(ClrID);
                return View(Mapper.ToDto(result));
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        [HttpPost]
        public ActionResult DeleteColor(ColorModel model)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                var result = _colorRepository.DeleteColor(model.ClrID);
                return RedirectToAction("ListColor");
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }

        [HttpPost]
        public JsonResult doesColorNameExist(string ClrName)
        {
            // string CurrentURL = System.Web.HttpContext.Current.Request.UrlReferrer.LocalPath.Substring(10);
            string CurrentURL = System.Web.HttpContext.Current.Request.UrlReferrer.Segments[2]; //ดูหน้าเพจว่าอยู่หน้า CREATE or EDIT
            if (CurrentURL.Equals("EditColor"))
            {
                //ถ้า อยู่ในหน้า EDIT จะเช็คจากไอดีอื่นว่ามีชื่ออื่นซ้ำไหมถ้าไม่ใช่ ID ตัวเอง
                string Id = System.Web.HttpContext.Current.Request.UrlReferrer.Query.Split('=')[1];
                bool unique = _colorRepository.CheckNameUnique(ClrName.Replace(" ", string.Empty), Id);
                if (unique)
                {
                    return Json("The color name has been taken", JsonRequestBehavior.AllowGet);
                }
                return Json(true, JsonRequestBehavior.AllowGet);
            }
            else
            {
                //กรณีสร้างใหม่ไม่มี ID ให้เช็คจะตรวจสอบชื่อจากทุกอัน
                bool unique = _colorRepository.CheckNameUnique(ClrName.Replace(" ", string.Empty), "CREATE");
                if (unique)
                {
                    return Json("The color name has been taken", JsonRequestBehavior.AllowGet);
                }
                return Json(true, JsonRequestBehavior.AllowGet);
            }
        }
        #endregion Color

        #region Type of product
        [HttpGet]
        public ActionResult TypeCreate()
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                return View();
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }

        [HttpPost]
        public ActionResult TypeCreate(TypeproductModel model)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                if (ModelState.IsValid)
                {
                    _typeRepository.InsertTypeproduct(Mapper.ToDto(model));
                    ViewBag.StatusMessage = "Success";
                    return RedirectToAction("ListType");
                }
                ModelState.AddModelError("", "Please complete the following information !");
                return View();
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        public ActionResult ListType()
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                var result = _typeRepository.ListTypeproduct();
                return View(Mapper.ToDto(result));
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }

        }
        public JsonResult JsonListType()
        {
            var result = _typeRepository.ListTypeproduct();
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        [HttpGet]
        public ActionResult EditType(string TypeProductID)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                var result = _typeRepository.GetTypeproduct(TypeProductID);
                return View(Mapper.ToDto(result));
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        [HttpPost]
        public ActionResult EditType(TypeproductModel model)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                if (ModelState.IsValid)
                {
                    if (_typeRepository.UpdateTypeproduct(Mapper.ToDto(model)) == true)
                    {
                        return RedirectToAction("ListType");
                    }
                }
                return View(model);
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }

        public ActionResult DeleteType(string TypeProductID)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                var result = _typeRepository.GetTypeproduct(TypeProductID);
                return View(Mapper.ToDto(result));
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        [HttpPost]
        public ActionResult DeleteType(TypeproductModel model)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                var result = _typeRepository.DeleteTypeproduct(model.TypeProductID);
                return RedirectToAction("ListType");
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }

        [HttpPost]
        public JsonResult doesTyeProductNameExist(string TypeName)
        {
            // string CurrentURL = System.Web.HttpContext.Current.Request.UrlReferrer.LocalPath.Substring(10);


            string CurrentURL = System.Web.HttpContext.Current.Request.UrlReferrer.Segments[2]; //ดูหน้าเพจว่าอยู่หน้า CREATE or EDIT
            if (CurrentURL.Equals("EditType"))
            {
                //ถ้า อยู่ในหน้า EDIT จะเช็คจากไอดีอื่นว่ามีชื่ออื่นซ้ำไหมถ้าไม่ใช่ ID ตัวเอง
                string Id = System.Web.HttpContext.Current.Request.UrlReferrer.Query.Split('=')[1];
                bool unique = _typeRepository.CheckNameUnique(TypeName.Replace(" ", string.Empty), Id);
                if (unique)
                {
                    return Json("The type name has been taken", JsonRequestBehavior.AllowGet);
                }
                return Json(true, JsonRequestBehavior.AllowGet);
            }
            else
            {
                //กรณีสร้างใหม่ไม่มี ID ให้เช็คจะตรวจสอบชื่อจากทุกอัน
                bool unique = _typeRepository.CheckNameUnique(TypeName.Replace(" ", string.Empty), "CREATE");
                if (unique)
                {
                    return Json("The type name has been taken", JsonRequestBehavior.AllowGet);
                }
                return Json(true, JsonRequestBehavior.AllowGet);
            }
        }
        #endregion Type of product



        #region Product
        [HttpGet]
        public ActionResult ProductCreate()
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                     List<SelectListItem> li = new List<SelectListItem>();
                     li.Add(new SelectListItem { Text = "มีซีเรียลนัมเบอร์", Value = "1" });
                     li.Add(new SelectListItem { Text = "ไม่มีซีเรียลนัมเบอร์", Value = "0" });
                ViewData["SerialStatus"] = li;
                return View();
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }

        [HttpPost]
        public ActionResult ProductCreate(ProductModel model)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                if (ModelState.IsValid)
                {
                    List<string> DataPhoto = new List<string>();
                    foreach (HttpPostedFileBase file in model.Photo)
                    {
                        try
                        {
                            string path = "";
                            try
                            {
                                path = System.IO.Path.Combine(Server.MapPath("/Photos/" + model.TypeName.Trim() + "/" + model.TrdName.Trim() + "/" + model.BrandName.Trim()));
                            }
                            catch
                            {
                                ModelState.AddModelError("", "กรุณาเลือกยี่ห้อสินค้าก่อนที่ทำการบันทึก");
                                return View(model);
                            }
                            //check if directory does not exists , 
                            if (!Directory.Exists(path))
                            {
                                Directory.CreateDirectory(path);
                            }

                            var filepath = Path.Combine(path, System.IO.Path.GetFileName(file.FileName).Trim());
                            file.SaveAs(filepath); //save photo to server
                            var file_db = System.IO.Path.Combine("/Photos/" + model.TypeName.Trim() + "/" + model.TrdName.Trim() + "/" + model.BrandName.Trim(), Path.GetFileName(file.FileName));
                            file_db = file_db.Replace('\\', '/');
                            DataPhoto.Add(file_db);
                        }
                        catch
                        {
                            ModelState.AddModelError("", "Please complete the following information for Images!");
                            List<SelectListItem> li = new List<SelectListItem>();
                            li.Add(new SelectListItem { Text = "มีซีเรียลนัมเบอร์", Value = "1" });
                            li.Add(new SelectListItem { Text = "ไม่มีซีเรียลนัมเบอร์", Value = "0" });
                            ViewData["SerialStatus"] = li;
                            return View(model);
                        };
                    }
                    _proRepository.InsertProduct(Mapper.ToDto(model), DataPhoto);
                    ViewBag.StatusMessage = "Success";
                    return RedirectToAction("ListProduct");
                    //return RedirectToAction("ProductCreate");
                }
                ModelState.AddModelError("", "Please complete the following information !");
                return View();
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }

        public ActionResult AddProductSup()
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                return View();
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }

        public ActionResult EditProductSup()
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                return View();
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        public ActionResult ProductSupCreate()
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                var resolveRequest = HttpContext.Request;
                resolveRequest.InputStream.Seek(0, SeekOrigin.Begin);
                string jsonString = new StreamReader(resolveRequest.InputStream).ReadToEnd();
                if (jsonString != null)
                {
                    List<ProductSup> myDeserializedObjList = (List<ProductSup>)Newtonsoft.Json.JsonConvert.DeserializeObject(jsonString, typeof(List<ProductSup>));

                    if (_proRepository.InsertProductForSup(myDeserializedObjList) == true)
                        return Json(new { success = true }, JsonRequestBehavior.AllowGet);
                    else
                        return Json(new { success = false }, JsonRequestBehavior.AllowGet);
                }
                return Json(new { success = false }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        public ActionResult JsonProductCreateSup(string id)
        {
            var result = Mapper.ToDto(_proRepository.ListProductAddSup(id));
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult ProductSupEdit()
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                var resolveRequest = HttpContext.Request;
                resolveRequest.InputStream.Seek(0, SeekOrigin.Begin);
                string jsonString = new StreamReader(resolveRequest.InputStream).ReadToEnd();
                if (jsonString != null)
                {
                    List<ProductSup> myDeserializedObjList = (List<ProductSup>)Newtonsoft.Json.JsonConvert.DeserializeObject(jsonString, typeof(List<ProductSup>));

                    if (_proRepository.UpdateProductForSup(myDeserializedObjList) == true)
                        return Json(new { success = true }, JsonRequestBehavior.AllowGet);
                    else
                        return Json(new { success = false }, JsonRequestBehavior.AllowGet);
                }
                return Json(new { success = false }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        public ActionResult JsonProductEditSup(string id)
        {
            var result = Mapper.ToDto(_proRepository.ListProductEditSup(id));
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult EditProduct(string id)
        {

            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                var result = _proRepository.GetProductTuple(id);
                List<SelectListItem> li = new List<SelectListItem>();
                li.Add(new SelectListItem { Text = "มีซีเรียลนัมเบอร์", Value = "1" });
                li.Add(new SelectListItem { Text = "ไม่มีซีเรียลนัมเบอร์", Value = "0" });
                ViewData["SerialStatus"] = li;

                List<SelectListItem> sta = new List<SelectListItem>();
                sta.Add(new SelectListItem { Text = "สินค้าใหม่", Value = "สินค้าใหม่" });
                sta.Add(new SelectListItem { Text = "สินค้าเก่า", Value = "สินค้าเก่า" });
                sta.Add(new SelectListItem { Text = "สินค้าขายดี", Value = "สินค้าขายดี" });
                sta.Add(new SelectListItem { Text = "สินค้าแนะนำ", Value = "สินค้าแนะนำ" });

                ViewData["Photo"] = result.Item2;

                ViewData["StatusProduct"] = sta.ToList().OrderBy(status => status.Text)
                     .Select(status =>
                                 new SelectListItem
                                 {
                                     Selected = (status.Value == result.Item1.PrdStatus),
                                     Text = status.Text,
                                     Value = status.Value.ToString()
                                 });
                ViewData["TYPE"] = _typeRepository.ListTypeproduct().OrderBy(type => type.TypeName)
                     .Select(type =>
                                 new SelectListItem
                                 {
                                     Selected = (type.TypeProductID == result.Item1.TypeProductID),
                                     Text = type.TypeName,
                                     Value = type.TypeProductID.ToString()
                                 });
                ViewData["SerialStatus"] = li.ToList().OrderBy(serial => serial.Text)
                     .Select(serial =>
                                 new SelectListItem
                                 {
                                     Selected = (serial.Value == result.Item1.SerialStatus),
                                     Text = serial.Text,
                                     Value = serial.Value.ToString()
                                 });
                ViewData["COLOR"] = _colorRepository.ListColor().OrderBy(color => color.ClrName)
                     .Select(color =>
                                 new SelectListItem
                                 {
                                     Selected = (color.ClrID == result.Item1.ClrID),
                                     Text = color.ClrName,
                                     Value = color.ClrID.ToString()
                                 });
                Session["BRAND"] = result.Item1.BrandID;
                return View(Mapper.ToDto(result.Item1));
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }

        [HttpPost]
        public ActionResult EditProduct(ProductModel model)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                if (ModelState.IsValid)
                {
                    List<string> DataPhoto = new List<string>();
                    if (model.Photo.First() != null)
                    {
                        foreach (HttpPostedFileBase file in model.Photo)
                        {
                            string path = System.IO.Path.Combine(Server.MapPath("/Photos/" + model.TypeName.Trim() + "/" + model.TrdName.Trim() + "/" + model.BrandName.Trim()));
                            try
                            {
                                //check if directory does not exists , 
                                if (!Directory.Exists(path))
                                {
                                    Directory.CreateDirectory(path);
                                }

                                var filepath = Path.Combine(path, System.IO.Path.GetFileName(file.FileName).Trim());
                                file.SaveAs(filepath); //save photo to server
                                var file_db = System.IO.Path.Combine("/Photos/" + model.TypeName.Trim() + "/" + model.TrdName.Trim() + "/" + model.BrandName.Trim(), Path.GetFileName(file.FileName));
                                file_db = file_db.Replace('\\', '/');
                                DataPhoto.Add(file_db);
                            }
                            catch
                            {
                                ModelState.AddModelError("", "Please complete the following information for Images!");
                            };
                        }
                    }
                    if (_proRepository.UpdateProduct(Mapper.ToDto(model), DataPhoto))
                    {
                        ViewBag.StatusMessage = "Success";
                        return RedirectToAction("ListProduct", "Products");
                    }
                    else
                    {
                        ModelState.AddModelError("", "Please complete the following information !");
                        return View(model);
                    }
                }
                ModelState.AddModelError("", "Please complete the following information !");
                return View();
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }

        [HttpPost]
        public ActionResult DeleteProduct(string id)
        {
            if (Session["S_EmpID"] != null)
            {
                if (!string.IsNullOrEmpty(id))
                {
                    var result = _proRepository.DeleteProduct(id);
                    return RedirectToAction("ListProduct", "Products");
                }
                return View();
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        public ActionResult ListProduct()
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                //var result = Mapper.ToDto(_proRepository.ListProduct(id));
                // ViewData["Listproduct"] = result;
                ViewBag.EmpID = Session["S_EmpID"].ToString();
                ViewBag.EmpFname = Session["S_EmpFname"].ToString();
                ViewBag.DateNow = System.DateTime.Now.ToString("yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture);
                return View();
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
            //var result = _proRepository.ListProduct();
            //return View(Mapper.ToDto(result));
        }

        public JsonResult JsonListProduct()
        {
            var result = _proRepository.ListProduct();
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public JsonResult JsonListProduct2()
        {
            var result = _proRepository.ListProductPic1();
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public JsonResult JsonGetListForOffer()
        {
            var result = _proRepository.ListProductForOffer();
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public JsonResult JsonGetProductIDList(string id)
        {
            var result = _proRepository.GetProductList(id);
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        #endregion Product



        #region Offer
        public ActionResult OfferCreate()
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                //var result = Mapper.ToDto(_proRepository.ListProduct(id));
                // ViewData["Listproduct"] = result;
                ViewBag.EmpID = Session["S_EmpID"].ToString();
                ViewBag.EmpFname = Session["S_EmpFname"].ToString();
                ViewBag.DateNow = System.DateTime.Now.ToString("yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture);
                return View();
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }

        public ActionResult JsonProductSupp(string id)
        {
            var result = Mapper.ToDto(_proRepository.ListProduct(id));
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult JsonProductSupp2(string id)
        {
            var result = Mapper.ToDto(_proRepository.ListProductNoPic(id));
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult OfferCreatePos(OfferModel model)
        {
            if (Session["S_EmpID"] != null)
            {
                var resolveRequest = HttpContext.Request;
                resolveRequest.InputStream.Seek(0, SeekOrigin.Begin);
                string jsonString = new StreamReader(resolveRequest.InputStream).ReadToEnd();
                List<OfferModel> sups = new List<OfferModel>();
                if (jsonString != null)
                {
                    if (Session["S_EmpID"].ToString() != null)
                    {

                        dynamic jArr2 = Newtonsoft.Json.JsonConvert.DeserializeObject(jsonString);
                        foreach (dynamic item in jArr2)
                        {
                            foreach (var subitem in item.OfferModel)
                            {
                                model.SupID = subitem.SupID;
                                model.EmpID = Session["S_EmpID"].ToString();
                                model.OffDate = System.DateTime.Now.ToString("yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture);
                                sups.Add(new OfferModel() { SupID = model.SupID, EmpID = model.EmpID, OffDate = model.OffDate });
                            }
                            List<OfferDetailModel> myDeserializedObjList = item.OfferDetail.ToObject<List<OfferDetailModel>>();
                            var map_offer = Mapper._ToDto(sups);
                            var map_offerDta = Mapper._ToDto(myDeserializedObjList);
                            _offerRepository.InsertOffer(map_offer, map_offerDta);
                        }
                        return Json(new { success = true }, JsonRequestBehavior.AllowGet);
                        //return Json(_proRepository.ListProduct(), JsonRequestBehavior.AllowGet);
                        //return View(_proRepository.ListProduct());
                    }
                    return RedirectToAction("Login2", "Account");
                }
                return View();
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        public ActionResult ListOffer()
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                var result = _offerRepository.ListOffer();
                if (Request.IsAjaxRequest())
                {
                    // Thread.Sleep(1000);
                    return PartialView("~/Views/Products/_ListOfferPartial.ascx", Mapper.ToDto(result));
                }
                return View("OfferCreatePos");
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }

        }

        public JsonResult JsonListOffer()
        {
            var result = _offerRepository.ListOffer();
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult ShowListOffer()
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                return View();
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }

        }

        public ActionResult ApproveOffer(string id, string SupName, string Approve)
        {
            if (Session["S_EmpID"] != null)
            {
                var result = _offerRepository.GetListOffer(id);
                Session["ReportOFFID"] = id;
                Session["OffID"] = id;
                ViewBag.OffID = id;
                ViewBag.SupName = SupName.Replace("/undefined", "");
                if (Approve != null)
                    ViewData["Approve"] = Approve.Replace("/undefined", "");
                else ViewData["Approve"] = "false";
                if (result == null)
                {
                    return new HttpNotFoundResult();
                }
                return PartialView("~/Views/Products/_Approve.ModalPreview.ascx", Mapper.ToDto(result));
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        public ActionResult JsonApproveOffer(string id, string SupName, string Approve)
        {
            if (Session["S_EmpID"] != null)
            {
                var result = _offerRepository.GetListOffer(id);
                Session["ReportOFFID"] = id;
                Session["OffID"] = id;
                ViewBag.OffID = id;
                ViewBag.SupName = SupName.Replace("/undefined", "");
                if (!Approve.Equals("Wait"))
                    ViewData["Approve"] = Approve.Replace("/undefined", "");
                else ViewData["Approve"] = "false";
                if (result == null)
                {
                    return new HttpNotFoundResult();
                }
                List<DataDetail> data = new List<DataDetail>{
                new DataDetail(){ReportOFFID = id,OffID=id,SupName= SupName.Replace("/undefined", ""),Approve= ViewData["Approve"].ToString()}
                };
                var genericResult = new { DataDetail = data, Results = result };
                return Json(genericResult, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        [HttpPost]
        public ActionResult UpdateOffer(OfferDetailModel model)
        {
            if (Session["S_EmpID"].ToString() != null)
            {

                var resolveRequest = HttpContext.Request;
                resolveRequest.InputStream.Seek(0, SeekOrigin.Begin);
                string jsonString = new StreamReader(resolveRequest.InputStream).ReadToEnd();
                if (jsonString != null)
                {
                    List<OfferDetailModel> myDeserializedObjList = (List<OfferDetailModel>)Newtonsoft.Json.JsonConvert.DeserializeObject(jsonString, typeof(List<OfferDetailModel>));
                    var map_update = Mapper._ToDto2(myDeserializedObjList);
                    _offerRepository.UpdateOffer(map_update, Session["OffID"].ToString(), Session["S_EmpFname"].ToString());
                    return Json(new { success = true }, JsonRequestBehavior.AllowGet);
                }
                Session["OffID"] = null;
                ViewBag.OffID = null;
                ViewBag.SupName = null;
                ViewData["Approve"] = null;
                return Json(new { success = false }, JsonRequestBehavior.AllowGet);
                // return RedirectToAction("OfferCreate", "Products");
            }
            return RedirectToAction("Login2", "Account");
        }
        [HttpPost]
        public ActionResult DeleteOffer(string id)
        {
            if (Session["S_EmpID"].ToString() != null)
            {
                var result = _offerRepository.DeleteOffer(id);
                Session["OffID"] = null;
                ViewBag.OffID = null;
                ViewBag.SupName = null;
                ViewData["Approve"] = null;
                return RedirectToAction("OfferCreate", "Products");
            }
            return RedirectToAction("Login2", "Account");
        }
        #endregion Offer

        #region Reports
        public ActionResult OfferReport(string id)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                ReportDocument rd = new ReportDocument();
                rd.Load(Path.Combine(Server.MapPath("~/Reporting"), "OfferReport.rpt"));
                //ConnectionInfo crConnectionInfo = new ConnectionInfo();
                //crConnectionInfo.ServerName = "GAMEMUMU"; //Database server or ODBC
                //crConnectionInfo.DatabaseName = "gamingstore"; // Database name
                //crConnectionInfo.UserID = "g_root"; // username
                //crConnectionInfo.Password = "2525"; // password

                rd.SetDatabaseLogon("g_root", "2525", "GAMEMUMU", "gamingstore");
                rd.SetParameterValue("OfferID", id);
                //rd.SetParameterValue("OfferID", Session["ReportOFFID"].ToString());
                Response.Buffer = false;
                Response.ClearContent();
                Response.ClearHeaders();
                try
                {
                    Stream stream = rd.ExportToStream(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
                    // stream.Seek(0, SeekOrigin.Begin);
                    Response.AppendHeader("Content-Disposition", "inline; filename=foo.pdf");
                    return File(stream, "application/pdf");
                }
                catch (Exception ex)
                {
                    throw;
                }
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }

        }
        #endregion Reports

        class DataDetail
        {
            public string ReportOFFID { get; set; }
            public string OffID { get; set; }
            public string SupName { get; set; }
            public string Approve { get; set; }
        }
    }
}
