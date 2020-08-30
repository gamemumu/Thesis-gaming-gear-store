using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ThesisGamingStore.Models
{
    public class RolesModel
    {
        public string RoleID { get; set; }
       
        [Required]
        [Remote("doesRoleNameExist", "Role", HttpMethod = "POST", ErrorMessage = "Role name already exists. Please enter a different role name.")]
        [Display(Name = "Role name")]
        public string RoleName { get; set; }
    }

    public class PosInRole
    {
        public string RoleID { get; set; }
        public string RoleName { get; set; }
        public string PosID { get; set; }
        public string PosName { get; set; }
        
    }

    public class UpdateRoleForPosModel
    {
        public string RoleID { get; set; }
        public string RoleName { get; set; }
        public string PosID { get; set; }
        public string PosName { get; set; }
        public string EmpID { get; set; }
        public string EmpName { get; set; }
    }
}