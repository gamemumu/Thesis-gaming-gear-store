using CrystalDecisions.CrystalReports.Engine;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ThesisGamingStore.Models;

namespace ThesisGamingStore.Controllers
{
    public class ReportController : Controller
    {
        //
        // GET: /Report/
        gamingstoreEntities db = new gamingstoreEntities();
        [HttpGet]
        [Authorize(Roles = "สิทธิจัดการออกรายงาน")]
        public ActionResult ViewReport()
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

        public ActionResult DataSellReport(DateTime dStart, DateTime dEnd)
        {
            var result = db.SELLPRODUCT_DTA.Where(w => w.SELLPRODUCT.SlpDate >= dStart && w.SELLPRODUCT.SlpDate <= dEnd
                && (w.SELLPRODUCT.SlpStatus.Equals("ส่งของแล้ว") || w.SELLPRODUCT.SlpStatus.Equals("เตรียมจัดส่งสินค้า")))
                .GroupBy(pl => new
                {
                    pl.PrdID,
                    ProName = pl.PRODUCT.BRAND.TRADEMARK.TrdName
                            + " " + pl.PRODUCT.BRAND.BrandName + " (" + pl.PRODUCT.COLOR.ClrName + ")"
                    // type = pl.PRODUCT.TYPEPRODUCT.TypeName
                })
                .Select(g => new TempSellReportModel
                {
                    //type = g.Key.type,
                    PrdID = g.Key.PrdID,
                    ProName = g.Key.ProName,
                    Amount =  g.AsEnumerable().Sum(j => j.SpdAmount),
                    Sumxx = g.AsEnumerable().Sum(j => j.SpdAmount * j.SpdPrice)
                })
                .ToList();
            ViewData["DataSellReport"] = result;
            Session["startDate"] = dStart;
            Session["endDate"] = dEnd;
            Session["DataSellReport"] = result;
            return PartialView("~/Views/Report/_DataSellReport.ascx", ViewData["DataSellReport"]);
        }
        public ActionResult DataProfitAndLossReport(DateTime dStart, DateTime dEnd)
        {
            //รายจ่าย
            var Expenses = db.ORDER_PRODUCT_DTA
                // .Where(w => w.ORDER_PRODUCT.OrdDate >= dStart && w.ORDER_PRODUCT.OrdDate <= dEnd)
                .GroupBy(pl => new
                {
                    pl.OFFERDETAIL.PrdID,
                    ProName = pl.OFFERDETAIL.PRODUCT.BRAND.TRADEMARK.TrdName + " " +
                              pl.OFFERDETAIL.PRODUCT.BRAND.BrandName + " " + pl.OFFERDETAIL.PRODUCT.COLOR.ClrName
                })
                .Select(g => new ProfitLossModels
                {
                    //type = g.Key.type,
                    PrdID = g.Key.PrdID,
                    ProName = g.Key.ProName,
                    Sum = g.AsEnumerable().Sum(j => (decimal?)j.OFFERDETAIL.Cost * j.OrdAmount),
                    AmountRemain = g.FirstOrDefault().OFFERDETAIL.PRODUCT.StockQuantity,
                    AmountOrder = g.AsEnumerable().Sum(j => j.OrdAmount),
                    AmountLotxx = db.PRODUCTLOT.Where(x => x.PrdID == g.Key.PrdID)
                                .GroupBy(pl => new { pl.PrdID })
                                .Select(v => new
                                {
                                    _Value = v.Sum(s => (int?)s.AmountRec),
                                }).FirstOrDefault()._Value
                })
                .ToList();

            //รายรับ
            var Income = db.SELLPRODUCT_DTA.Where(w => w.SELLPRODUCT.SlpDate >= dStart && w.SELLPRODUCT.SlpDate <= dEnd
              && (w.SELLPRODUCT.SlpStatus.Equals("ส่งของแล้ว") || w.SELLPRODUCT.SlpStatus.Equals("เตรียมจัดส่งสินค้า")))
              .GroupBy(pl => new
              {
                  pl.PrdID,
                  ProName = pl.PRODUCT.BRAND.TRADEMARK.TrdName
                          + " " + pl.PRODUCT.BRAND.BrandName + " " + pl.PRODUCT.COLOR.ClrName,
              })
              .Select(g => new ProfitLossModels
              {
                  PrdID = g.Key.PrdID,
                  ProName = g.Key.ProName,
                  INCOME = g.Sum(j => (decimal?)j.SpdAmount * j.SpdPrice),
                  amountSell = g.AsEnumerable().Sum(j => j.SpdAmount),
              })
              .ToList();
            //  ViewData["DataExpenses"] = Expenses;
            //  ViewData["DataIncome"] = Income;

            //สร้างข้อมูลเพื่อนเข้า Crytal Report 
            List<ProfitLossReportModels> dataSource = new List<ProfitLossReportModels>();
            foreach (var item in Expenses)
            {
                foreach (var item2 in Income)
                {
                    if (item2.PrdID == item.PrdID)
                    {
                        int amountLot = Convert.ToInt32(item.AmountLotxx);
                        dataSource.Add(new ProfitLossReportModels()
                        {
                            PrdID = item.PrdID
                            ,
                            ProName = item.ProName
                            ,
                            AmoutAll = amountLot,
                            AmountRemain = item.AmountOrder - amountLot == 0 ? item.AmountRemain : item.AmountRemain + (item.AmountOrder - amountLot)
                            ,
                            //AmoutSell = (amountLot - (item.AmountOrder - amountLot == 0 ? item.AmountRemain : item.AmountRemain + (item.AmountOrder - amountLot))),
                            AmoutSell = item2.amountSell,
                            rSumEXPENSES = item.Sum == null ? 0 : item.Sum ?? 0
                            ,
                            rINCOME = item2.INCOME == null ? 0 : item2.INCOME ?? 0
                            ,
                            rProfitLoss = (item2.INCOME - item.Sum) ?? 0    
                        });
                    }
                    else { continue; }
                }
            }
            Session["DataProfitAndLossReport"] = dataSource;
            Session["startDate"] = dStart;
            Session["endDate"] = dEnd;
            ViewData["DataProfitAndLossReport"] = dataSource;
            return PartialView("~/Views/Report/_DataProfitLosslReport.ascx");
        }
        public ActionResult DataYearReport(int year)
        {
            var result = db.SELLPRODUCT_DTA.Where(w => w.SELLPRODUCT.SlpDate.Year == year
               && (w.SELLPRODUCT.SlpStatus.Equals("ส่งของแล้ว") || w.SELLPRODUCT.SlpStatus.Equals("เตรียมจัดส่งสินค้า")))
                   .GroupBy(pl => new
                   {
                       Typename = pl.PRODUCT.TYPEPRODUCT.TypeName,
                       TypeId = pl.PRODUCT.TYPEPRODUCT.TypeProductID
                   })
                   .Select(g => new YearModel
                               {
                                   TypeId = g.Key.TypeId
                                   ,
                                   TypeName = g.Key.Typename
                                   ,
                                   Jan = g.AsEnumerable().Where(w => w.SELLPRODUCT.SlpDate.Month == 1)
                                     .Sum(j => (decimal?)j.SpdAmount * j.SpdPrice)
                                   ,
                                   Feb = g.AsEnumerable().Where(w => w.SELLPRODUCT.SlpDate.Month == 2)
                                    .Sum(j => (decimal?)j.SpdAmount * j.SpdPrice)
                                   ,
                                   Mar = g.AsEnumerable().Where(w => w.SELLPRODUCT.SlpDate.Month == 3)
                                    .Sum(j => (decimal?)j.SpdAmount * j.SpdPrice)
                                   ,
                                   Apr = g.AsEnumerable().Where(w => w.SELLPRODUCT.SlpDate.Month == 4)
                                  .Sum(j => (decimal?)j.SpdAmount * j.SpdPrice)
                                   ,
                                   May = g.AsEnumerable().Where(w => w.SELLPRODUCT.SlpDate.Month == 5)
                                    .Sum(j => (decimal?)j.SpdAmount * j.SpdPrice)
                                   ,
                                   Jun = g.AsEnumerable().Where(w => w.SELLPRODUCT.SlpDate.Month == 6)
                                    .Sum(j => (decimal?)j.SpdAmount * j.SpdPrice)
                                   ,
                                   Jul = g.AsEnumerable().Where(w => w.SELLPRODUCT.SlpDate.Month == 7)
                                   .Sum(j => (decimal?)j.SpdAmount * j.SpdPrice)
                                   ,
                                   Aug = g.AsEnumerable().Where(w => w.SELLPRODUCT.SlpDate.Month == 8)
                                   .Sum(j => (decimal?)j.SpdAmount * j.SpdPrice)
                                   ,
                                   Sep = g.AsEnumerable().Where(w => w.SELLPRODUCT.SlpDate.Month == 9)
                                    .Sum(j => (decimal?)j.SpdAmount * j.SpdPrice)
                                   ,
                                   Oct = g.AsEnumerable().Where(w => w.SELLPRODUCT.SlpDate.Month == 10)
                                    .Sum(j => (decimal?)j.SpdAmount * j.SpdPrice)
                                   ,
                                   Nov = g.AsEnumerable().Where(w => w.SELLPRODUCT.SlpDate.Month == 11)
                                    .Sum(j => (decimal?)j.SpdAmount * j.SpdPrice)
                                   ,
                                   Dec = g.AsEnumerable().Where(w => w.SELLPRODUCT.SlpDate.Month == 12)
                                    .Sum(j => (decimal?)j.SpdAmount * j.SpdPrice)
                               })
                   .ToList();
            //สร้างข้อมูลเพื่อนเข้า Crytal Report 
            List<YearModelReport> dataSource = new List<YearModelReport>();
            foreach (var item in result)
            {
                dataSource.Add(new YearModelReport()
                {
                    TypeId = item.TypeId
                    ,TypeName = item.TypeName
                    ,Jan = item.Jan??0
                    ,Feb = item.Feb??0
                    ,Mar = item.Mar??0
                    ,Apr = item.Apr??0
                    ,May = item.May??0
                    ,Jun = item.Jun??0
                    ,Jul = item.Jul??0
                    ,Aug = item.Aug??0
                    ,Sep = item.Sep??0
                    ,Oct = item.Oct??0
                    ,Nov = item.Nov??0
                    ,Dec = item.Dec??0
                });
            }
            ViewData["DataYearReport"] = result;
            Session["DataYearReport"] = dataSource;
            Session["Year"] = year;
            return PartialView("~/Views/Report/_DataYearReport.ascx", ViewData["DataYearReport"]);
        }
        public ActionResult DataClaimReport(DateTime dStart, DateTime dEnd)
        {
            //สร้างข้อมูลเพื่อนเข้า Crytal Report 
            List<RClaimReportModel> dataSource = new List<RClaimReportModel>();
            dataSource.Add(new RClaimReportModel() { typeName = "MOUSE", PrdID = "PRO00008", ProName = "Razer Taipan-White (White)", AmountClaim = 4 });
            dataSource.Add(new RClaimReportModel() { typeName = "JOYSTICKS", PrdID = "PRO00010", ProName = "Steelseries  Stratus Wireless Gaming Controller (Drak)", AmountClaim = 2 });
            dataSource.Add(new RClaimReportModel() { typeName = "HEADPHONE", PrdID = "PRO00008", ProName = "Steelseries  Siberia v2 (White)", AmountClaim = 5 });
            dataSource.Add(new RClaimReportModel() { typeName = "MOUSE", PrdID = "PRO00003", ProName = "Razer  Abyssus 2014 (Drak)", AmountClaim = 1 });
            ViewData["DataClaimReport"] = dataSource;
            Session["DataClaimReport"] = dataSource;
            Session["startDate"] = dStart;
            Session["endDate"] = dEnd;
            return PartialView("~/Views/Report/_DataClaimReport.ascx", ViewData["DataClaimReport"]);
        }
        #region Reports
        public ActionResult SellReport()
        {
            List<TempSellReportModel> allRecord = new List<TempSellReportModel>();
            allRecord = (List<TempSellReportModel>)Session["DataSellReport"];
            string start = Convert.ToDateTime(Session["startDate"].ToString()).ToString("dd/MM/yyyy");
            string end = Convert.ToDateTime(Session["endDate"].ToString()).ToString("dd/MM/yyyy");
            ReportDocument rd = new ReportDocument();
            rd.Load(Path.Combine(Server.MapPath("~/Reporting"), "SellReport.rpt"));
            rd.SetDatabaseLogon("g_root", "2525", "GAMEMUMU", "gamingstore");
            rd.SetDataSource(allRecord);
            rd.SetParameterValue("startDate", start);
            rd.SetParameterValue("endDate", end);
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

        public ActionResult ClaimReport()
        {
            List<RClaimReportModel> allRecord = new List<RClaimReportModel>();
            allRecord = (List<RClaimReportModel>)Session["DataClaimReport"];
            string start = Convert.ToDateTime(Session["startDate"].ToString()).ToString("dd/MM/yyyy");
            string end = Convert.ToDateTime(Session["endDate"].ToString()).ToString("dd/MM/yyyy");
            ReportDocument rd = new ReportDocument();
            rd.Load(Path.Combine(Server.MapPath("~/Reporting"), "ClaimReport.rpt"));
            rd.SetDatabaseLogon("g_root", "2525", "GAMEMUMU", "gamingstore");
            rd.SetDataSource(allRecord);
            rd.SetParameterValue("startDate", start);
            rd.SetParameterValue("endDate", end);
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
        public ActionResult ProfitAndLossReport()
        {
            List<ProfitLossReportModels> allRecord = new List<ProfitLossReportModels>();
            allRecord = (List<ProfitLossReportModels>)Session["DataProfitAndLossReport"];
            string start = Convert.ToDateTime(Session["startDate"].ToString()).ToString("dd/MM/yyyy");
            string end = Convert.ToDateTime(Session["endDate"].ToString()).ToString("dd/MM/yyyy");
            ReportDocument rd = new ReportDocument();
            rd.Load(Path.Combine(Server.MapPath("~/Reporting"), "ProfitLossReport.rpt"));
            rd.SetDatabaseLogon("g_root", "2525", "GAMEMUMU", "gamingstore");
            rd.SetDataSource(allRecord);
            rd.SetParameterValue("startDate", start);
            rd.SetParameterValue("endDate", end);
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
        public ActionResult YearReport()
        {
            List<YearModelReport> allRecord = new List<YearModelReport>();
            allRecord = (List<YearModelReport>)Session["DataYearReport"];
            string year = Session["Year"].ToString();
            ReportDocument rd = new ReportDocument();
            rd.Load(Path.Combine(Server.MapPath("~/Reporting"), "YearReport.rpt"));
            rd.SetDatabaseLogon("g_root", "2525", "GAMEMUMU", "gamingstore");
            rd.SetDataSource(allRecord);
            rd.SetParameterValue("yearData", year);
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

        public ActionResult JsonGetYear()
        {
            var result = db.SELLPRODUCT_DTA.Where(w => 
                (w.SELLPRODUCT.SlpStatus.Equals("ส่งของแล้ว") || w.SELLPRODUCT.SlpStatus.Equals("เตรียมจัดส่งสินค้า")))
                   .GroupBy(pl => new
                   {
                       Year = pl.SELLPRODUCT.SlpDate.Year
                   }).Select(g => new
                   {
                       g.Key.Year
                   })
                   .OrderByDescending(x => x.Year)
                   .ToList();
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        #region Temp
        // ยอดขายรายปีของแต่ละสินค้า
        //var result = db.SELLPRODUCT_DTA.Where(w => w.SELLPRODUCT.SlpDate.Year == year && w.SELLPRODUCT.SlpStatus.Equals("ส่งของแล้ว"))
        //      .GroupBy(pl => new
        //      {
        //          pl.PrdID,
        //          ProName = pl.PRODUCT.BRAND.TRADEMARK.TrdName
        //                  + " " + pl.PRODUCT.BRAND.BrandName
        //      })
        //      .Select(g => new YearModel
        //      {
        //          PrdID = g.Key.PrdID
        //          ,
        //          ProName = g.Key.ProName
        //          ,
        //          Jan = g.AsEnumerable().Where(w => w.SELLPRODUCT.SlpDate.Month == 1)
        //            .Sum(j => (decimal?)j.SpdAmount * j.SpdPrice)
        //          ,
        //          Feb = g.AsEnumerable().Where(w => w.SELLPRODUCT.SlpDate.Month == 2)
        //           .Sum(j => (decimal?)j.SpdAmount * j.SpdPrice)
        //          ,
        //          Mar = g.AsEnumerable().Where(w => w.SELLPRODUCT.SlpDate.Month == 3)
        //           .Sum(j => (decimal?)j.SpdAmount * j.SpdPrice)
        //          ,
        //          Apr = g.AsEnumerable().Where(w => w.SELLPRODUCT.SlpDate.Month == 4)
        //         .Sum(j => (decimal?)j.SpdAmount * j.SpdPrice)
        //          ,
        //          May = g.AsEnumerable().Where(w => w.SELLPRODUCT.SlpDate.Month == 5)
        //           .Sum(j => (decimal?)j.SpdAmount * j.SpdPrice)
        //          ,
        //          Jun = g.AsEnumerable().Where(w => w.SELLPRODUCT.SlpDate.Month == 6)
        //           .Sum(j => (decimal?)j.SpdAmount * j.SpdPrice)
        //          ,
        //          Jul = g.AsEnumerable().Where(w => w.SELLPRODUCT.SlpDate.Month == 7)
        //          .Sum(j => (decimal?)j.SpdAmount * j.SpdPrice)
        //          ,
        //          Aug = g.AsEnumerable().Where(w => w.SELLPRODUCT.SlpDate.Month == 8)
        //          .Sum(j => (decimal?)j.SpdAmount * j.SpdPrice)
        //          ,
        //          Sep = g.AsEnumerable().Where(w => w.SELLPRODUCT.SlpDate.Month == 9)
        //           .Sum(j => (decimal?)j.SpdAmount * j.SpdPrice)
        //          ,
        //          Oct = g.AsEnumerable().Where(w => w.SELLPRODUCT.SlpDate.Month == 10)
        //           .Sum(j => (decimal?)j.SpdAmount * j.SpdPrice)
        //          ,
        //          Nov = g.AsEnumerable().Where(w => w.SELLPRODUCT.SlpDate.Month == 11)
        //           .Sum(j => (decimal?)j.SpdAmount * j.SpdPrice)
        //          ,
        //          Dec = g.AsEnumerable().Where(w => w.SELLPRODUCT.SlpDate.Month == 12)
        //           .Sum(j => (decimal?)j.SpdAmount * j.SpdPrice)
        //      })
        //      .ToList();
        // ยอดขายรายปีของแต่ละสินค้า

        //รายจ่าย
        //var Expenses = db.ORDER_PRODUCT_DTA
        //   // .Where(w => w.ORDER_PRODUCT.OrdDate >= dStart && w.ORDER_PRODUCT.OrdDate <= dEnd)
        //    .GroupBy(pl => new
        //    {
        //        pl.OFFERDETAIL.PrdID,
        //        ProName = pl.OFFERDETAIL.PRODUCT.BRAND.TRADEMARK.TrdName + " " +
        //                  pl.OFFERDETAIL.PRODUCT.BRAND.BrandName + " " + pl.OFFERDETAIL.PRODUCT.COLOR.ClrName
        //    })
        //    .Select(g => new SellReportModel
        //    {
        //        //type = g.Key.type,
        //        PrdID = g.Key.PrdID,
        //        ProName = g.Key.ProName,
        //        Sum = g.AsEnumerable().Sum(j => (decimal?)j.OFFERDETAIL.Cost * j.OrdAmount),
        //        AmountLot = g.FirstOrDefault().OFFERDETAIL.PRODUCT.StockQuantity
        //    })
        //    .ToList();
        #endregion Temp
    }

}
