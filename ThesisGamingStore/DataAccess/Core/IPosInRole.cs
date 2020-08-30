using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ThesisGamingStore.Entity;

namespace ThesisGamingStore.DataAccess.Core
{
    interface IPosInRole
    {
        bool InsertPosInRole(PosInRoleEntity role);
        bool UpdatePosInRole(PosInRoleEntity role);
        bool DeletePosInRole(string PosInRoleID);
        List<PosInRoleEntity> ListRole();

      //  List<PosInRole> ListRole(int pageSize, int pageNum);
        PosInRoleEntity GetRole(string PosInRoleID);
       // bool CheckUnique(string roleName);
    }
}
