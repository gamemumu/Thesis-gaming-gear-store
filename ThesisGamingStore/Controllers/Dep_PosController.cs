using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ThesisGamingStore.Code;
using ThesisGamingStore.DataAccess;
using ThesisGamingStore.DataAccess.Core;
using ThesisGamingStore.Entity;
using ThesisGamingStore.Models;

namespace ThesisGamingStore.Controllers
{
    public class Dep_PosController : Controller
    {

        private IDepartmentDao _depRepository;
        private IPositionDao _posRepository;
        /// <summary>
        /// Default Constructor for AuthController.
        /// </summary>
        public Dep_PosController() :
            this(new SqlDepartment(),
                 new SqlPosition()
                 )
        {
        }
        public Dep_PosController(SqlDepartment depRepository, SqlPosition posRepository)
        {
            this._depRepository = depRepository;
            this._posRepository = posRepository;
        }
        //
        // GET: /Dep_Pos/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Test()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Test(PositionModel model)
        {
            if (ModelState.IsValid)
            {
                return View();
            }
            return View(model);
        }

        public ActionResult View1()
        {
            return View();
        }

        #region dep
        public ActionResult CreateDep()
        {
            return View();
        }

        [HttpPost]
        public ActionResult CreateDep(DepartmentModel model)
        {
            if (ModelState.IsValid)
            {
                _depRepository.InsertDepartment(Mapper.ToDto(model));
                return RedirectToAction("ListDeparts");
            }
            return View(model);
        }

        public ActionResult ListDeparts()
        {
            var result = _depRepository.ListDepartment();
            return View(Mapper.ToDto(result));
        }

        [HttpGet]
        public ActionResult EditDep(string DepID)
        {
            var ressult = _depRepository.GetDepartment(DepID);
            return View(Mapper.ToDto(ressult));
        }
        [HttpPost]
        public ActionResult EditDep(DepartmentModel model)
        {
            if (ModelState.IsValid)
            {
                if (_depRepository.UpdateDepartment(Mapper.ToDto(model)) == true)
                {
                    return RedirectToAction("ListDeparts");
                }
            }
            return View(model);
        }
        public ActionResult DeleteDep(string DepID)
        {
            var result = _depRepository.GetDepartment(DepID);
            return View(Mapper.ToDto(result));
        }
        [HttpPost]
        public ActionResult DeleteDep(DepartmentModel  model)
        {
            var result = _depRepository.DeleteDepartment(model.DepID);
            return RedirectToAction("ListDeparts");
        }


        [HttpPost]
        public JsonResult doesDepNameExist(string DepName)
        {
            // string CurrentURL = System.Web.HttpContext.Current.Request.UrlReferrer.LocalPath.Substring(10);
            string CurrentURL = System.Web.HttpContext.Current.Request.UrlReferrer.Segments[2]; //ดูหน้าเพจว่าอยู่หน้า CREATE or EDIT
            if (CurrentURL.Equals("EditDep"))
            {
                //ถ้า อยู่ในหน้า EDIT จะเช็คจากไอดีอื่นว่ามีชื่ออื่นซ้ำไหมถ้าไม่ใช่ ID ตัวเอง
                string Id = System.Web.HttpContext.Current.Request.UrlReferrer.Query.Split('=')[1];
                bool unique = _depRepository.CheckNameUnique(DepName.Replace(" ", string.Empty), Id);
                if (unique)
                {
                    return Json("The department name has been taken", JsonRequestBehavior.AllowGet);
                }
                return Json(true, JsonRequestBehavior.AllowGet);
            }
            else
            {
                //กรณีสร้างใหม่ไม่มี ID ให้เช็คจะตรวจสอบชื่อจากทุกอัน
                bool unique = _depRepository.CheckNameUnique(DepName.Replace(" ", string.Empty), "CREATE");
                if (unique)
                {
                    return Json("The department name has been taken", JsonRequestBehavior.AllowGet);
                }
                return Json(true, JsonRequestBehavior.AllowGet);
            }
        }
#endregion dep





        public ActionResult CreatePos2()
        {
            return View();
        }

