using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;

namespace ThesisGamingStore.Models.Role
{
    public class PosRolesProvider : RoleProvider
    {
        public override void AddUsersToRoles(string[] usernames, string[] roleNames)
        {
            throw new NotImplementedException();
        }

        public override string ApplicationName
        {
            get
            {
                throw new NotImplementedException();
            }
            set
            {
                throw new NotImplementedException();
            }
        }

        public override void CreateRole(string roleName)
        {
            throw new NotImplementedException();
        }

        public override bool DeleteRole(string roleName, bool throwOnPopulatedRole)
        {
            throw new NotImplementedException();
        }

        public override string[] FindUsersInRole(string roleName, string usernameToMatch)
        {
            throw new NotImplementedException();
        }

        public override string[] GetAllRoles()
        {
            throw new NotImplementedException();
        }

        public override string[] GetRolesForUser(string username)
        {
                using (gamingstoreEntities objContext = new gamingstoreEntities())
                {
                    var objUser = objContext.EMPLOYEE.FirstOrDefault(u => u.Username == username);
                    var objPos = objContext.POSITION.FirstOrDefault(x => x.PosID == objUser.PosID);
                    if (objPos == null)
                    {

                        return null;
                    }
                    else
                    {
                        //       var Temp = objContext.POSITION.FirstOrDefault(x => x.PosID == objUser.PosID).Temp;
                        //     var nameRole = new string[] { Temp, "\0" };
                        string[] ret = objPos.C_Roles.Select(x => x.RoleName).ToArray();
                        return ret;
                    }
                }
        }

        public override string[] GetUsersInRole(string roleName)
        {
            throw new NotImplementedException();
        }

        public override bool IsUserInRole(string username, string roleName)
        {
            throw new NotImplementedException();
        }

        public override void RemoveUsersFromRoles(string[] usernames, string[] roleNames)
        {
            throw new NotImplementedException();
        }

        public override bool RoleExists(string roleName)
        {
            throw new NotImplementedException();
        }
    }
}