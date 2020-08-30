//using CrystalDecisions.CrystalReports.Engine;
using System;
using System.Collections.Generic;
using System.Data.Objects.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ThesisGamingStore.Models;

namespace ThesisGamingStore.Controllers
{
    public class ClaimController : Controller
    {
        //
        // GET: /Claim/
        gamingstoreEntities db = new gamingstoreEntities();
        [HttpGet]
        [Authorize(Roles = "สิทธิจัดการเคลมสินค้า")]
        public ActionResult ClaimMember()
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
        public ActionResult GetDataMember(string INPUT)
        {
            if (INPUT.Substring(0, 3).ToUpper().Equals("SLP"))
            {
                var a = db.SELLPRODUCT_DTA_SERIA.Where(w => w.SlpID == INPUT.ToUpper()).ToList();
                ViewData["ListMemberClaim"] = a;
            }
            else
            {
                var b = db.SELLPRODUCT_DTA_SERIA.Where(w => w.SERIAL.SrlID.ToUpper() == INPUT.ToUpper()).ToList();
                ViewData["ListMemberClaim"] = b;

            }
            return PartialView("~/Views/Claim/_MemberListProductForClaim.ascx");
        }
        [HttpGet]
        [Authorize(Roles = "สิทธิจัดการเคลมสินค้า")]
        public ActionResult ListProductForClaim()
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

        [HttpGet]
        [Authorize(Roles = "สิทธิจัดการเคลมสินค้า")]
        public ActionResult ReciveClaim()
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                List<ReceiveClaimModel> dataSource = new List<ReceiveClaimModel>();
                dataSource.Add(new ReceiveClaimModel() { CLMID= "CLM00001", CLMDate = "20/04/2015", EmpName = "abadon ab",SupName="Com7"});
                ViewData["ReceiveClaim"] = dataSource;
                return View();
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }

        public ActionResult GetData(string SupID, string Se)
        {
            if (Se.Equals("0"))
            {
                ViewData["ListProductForClaim"] = db.PRODUCTLOT.Where(x => x.Amount > 0 && x.RECEIVEORDER_DTA.ORDER_PRODUCT_DTA.ORDER_PRODUCT.SUPPLIER.SupID == SupID && x.PRODUCT.SerialStatus == Se)
                    .OrderBy(x => x.PRODUCT.SerialStatus)
                    .ToList();
                ViewData["Serial"] = null;
            }
            else
            {
                var result = db.PRODUCTLOT
                 .Where(w => w.SERIAL.Any(s => s.SrlStatus == "0" && s.PRODUCTLOT.RECEIVEORDER_DTA.ORDER_PRODUCT_DTA.ORDER_PRODUCT.SupID == SupID))
                    //  .Select(s => new { SERIAL = s.SERIAL.Where(x=>x.SrlStatus == "48vgNT9y").FirstOrDefault()})
                    .ToList();
                List<ICollection<SERIAL>> a = result.Select(x => x.SERIAL).ToList();
                ViewData["Serial"] = a;
                ViewData["ListProductForClaim"] = null;
            }
            return PartialView("~/Views/Claim/_ListProductForClaim.ascx");
        }

        public ActionResult GetData7Day()
        {
            ViewData["List7Day"] = db.CLAIM_MEMBER_CHANG7DAY
                .Where(x => x.CcmStatus == "0")
                .ToList();
            return PartialView("~/Views/Claim/_Change7Day.ascx");
        }

        public JsonResult JsonListMemberClaim()
        {
            var result = db.CLAIM_MEMBER.Where(x => x.MClmStatus.Equals("รอการส่งเคลม"))
                 .Select(g => new
                 {
                     g.MClmID,
                     MClmDate = SqlFunctions.DateName("day", g.MClmDate).Trim() + "/" +
                     SqlFunctions.StringConvert((double)g.MClmDate.Month).TrimStart() + "/" +
                     SqlFunctions.DateName("year", g.MClmDate),
                     Name = g.EMPLOYEE.Fname + " " + g.EMPLOYEE.Lname,
                     g.MClmStatus
                 }).ToList();
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public JsonResult JsonDetailMemberClaim(string id)
        {
            //var result = db.CLAIM_MEMBER_DTA.Where(x => x.MClmID == id)
            //     .Select(g => new
            //     {
            //         g.MClmID,
            //         g.SlpID,
            //         g.SlpNo,
            //         g.SrlID,
            //         g.PrdID,
            //         g.LotNo,
            //         g.MClmProp,
            //         NameProduct = g.SELLPRODUCT_DTA_SERIA.SERIAL.PRODUCTLOT.PRODUCT.BRAND.TRADEMARK.TrdName + " " +
            //         g.SELLPRODUCT_DTA_SERIA.SERIAL.PRODUCTLOT.PRODUCT.BRAND.BrandName,
            //     }).ToList();
            List<TempCLAIM_MEMBER_DTA> result = new List<TempCLAIM_MEMBER_DTA>();
            result.Add(new TempCLAIM_MEMBER_DTA() { NameProduct = "Logitech  Driving Force GT (Drak)", SrlID = "te2vCV3G", MClmProp = "ตอบสนองช้า" });
            return Json(result, JsonRequestBehavior.AllowGet);
        }


        #region Reports
        //public ActionResult MClaimReport()
        //{
        //    ReportDocument rd = new ReportDocument();
        //    rd.Load(Path.Combine(Server.MapPath("~/Reporting"), "MClaimReport.rpt"));
        //    rd.SetDatabaseLogon("g_root", "2525", "GAMEMUMU", "gamingstore");
        //    //  rd.SetParameterValue("DivID", Session["RDlvID"].ToString());
        //    Response.Buffer = false;
        //    Response.ClearContent();
        //    Response.ClearHeaders();
        //    try
        //    {
        //        Stream stream = rd.ExportToStream(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
        //        stream.Seek(0, SeekOrigin.Begin);
        //        Response.AppendHeader("Content-Disposition", "inline; filename=foo.pdf");
        //        return File(stream, "application/pdf");
        //    }
        //    catch (Exception ex)
        //    {
        //        throw;
        //    }
        //}

        //public ActionResult OClaimReport()
        //{
        //    ReportDocument rd = new ReportDocument();
        //    rd.Load(Path.Combine(Server.MapPath("~/Reporting"), "OClaimReport.rpt"));
        //    rd.SetDatabaseLogon("g_root", "2525", "GAMEMUMU", "gamingstore");
        //    //  rd.SetParameterValue("DivID", Session["RDlvID"].ToString());
        //    Response.Buffer = false;
        //    Response.ClearContent();
        //    Response.ClearHeaders();
        //    try
        //    {
        //        Stream stream = rd.ExportToStream(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
        //        stream.Seek(0, SeekOrigin.Begin);
        //        Response.AppendHeader("Content-Disposition", "inline; filename=foo.pdf");
        //        return File(stream, "application/pdf");
        //    }
        //    catch (Exception ex)
        //    {
        //        throw;
        //    }
        //}
        #endregion Reports
    }
}
