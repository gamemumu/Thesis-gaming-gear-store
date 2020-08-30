using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;

namespace ThesisGamingStore.Models.Role
{
    public class EmpRoleProvider : RoleProvider
    {
        //public override void AddUsersToRoles(string[] usernames, string[] roleNames)
        //{
        //    throw new NotImplementedException();
        //}

        //public override string ApplicationName
        //{
        //    get
        //    {
        //        throw new NotImplementedException();
        //    }
        //    set
        //    {
        //        throw new NotImplementedException();
        //    }
        //}

        //public override void CreateRole(string roleName)
        //{
        //    throw new NotImplementedException();
        //}

        //public override bool DeleteRole(string roleName, bool throwOnPopulatedRole)
        //{
        //    throw new NotImplementedException();
        //}

        //public override string[] FindUsersInRole(string roleName, string usernameToMatch)
        //{
        //    throw new NotImplementedException();
        //}

        //public override string[] GetAllRoles()
        //{
        //    throw new NotImplementedException();
        //}

        //public override string[] GetRolesForUser(string username)
        //{
        //    using (EmpRoleDBEntities objContext = new EmpRoleDBEntities())
        //    {
        //        var objUser = objContext.EMPLOYEE.FirstOrDefault(x => x.Username == username);
        //        if (objUser == null)
        //        {
                   
        //            return null;
        //        }
        //        else
        //        {
        //            var posPermit = objContext.POSITION.FirstOrDefault(x => x.PosID == objUser.PosID).PosPermit;
        //            var nameRole = new string[] { posPermit, "\0" };
        //            string[] ret = nameRole;
        //            return ret;
        //        }
        //    }
        //}

        //public override string[] GetUsersInRole(string roleName)
        //{
        //    throw new NotImplementedException();
        //}

        //public override bool IsUserInRole(string username, string roleName)
        //{
        //    throw new NotImplementedException();
        //}

        //public override void RemoveUsersFromRoles(string[] usernames, string[] roleNames)
        //{
        //    throw new NotImplementedException();
        //}

        //public override bool RoleExists(string roleName)
        //{
        //    throw new NotImplementedException();
        //}
    }
}