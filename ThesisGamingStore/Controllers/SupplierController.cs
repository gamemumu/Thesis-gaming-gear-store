using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ThesisGamingStore.Code;
using ThesisGamingStore.DataAccess;
using ThesisGamingStore.DataAccess.Core;
using ThesisGamingStore.Models;

namespace ThesisGamingStore.Controllers
{
    public class SupplierController : Controller
    {
        private ISupplierDao _supRepository;
        gamingstoreEntities db = new gamingstoreEntities();
        public SupplierController() :
            this(new SqlSupplier()
               )
        {
        }
        public SupplierController(SqlSupplier supRepository)
        {
            this._supRepository = supRepository;
        }

        [AllowAnonymous]
        public ActionResult CreateSup()
        {
            var sup = new SupplierModel();
            sup.CreatePhoneNumbers(2);
            return View(sup);
        }
        [HttpPost]
        public ActionResult CreateSup(SupplierModel sup)
        {
            if (ModelState.IsValid)
            {
                foreach (SUPPLIER_PHONE phone in sup.Phones.ToList())
                {
                    if (phone.DeletePhone == true)
                    {
                        // Delete Phone Numbers which is marked to remove
                        sup.Phones.Remove(phone);
                    }
                    if (phone.Phone == null)
                    {
                        // Delete Phone Numbers When Phone = null
                        sup.Phones.Remove(phone);
                    }
                }

                //เช็ค เบอร์ซ้ำ
                List<SUPPLIER_PHONE> pList = new List<SUPPLIER_PHONE>(sup.Phones);
                for (int i = 0; i < pList.Count; i++)
                {
                    for (int j = 0; j < pList.Count; j++)
                    {
                        if (pList[i].Phone.Equals(pList[j].Phone) && i != j)
                        {
                            ModelState.AddModelError("", "Please complete the following information,Phone Number Fail.");
                            return View(sup);
                        }
                    }
                }

                if (_supRepository.InsertSupAndPhone(Mapper.ToDto(sup), sup.Phones.ToList()) == false)
                {
                    ModelState.AddModelError("", "Please complete the following information,Phone Number Fail.");
                    return View(sup);
                }

                return RedirectToAction("ListSup");
            }
            ModelState.AddModelError("", "Please complete the following information.");
            //return Redirect("CreateSup");
            return View(sup);
        }

        [HttpGet]
        public ActionResult ListSup()
        {
            //var resutl = _supRepository.ListSupplier();
            // ViewData["ListSup"] = resutl;
            // return View();
            return View(db.SUPPLIER.ToList().Where(m => m.SubEnabled == "0"));
        }

        public ActionResult JsonListSupplier()
        {
            var result = _supRepository.ListSupplier();
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult EditSup(string SupID)
        {
            ThesisGamingStore.Models.SUPPLIER suppllier = db.SUPPLIER.Find(SupID);
            var result = Mapper.ToDto2(suppllier);
            if (suppllier == null)
            {
                return HttpNotFound();
            }
            return View(result);
        }

        [HttpPost]
        public ActionResult EditSup(SupplierModel supplier)
        {
            foreach (SUPPLIER_PHONE phone in supplier.Phones.ToList())
            {
                if (phone.DeletePhone == true)
                {
                    // Delete Phone Numbers which is marked to remove
                    supplier.Phones.Remove(phone);
                }
                if (phone.Phone == null)
                {
                    // Delete Phone Numbers When Phone = null
                    supplier.Phones.Remove(phone);
                }
            }

            //เช็ค เบอร์ซ้ำ
            List<SUPPLIER_PHONE> pList = new List<SUPPLIER_PHONE>(supplier.Phones);
            for (int i = 0; i < pList.Count; i++)
            {
                for (int j = 0; j < pList.Count; j++)
                {
                    if (pList[i].Phone.Equals(pList[j].Phone) && i != j)
                    {
                        ModelState.AddModelError("", "Please complete the following information,Phone Number Fail.");
                        return View(supplier);
                    }
                }
            }
            if (_supRepository.UpdateSupplier(Mapper.ToDto(supplier), supplier.Phones.ToList()) == false)
            {
                ModelState.AddModelError("", "Please complete the following information,Phone Number Fail.");
                return View(supplier);
            }
            return RedirectToAction("ListSup", "Supplier");
        }

        public ActionResult DeleteSup(string SupID)
        {
            ThesisGamingStore.Models.SUPPLIER sup = db.SUPPLIER.Find(SupID);
            if (sup == null)
            {
                return HttpNotFound();
            }
            return View(sup);
        }

        [HttpPost, ActionName("DeleteSup")]
        public ActionResult DeleteConfirmed(string SupID)
        {
            _supRepository.DeleteSupplier(SupID);
            return RedirectToAction("ListSup", "Supplier");
        }

        //เช็คว่ามีชื่อ username ซ้ำกับ database หรือไม่
        [HttpPost]
        public JsonResult doesSupNameExist(string SupName)
        {

            bool user = _supRepository.CheckNameSup(SupName);
            if (user)
            {
                return Json("The supplier name has been taken", JsonRequestBehavior.AllowGet);
            }
            return Json(true, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public JsonResult doessupPhoneExist(ICollection<SUPPLIER_PHONE> Phones)
        {

            foreach (var ls in Phones.ToList())
            {
                if (ls.DeletePhone == true || ls.Phone == null)
                {
                    // Delete Phone Numbers which is marked to remove
                    Phones.Remove(ls);
                }
                else if (_supRepository.CheckPhone(ls.Phone) == true)
                {
                    return Json("Phone Already Exists", JsonRequestBehavior.AllowGet);
                }
            }
            return Json(true, JsonRequestBehavior.AllowGet);
        }
    }

}