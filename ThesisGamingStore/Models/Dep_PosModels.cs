using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Runtime.Serialization;

namespace ThesisGamingStore.Models
{
    public class DepartmentModel
    {
        public string DepID { get; set; }
        [Required]
        [Remote("doesDepNameExist", "Dep_Pos", HttpMethod = "POST", ErrorMessage = "Department name already exists. Please enter a different department name.")]
        [Display(Name = "Department Name")]
        public string DepName { get; set; }
    }
    public class PositionModel
    {
        public string PosID { get; set; }
        public string DepID { get; set; }
        [Required]
        [Remote("doesPosNameExist", "Dep_Pos", HttpMethod = "POST", ErrorMessage = "Position name already exists. Please enter a different position name.")]
        [Display(Name = "Position name")]
        public string PosName { get; set; }
        public string DepName { get; set; }
        public string Temp { get; set; }

    }

    public class PosInRoleModel
    {
        public string RoleID { get; set; }
        public string PosID { get; set; }
    }
    public class PosInRoleDetailDto
    {
        public string RoleID { get; set; }
        public string RoleName { get; set; }
        public string PosID { get; set; }
        public string PosName { get; set; }
    }
}