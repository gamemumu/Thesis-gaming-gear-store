using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Transactions;
using System.Web;
using ThesisGamingStore.DataAccess.Core;
using ThesisGamingStore.Entity;

namespace ThesisGamingStore.DataAccess
{
    public class SqlDepartment : IDepartmentDao
    {
       // private static readonly string connectionString = ConfigurationManager.ConnectionStrings["MyMvcDbConnection"].ConnectionString;
        public bool InsertDepartment(DepartmentEntity department)
        {
            string sql = @"sp_department_INSERT";
            using (TransactionScope ts = new TransactionScope())
            {
                try { Db.Insert(sql, Take(department)); ts.Complete(); return true; }
                catch { return false; }
            }
        }

        public bool UpdateDepartment(DepartmentEntity department)
        {
            string sql = @"sp_department_UPDATE";
            object[] obj = { "@DepID", department.DepID, "@DepName", department.DepName };
            using (TransactionScope ts = new TransactionScope())
            {
                try { Db.Update(sql, obj); ts.Complete(); return true; }
                catch { return false; }
            }
        }

        public bool DeleteDepartment(string depID)
        {
            string sql = @"sp_department_DELETE";
            object[] obj = { "@DepID ", depID };
            using (TransactionScope ts = new TransactionScope())
            {
                try { Db.Delete(sql, obj); ts.Complete(); return true; }
                catch { return false; }
            }
        }

        public List<DepartmentEntity> ListDepartment()
        {
            string sql = @"SELECT [DepID],[DepName] FROM [DEPARTMENT] where DepEnabled = 0;";
            return Db.ReadList(sql, Make);
        }

        public List<DepartmentEntity> ListDepartment(int pageSize, int pageNum)
        {
            throw new NotImplementedException();
        }

        public DepartmentEntity GetDepartment(string depID)
        {
            string sql = @"SELECT [DepID]
                          ,[DepName]
                      FROM [DEPARTMENT] where DepID = '" + depID + "'";
            return Db.Read(sql, Make);
        }


        public bool CheckNameUnique(string DepName, string ID)
        {
            if (ID.Equals("CREATE"))
            {
                string sql = @"SELECT COUNT(*) FROM DEPARTMENT WHERE REPLACE(DepName, ' ', '') = @DepName";
                object[] obj = { "@DepName", DepName };
                return Db.GetCount(sql, obj) > 0;
            }
            else
            {
                string sql = @"SELECT COUNT(*) FROM DEPARTMENT WHERE REPLACE(DepName, ' ', '') = @DepName and DepID != @DepID";
                object[] obj = { "@DepName", DepName, "@DepID", ID };
                return Db.GetCount(sql, obj) > 0;
            }
        }

        protected object[] Take(DepartmentEntity department)
        {
            return new object[]{
                   // "@DepId",department.DepID,
                    "@DepName",department.DepName,
            };
        }
        protected Func<IDataReader, DepartmentEntity> Make = reader =>
        {
            return new DepartmentEntity
            {
                DepID = reader["DepID"].ToString(),
                DepName = reader["DepName"].ToString(),
            };
        };


    }
}