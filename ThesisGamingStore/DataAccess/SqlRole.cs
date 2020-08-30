using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Transactions;
using System.Web;
using ThesisGamingStore.DataAccess.Core;
using ThesisGamingStore.Entity;

namespace ThesisGamingStore.DataAccess
{
    public class SqlRole : IRoleDao
    {
        
        public bool InsertRole(RoleEntity role)
        {
            string sql = @"spRoles_INSERT";
            using (TransactionScope ts = new TransactionScope())
            {
                try { Db.Insert(sql, Take(role)); ts.Complete(); return true; }
                catch { return false; }
            }
        }

        public bool UpdateRole(RoleEntity role)
        {
            string sql = @"spRoles_UPDATE";
            object[] obj = { "@RoleID",role.RoleID,"@RoleName",role.RoleName};
            using (TransactionScope ts = new TransactionScope())
            {
                try { Db.Update(sql, obj); ts.Complete(); return true; }
                catch { return false; }
            }
        }

        public bool DeleteRole(string roleID)
        {
            string sql = @"spRoles_DELETE";
            object[] obj = { "@RoleID", roleID };
            using (TransactionScope ts = new TransactionScope())
            {
                try { Db.Delete(sql, obj); ts.Complete(); return true; }
                catch { return false; }
            }
        }

        public List<RoleEntity> ListRole()
        {
            string sql = @"SELECT [RoleID],[RoleName] FROM [_Roles] where RoleEnabled = 0 ";
            return Db.ReadList(sql, Make);
        }


        public List<RoleEntity> ListRole(int pageSize, int pageNum)
        {
            throw new NotImplementedException();
        }

        public RoleEntity GetRole(string roleID)
        {
            string sql = @"SELECT [RoleID]
                  ,[RoleName]
              FROM [dbo].[_Roles] where RoleID = '" + roleID + "'";
            return Db.Read(sql, Make);
        }

        public bool CheckUnique(string roleName, string ID)
        {

            if (ID.Equals("CREATE"))
            {
                string sql = @"SELECT COUNT(*) FROM _ROLES WHERE REPLACE(ROLENAME, ' ', '') = @RoleName";
                object[] obj = { "@RoleName", roleName };
                return Db.GetCount(sql, obj) > 0;
            }
            else
            {
                string sql = @"SELECT COUNT(*) FROM _ROLES WHERE REPLACE(ROLENAME, ' ', '') = @RoleName and RoleID != @RoleID";
                object[] obj = { "@RoleName", roleName, "@RoleID", ID };
                return Db.GetCount(sql, obj) > 0;
            }
        }

        protected object[] Take(RoleEntity role)
        {
            return new object[]{
                  //  "@RoleID",position.RoleID,
                    "@RoleName",role.RoleName,
            };
        }
        protected Func<IDataReader, RoleEntity> Make = reader =>
        {
            return new RoleEntity
            {
                RoleID = reader["RoleID"].ToString(),
                RoleName = reader["RoleName"].ToString(),
            };
        };
    }
}