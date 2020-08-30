using CrystalDecisions.CrystalReports.Engine;
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
    public class EShippingController : Controller
    {
        //
        // GET: /EShipping/
        gamingstoreEntities db = new gamingstoreEntities();
        private ISellDao _sellRepository;
        public EShippingController() : this(new SqlSellProduct()) { }
        public EShippingController(SqlSellProduct _sellRepository)
        {
            this._sellRepository = _sellRepository;
        }
        [HttpGet]
        [Authorize(Roles = "สิทธิการจัดส่งสินค้า")]
        public ActionResult ShippingManagement()
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                ViewData["LShippingManagement"] = db.SELLPRODUCT.Where(s => s.SlpEnabled == "0" && s.SlpStatus == "เตรียมจัดส่งสินค้า").ToList();
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

        public ActionResult Delivery(string SlpID)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                var _SlpID = SlpID.Replace("/undefined", "");
                var result = db.SELLPRODUCT_DTA.Where(s => s.SlpID == _SlpID).ToList();
                ViewData["EDelivery"] = result;
                ViewBag.SldID = _SlpID;
                return PartialView("~/Views/EShipping/_EDelivery.Modal.ascx", ViewData["EDelivery"]);
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }

        public ActionResult ModalListDelivery(string SlpID)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                var _SlpID = SlpID.Replace("/undefined", "");
                var result = db.SELLPRODUCT_DTA.Where(s => s.SlpID == _SlpID).ToList();
                ViewData["EModalDelivery"] = result;
                ViewBag.SldID = _SlpID;
                ViewBag.DivID = result.FirstOrDefault().SELLPRODUCT.DELIVER.FirstOrDefault().DlvID;
                ViewBag.EMS = result.FirstOrDefault().SELLPRODUCT.DELIVER.FirstOrDefault().DlvSerial;
                return PartialView("~/Views/EShipping/_EDeliveryForList.Modal.ascx", ViewData["EModalDelivery"]);
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        [HttpPost]
        public ActionResult CreateDeliver(string SlpID,string EMS)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                string DlvID = "";
                DELIVER model = new DELIVER();
                model.EmpID = Session["S_EmpID"].ToString();
                model.DlvSerial = EMS;
                model.SlpID = SlpID;
                model.DlvDate = DateTime.Now;
                if ((DlvID = _sellRepository.InsertDeliver(model)) != "")
                {
                    Session["RDlvID"] = DlvID;
                    return Json(true, JsonRequestBehavior.AllowGet);
                }
                return Json(false, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
         [HttpPost]
        public ActionResult EditDeliver(string DivID,string SlpID, string EMS)
        {

            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                DELIVER model = new DELIVER();
                model.EmpID = Session["S_EmpID"].ToString();
                model.DlvSerial = EMS;
                model.SlpID = SlpID;
                model.DlvDate = DateTime.Now;
                model.DlvID = DivID;
                if (_sellRepository.UpdateDeliver(model))
                    return Json(true, JsonRequestBehavior.AllowGet);
                return Json(false, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
         [HttpGet]
         [Authorize(Roles = "สิทธิการจัดส่งสินค้า")]
        public ActionResult ListDeliver()
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                ViewData["ListDeliver"] = db.DELIVER.Where(d => d.DlvEnabled == "0").ToList();
                return View();
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        public ActionResult JGetSerial(string SlpID, string PrdID)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {   
                 var _SlpID = SlpID.Replace("/undefined", "");
                 var result = db.SELLPRODUCT_DTA_SERIA
                     .Where(s => s.SlpID == _SlpID && s.PrdID == PrdID)
                     .Select(p => p.SERIAL)
                     .ToList();
                  ViewData["EDeliverySerial"] = result;
                 return PartialView("~/Views/EShipping/_EDeliverySerial.Modal.ascx", ViewData["EDeliverySerial"]);
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }

        #region Reports
        public ActionResult DeliverReport()
        {
            ReportDocument rd = new ReportDocument();
            rd.Load(Path.Combine(Server.MapPath("~/Reporting"), "DeliverReport.rpt"));
            rd.SetDatabaseLogon("g_root", "2525", "GAMEMUMU", "gamingstore");
            rd.SetParameterValue("DivID", Session["RDlvID"].ToString());
            Response.Buffer = false;
            Response.ClearContent();
            Response.ClearHeaders();
            try
            {
                Stream stream = rd.ExportToStream(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
                stream.Seek(0, SeekOrigin.Begin);
                Response.AppendHeader("Content-Disposition", "inline; filename=foo.pdf");
                return File(stream, "application/pdf");
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public ActionResult DeliverReportID(string id)
        {
            ReportDocument rd = new ReportDocument();
            rd.Load(Path.Combine(Server.MapPath("~/Reporting"), "DeliverReport.rpt"));
            rd.SetDatabaseLogon("g_root", "2525", "GAMEMUMU", "gamingstore");
            rd.SetParameterValue("MyParameter", id);
            Response.Buffer = false;
            Response.ClearContent();
            Response.ClearHeaders();
            try
            {
                Stream stream = rd.ExportToStream(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
                stream.Seek(0, SeekOrigin.Begin);
                Response.AppendHeader("Content-Disposition", "inline; filename=foo.pdf");
                return File(stream, "application/pdf");
            }
            catch (Exception ex)
            {
                throw;
            }
        }
        #endregion Reports
    }
}
