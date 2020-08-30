using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ThesisGamingStore.Entity;
using ThesisGamingStore.Models;

namespace ThesisGamingStore.DataAccess.Core
{
    interface IEmployeeDao
    {
        bool InsertEmployee(EmployeeEntity employee);
        bool InsertEmpAndPhone(EmployeeEntity employee, ICollection<EMPLOYEE_PHONE> list, string UPDATEDATA);
        bool UpdateEmployee(EmployeeEntity employee);
        bool DeleteEmployee(string empID);
        List<EmpPosDetial> ListEmployee();
        //List<MultiPhoneEmpEntity> ListEmployee(string EmpID);
        List<EmployeeEntity> ListEmployee(int pageSize, int pageNum);
        EmployeeEntity GetEmployee(string empID);
    }
}
