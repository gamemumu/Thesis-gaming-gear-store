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
    public class SqlSupplier : ISupplierDao
    {
        public bool InsertSupplier(SupplierEntity Supplier)
        {
            throw new NotImplementedException();
        }

        public bool InsertSupAndPhone(SupplierEntity Supplier, ICollection<Models.SUPPLIER_PHONE> list)
        {
            string sql = @"sp_supplier_INSERT";
            string sql_phone = @"sp_supAndPhone_INSERT";

            using (TransactionScope ts = new TransactionScope())
            {
                string retID = Db.InsertReturnID(sql, Take(Supplier));
                if (retID != null)
                {
                    if (list.Count() == 0)
                    {
                        object[] obj = { "@PhoneNumber", "XXXXXXXXXX" };
                        Db.Insert(sql_phone, obj);
                    }
                    else
                    {
                        foreach (var ls in list)
                        {
                            object[] obj = { "@SupID", retID, "@PhoneNumber", ls.Phone };
                            try
                            {
                                Db.Insert(sql_phone, obj);
                            }
                            catch
                            {
                                return false;
                            }
                        }
                    }
                    ts.Complete();
                    return true;
                }
                else { return false; }
            }
        }

        public bool UpdateSupplier(SupplierEntity Supplier, ICollection<Models.SUPPLIER_PHONE> list)
        {
                string sql_sup = @"sp_supplier_UPDATE";
                string sql_upd = @"sp_supAndPhone_UPDATE";
                string sql_del = @"sp_supAndPhone_DELETE";


                using (TransactionScope ts = new TransactionScope())
                {
                    // UPDATE พนักงาน
                    Db.Update(sql_sup, Take2(Supplier));
                    // ลบ และ สร้าง เบอร์ใหม่ เพื่อ อัพเดท
                    object[] del = { "@SupID", Supplier.SupID };
                    Db.Delete(sql_del, del);
                    {
                        foreach (var ls in list)
                        {
                            object[] obj = { "@SupID", Supplier.SupID, "@Phone", ls.Phone };
                            try
                            {
                                Db.Insert(sql_upd, obj);
                            }
                            catch
                            {
                                return false;
                            }
                        }
                        ts.Complete();
                        return true;
                    }
                }
        }

        public bool DeleteSupplier(string supID)
        {
            string sql = @"sp_supplier_DELETE";
            object[] obj = { "@SupID", supID };
            using (TransactionScope ts = new TransactionScope())
            {
                try { Db.Delete(sql, obj); ts.Complete(); return true; }
                catch { return false; }
            }
        }

        public List<SupplierEntity> ListSupplier()
        {
                string sql = @"SELECT [SupID]
                                          ,[SupName]
                                          ,[SubAddress]
                                          ,[SubEnabled]
                                      FROM [SUPPLIER]
                                      where SubEnabled = 0
                                      order by SupID asc";
           return Db.ReadList(sql, Make);
        }

        public List<SupplierEntity> ListSupplier(int pageSize, int pageNum)
        {
            throw new NotImplementedException();
        }

        public SupplierEntity GetSupplier(string supID)
        {
            throw new NotImplementedException();
        }

        public bool CheckNameSup(string supName)
        {
            string sql = @"SELECT COUNT(*) FROM SUPPLIER WHERE SupName = @SupName";
            object[] obj = { "@SupName", supName };
            return Db.GetCount(sql, obj) > 0;
        }

        public bool CheckPhone(string phoneNum)
        {
            string sql = @"SELECT COUNT(*) FROM SUPPLIER_PHONE WHERE Phone = @Phone";
            object[] obj = { "@Phone", phoneNum };
            return Db.GetCount(sql, obj) > 0;
        }

        protected object[] Take(SupplierEntity supplier)
        {
            return new object[]{
                            "@SupName",supplier.SupName,
                            "@SubAddress",supplier.SubAddress,
                           // @"Parameters["'ReturnID'"].Direction",ParameterDirection.Output
            };
        }

        protected object[] Take2(SupplierEntity supplier)
        {
            return new object[]{
                            "@SupID",supplier.SupID,
                            "@SupName",supplier.SupName,
                            "@SubAddress",supplier.SubAddress,
            };
        }

        protected Func<IDataReader, SupplierEntity> Make = reader =>
        {
            return new SupplierEntity
            {
                SupID = reader["SupID"].ToString(),
                SupName = reader["SupName"].ToString(),
                SubAddress = reader["SubAddress"].ToString(),
                SubEnabled = reader["SubEnabled"].ToString(),
            };
        };
    }
}