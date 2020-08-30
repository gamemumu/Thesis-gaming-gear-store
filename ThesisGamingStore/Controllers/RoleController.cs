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
    public class RoleController : Controller
    {
        private IRoleDao _roleRepository;
       // private IPositionDao _posRepository;
        //private IDepartmentDao _depRepository;

        /// <summary>
        /// Default Constructor for AuthController.
        /// </summary>
        public RoleController() :
            this(new SqlRole())
        {
        }
        public RoleController(SqlRole roleRepository)
        {
            this._roleRepository = roleRepository;
        }
        //
        // GET: /Role/

        public ActionResult CreateRole()
        {
            return View();
        }

        [HttpPost]
        public ActionResult CreateRole(RolesModel model)
        {
            if (ModelState.IsValid)
            {   
                _roleRepository.InsertRole(Mapper.ToDto(model));
                return RedirectToAction("ListRoles");
            }
            return View(model);
        }

        [HttpPost]
        public JsonResult doesRoleNameExist(string roleName)
        {
            // string CurrentURL = System.Web.HttpContext.Current.Request.UrlReferrer.LocalPath.Substring(10);


            string CurrentURL = System.Web.HttpContext.Current.Request.UrlReferrer.Segments[2]; //ดูหน้าเพจว่าอยู่หน้า CREATE or EDIT
            if (CurrentURL.Equals("EditRole"))
            {
                //ถ้า อยู่ในหน้า EDIT จะเช็คจากไอดีอื่นว่ามีชื่ออื่นซ้ำไหมถ้าไม่ใช่ ID ตัวเอง
                string Id = System.Web.HttpContext.Current.Request.UrlReferrer.Query.Split('=')[1];
                bool unique = _roleRepository.CheckUnique(roleName.Replace(" ", string.Empty), Id);
                if (unique)
                {
                    return Json("The role name has been taken", JsonRequestBehavior.AllowGet);
                }
                return Json(true, JsonRequestBehavior.AllowGet);
            }
            else
            {
                //กรณีสร้างใหม่ไม่มี ID ให้เช็คจะตรวจสอบชื่อจากทุกอัน
                bool unique = _roleRepository.CheckUnique(roleName.Replace(" ", string.Empty), "CREATE");
                if (unique)
                {
                    return Json("The role name has been taken", JsonRequestBehavior.AllowGet);
                }
                return Json(true, JsonRequestBehavior.AllowGet);
            }
        }
        public ActionResult ListRole()
        {
            var result = _roleRepository.ListRole();
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult ListRoles()
        {
            var result = _roleRepository.ListRole();
            return View(Mapper.ToDto(result));
        }
        [HttpGet]
        public ActionResult EditRole(string RoleID)
        {
            var ressult = _roleRepository.GetRole(RoleID);
            return View(Mapper.ToDto(ressult));
        }
        [HttpPost]
        public ActionResult EditRole(RolesModel model)
        {
            if (ModelState.IsValid)
            {
                if(_roleRepository.UpdateRole(Mapper.ToDto(model)) == true)
                {
                    return RedirectToAction("ListRoles");
                }
            }
            return View(model);
        }
        public ActionResult DeleteRole(string RoleID)
        {
            var result = _roleRepository.GetRole(RoleID);
            return View(Mapper.ToDto(result));
        }
        [HttpPost]
        public ActionResult DeleteRole(RolesModel model)
        {
            var result = _roleRepository.DeleteRole(model.RoleID);
            return RedirectToAction("ListRoles");
        }
        public ActionResult UpdateRoleForPos()
        {

            return View();
        }

        public ActionResult ListRolesAndPos()
        {
            var result = _roleRepository.ListRole();
            return Json(result, JsonRequestBehavior.AllowGet);
        }
    }
}
