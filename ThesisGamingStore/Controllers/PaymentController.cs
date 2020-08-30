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
    public class PaymentController : Controller
    {
        //
        // GET: /Payment/
      gamingstoreEntities db = new gamingstoreEntities();
      private IPaymentDao _payRepository;
      public PaymentController() : this(new SqlPayment()) { }
        public PaymentController(SqlPayment _payRepository)
        {
            this._payRepository = _payRepository;
        }

        public ActionResult PayMent(string SlpID)
        {
            if (Session["MemID"] == null)
                return RedirectToAction("mLogin", "Member");
            ViewData["SlpID"] = SlpID;
            string memID = Session["MemID"].ToString();
            try {
                var count = db.PAYMENT.Where(x => x.SlpID == SlpID  && x.PayPriceCheck != 0).FirstOrDefault();
                if (count != null)
                {
                    ViewData["SlpSum"] = Convert.ToInt32(count.PayPriceCheck);
                    ViewData["BANK"] = db.BANK.Where(b => b.BnkEnabled == "0").ToList();
                    return View();
                }
                else
                {
                    var result = db.SELLPRODUCT.Where(x => x.SlpID == SlpID && x.MemID == memID
                        && x.SlpStatus != "ส่งของแล้ว").FirstOrDefault().SlpSum;
                    ViewData["SlpSum"] = Convert.ToInt32(result);
                    ViewData["BANK"] = db.BANK.Where(b => b.BnkEnabled == "0").ToList();
                    return View();
                }
            }
            catch
            {
                return RedirectToAction("Error404", "Shipping");
            }
        }

        [HttpPost]
        public ActionResult PayMent(_Payment data)
        {
            HttpPostedFileBase file = data.Photo;
            var Memid = Session["MemID"].ToString();
            var checkMemid = db.SELLPRODUCT.Where(c => c.MemID == Memid && c.SlpID == data.SlpID).Count();
            if (checkMemid > 0)
            {
                try
                {
                    string path = "";
                    path = System.IO.Path.Combine(Server.MapPath("/Photos/PayMent/" + Memid));
                    if (!Directory.Exists(path))
                    {
                        Directory.CreateDirectory(path);
                    }
                    var filepath = Path.Combine(path, System.IO.Path.GetFileName(file.FileName).Trim());
                    file.SaveAs(filepath); //save photo to server
                    var file_db = System.IO.Path.Combine("/Photos/PayMent/" + Memid, Path.GetFileName(file.FileName));
                    file_db = file_db.Replace('\\', '/');
                    data.PayImg = file_db;
                   
                    if (_payRepository.InsertPayment(data))
                    {
                        return Json(new { success = true }, JsonRequestBehavior.AllowGet);
                    }
                    return Json(new { success = false }, JsonRequestBehavior.AllowGet);
                }
                catch
                {
                    // ModelState.AddModelError("", "Please complete the following information for Images!");
                };
            }
            else
            {
                return RedirectToAction("Error404", "Shipping");
            }
            return Json(new { success = false }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult Info(string SlpID)
        {
            if (Session["MemID"].ToString() != null)
            {
                var memId = Session["MemID"].ToString();
                var _SlpID = SlpID.Replace("/undefined", "");
                var checkMemid = db.SELLPRODUCT.Where(c => c.MemID == memId && c.SlpID == _SlpID).Count();
                  if (checkMemid > 0)
                  {
                      var result = db.SELLPRODUCT_DTA.Where(s => s.SlpID == _SlpID).ToList();
                      ViewData["MDetailOrder"] = result;
                      ViewBag.SldID = _SlpID;
                      return PartialView("~/Views/Member/__MOrderDetailProduct.Modal.ascx", ViewData["MDetailOrder"]);
                  }
                  else
                  {
                      return RedirectToAction("Error404", "Shipping");
                  }
            }
            return RedirectToAction("Error404", "Shipping");
        }

        [HttpPost]
        public ActionResult DeleteMOrder(string id)
        {
            if (Session["MemID"].ToString() != null)
            {
                if (!string.IsNullOrEmpty(id))
                {
                    var dta = db.SELLPRODUCT_DTA.Where(s => s.SlpID == id).ToList();
                    var result = _payRepository.DeletePayment(id,dta);
                    return RedirectToAction("MListOrder", "Member");
                }
                return RedirectToAction("Error404", "Shipping");
            }
            else
            {
                return RedirectToAction("Error404", "Shipping");
            }
        }

        [HttpPost]
        public ActionResult DeleteMOrderByEmp(string id)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                if (!string.IsNullOrEmpty(id))
                {
                    var dta = db.SELLPRODUCT_DTA.Where(s => s.SlpID == id).ToList();
                    var result = _payRepository.DeletePayment(id, dta);
                    return RedirectToAction("SalesManagement", "Sell");
                }
                return RedirectToAction("Login2", "Account");
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
    }
}
