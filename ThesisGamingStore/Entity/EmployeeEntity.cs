using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ThesisGamingStore.Entity
{
    public class EmployeeEntity
    {
   
        public string EmpID { get; set; }
        public string PosID { get; set; }
        public string Idcard { get; set; }
        public string Email { get; set; }
        public string Fname { get; set; }
        public string Lname { get; set; }
        public string Address { get; set; }
        public string Sex { get; set; }
        public decimal Salary { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
       
    }
}