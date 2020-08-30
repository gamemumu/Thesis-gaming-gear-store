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
using ThesisGamingStore.Models;

namespace ThesisGamingStore.DataAccess
{
    public class SqlPosition : IPositionDao
    {
        //private static readonly string connectionString = ConfigurationManager.ConnectionStrings["MyMvcDbConnection"].ConnectionString;
        //public static bool CheckUnique(string posName)
        //{
        //    bool check = false;
        //    string query = string.Format("Select PosName FROM [POSITION] WHERE REPLACE(PosName, ' ', '') = '{0}'", posName);
        //    using (SqlConnection connection = new SqlConnection(connectionString))
        //    {
        //        SqlCommand cmd = new SqlCommand(query, connection);
        //        connection.Open();
        //        SqlDataReader sdr = cmd.ExecuteReader();
        //        check = sdr.HasRows;
        //        connection.Close();
        //        return (check);
        //    }
        //}
        public bool InsertPosition(PositionsEntity position)
        {
            string sql = @"sp_position_INSERT";
            using (TransactionScope ts = new TransactionScope())
            {
                try { Db.Insert(sql, Take(position)); ts.Complete(); return true; }
                catch { return false; }
            }
        }
        public bool InsertPosandRole(PositionsEntity position, PosInRoleDetailDto[] list, string UPDATEDATA)
        {

            string sql = @"sp_position_INSERT";
            string sql_role = @"sp_PosAndRole_INSERT";

            string retID = "";
            if (UPDATEDATA.Equals("INSERT"))
            {
                using (TransactionScope ts = new TransactionScope())
                {
                    retID = Db.InsertReturnID(sql, Take(position));
                    if (retID != null)
                    {
                        foreach (var ls in list)
                        {
                            object[] obj = { "@RoleID", ls.RoleID, "@PosID", retID };
                            try
                            {
                                Db.Insert(sql_role, obj);
                            }
                            catch
                            {
                                return false;
                            }
                        }
                        ts.Complete();
                        return true;
                    }
                    else { return false; }
                }
            }
            else if (UPDATEDATA.Equals("UPDATE"))
            {
                string sql_upd = @"sp_PosAndRole_UPDATE";
                using (TransactionScope ts = new TransactionScope())
                {
                    DeletePosition(position.PosID);
                    {
                        foreach (var ls in list)
                        {
                            object[] obj = { "@RoleID", ls.RoleID, "@PosID", position.PosID };
                            Db.Insert(sql_upd, obj);
                        }
                        ts.Complete();
                        return true;
                    }
                }
            }
            return false;
        }
        public bool UpdatePosition(PositionsEntity position)
        {
            throw new NotImplementedException();
        }

        public bool DeletePosition(string posID)
        {
            string sql = @"sp_PosAndRole_DELETE";
            object[] obj = { "@PosID", posID };
            using (TransactionScope ts = new TransactionScope())
            {
                try { Db.Delete(sql, obj); ts.Complete(); return true; }
                catch { return false; }
            }
        }

        public bool DeletePositionForEnabled(string posID)
        {
            string sql = @"sp_position_DELETE";
            object[] obj = { "@PosID", posID };
            using (TransactionScope ts = new TransactionScope())
            {
                try { Db.Delete(sql, obj); ts.Complete(); return true; }
                catch { return false; }
            }
        }

        public List<PositionsEntity> ListPosition()
        {
            //string sql = @"SELECT [DepID],[PosName]FROM [POSITION]";
            string sql = @"SELECT  p.[PosID],p.[PosName],d.[DepID],d.DepName
                        FROM [POSITION] as p ,[DEPARTMENT] as d  
                        where p.DepID = d.DepID and PosEnabled = 0
                        ORDER BY P.[DEPID]";
            return Db.ReadList(sql, Make);
        }


        public List<PositionsEntity> ListPosition(int pageSize, int pageNum)
        {
            throw new NotImplementedException();
        }

        public List<WeakPosDetailsEntity> GetListPosition(string PosID, string DepID)
        {
            //            string sql = @"SELECT TOP 1000 r.RoleName,pr.RoleID,p.[PosID],d.DepName,p.[PosName]
            //                        FROM [_PosInRoles] as pr ,[_Roles]  as r ,[DEPARTMENT] d , [POSITION] p
            //                        where  pr.RoleID = r.RoleID and p.DepID = d.DepID and p.PosID =" + PosID + " and pr.[PosID] =" + PosID;
            string sql = @"SELECT pr.[RoleID],r.[RoleName],p.[PosID],p.[PosName],d.[DepID],d.[DepName]
FROM [gamingstore].[dbo].[_PosInRoles] as pr ,[gamingstore].[dbo].[_Roles]  as r ,[gamingstore].[dbo].[DEPARTMENT] d ,[gamingstore].[dbo].[POSITION] p
where  pr.RoleID = r.RoleID and p.DepID = d.DepID and p.PosID ='" + PosID + "' and pr.[PosID] ='" + PosID + "'";
            return Db.ReadList(sql, MakeMulti);

        }
        public PositionsEntity GetPosition(string PosID)
        {
            string sql = @"SELECT  p.[PosID],p.[PosName],d.[DepID],d.DepName
                        FROM [POSITION] as p ,[DEPARTMENT] as d  
                        where p.DepID = d.DepID and PosEnabled = 0 and PosID = '" + PosID + "'";
            return Db.Read(sql, Make);
        }

        public bool CheckUnique(string posName, string ID)
        {
            if (ID.Equals("CREATE"))
            {
                string sql = @"SELECT COUNT(*) FROM POSITION WHERE REPLACE(PosName, ' ', '') = @PosName";
                object[] obj = { "@PosName", posName };
                return Db.GetCount(sql, obj) > 0;
            }
            else
            {
                string sql = @"SELECT COUNT(*) FROM POSITION WHERE REPLACE(PosName, ' ', '') = @PosName and PosID != @PosID";
                object[] obj = { "@PosName", posName, "@PosID", ID };
                return Db.GetCount(sql, obj) > 0;
            }
        }
        protected object[] Take(PositionsEntity position)
        {
            return new object[]{
                    "@DepID",position.DepID,
                    "@PosName",position.PosName,
                  //  "@Temp",position.Temp,
            };
        }
        protected Func<IDataReader, PositionsEntity> Make = reader =>
        {
            return new PositionsEntity
            {
                DepID = reader["DepID"].ToString(),
                PosID = reader["PosID"].ToString(),
                PosName = reader["PosName"].ToString(),
                DepName = reader["DepName"].ToString(),
                //     Temp = reader["Temp"].ToString(),
            };
        };

        protected Func<IDataReader, WeakPosDetailsEntity> MakeMulti = reader =>
            {
                return new WeakPosDetailsEntity
                {
                    DepID = reader["DepID"].ToString(),
                    PosID = reader["PosID"].ToString(),
                    PosName = reader["PosName"].ToString(),
                    DepName = reader["DepName"].ToString(),
                    RoleID = reader["RoleID"].ToString(),
                    RoleName = reader["RoleName"].ToString(),
                };
            };
    }
}