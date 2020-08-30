using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ThesisGamingStore.Entity;

namespace ThesisGamingStore.DataAccess.Core
{
    interface IRoleDao
    {
        bool InsertRole(RoleEntity role);
        bool UpdateRole(RoleEntity role);
        bool DeleteRole(string roleID);
        List<RoleEntity> ListRole();
        List<RoleEntity> ListRole(int pageSize, int pageNum);
        RoleEntity GetRole(string roleID);
        bool CheckUnique(string roleName,string ID);
    }

}
