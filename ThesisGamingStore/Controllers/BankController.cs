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
    public class BankController : Controller
    {
          private IBankDao _BankRepository;
          public BankController() : this(new SqlBank()){}
          public BankController(SqlBank _BankRepository)
          {
            this._BankRepository = _BankRepository;
          }
        //
        // GET: /Bank/

        public ActionResult CreateBank()
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                List<SelectListItem> li = new List<SelectListItem>();
                li.Add(new SelectListItem { Text = "ธนาคารกรุงเทพ", Value = "ธนาคารกรุงเทพ" });
                li.Add(new SelectListItem { Text = "ธนาคารกรุงศรีอยุธยา", Value = "ธนาคารกรุงศรีอยุธยา" });
                li.Add(new SelectListItem { Text = "ธนาคารกสิกรไทย", Value = "ธนาคารกสิกรไทย" });
                li.Add(new SelectListItem { Text = "ธนาคารกรุงไทย", Value = "ธนาคารกรุงไทย" });
                li.Add(new SelectListItem { Text = "ธนาคารไทยพาณิชย์", Value = "ธนาคารไทยพาณิชย์" });
                ViewData["bankname"] = li;
                return View();
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        [HttpPost]
        public ActionResult CreateBank(BANK model)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                if (ModelState.IsValid)
                {
                    _BankRepository.InsertBank(model);
                    return RedirectToAction("ListBank");
                }
                ModelState.AddModelError("", "Please complete the following information !");
                return View();
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        [HttpGet]
        public ActionResult EditBank(string BnkAccNumber)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                List<SelectListItem> li = new List<SelectListItem>();
                li.Add(new SelectListItem { Text = "ธนาคารกรุงเทพ", Value = "ธนาคารกรุงเทพ" });
                li.Add(new SelectListItem { Text = "ธนาคารไทยธนาคาร", Value = "ธนาคารไทยธนาคาร" });
                li.Add(new SelectListItem { Text = "ธนาคารกรุงศรีอยุธยา", Value = "ธนาคารกรุงศรีอยุธยา" });
                li.Add(new SelectListItem { Text = "ธนาคารกสิกรไทย", Value = "ธนาคารกสิกรไทย" });
                li.Add(new SelectListItem { Text = "ธนาคารกรุงไทย", Value = "ธนาคารกรุงไทย" });
                li.Add(new SelectListItem { Text = "ธนาคารนครหลวงไทย", Value = "ธนาคารนครหลวงไทย" });
                li.Add(new SelectListItem { Text = "ธนาคารไทยพาณิชย์", Value = "ธนาคารไทยพาณิชย์" });
                li.Add(new SelectListItem { Text = "ธนาคารสแตนดาร์ดชาร์เตอร์", Value = "ธนาคารสแตนดาร์ดชาร์เตอร์" });
                li.Add(new SelectListItem { Text = "ธนาคารทหารไทย", Value = "ธนาคารทหารไทย" });
                li.Add(new SelectListItem { Text = "ธนาคารยูโอบี", Value = "ธนาคารยูโอบี" });
                ViewData["bankname"] = li;
                var result = _BankRepository.GetBank(BnkAccNumber);
                return View(result);
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        [HttpPost]
        public ActionResult EditBank(BANK model)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                if (ModelState.IsValid)
                {
                    if (_BankRepository.UpdateBank(model) == true)
                    {
                        return RedirectToAction("ListBank");
                    }
                }
                return View(model);
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        public ActionResult DeleteBank(BANK model)
        {
            if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                var result = _BankRepository.DeleteBank(model.BnkAccNumber);
                return RedirectToAction("ListBank");
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }
        public ActionResult ListBank()
        {
           if (Session["S_EmpID"] != null && Session["S_EmpFname"] != null)
            {
                var result = _BankRepository.ListBank();
                return View(result);
            }
            else
            {
                return RedirectToAction("Login2", "Account");
            }
        }

        [HttpPost]
        public JsonResult doesBankAccountExist(string BnkAccNumber)
        {
            string CurrentURL = System.Web.HttpContext.Current.Request.UrlReferrer.Segments[2]; //ดูหน้าเพจว่าอยู่หน้า CREATE or EDIT
            if (CurrentURL.Equals("EditBank"))
            {
                //ถ้า อยู่ในหน้า EDIT จะเช็คจากไอดีอื่นว่ามีชื่ออื่นซ้ำไหมถ้าไม่ใช่ ID ตัวเอง
                string Id = System.Web.HttpContext.Current.Request.UrlReferrer.Query.Split('=')[1];
                bool unique = _BankRepository.CheckName(BnkAccNumber.Replace(" ", string.Empty), Id);
                if (unique)
                {
                    return Json("เลขที่บัญชีนี้มีอยู่ในระบบแล้ว", JsonRequestBehavior.AllowGet);
                }
                return Json(true, JsonRequestBehavior.AllowGet);
            }
            else
            {
                //กรณีสร้างใหม่ไม่มี ID ให้เช็คจะตรวจสอบชื่อจากทุกอัน
                bool unique = _BankRepository.CheckName(BnkAccNumber.Replace(" ", string.Empty), "CREATE");
                if (unique)
                {
                    return Json("เลขที่บัญชีนี้มีอยู่ในระบบแล้ว", JsonRequestBehavior.AllowGet);
                }
                return Json(true, JsonRequestBehavior.AllowGet);
            }

        }
    }
}
