//using CrystalDecisions.CrystalReports.Engine;
using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ThesisGamingStore.Code;
using ThesisGamingStore.DataAccess;
using ThesisGamingStore.DataAccess.Core;
using ThesisGamingStore.Models;

namespace ThesisGamingStore.Controllers
{
    public class OrderController : Controller
    {
        #region Constructor

        private IOfferDao _offerRepository;
        private IOrderDao _orderRepository;
        private IReceiveOrderDao _receiveRepository;
        public OrderController() :
            this(new SqlOffer(), new SqlOrder(), new SqlReceive()
              )
        {
        }
        public OrderController(SqlOffer offerRepository, SqlOrder orderRepository, SqlReceive receiveRepository)
        {
            this._offerRepository = offerRepository;
            this._orderRepository = orderRepository;
            this._receiveRepository = receiveRepository;
        }
        #endregion Constructor

        [HttpGet]
        [Authorize(Roles = "สิทธิการสั่งซื้อสินค้า")]
        public ActionResult CreateOrder()
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                //var result = _offerRepository.ListOfferForOrder("SUP00003");
                ViewBag.DateNowOrder = System.DateTime.Now.ToString("yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture);
                return View();
                // return View(Mapper.ToDto(result));
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }



        [HttpPost]
        [Authorize(Roles = "สิทธิการสั่งซื้อสินค้า")]
        public ActionResult CreateOrder(OrderModel model)
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
                        try
                        {
                            foreach (dynamic item in jArr2)
                            {
                                foreach (var subitem in item.SupID)
                                {
                                    model.SupID = subitem.SupID;
                                }

                                foreach (var total in item.Total)
                                {
                                    model.TotalCost = total.Total;
                                }
                                List<OrderDetailModel> myDeserializedObjList = item.dataTable.ToObject<List<OrderDetailModel>>();
                                model.EmpID = Session["S_EmpID"].ToString();
                                model.OrdDate = System.DateTime.Now.ToString("yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture);
                                var map_order = Mapper.ToDto(model);
                                var map_orderDta = Mapper._ToDto(myDeserializedObjList);
                                string OdrID = _orderRepository.InsertOrder(map_order, map_orderDta);
                                Session["OrdID"] = OdrID;
                            }
                            return Json(new { success = true }, JsonRequestBehavior.AllowGet);
                        }
                        catch
                        {
                            return Json(new { success = false }, JsonRequestBehavior.AllowGet);
                        }
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

        #region Reports
        //public ActionResult OrderReport()
        //{
        //    ReportDocument rd = new ReportDocument();
        //    rd.Load(Path.Combine(Server.MapPath("~/Reporting"), "OrderReport.rpt"));
        //    rd.SetDatabaseLogon("g_root", "2525", "GAMEMUMU", "gamingstore");
        //    rd.SetParameterValue("OrdID", Session["OrdID"].ToString());
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

        public ActionResult JsonOffApprove(string id)
        {
            var result = _offerRepository.ListOfferForOrder(id);
            return Json(result, JsonRequestBehavior.AllowGet);
        }


        public ActionResult OrderDetail(string id, string SupName)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                var result = _offerRepository.GetListOffer(id);
                Session["OffID"] = id;
                ViewBag.OffID = id;
                ViewBag.SupName = SupName.Replace("/undefined", "");
                if (result == null)
                {
                    return new HttpNotFoundResult();
                }
                return PartialView("~/Views/Order/_ListOrderProductModal.ascx", Mapper.ToDto(result));
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }

        public ActionResult JsonOrderDetails(string id, string SupName)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                var result = _offerRepository.GetListOffer(id);
                Session["OffID"] = id;
                ViewBag.OffID = id;
                ViewBag.SupName = SupName.Replace("/undefined", "");

                if (result == null)
                {
                    return new HttpNotFoundResult();
                }
                return Json(Mapper.ToDto(result), JsonRequestBehavior.AllowGet);
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }

        public ActionResult JsonOrderDetailsList(OrderModel model)
        {
            var resolveRequest = HttpContext.Request;
            resolveRequest.InputStream.Seek(0, SeekOrigin.Begin);
            string jsonString = new StreamReader(resolveRequest.InputStream).ReadToEnd();
            ArrayList listOfObjects = new ArrayList();
            if (jsonString != null)
            {
                if (Session["S_EmpID"].ToString() != null)
                {
                    dynamic jArr2 = Newtonsoft.Json.JsonConvert.DeserializeObject(jsonString);
                    foreach (dynamic item in jArr2)
                    {
                        var a = _offerRepository.GetListOffer(item.OffID.ToString());
                        listOfObjects.Add(a);
                    }
                    return Json(listOfObjects, JsonRequestBehavior.AllowGet);
                }
                return RedirectToAction("Login2", "Account");
            }
            return View();
        }

