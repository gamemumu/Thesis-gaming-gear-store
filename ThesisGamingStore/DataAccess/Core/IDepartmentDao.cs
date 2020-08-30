using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ThesisGamingStore.Entity;

namespace ThesisGamingStore.DataAccess.Core
{
    interface IDepartmentDao
    {
        bool InsertDepartment(DepartmentEntity department);
        bool UpdateDepartment(DepartmentEntity department);
        bool DeleteDepartment(string depID);
        List<DepartmentEntity> ListDepartment();
        List<DepartmentEntity> ListDepartment(int pageSize, int pageNum);
        DepartmentEntity GetDepartment(string depID);
        bool CheckNameUnique(string DepName, string ID);
    }
}
