using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using ThesisGamingStore.Code;
using ThesisGamingStore.DataAccess;
using ThesisGamingStore.DataAccess.Core;
using ThesisGamingStore.Entity;
using ThesisGamingStore.Models;
using ThesisGamingStore.Models.Role;

namespace ThesisGamingStore.Controllers
{
    public class AccountController : Controller
    {

        private IEmployeeDao _empRepository;
        gamingstoreEntities db = new gamingstoreEntities();
        public AccountController() :
            this(new SqlEmployee()
               )
        {
        }
        public AccountController(SqlEmployee empRepository)
        {
            this._empRepository = empRepository;
        }
        //
        // GET: /Account/

        public ActionResult noPermission()
        {
            if (Session["S_EmpID"] != null)
            {
                //ViewBag.Message = Session["S_EmpFname"].ToString() + "No permission join to url.";
                ViewBag.Message = " You do not have permission to access this section.";
                return View();
            }
            else { 
            return RedirectToAction("Login2", "Account");
            }
        }
        [AllowAnonymous]
        public ActionResult CreateEmp()
        {
            var employee = new Employee();
            employee.CreatePhoneNumbers(2);
            return View(employee);
        }
        [HttpPost]
        public ActionResult CreateEmp(Employee employee)
        {
            if (ModelState.IsValid)
            {
                string UPDATEDATA = "INSERT";
                foreach (EMPLOYEE_PHONE phone in employee.Phones.ToList())
                {
                    if (phone.DeletePhone == true)
                    {
                        // Delete Phone Numbers which is marked to remove
                        employee.Phones.Remove(phone);
                    }
                    if (phone.Phone == null)
                    {
                        // Delete Phone Numbers When Phone = null
                        employee.Phones.Remove(phone);
                    }
                }
                //เช็ค เบอร์ซ้ำ
                List<EMPLOYEE_PHONE> pList = new List<EMPLOYEE_PHONE>(employee.Phones);
                for (int i = 0; i < pList.Count; i++)
                {
                    if (pList[i].Phone.Length < 6 || pList[i].Phone.Length > 15)
                    {
                        ModelState.AddModelError("", "Phone number should be less than {9} characters.");
                        return View(employee);
                    }
                    for (int j = 0; j < pList.Count; j++)
                    {
                        if (pList[i].Phone.Equals(pList[j].Phone) && i != j)
                        {
                            ModelState.AddModelError("", "Please complete the following information,Phone Number Fail.");
                            return View(employee);
                        }
                    }
                }

                if (_empRepository.InsertEmpAndPhone(Mapper.ToDto(employee), employee.Phones.ToList(), UPDATEDATA) == false)
                {
                    ModelState.AddModelError("", "Please complete the following information,Phone Number Fail.");
                    return View(employee);
                }
                return RedirectToAction("ListEmp2");
            }
            ModelState.AddModelError("", "Please complete the following information.");
            return View(employee);
        }



        [HttpGet]
        public ActionResult ListEmp2()
        {
            var resutl = _empRepository.ListEmployee();
            ViewData["ListEmp"] = resutl;
            return View();
        }
        public ActionResult Edit(string EmpID)
        {
            ThesisGamingStore.Models.EMPLOYEE employee = db.EMPLOYEE.Find(EmpID);
            var result = Mapper.ToDto2(employee);
            if (employee == null)
            {
                return HttpNotFound();
            }
            return View(result);
        }

        //for
        [HttpPost]
        public ActionResult Edit(Employee employee)
        {
            string UPDATEDATA = "UPDATE";
            foreach (EMPLOYEE_PHONE phone in employee.Phones.ToList())
            {
                if (phone.DeletePhone == true)
                {
                    // Delete Phone Numbers which is marked to remove
                    employee.Phones.Remove(phone);
                }
                if (phone.Phone == null)
                {
                    // Delete Phone Numbers When Phone = null
                    employee.Phones.Remove(phone);
                }
            }
            //เช็ค เบอร์ซ้ำ
            List<EMPLOYEE_PHONE> pList = new List<EMPLOYEE_PHONE>(employee.Phones);
            for (int i = 0; i < pList.Count; i++)
            {
                for (int j = 0; j < pList.Count; j++)
                {
                    if (pList[i].Phone.Equals(pList[j].Phone) && i != j)
                    {
                        ModelState.AddModelError("", "Please complete the following information,Phone Number Fail.");
                        return View(employee);
                    }
                }
            }
            if (_empRepository.InsertEmpAndPhone(Mapper.ToDto(employee), employee.Phones.ToList(), UPDATEDATA) == false)
            {
                ModelState.AddModelError("", "Please complete the following information,Phone Number Fail.");
                return View(employee);
            }
            return RedirectToAction("ListEmp2", "Account");
        }

        public ActionResult DeleteEmp(string EmpID)
        {
            ThesisGamingStore.Models.EMPLOYEE employee = db.EMPLOYEE.Find(EmpID);
            if (employee == null)
            {
                return HttpNotFound();
            }
            return View(employee);
        }

        [HttpPost, ActionName("DeleteEmp")]
        public ActionResult DeleteConfirmed(string EmpID)
        {
            _empRepository.DeleteEmployee(EmpID);
            return RedirectToAction("ListEmp2", "Account");
        }

