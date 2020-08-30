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
    public class SqlTypeproduct : ITypeproductDao
    {
        public bool InsertTypeproduct(TypeproductEntity typeproduct)
        {
            string sql = @"sp_typeproduct_INSERT";
            object[] obj = {"@TypeName",typeproduct.TypeName };
            using (TransactionScope ts = new TransactionScope())
            {
                try { Db.Insert(sql, obj); ts.Complete(); return true; }
                catch { return false; }
            }
        }

        public bool UpdateTypeproduct(TypeproductEntity typeproduct)
        {
            string sql = @"[sp_typeproduct_UPDATE]";
            object[] obj = { "@TypeProductID", typeproduct.TypeProductID, "@TypeName", typeproduct.TypeName };
            using (TransactionScope ts = new TransactionScope())
            {
                try { Db.Update(sql, obj); ts.Complete(); return true; }
                catch { return false; }
            }
        }

        public bool DeleteTypeproduct(string typeproductID)
        {
            string sql = @"sp_typeproduct_DELETE";
            object[] obj = { "@TypeProductID", typeproductID };
            using (TransactionScope ts = new TransactionScope())
            {
                try { Db.Delete(sql, obj); ts.Complete(); return true; }
                catch { return false; }
            }
        }

        public List<TypeproductEntity> ListTypeproduct()
        {
            string sql = @"SELECT [TypeProductID]
                                  ,[TypeName]
                                  ,[TypeEnabled]
                              FROM [dbo].[TYPEPRODUCT] where TypeEnabled = 0";
            return Db.ReadList(sql, Make);
        }

        public List<TypeproductEntity> ListTypeproduct(int pageSize, int pageNum)
        {
            throw new NotImplementedException();
        }

        public TypeproductEntity GetTypeproduct(string typeproductID)
        {
            string sql = @"SELECT [TypeProductID]
                          ,[TypeName]
                          ,[TypeEnabled]
                      FROM [TYPEPRODUCT] where TypeProductID = '" + typeproductID + "'";
            return Db.Read(sql, Make);
        }


        public bool CheckNameUnique(string typeproductName,string ID)
        {
            if (ID.Equals("CREATE"))
            {
                string sql = @"SELECT COUNT(*) FROM TYPEPRODUCT WHERE REPLACE(TypeName, ' ', '') = @TypeName";
                object[] obj = { "@TypeName", typeproductName };
                return Db.GetCount(sql, obj) > 0;
            }
            else
            {
                string sql = @"SELECT COUNT(*) FROM TYPEPRODUCT WHERE REPLACE(TypeName, ' ', '') = @TypeName and TypeProductID != @TypeProductID";
                object[] obj = { "@TypeName", typeproductName, "@TypeProductID", ID };
                return Db.GetCount(sql, obj) > 0;
            }
          
        }
        protected Func<IDataReader, TypeproductEntity> Make = reader =>
        {
            return new TypeproductEntity
            {
                TypeProductID = reader["TypeProductID"].ToString(),
                TypeName = reader["TypeName"].ToString(),
                TypeEnabled = reader["TypeEnabled"].ToString(),
            };
        };
    }
}