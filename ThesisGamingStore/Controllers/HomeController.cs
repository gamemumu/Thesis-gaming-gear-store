using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ThesisGamingStore.Controllers
{
   
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            ViewBag.Message = "Modify this template to jump-start your ASP.NET MVC application.";
            return View();
        }

        [Authorize(Roles = "สิทธิในการจัดการข้อมูล")]
        public ActionResult About()
        {
            ViewBag.Message = "Your app description page.";

            return View();
        }


         [Authorize(Roles = "Admin,สิทธิในการรับสินค้า")]
        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}
