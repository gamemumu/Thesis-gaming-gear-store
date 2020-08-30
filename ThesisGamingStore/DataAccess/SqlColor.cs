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
    public class SqlColor :IColorDao
    {
        public bool InsertColor(ColorEntity color)
        {
            string sql = @"sp_color_INSERT";
            object[] obj = {"@ClrName",color.ClrName};
            using (TransactionScope ts = new TransactionScope())
            {
                try { Db.Insert(sql, obj); ts.Complete(); return true; }
                catch { return false; }
            }
        }

        public bool UpdateColor(ColorEntity color)
        {
            string sql = @"[sp_color_UPDATE]";
            object[] obj = { "@ClrID", color.ClrID, "@ClrName", color.ClrName};
            using (TransactionScope ts = new TransactionScope())
            {
                try { Db.Update(sql, obj); ts.Complete(); return true; }
                catch { return false; }
            }
        }

        public bool DeleteColor(string colorID)
        {
            string sql = @"sp_color_DELETE";
            object[] obj = { "@ClrID ", colorID };
            using (TransactionScope ts = new TransactionScope())
            {
                try { Db.Delete(sql, obj); ts.Complete(); return true; }
                catch { return false; }
            }
        }

        public List<ColorEntity> ListColor()
        {
            string sql = @"SELECT [ClrID]
                                  ,[ClrName]
                                  ,[ClrEnabled]
                              FROM [COLOR] where ClrEnabled = 0";
            return Db.ReadList(sql, Make);
        }

        public List<ColorEntity> ListColor(int pageSize, int pageNum)
        {
            throw new NotImplementedException();
        }

        public ColorEntity GetColor(string colorID)
        {
            string sql = @"SELECT [ClrID]
                                  ,[ClrName]
                                  ,[ClrEnabled]
                              FROM [COLOR] where ClrID ='" + colorID + "'";
            return Db.Read(sql, Make);
        }

        public bool CheckNameUnique(string colorName, string colorID)
        {
            if (colorName.Equals("CREATE"))
            {
                string sql = @"SELECT COUNT(*) FROM COLOR WHERE REPLACE(ClrName, ' ', '') = @ClrName";
                object[] obj = { "@ClrName", colorName };
                return Db.GetCount(sql, obj) > 0;
            }
            else
            {
                string sql = @"SELECT COUNT(*) FROM COLOR WHERE REPLACE(ClrName, ' ', '') = @ClrName and ClrID != @ClrID";
                object[] obj = { "@ClrName", colorName, "@ClrID", colorID };
                return Db.GetCount(sql, obj) > 0;
            }
           
        }

        protected Func<IDataReader, ColorEntity> Make = reader =>
        {
            return new ColorEntity
            {
                ClrID = reader["ClrID"].ToString(),
                ClrName = reader["ClrName"].ToString(),
                ClrEnabled = reader["ClrEnabled"].ToString(),
            };
        };
    }
}