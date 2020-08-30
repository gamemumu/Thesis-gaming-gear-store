using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ThesisGamingStore.Models
{
    public class MemberModels
    {
        public string MemID { get; set; }
        public string MFname { get; set; }
        public string MLname { get; set; }
        public string MAddress { get; set; }
        public string MSex { get; set; }
        [Required(ErrorMessage = "Please enter your email")]
        [RegularExpression(@"\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*", ErrorMessage = "Invalid Email Format")]
        //[Remote("doesEmailNameExist", "Member", HttpMethod = "POST", ErrorMessage = "Email address already exists. Please enter a different email.")]
        [Display(Name = "Email Address")]
        public string MEmail { get; set; }
        [Required]
        [StringLength(100, ErrorMessage = "The {0} must be at least {2} characters long.", MinimumLength = 4)] //*แก้ด้วย
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        public string MPassword { get; set; }
        [DataType(DataType.Password)]
        [Display(Name = "Confirm password")]
        [Compare("MPassword", ErrorMessage = "The password and confirmation password do not match.")]
        public string ConfirmPassword { get; set; }
        public string MStatus { get; set; }
    }
}