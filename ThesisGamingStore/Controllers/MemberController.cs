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
    public class MemberController : Controller
    {
        private IMemberDao _memRepository;
        gamingstoreEntities db = new gamingstoreEntities();
        public MemberController() : this(new SqlMember()) { }
        public MemberController(SqlMember _memRepository)
        {
            this._memRepository = _memRepository;
        }
        //
        // GET: /Member/
        #region Login สมาชิก
        public ActionResult mLogin()
        {
            if (Session["MEmail"] != null && Session["MemID"] != null)
                return RedirectToAction("Index", "Shipping");
            return View();
        }
        [HttpPost]
        public ActionResult mLogin(string email, string password)
        {
            if (Session["MEmail"] == null && Session["MemID"] == null)
            {
                var objUser = db.MEMBER.Where(m => m.MEmail == email && m.MPassword == password).FirstOrDefault();
                if (objUser != null)
                {
                    Session["MemID"] = objUser.MemID;
                    Session["MEmail"] = objUser.MEmail;
                    if (Session["cart"] != null)
                        return RedirectToAction("CheckOut", "Shipping");
                }
                return RedirectToAction("Index", "Shipping");
            }
            return RedirectToAction("Index", "Shipping");
        }
        public ActionResult mLogout()
        {
            if (Session["MEmail"] != null && Session["MemID"] != null)
            {
                Session["MemID"] = null;
                Session["MEmail"] = null;
                return RedirectToAction("Index", "Shipping");
            }
            return RedirectToAction("Index", "Shipping");
        }
        #endregion Login สมาชิก

        #region สมัครสมาชิก
        public ActionResult SignupMember()
        {
            if (Session["MEmail"] == null && Session["MemID"] == null)
                return View();
            return RedirectToAction("Index", "Shipping");
        }
        public ActionResult EditMember()
        {
            if (Session["MEmail"] != null && Session["MemID"] != null)
            {
                var MemID = Session["MemID"].ToString();
                var result = db.MEMBER.Where(x => x.MemID == MemID).FirstOrDefault();
                ViewData["MEditMem"] = result;
                return View();
            }
            return RedirectToAction("Index", "Shipping");
        }
         [HttpPost]
        public ActionResult EditMember(MEMBER model)
        {
            if (Session["MEmail"] != null && Session["MemID"] != null)
            {
                var resolveRequest = HttpContext.Request;
                resolveRequest.InputStream.Seek(0, SeekOrigin.Begin);
                string jsonString = new StreamReader(resolveRequest.InputStream).ReadToEnd();
                if (jsonString != null)
                {
                    List<string> phones = new List<string>();
                    dynamic jArr2 = Newtonsoft.Json.JsonConvert.DeserializeObject(jsonString);
                    try
                    {
                        foreach (dynamic item in jArr2)
                        {
                            string type = item.name.Value.ToString();
                            switch (type)
                            {
                                case "email": model.MEmail = item.value.Value; break;
                                case "inputFName": model.MFname = item.value.Value; break;
                                case "inputLName": model.MLname = item.value.Value; break;
                                case "address": model.MAddress = item.value.Value; break;
                                case "optradio": model.MSex = item.value.Value; break;
                                case "mobilePhone[]": model.MEMBER_PHONE.Add(new MEMBER_PHONE() { Phone = item.value.Value }); break;
                                // phones.Add(item.value.Value); break;
                            }
                            model.MemID = Session["MemID"].ToString();
                        }
                        if (_memRepository.UpdateMember(model))
                        {
                            var objUser = db.MEMBER.Where(m => m.MEmail == model.MEmail && m.MPassword == model.MPassword).FirstOrDefault();
                            if (objUser != null)
                            {
                                Session["MemID"] = objUser.MemID;
                                Session["MEmail"] = objUser.MEmail;
                            }
                            return RedirectToAction("Index", "Shipping");
                        }
                    }
                    catch
                    {
                        return Json(new { success = false }, JsonRequestBehavior.AllowGet);
                    }
                }
                return View();
            }
            return RedirectToAction("Index", "Shipping");
        }
        [HttpPost]
        public ActionResult CreateMember(MEMBER model)
        {

            var resolveRequest = HttpContext.Request;
            resolveRequest.InputStream.Seek(0, SeekOrigin.Begin);
            string jsonString = new StreamReader(resolveRequest.InputStream).ReadToEnd();
            if (jsonString != null)
            {
                List<string> phones = new List<string>();
                dynamic jArr2 = Newtonsoft.Json.JsonConvert.DeserializeObject(jsonString);
                try
                {
                    foreach (dynamic item in jArr2)
                    {
                        string type = item.name.Value.ToString();
                        switch (type)
                        {
                            case "email": model.MEmail = item.value.Value; break;
                            case "password": model.MPassword = item.value.Value; break;
                            case "inputFName": model.MFname = item.value.Value; break;
                            case "inputLName": model.MLname = item.value.Value; break;
                            case "address": model.MAddress = item.value.Value; break;
                            case "optradio": model.MSex = item.value.Value; break;
                            case "mobilePhone[]": model.MEMBER_PHONE.Add(new MEMBER_PHONE() { Phone = item.value.Value }); break;
                            // phones.Add(item.value.Value); break;
                        }
                    }
                    if (_memRepository.InsertMember(model))
                    {
                        var objUser = db.MEMBER.Where(m => m.MEmail == model.MEmail && m.MPassword == model.MPassword).FirstOrDefault();
                        if (objUser != null)
                        {
                            Session["MemID"] = objUser.MemID;
                            Session["MEmail"] = objUser.MEmail;
                        }
                        return RedirectToAction("Index", "Shipping");
                    }
                }
                catch
                {
                    return Json(new { success = false }, JsonRequestBehavior.AllowGet);
                }
            }
            return View();
        }
        [HttpPost]
        public JsonResult checkExist(string email)
        {
            var isAvailable = db.MEMBER.Where(m => m.MEmail == email).Count();
            if (isAvailable > 0)
            {
                return Json(new { valid = false }, JsonRequestBehavior.AllowGet);
            }
            return Json(new { valid = true }, JsonRequestBehavior.AllowGet);
        }
        #endregion สมัครสมาชิก

        #region สมัครสมาชิกโดยพนักงาน
        [HttpGet]
        [Authorize(Roles = "สิทธิจัดการสมาชิก")]
        public ActionResult SignupMemberByEmp()
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
        [Authorize(Roles = "สิทธิจัดการสมาชิก")]
        public ActionResult EditMemberByEmp(string MemID)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                var result = db.MEMBER.Where(x => x.MemID == MemID).FirstOrDefault();
                ViewData["MEditMemByEmp"] = result;
                Session["MemIDForEdit"] = MemID;
                return View();
            }
            return RedirectToAction("Login2", "Account");
        }
        [HttpPost]
        public ActionResult EditMemberByEmp(MEMBER model)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                var resolveRequest = HttpContext.Request;
                resolveRequest.InputStream.Seek(0, SeekOrigin.Begin);
                string jsonString = new StreamReader(resolveRequest.InputStream).ReadToEnd();
                if (jsonString != null)
                {
                    List<string> phones = new List<string>();
                    dynamic jArr2 = Newtonsoft.Json.JsonConvert.DeserializeObject(jsonString);
                    try
                    {
                        foreach (dynamic item in jArr2)
                        {
                            string type = item.name.Value.ToString();
                            switch (type)
                            {
                                case "email": model.MEmail = item.value.Value; break;
                                case "inputFName": model.MFname = item.value.Value; break;
                                case "inputLName": model.MLname = item.value.Value; break;
                                case "address": model.MAddress = item.value.Value; break;
                                case "optradio": model.MSex = item.value.Value; break;
                                case "mobilePhone[]": model.MEMBER_PHONE.Add(new MEMBER_PHONE() { Phone = item.value.Value }); break;
                                // phones.Add(item.value.Value); break;
                            }
                        }
                        model.MemID = Session["MemIDForEdit"].ToString();
                        if (_memRepository.UpdateMember(model))
                        {
                            Session["MemIDForEdit"] = null;
                            return RedirectToAction("ListMemberByEmp", "Member");
                        }
                    }
                    catch
                    {
                        return Json(new { success = false }, JsonRequestBehavior.AllowGet);
                    }
                }
                return View();
            }
            return RedirectToAction("Login2", "Account");
        }
        [HttpPost]
        public ActionResult CreateMemberByEmp(MEMBER model)
        {

            var resolveRequest = HttpContext.Request;
            resolveRequest.InputStream.Seek(0, SeekOrigin.Begin);
            string jsonString = new StreamReader(resolveRequest.InputStream).ReadToEnd();
            if (jsonString != null)
            {
                List<string> phones = new List<string>();
                dynamic jArr2 = Newtonsoft.Json.JsonConvert.DeserializeObject(jsonString);
                try
                {
                    foreach (dynamic item in jArr2)
                    {
                        string type = item.name.Value.ToString();
                        switch (type)
                        {
                            case "email": model.MEmail = item.value.Value; break;
                            case "password": model.MPassword = item.value.Value; break;
                            case "inputFName": model.MFname = item.value.Value; break;
                            case "inputLName": model.MLname = item.value.Value; break;
                            case "address": model.MAddress = item.value.Value; break;
                            case "optradio": model.MSex = item.value.Value; break;
                            case "mobilePhone[]": model.MEMBER_PHONE.Add(new MEMBER_PHONE() { Phone = item.value.Value }); break;
                            // phones.Add(item.value.Value); break;
                        }
                    }
                    if (_memRepository.InsertMember(model))
                    {
                        return RedirectToAction("ListMemberByEmp", "Member");
                    }
                }
                catch
                {
                    return Json(new { success = false }, JsonRequestBehavior.AllowGet);
                }
            }
            return View();
        }
        [HttpGet]
        [Authorize(Roles = "สิทธิจัดการสมาชิก")]
        public ActionResult ListMemberByEmp()
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                ViewData["ListMemberByEmp"] = db.MEMBER.Where(x => x.MStatus == "0").ToList();
                return View();
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        public ActionResult DeleteMember(string id)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                if (!string.IsNullOrEmpty(id))
                {
                    var result = _memRepository.DeleteMember(id);
                    return RedirectToAction("ListMemberByEmp", "Member");
                }
                return View();
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }

        #endregion สมัครสมาชิกโดยพนักงาน
        public ActionResult MListOrder()
        {
            if (Session["MemID"] != null)
            {
                var MemId = Session["MemID"].ToString();
                ViewData["Data"] = db.SELLPRODUCT.Where(l => l.MemID == MemId && l.SlpEnabled == "0").ToList();
                return View();
            }
            return RedirectToAction("Index", "Shipping");
        }
    }
}