        [HttpPost]
        public ActionResult CreatePos2(PositionModel model)
        {
            if (ModelState.IsValid)
            {
                string UPDATEDATA = "INSERT";
                List<PosInRole> myDeserializedObjList = (List<PosInRole>)Newtonsoft.Json.JsonConvert.DeserializeObject(model.Temp, typeof(List<PosInRole>));
                var map_pos = Mapper.ToDto(model);
                var map_role = Mapper._ToDto(myDeserializedObjList);
                _posRepository.InsertPosandRole(map_pos, map_role, UPDATEDATA);
                return RedirectToAction("Index", "Home");
            }
            return View(model);
        }

        public ActionResult ListPosit()
        {
            var result = _posRepository.ListPosition();
            ViewData["Listpos"] = result;
            return View();
        }
        public ActionResult JsonListPosit()
        {
            var result = _posRepository.ListPosition();
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult ListDepart()
        {
            var result = _depRepository.ListDepartment();
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        //เช็คว่ามีชื่อสิทธ์ ซ้ำกับ database หรือไม่

        [HttpPost]
        public JsonResult doesPosNameExist(string posName)
        {
              // string CurrentURL = System.Web.HttpContext.Current.Request.UrlReferrer.LocalPath.Substring(10);
            string CurrentURL = System.Web.HttpContext.Current.Request.UrlReferrer.Segments[2]; //ดูหน้าเพจว่าอยู่หน้า CREATE or EDIT
            if (CurrentURL.Equals("EditPosInRole"))
            {
                //ถ้า อยู่ในหน้า EDIT จะเช็คจากไอดีอื่นว่ามีชื่ออื่นซ้ำไหมถ้าไม่ใช่ ID ตัวเอง
                string Id = System.Web.HttpContext.Current.Request.UrlReferrer.Query.Split('=')[1].Substring(0, 8);
                bool unique = _posRepository.CheckUnique(posName.Replace(" ", string.Empty), Id);
                if (unique)
                {
                    return Json("The permission name has been taken", JsonRequestBehavior.AllowGet);
                }
                return Json(true, JsonRequestBehavior.AllowGet);
            }
            else
            {
                //กรณีสร้างใหม่ไม่มี ID ให้เช็คจะตรวจสอบชื่อจากทุกอัน
                bool unique = _posRepository.CheckUnique(posName.Replace(" ", string.Empty), "CREATE");
                if (unique)
                {
                    return Json("The permission name has been taken", JsonRequestBehavior.AllowGet);
                }
                return Json(true, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult EditPosInRole(String PosID, String DepID,String PosName,String DepName)
        {
            if (!string.IsNullOrEmpty(PosID) && !string.IsNullOrEmpty(DepID))
            {
                var result = _posRepository.GetListPosition(PosID, DepID);
                if (result.Count > 0) { 
                Session["ListposInRole"] = result;
                return View(new PositionModel
                    {
                        DepID = result.First().DepID,
                        DepName = result.First().DepName,
                        PosID = result.First().PosID,
                        PosName = result.First().PosName,
                    });
                }
                else
                {
                    return View(new PositionModel
                    {
                        DepID = DepID,
                        DepName = DepName,
                        PosID = PosID,
                        PosName = PosName,
                    });
                }
            }
            return View();
        }

        [HttpPost]
        public ActionResult EditPosInRole(PositionModel model)
        {
            if (ModelState.IsValid)
            {
                string UPDATEDATA = "UPDATE";
                //_posRepository.DeletePosition(model.PosID);
                List<PosInRole> myDeserializedObjList = (List<PosInRole>)Newtonsoft.Json.JsonConvert.DeserializeObject(model.Temp, typeof(List<PosInRole>));
                var map_pos = Mapper.ToDto(model);
                var map_role = Mapper._ToDto(myDeserializedObjList);
                _posRepository.InsertPosandRole(map_pos, map_role, UPDATEDATA);
                return RedirectToAction("ListPosit", "Dep_Pos");
            }
            return View(model);
        }

        [HttpPost]
        public ActionResult DeletePos(string id)
        {
            if (!string.IsNullOrEmpty(id))
            {
                var result = _posRepository.DeletePositionForEnabled(id);
                return RedirectToAction("ListPosit", "Dep_Pos");
            }
            return View();
        }

        public ActionResult JsonEditPosInRole()
        {
            var result = Session["ListposInRole"];
            Session["ListposInRole"] = null;
            return Json(result, JsonRequestBehavior.AllowGet);
        }
    }
}
