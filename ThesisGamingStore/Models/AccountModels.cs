using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ThesisGamingStore.Entity;

namespace ThesisGamingStore.Models
{
 
    public class LoginModel
    {
        [Required]
        [Display(Name = "User name")]
        public string UserName { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        public string Password { get; set; }

        [Display(Name = "Remember me?")]
        public bool RememberMe { get; set; }
    }

    public class RegisterModel
    {
        [Required]
        [Display(Name = "User name")]
        public string UserName { get; set; }

        [Required]
        [StringLength(100, ErrorMessage = "The {0} must be at least {2} characters long.", MinimumLength = 6)]
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        public string Password { get; set; }

        [DataType(DataType.Password)]
        [Display(Name = "Confirm password")]
        [Compare("Password", ErrorMessage = "The password and confirmation password do not match.")]
        public string ConfirmPassword { get; set; }
    }


    public partial class Employee
    {
        public Employee()
    {
        this.Phones = new HashSet<EMPLOYEE_PHONE>();
    }
        [Required]
        [Remote("doesUserNameExist", "Account", HttpMethod = "POST", ErrorMessage = "User name already exists. Please enter a different user name.")]
        [Display(Name = "User name")]
        public string UserName { get; set; }

        [Required]
        [StringLength(100, ErrorMessage = "The {0} must be at least {2} characters long.", MinimumLength = 0)] //*แก้ด้วย
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        public string Password { get; set; }

        [DataType(DataType.Password)]
        [Display(Name = "Confirm password")]
        [Compare("Password", ErrorMessage = "The password and confirmation password do not match.")]
        public string ConfirmPassword { get; set; }

        [Required(ErrorMessage = "Please enter your email")]
        [RegularExpression(@"\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*", ErrorMessage = "Invalid Email Format")] 
        [Display(Name = "Email")]
        public string Email { get; set; }

        [Required(ErrorMessage = "ID card number is Required")]

      //  [RegularExpression(@"^\d{1}-\d{4}-\d{5}-\d{2}-\d{1}", ErrorMessage = "Format for Idcard is x-xxxx-xxxxx-xx-x")]
        [StringLength(13, MinimumLength = 13, ErrorMessage = "ID card number should be less than {1} characters")]
       // [Remote("CheckDuplicateNIC", "hcm", "Employee Already Exists")]
        [Remote("doesIdCardExist", "Account", HttpMethod = "POST", ErrorMessage = "IdCard Already Exists")]
        [DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:c}")]
        [Display(Name = "Identity card")]
        public string Idcard { get; set; }

        [Display(Name = "EmployeeID")]
        public string EmpID { get; set; }
        //public string DepID { get; set; }
        public string PosID { get; set; }

        [Required]
        [RegularExpression(@"^[A-Z][a-zA-Z]*$", ErrorMessage = "Invalid First Name Format")]
        [Display(Name = "First Name")]
        public string Fname { get; set; }

        [Required]
        [RegularExpression(@"^[A-Z][a-zA-Z]*$", ErrorMessage = "Invalid Last Name Format")]
        [Display(Name = "Last Name")]
        public string Lname { get; set; }

        [Display(Name = "Address")]
        public string Address { get; set; }

        [Display(Name = "Sex")]
        public  string Sex { get; set; }

        [Required]
        //[RegularExpression(@"^-*[0-9,\.]+$", ErrorMessage = "Invalid Salary Format")]
        [Range(1.0, 10000000.0)]
        [Display(Name = "Salary")]
        public decimal Salary { get; set; }

        //[Required(ErrorMessage = "Phone number should be less than {9} characters")]
        //[StringLength(10, MinimumLength = 9, ErrorMessage = "Phone number should be less than {9} characters")]
        //[DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:c}")]
        //[Display(Name = "Phones"), DataType(DataType.PhoneNumber)]
        public virtual ICollection<EMPLOYEE_PHONE> Phones { get; set; }
        internal void CreatePhoneNumbers(int count = 1)
        {
            for (int i = 0; i < count; i++)
            {
                Phones.Add(new EMPLOYEE_PHONE());
            }
        }
    }
    public class LocalPasswordModel
    {
        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Current password")]
        public string OldPassword { get; set; }

        [Required]
        [StringLength(100, ErrorMessage = "The {0} must be at least {2} characters long.", MinimumLength = 6)]
        [DataType(DataType.Password)]
        [Display(Name = "New password")]
        public string NewPassword { get; set; }

        [DataType(DataType.Password)]
        [Display(Name = "Confirm new password")]
        [Compare("NewPassword", ErrorMessage = "The new password and confirmation password do not match.")]
        public string ConfirmPassword { get; set; }
    }
}