        [AllowAnonymous]
        public ActionResult Login(string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;
            return View();
        }

        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult Login(LoginModel model, string returnUrl)
        {
            if (ModelState.IsValid)
            {
                if (SqlEmployee.UserIsValid(model.UserName, model.Password))
                {
                    FormsAuthentication.SetAuthCookie(model.UserName, model.RememberMe);// checkbox ture or false sto saving cookie
                
                    if (Url.IsLocalUrl(returnUrl) && returnUrl.Length > 1 && returnUrl.StartsWith("/")
                       && !returnUrl.StartsWith("//") && !returnUrl.StartsWith("/\\"))
                    {
                        return Redirect(returnUrl);
                    }
                    else
                    {
                        //Redirect to default page
                        return RedirectToAction("RedirectToDefault");
                    }
                }
                ModelState.AddModelError("LogOnError", "The user name or password provided is incorrect.");
            }
            return View();
        }

        [AllowAnonymous]
        public ActionResult Login2(string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;
            return View();
        }

        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult Login2(LoginModel model, string returnUrl)
        {
            if (ModelState.IsValid)
            {
                if (SqlEmployee.UserIsValid(model.UserName, model.Password))
                {
                    FormsAuthentication.SetAuthCookie(model.UserName, model.RememberMe);// checkbox ture or false sto saving cookie
                    var sessionEmp = db.EMPLOYEE.FirstOrDefault(x => x.Username == model.UserName);
                    Session["S_EmpID"] = sessionEmp.EmpID;
                    ViewBag.S_EmpID = sessionEmp.EmpID;
                    ViewData["S_EmpID"] = sessionEmp.EmpID;
                    Session["S_EmpFname"] = sessionEmp.Fname;
                    if (Url.IsLocalUrl(returnUrl) && returnUrl.Length > 1 && returnUrl.StartsWith("/")
                       && !returnUrl.StartsWith("//") && !returnUrl.StartsWith("/\\"))
                    {
                        return Redirect(returnUrl);
                    }
                    else
                    {
                        //Session["EmpId"] = 
                        //Redirect to default page 
                        return RedirectToAction("RedirectToDefault");
                       // return RedirectToAction("OfferCreate", "Products");
                    }
                }
                ModelState.AddModelError("LogOnError", "The user name or password provided is incorrect.");
            }
            return View();
        }


        //### ไปหน้าแรกของ สิทธ์พนักงานนั้นๆ
        public ActionResult RedirectToDefault()
        {

            String[] roles = Roles.GetRolesForUser();

            if (roles.Contains("Admin"))
            {
                return RedirectToAction("Index", "Home");
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
        }

        [AllowAnonymous]
        public ActionResult LogOff()
        {
            Session.Clear();
            Session["S_EmpID"] = null;
            Session["S_EmpFname"] = null;
            ViewData["S_EmpID"] = null;
            FormsAuthentication.SignOut();
            return RedirectToAction("Login2");
        }

        [HttpGet]
        public ActionResult RegisterEmp()
        {
            return View();
        }

        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult RegisterEmp(Employee model)
        {
            return View();
        }


        //เช็คว่ามีชื่อ username ซ้ำกับ database หรือไม่
        [HttpPost]
        public JsonResult doesUserNameExist(string UserName)
        {

            bool user = DataAccess.SqlEmployee.GetUserNames(UserName.Replace(" ", string.Empty));
            if (user)
            {
                return Json("The username has been taken", JsonRequestBehavior.AllowGet);
            }
            return Json(true, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public JsonResult doesIdCardExist(string Idcard)
        {

            bool id_c = DataAccess.SqlEmployee.GetIdCard(Idcard.Replace(" ", string.Empty));
            if (id_c)
            {
                return Json("IdCard Already Exists", JsonRequestBehavior.AllowGet);
            }
            return Json(true, JsonRequestBehavior.AllowGet);
        }

        //        [HttpGet]
        //        public ActionResult ListEmp()
        //        {

        ////            var query = db.EMPLOYEE.SqlQuery(@"SELECT [EmpID]
        ////                                              ,e.PosID as Temp
        ////	                                          ,p.PosName as PosID
        ////                                              ,[Idcard]
        ////                                              ,[Email]
        ////                                              ,[Fname]
        ////                                              ,[Lname]
        ////                                              ,[Address]
        ////                                              ,[Sex]
        ////                                              ,[Salary]
        ////                                              ,[Username]
        ////                                              ,[Password]
        ////                                              ,[Status]
        ////                                          FROM [EMPLOYEE] as e , [POSITION] as p where p.PosID = e.PosID");

        //            //var test = (from emp in db.EMPLOYEE
        //            //            join pos in db.POSITION on emp.PosID equals pos.PosID
        //            //            join phone in db.EMPLOYEE_PHONE on emp.EmpID equals phone.EmpID
        //            //            orderby emp.PosID
        //            //            select new
        //            //            {
        //            //                emp.EmpID,
        //            //                PosID = pos.PosName,
        //            //                emp.Idcard,
        //            //                emp.Email,
        //            //                emp.Fname,
        //            //                emp.Lname,
        //            //                emp.Address,
        //            //                emp.Sex,
        //            //                emp.Salary,
        //            //                emp.Username,
        //            //                emp.Password,
        //            //                phone.Phone,
        //            //                emp.Status,
        //            //            }).ToList();

        //            //var sql = test.ToString();

        //            return View(db.EMPLOYEE.ToList().Where(m => m.EStatus == "0"));
        //        }
    }
}
