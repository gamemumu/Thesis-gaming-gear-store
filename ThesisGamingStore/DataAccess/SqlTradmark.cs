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
    public class SqlTradmark : ITradmarkDao
    {
        private static readonly string connectionString = ConfigurationManager.ConnectionStrings["MyMvcDbConnection"].ConnectionString;
        public bool InsertTradmark(TradmarkEntity tradmark)
        {
            string sql = @"sp_tradmark_INSERT";
            object[] obj = {"@TrdName",tradmark.TrdName.Replace(" ", "")};
            using (TransactionScope ts = new TransactionScope())
            {
                try { Db.Insert(sql, obj); ts.Complete(); return true; }
                catch { return false; }
            }
        }

        public bool UpdateTradmark(TradmarkEntity tradmark)
        {
            string sql = @"[sp_tradmark_UPDATE]";
            object[] obj = { "@TrdID", tradmark.TrdID, "@TrdName", tradmark.TrdName.Replace(" ", "") };
            using (TransactionScope ts = new TransactionScope())
            {
                try { Db.Update(sql, obj); ts.Complete(); return true; }
                catch { return false; }
            }
        }

        public bool DeleteTradmark(string tradmarkID)
        {
            string sql = @"sp_tradmark_DELETE";
            object[] obj = { "@TrdID ", tradmarkID };
            using (TransactionScope ts = new TransactionScope())
            {
                try { Db.Delete(sql, obj); ts.Complete(); return true; }
                catch { return false; }
            }
        }

        public List<TradmarkEntity> ListTradmark()
        {
            string sql = @"SELECT [TrdID]
                                  ,[TrdName]
                                  ,[TrdEnabled]
                                  FROM [dbo].[TRADEMARK] where TrdEnabled = 0
                                  order by TrdID asc";
            return Db.ReadList(sql, Make);
        }

        public List<TradmarkEntity> ListTradmark(int pageSize, int pageNum)
        {
            throw new NotImplementedException();
        }

        public TradmarkEntity GetTradmark(string tradmarkID)
        {
            string sql = @"SELECT [TrdID]
                          ,[TrdName]
                          ,[TrdEnabled]
                      FROM [TRADEMARK] where TrdID = '" + tradmarkID + "'";
            return Db.Read(sql, Make);
        }


        public bool CheckNameUnique(string tradmarkName, string ID)
        {
            if (ID.Equals("CREATE"))
            {
                string sql = @"SELECT COUNT(*) FROM TRADEMARK WHERE REPLACE(TrdName, ' ', '') = @TrdName";
                object[] obj = { "@TrdName", tradmarkName };
                return Db.GetCount(sql, obj) > 0;
            }
            else
            {
                string sql = @"SELECT COUNT(*) FROM TRADEMARK WHERE REPLACE(TrdName, ' ', '') = @TrdName and TrdID != @TrdID";
                object[] obj = { "@TrdName", tradmarkName, "@TrdID", ID };
                return Db.GetCount(sql, obj) > 0;
            }
        }

        protected Func<IDataReader, TradmarkEntity> Make = reader =>
        {
            return new TradmarkEntity
            {
                TrdID = reader["TrdID"].ToString(),
                TrdName = reader["TrdName"].ToString(),
                TrdEnabled = reader["TrdEnabled"].ToString(),
                //     Temp = reader["Temp"].ToString(),
            };
        };
    }
}