using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ThesisGamingStore.DataAccess;
using ThesisGamingStore.DataAccess.Core;
using ThesisGamingStore.Models;

namespace ThesisGamingStore.Controllers
{
    public class PromotionController : Controller
    {
        gamingstoreEntities db = new gamingstoreEntities();
        private IPromotionDao _PromotionRepository;
        public PromotionController() : this(new SqlPromotion()) { }
        public PromotionController(SqlPromotion _PromotionRepository)
        {
            this._PromotionRepository = _PromotionRepository;
        }
        //
        // GET: /Promotion/

        public ActionResult CreatePromotion()
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
        public ActionResult CreatePromotion(PROMOTION model)
        {
            if (Session["S_EmpID"] != null)
            {
                var resolveRequest = HttpContext.Request;
                resolveRequest.InputStream.Seek(0, SeekOrigin.Begin);
                string jsonString = new StreamReader(resolveRequest.InputStream).ReadToEnd();
                if (jsonString != null)
                {
                    if (Session["S_EmpID"].ToString() != null)
                    {
                        dynamic jArr2 = Newtonsoft.Json.JsonConvert.DeserializeObject(jsonString);
                        foreach (dynamic item in jArr2)
                        {
                            foreach (var pr in item.PROMOTION)
                            {
                                model.ProMStartDate = pr.ProMStartDate;
                                model.ProMEndDate = pr.ProMEndDate;
                                model.Discount = pr.Discount;
                            }
                            foreach (var rs in item.rows)
                            {
                                model.PRODUCT.Add(new PRODUCT() { PrdID = rs });
                            }
                        }
                        if (_PromotionRepository.InsertPROMOTION(model) == true)
                            return Json(new { success = true }, JsonRequestBehavior.AllowGet);
                        return Json(new { success = false }, JsonRequestBehavior.AllowGet);
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
      
        [HttpGet]
        public ActionResult EditPromotion(string ProMID)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                PROMOTION pm = new PROMOTION();
                pm.ProMID = ProMID;
                return View(pm);
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        [HttpPost]
        public ActionResult EditPromotion(PROMOTION model)
        {
            if (Session["S_EmpID"] != null)
            {
                var resolveRequest = HttpContext.Request;
                resolveRequest.InputStream.Seek(0, SeekOrigin.Begin);
                string jsonString = new StreamReader(resolveRequest.InputStream).ReadToEnd();
                if (jsonString != null)
                {
                    if (Session["S_EmpID"].ToString() != null)
                    {
                        dynamic jArr2 = Newtonsoft.Json.JsonConvert.DeserializeObject(jsonString);
                        foreach (dynamic item in jArr2)
                        {
                            foreach (var pr in item.PROMOTION)
                            {
                                model.ProMStartDate = pr.ProMStartDate;
                                model.ProMEndDate = pr.ProMEndDate;
                                model.Discount = pr.Discount;
                                model.ProMID = pr.ProMID;
                            }
                            foreach (var rs in item.rows)
                            {
                                model.PRODUCT.Add(new PRODUCT() { PrdID = rs });
                            }
                        }
                        if (_PromotionRepository.UpdatePROMOTION(model) == true)
                            return Json(new { success = true }, JsonRequestBehavior.AllowGet);
                        return Json(new { success = false }, JsonRequestBehavior.AllowGet);
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
        [HttpPost]
        public ActionResult DeletePromotion(string id)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                var result = _PromotionRepository.DeletePROMOTION(id);
                return RedirectToAction("ListPromotion");
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        public ActionResult ListPromotion()
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                var result = _PromotionRepository.ListPROMOTION();
                return View(result);
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        public JsonResult JsonListPromotion()
        {
            var result = _PromotionRepository.ListPROMOTION();
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public JsonResult JsonGetPromotionEdit(string id)
        {
            var result = _PromotionRepository.GetPROMOTION(id);
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public JsonResult JsonGetPromotion(string id)
        {
            var result = _PromotionRepository.GetPROMOTION2(id);  
            //var result = db.PROMOTION.Find(id).PRODUCT.ToList();
            return Json(result, JsonRequestBehavior.AllowGet);
        }
    }
}
