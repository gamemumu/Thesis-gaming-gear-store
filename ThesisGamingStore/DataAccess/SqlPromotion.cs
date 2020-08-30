using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Transactions;
using System.Web;
using ThesisGamingStore.DataAccess.Core;
using ThesisGamingStore.Models;

namespace ThesisGamingStore.DataAccess
{
    public class SqlPromotion : IPromotionDao
    {
        public bool InsertPROMOTION(PROMOTION PROMOTION)
        {
            string sql = @"sp_promotion_INSERT";
            string sql_dta = @"sp_promotionproduct_INSERT";
            object[] obj = { "@ProMStartDate", PROMOTION.ProMStartDate, "@ProMEndDate", PROMOTION.ProMEndDate, "@Discount", PROMOTION.Discount };

            using (TransactionScope ts = new TransactionScope())
            {
                    string retID = Db.InsertReturnID(sql, obj);
                    if (retID != null)
                    {

                        foreach (var ls in PROMOTION.PRODUCT)
                        {
                            object[] objs = { "@PrdID", ls.PrdID, "@ProMID", retID };
                            try
                            {
                                Db.Insert(sql_dta, objs);
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

        public bool UpdatePROMOTION(PROMOTION PROMOTION)
        {
            string sql = @"sp_promotion_UPDATE";
            string sql_dta = @"sp_promotionproduct_UPDATE";
            string sql_del = @"sp_promotionproduct_DELETE";
            object[] obj = { "@ProMID", PROMOTION.ProMID, "@ProMStartDate", PROMOTION.ProMStartDate, "@ProMEndDate", PROMOTION.ProMEndDate, "@Discount", PROMOTION.Discount };
            object[] del = { "@ProMID", PROMOTION.ProMID };
            using (TransactionScope ts = new TransactionScope())
            {
                try {
               
                    Db.Update(sql, obj);
                    Db.Delete(sql_del, del);
                    foreach (var ls in PROMOTION.PRODUCT)
                    {
                        object[] objs = { "@PrdID", ls.PrdID, "@ProMID", PROMOTION.ProMID };
                        try
                        {
                            Db.Insert(sql_dta, objs);
                        }
                        catch
                        {
                            return false;
                        }
                    }
                    ts.Complete();
                    return true;
                }
                catch { return false; }
            }
        }

        public bool DeletePROMOTION(string PROMOTIONID)
        {
            string sql = @"sp_promotion_DELETE";
            object[] obj = { "@ProMID", PROMOTIONID };
            using (TransactionScope ts = new TransactionScope())
            {
                   try { Db.Delete(sql, obj); ts.Complete();  return true; }
                   catch { return false; }
            }
        }

        public List<PROMOTION> ListPROMOTION()
        {
            string sql = @"SELECT convert(int,DATEDIFF(DAY, pm.ProMStartDate, pm.ProMEndDate)) as RangeDate,*
                                FROM [dbo].[PROMOTION] as pm where pm.ProMEnabled = 0";
            return Db.ReadList(sql, Make);
            //select *
            //            from(
            //            SELECT convert(int,DATEDIFF(DAY, pm.ProMStartDate, pm.ProMEndDate)) as diff , *
            //                  FROM [dbo].[PROMOTION] as pm where pm.ProMEnabled = 0
            //            ) aa
            //            group by aa.ProMID,aa.diff,aa.ProMStartDate,aa.ProMEndDate,aa.Discount,aa.ProMEnabled
            //            having aa.diff > 0
        }

        public List<PROMOTION_DTA> GetPROMOTION(string PROMOTIONID)
        {
            string sql = @"SELECT pm.ProMID,p_dta.PrdID
                              ,p.[ClrID]
	                          ,c.[ClrName]
                              ,p.[TypeProductID]
	                          ,t.[TypeName]
                              ,b.[TrdID]
	                          ,tr.[TrdName]
                              ,p.[BrandID]
	                              ,b.[BrandName] ,pm.ProMStartDate,pm.ProMEndDate,pm.Discount,pm.ProMEnabled
            FROM [PROMOTION_PRODUCT_DTA] as  p_dta,PROMOTION as pm,[PRODUCT] as p, [COLOR] as c , [BRAND] as b, [TYPEPRODUCT] as t, [TRADEMARK] as tr
            where c.ClrID = p.ClrID and p.TypeProductID = t.TypeProductID  and b.TrdID = tr.TrdID
            and p.BrandID = b.BrandID and p.PrdID = p_dta.PrdID and pm.ProMID = p_dta.ProMID and  pm.ProMID ='" + PROMOTIONID + "'";
            return Db.ReadList(sql, MakeGetID);
        }

        public List<PROMOTION_DTA> GetPROMOTION2(string PROMOTIONID)
        {
            string sql = @"SELECT pm.ProMID,p_dta.PrdID
                              ,p.[ClrID]
	                          ,c.[ClrName]
                              ,p.[TypeProductID]
	                          ,t.[TypeName]
                              ,b.[TrdID]
	                          ,tr.[TrdName]
                              ,p.[BrandID]
	                              ,b.[BrandName]
            FROM [PROMOTION_PRODUCT_DTA] as  p_dta,PROMOTION as pm,[PRODUCT] as p, [COLOR] as c , [BRAND] as b, [TYPEPRODUCT] as t, [TRADEMARK] as tr
            where c.ClrID = p.ClrID and p.TypeProductID = t.TypeProductID  and b.TrdID = tr.TrdID
            and p.BrandID = b.BrandID and p.PrdID = p_dta.PrdID and pm.ProMID = p_dta.ProMID and  pm.ProMID ='" + PROMOTIONID + "'";
            return Db.ReadList(sql, MakeID);
        }

        protected Func<IDataReader, PROMOTION> Make = reader =>
        {
            return new PROMOTION
            {
                ProMID = reader["ProMID"].ToString(),
                ProMStartDate = reader.GetDateTime(reader.GetOrdinal("ProMStartDate")).Date,
                ProMEndDate = reader.GetDateTime(reader.GetOrdinal("ProMEndDate")),
                Discount = reader.GetInt32(reader.GetOrdinal("Discount")),
                ProMEnabled = reader["ProMEnabled"].ToString(),
            };
        };

        protected Func<IDataReader, PROMOTION_DTA> MakeID = reader =>
        {
            return new PROMOTION_DTA
            {
                ProMID = reader["ProMID"].ToString(),
                PrdID = reader["PrdID"].ToString(),
                BrandName = reader["BrandName"].ToString(),
                TypeName = reader["TypeName"].ToString(),
                ClrName = reader["ClrName"].ToString(),
                TrdName = reader["TrdName"].ToString(),
            };
        };

        protected Func<IDataReader, PROMOTION_DTA> MakeGetID = reader =>
        {
            return new PROMOTION_DTA
            {
                ProMID = reader["ProMID"].ToString(),
                ProMStartDate = reader.GetDateTime(reader.GetOrdinal("ProMStartDate")).ToString("yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture),
                ProMEndDate = reader.GetDateTime(reader.GetOrdinal("ProMEndDate")).ToString("yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture),
                Discount = reader.GetInt32(reader.GetOrdinal("Discount")),
                ProMEnabled = reader["ProMEnabled"].ToString(),

                PrdID = reader["PrdID"].ToString(),
                BrandName = reader["BrandName"].ToString(),
                TypeName = reader["TypeName"].ToString(),
                ClrName = reader["ClrName"].ToString(),
                TrdName = reader["TrdName"].ToString(),
            };
        };
        public class PROMOTION_DTA {
            public string ProMID { get; set; }
            public string PrdID { get; set; }
            public string ClrName { get; set; }
            public string TypeName { get; set; }
            public string BrandName { get; set; }
            public string TrdName { get; set; }
            public string ProMStartDate { get; set; }
            public string ProMEndDate { get; set; }
            public int Discount { get; set; }
            public string ProMEnabled { get; set; }
        }
    }
}