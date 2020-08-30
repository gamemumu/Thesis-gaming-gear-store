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
    public class SellController : Controller
    {
        //
        // GET: /Sell/
        gamingstoreEntities db = new gamingstoreEntities();
        private IPaymentDao _payRepository;
        public SellController() : this(new SqlPayment()) { }
        public SellController(SqlPayment _payRepository)
        {
            this._payRepository = _payRepository;
        }
        public ActionResult SalesManagement()
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                ViewData["LSalesManagement"] = db.SELLPRODUCT.Where(s => s.SlpEnabled == "0" &&  s.SlpStatus != "ส่งของแล้ว" && s.SlpStatus != "เตรียมจัดส่งสินค้า" ).ToList();
                return View();
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        public ActionResult Info(string SlpID)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                var _SlpID = SlpID.Replace("/undefined", "");
                var result = db.SELLPRODUCT_DTA.Where(s => s.SlpID == _SlpID).ToList();
                ViewData["EDetailOrder"] = result;
                ViewBag.SldID = _SlpID;
                return PartialView("~/Views/Sell/__EOrderDetailProduct.Modal.ascx", ViewData["EDetailOrder"]);
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        public ActionResult DetailPayment(string SlpID)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                var _SlpID = SlpID.Replace("/undefined", "");
                var result = db.PAYMENT.Where(s => s.SlpID == _SlpID).ToList();
                ViewData["PaymentDetail"] = result;
                ViewBag.SldID = _SlpID;
                return PartialView("~/Views/Sell/_PaymentDetail.Modal.ascx", ViewData["PaymentDetail"]);
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }

        public ActionResult ListSalesManagement()
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                ViewData["ListSalesManagement"] = db.SELLPRODUCT.Where(s => s.SlpEnabled == "0" && s.SlpStatus == "ส่งของแล้ว").ToList();
                return View();
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        public ActionResult ConfirmPayment(string SldID)
        {
            if (_payRepository.UpdateStatus(SldID, "ยืนยันการชำระเงิน"))
                return Json(new { success = true }, JsonRequestBehavior.AllowGet);
            return Json(new { success = false }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult MOrderConfirm(string SldID)
        {
            var data = db.SELLPRODUCT_DTA.Where(s => s.SlpID == SldID).ToList();
            if (_payRepository.UpdateStock(SldID, "เตรียมจัดส่งสินค้า",data))
                return Json(new { success = true }, JsonRequestBehavior.AllowGet);
            return Json(new { success = false }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult MOrderError(string SldID, decimal PayCheck)
        {
            var data = db.SELLPRODUCT_DTA.Where(s => s.SlpID == SldID).ToList();
            if (_payRepository.UpdatePayError(SldID, "ชำระเงินไม่ครบ",PayCheck))
                return Json(new { success = true }, JsonRequestBehavior.AllowGet);
            return Json(new { success = false }, JsonRequestBehavior.AllowGet);
        }
    }
}
