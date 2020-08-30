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
    public class SqlBrand :IBrandDao
    {
        public bool InsertBrand(BrandEntity brand)
        {
            string sql = @"sp_brand_INSERT";
            object[] obj = {"@BrandName",brand.BrandName,"@TrdID",brand.TrdID};
            using (TransactionScope ts = new TransactionScope())
            {
                try { Db.Insert(sql, obj); ts.Complete(); return true; }
                catch { return false; }
            }
        }

        public bool UpdateBrand(BrandEntity brand)
        {
            string sql = @"[sp_brand_UPDATE]";
            object[] obj = { "@BrandID", brand.BrandID, "@BrandName", brand.BrandName, "@TrdID", brand.TrdID };
            using (TransactionScope ts = new TransactionScope())
            {
                try { Db.Update(sql, obj); ts.Complete(); return true; }
                catch { return false; }
            }
        }

        public bool DeleteBrand(string brandID)
        {
            string sql = @"sp_brand_DELETE";
            object[] obj = { "@BrandID", brandID };
            using (TransactionScope ts = new TransactionScope())
            {
                try { Db.Delete(sql, obj); ts.Complete(); return true; }
                catch { return false; }
            }
        }

        public List<BrandEntity> ListBrand()
        {
            string sql = @"select t.TrdID,t.TrdName,b.[BrandID],b.BrandName,b.BrandEnabled
			  FROM BRAND b ,TRADEMARK t where b.TrdID = t.TrdID and
			  b.[BrandID] not in (Select p.[BrandID] FROM [PRODUCT] p)";
            return Db.ReadList(sql, Make);
        }
        public List<BrandEntity> ListBrandEdit(string id)
        {
            string sql = @"select t.TrdID,t.TrdName,b.[BrandID],b.BrandName,b.BrandEnabled
			  FROM BRAND b ,TRADEMARK t where b.TrdID = t.TrdID and
			  b.[BrandID] not in (Select p.[BrandID] FROM [PRODUCT] p where p.BrandID != '" + id + "') ";
            return Db.ReadList(sql, Make);
        }

        public List<BrandEntity> ListBrandCheckProduct() {
            string sql = @"  select b.BrandID,b.BrandName,b.BrandEnabled,t.TrdID,t.TrdName from BRAND b , TRADEMARK t
                 where t.TrdID = b.TrdID and b.BrandID not in (select BrandID from PRODUCT)";
            return Db.ReadList(sql, Make);
        }
        public List<BrandEntity> ListBrand(string SupID)
        {
//            string sql = @"
//			  SELECT t.TrdID,t.TrdName,b.[BrandID],b.BrandName,b.BrandEnabled,p2.PrdID from PRODUCT p2
//			    , BRAND b ,TRADEMARK t where b.TrdID = t.TrdID and p2.BrandID = b.BrandID and
//			    p2.[BrandID] not in(
//					 SELECT  b.[BrandID]
//				  FROM BRAND b ,[PRODUCT] p where b.BrandID = p.BrandID and p.PrdID in(
//				 select PrdID from PRODUCTSUPPLIER
//			  where SupID='" + SupID + "')) order by t.TrdName";
            string sql = @" SELECT		 t.TrdID,t.TrdName,b.[BrandID],b.BrandName,b.BrandEnabled from 
			   BRAND b ,TRADEMARK t where b.TrdID = t.TrdID and b.BrandID not in(
					 SELECT  b.[BrandID]
				  FROM BRAND b ,[PRODUCT] p where b.BrandID = p.BrandID and p.PrdID in(
				 select PrdID from PRODUCTSUPPLIER
			  where SupID='" + SupID + "')) order by t.TrdName";
            return Db.ReadList(sql, Make);
            
        }
        public List<BrandEntity> ListBrandAll()
        {
            string sql = @"SELECT [BrandID]
                                      ,[BrandName]
            	                      ,b.TrdID
                                      ,t.TrdName
                                      ,[BrandEnabled]
                                  FROM [BRAND] as b , TRADEMARK as t 
                                  where t.TrdID = b.TrdID and BrandEnabled =0
                                  order by BrandID asc";
            return Db.ReadList(sql, Make);
        }

        public List<BrandEntity> ListBrand(int pageSize, int pageNum)
        {
            throw new NotImplementedException();
        }

        public BrandEntity GetBrand(string brandID)
        {
            string sql = @"SELECT [BrandID]
                                      ,[BrandName]
            	                      ,b.TrdID
                                      ,t.TrdName
                                      ,[BrandEnabled]
                                  FROM [BRAND] as b , TRADEMARK as t 
                                  where t.TrdID = b.TrdID
                                   and BrandID = '" + brandID + "'";
            return Db.Read(sql, Make);
        }


        public bool CheckNameUnique(string brandName, string BrandID)
        {
            if (BrandID.Equals("CREATE"))
            {
                string sql = @"SELECT COUNT(*) FROM BRAND WHERE REPLACE(BrandName, ' ', '') = @BrandName";
                object[] obj = { "@BrandName", brandName };
                return Db.GetCount(sql, obj) > 0;
            }
            else
            {
                string sql = @"SELECT COUNT(*) FROM BRAND WHERE REPLACE(BrandName, ' ', '') = @BrandName and BrandID != @BrandID";
                object[] obj = { "@BrandName", brandName,"@BrandID",BrandID};
                return Db.GetCount(sql, obj) > 0;
            }
        }
        protected Func<IDataReader, BrandEntity> Make = reader =>
        {
            return new BrandEntity
            {
                BrandID = reader["BrandID"].ToString(),
                BrandName = reader["BrandName"].ToString(),
                TrdID = reader["TrdID"].ToString(),
                TrdName = reader["TrdName"].ToString(),
                BrandEnabled = reader["BrandEnabled"].ToString(),
            };
        };
    }
}