        public ActionResult JsonGetTotal()
        {
            var resolveRequest = HttpContext.Request;
            resolveRequest.InputStream.Seek(0, SeekOrigin.Begin);
            string jsonString = new StreamReader(resolveRequest.InputStream).ReadToEnd();
            decimal sum = 0;
            if (jsonString != null)
            {
                if (Session["S_EmpID"].ToString() != null)
                {
                    List<string> myDeserializedObjList = (List<string>)Newtonsoft.Json.JsonConvert.DeserializeObject(jsonString, typeof(List<string>));
                    foreach (var ls in myDeserializedObjList)
                    {
                        foreach (var i in _offerRepository.GetListOffer(ls))
                        {
                            sum += (i.Cost * i.AmountApprove);
                        }
                    }
                }
                return Json(sum, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Login2", "Account");
        }

        //รายการสินค้าที่สั่งซื้อ จากใบเสนอแล้ว
        [HttpGet]
        public ActionResult OrderList()
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                var result = _orderRepository.ListOrder();
                return View(Mapper.ToDto(result));
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        public ActionResult OrderDetails(string id, string SupName)
        {
            if (Session["S_EmpID"].ToString() != null)
            {
                Session["OrdID"] = id;
                ViewBag.OrdID = id;
                ViewBag.SupName = SupName.Replace("/undefined", "");
                var Old = _orderRepository.GetListOrderOLD(id);
                if (Old.Count == 0)
                {
                    var New = _orderRepository.GetListOrderNEW(id);

                    if (New == null)
                    {
                        return new HttpNotFoundResult();
                    }
                    ViewData["Flag"] = "DataNew";
                    return PartialView("~/Views/Order/_OrderDetails.ModalPreview.ascx", Mapper.ToDto(New));
                }
                ViewData["Flag"] = "DataOld";
                return PartialView("~/Views/Order/_OrderDetails.ModalPreview.ascx", Mapper.ToDto(Old));
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        public ActionResult Test(string id, string SupName)
        {
            if (Session["S_EmpID"].ToString() != null)
            {
                Session["OrdID"] = id;
                ViewBag.OrdID = id;
                ViewBag.SupName = SupName.Replace("/undefined", "");
                var Old = _orderRepository.GetListOrderOLD(id);
                if (Old.Count == 0)
                {
                    var New = _orderRepository.GetListOrderNEW(id);

                    if (New == null)
                    {
                        return new HttpNotFoundResult();
                    }
                    ViewData["Flag"] = "DataNew";
                    return PartialView("~/Views/Order/Partial1Test.ascx", Mapper.ToDto(New));
                }
                ViewData["Flag"] = "DataOld";
                return PartialView("~/Views/Order/Partial1Test.ascx", Mapper.ToDto(Old));
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }

        [HttpPost]
        public ActionResult ReceiveProduct(ReceiveModel model)
        {
            if (Session["S_EmpID"] != null)
            {
                var resolveRequest = HttpContext.Request;
                resolveRequest.InputStream.Seek(0, SeekOrigin.Begin);
                string jsonString = new StreamReader(resolveRequest.InputStream).ReadToEnd();
                List<SERIAL> listOfObjects = new List<SERIAL>();
                if (jsonString != null)
                {
                    if (Session["S_EmpID"].ToString() != null)
                    {

                        dynamic jArr2 = Newtonsoft.Json.JsonConvert.DeserializeObject(jsonString);
                        try
                        {
                            foreach (dynamic item in jArr2)
                            {
                                foreach (var serial in item.serial)
                                {
                                    bool i = true; string temp = "";
                                    foreach (var data in serial)
                                    {
                                        if (i)
                                        {
                                            temp = data.Value;
                                            i = false;
                                        }else{
                                            listOfObjects.Add(new SERIAL() { PrdID = temp, SrlID = data.Value });
                                        }
                                    }
                                }
                                List<ReceiveDetailModel> myDeserializedObjList = item.dataTable.ToObject<List<ReceiveDetailModel>>();
                                model.EmpID = Session["S_EmpID"].ToString();
                                model.RecODate = System.DateTime.Now.ToString("yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture);
                                _receiveRepository.InsertReceive(model, myDeserializedObjList, listOfObjects);
                                return Json(new { success = true }, JsonRequestBehavior.AllowGet);
                            }
                        }
                        catch
                        {
                            return Json(new { success = false }, JsonRequestBehavior.AllowGet);
                        }
                    }
                    return RedirectToAction("Login2", "Account");
                }
                return View();
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
            //    var resolveRequest = HttpContext.Request;
            //    resolveRequest.InputStream.Seek(0, SeekOrigin.Begin);
            //    string jsonString = new StreamReader(resolveRequest.InputStream).ReadToEnd();
            //    if (jsonString != null)
            //    {
            //      //  List<ReceiveDetailModel> myDeserializedObjList = (List<ReceiveDetailModel>)Newtonsoft.Json.JsonConvert.DeserializeObject(jsonString, typeof(List<ReceiveDetailModel>));
            //        List<ReceiveDetailModel> myDeserializedObjList = item.dataTable.ToObject<List<ReceiveDetailModel>>();
            //        model.EmpID = Session["S_EmpID"].ToString();
            //        model.RecODate = System.DateTime.Now.ToString("yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture);
            //        //var map_update = Mapper._ToDto2(myDeserializedObjList);
            //        //_offerRepository.UpdateOffer(map_update, Session["OffID"].ToString(), Session["S_EmpFname"].ToString());
            //        _receiveRepository.InsertReceive(model, myDeserializedObjList);
            //        return Json(new { success = true }, JsonRequestBehavior.AllowGet);
            //    }
            //    return Json(new { success = false }, JsonRequestBehavior.AllowGet);
            //}
            //return RedirectToAction("Login2", "Account");
        }
    }
}
