using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Transactions;
using System.Web;
using ThesisGamingStore.DataAccess.Core;
using ThesisGamingStore.Entity;
using ThesisGamingStore.Models;

namespace ThesisGamingStore.DataAccess
{
    public class SqlOffer : IOfferDao
    {
        public bool InsertOffer(OfferModel[] off, OfferDetailModel[] list)
        {
            string sql = @"[sp_offer_INSERT]";
            string sql_Detail = @"[sp_offerDetail_INSERT]";
            int i = 0;
            string retID = "";
            using (TransactionScope ts = new TransactionScope())
            {
                foreach (var ls in list)
                {
                    if (ls.OfdNo == 1)
                    {
                        //สร้างหัว
                        object[] h_obj = { "@EmpID", off[i].EmpID, "@SupID", off[i].SupID, "@OffDate", off[i].OffDate };
                        retID = Db.InsertReturnID(sql, h_obj);
                    }

                    object[] obj = { "@OffID", retID, "@OfdNo", ls.OfdNo, "@PrdID", ls.PrdID, "@AmountPost", ls.AmountPost, "@AmountApprove", ls.AmountApprove, "@Cost", ls.Cost };
                    try
                    {
                        Db.Insert(sql_Detail, obj);
                        i++;
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

        public bool UpdateOffer(OfferDetailModel[] list, string OffID,string empApprove)
        {
            string sql_offer = @"sp_offer_UPDATE";
            string sql_offDta = @"sp_offerDetail_UPDATE";
            object[] obj1 = { "@OffID", OffID, "@EmpApprove", empApprove };

            using (TransactionScope ts = new TransactionScope())
            {
                try { Db.Update(sql_offer, obj1); }
                catch { return false; }
                foreach (var ls in list)
                {
                    object[] obj2 = { "@OffID", OffID, "@OfdNo", ls.OfdNo, "@PrdID", ls.PrdID, "@AmountApprove", ls.AmountApprove };
                    try { Db.Update(sql_offDta, obj2); }
                    catch { return false; }
                }
                ts.Complete();
                return true;
            }
        }

        public bool DeleteOffer(string offID)
        {
            string sql = @"sp_offer_DELETE";
            object[] obj = { "@OffID", offID };
            using (TransactionScope ts = new TransactionScope())
            {
                try { Db.Delete(sql, obj); ts.Complete(); return true; }
                catch { return false; }
            }
        }

        public List<OfferEntity> ListOffer()
        {
            string sql = @"SELECT [OffID]
                                  ,e.[EmpID]
	                              ,e.Fname
                                  ,s.SupName
                                  ,[OffDate]
                                  ,[OffStatus]
                                  ,[OffEnabled]
                                  ,[EmpApprove]
                              FROM [OFFER] o ,[SUPPLIER] s,EMPLOYEE e
                              where o.SupID = s.SupID and e.EmpID = o.EmpID  and [OffEnabled] =  0  and OffStatus not like 'Arrive'
                              order by OffID desc ";
            return Db.ReadList(sql, Make);
        }

        public  List<OfferEntity> ListOfferForOrder(string id)
        {
            string sql = @"SELECT
                                   [OffID]
                                  ,e.[EmpID]
	                              ,e.Fname
                                  ,o.[EmpApprove]
                                  ,s.SupName
                                  ,[OffDate]
                                  ,[OffStatus]
                              FROM [OFFER] o ,[SUPPLIER] s,EMPLOYEE e
                              where o.SupID = s.SupID and e.EmpID = o.EmpID  and [OffEnabled] =  0  and OffStatus like 'Approve' and s.SupID = '" + id + "'";
            return Db.ReadList(sql, Make);
        }

        public List<OfferEntity> ListOffer(int pageSize, int pageNum)
        {
            throw new NotImplementedException();
        }

        public List<WeakOfferDetailsEntity> GetListOffer(string offID)
        {
            string sql = @"SELECT	
                               offdta.[OffID]
							  ,offdta.[OfdNo]
                              ,offer.[OffStatus]
							  ,s.[SupID]
							  ,s.[SupName]
                              ,s.[SubAddress]
							  ,p.[PrdID]
                              ,p.[ClrID]
	                          ,c.[ClrName]
                              ,p.[TypeProductID]
	                          ,t.[TypeName]
                              ,b.[TrdID]
	                          ,tr.[TrdName]
                              ,p.[BrandID]
	                          ,b.[BrandName]
	                          ,[Description]
                              ,[Waranty]
                              ,[PrdEnabled]
							  ,offdta.[AmountPost]
							  ,offdta.[AmountApprove]
							  ,offdta.[Cost]
      FROM [PRODUCT] as p, [COLOR] as c , [BRAND] as b, [TYPEPRODUCT] as t, [TRADEMARK] as tr , SUPPLIER as s,[OFFERDETAIL] as offdta ,OFFER as offer
      where  c.ClrID = p.ClrID and p.TypeProductID = t.TypeProductID  and b.TrdID = tr.TrdID
        and p.BrandID = b.BrandID and s.SupID = offer.SupID and  PrdEnabled = 0 and p.PrdID = offdta.PrdID and offer.OffID = offdta.OffID and offer.OffID = '" + offID + "'";
            return Db.ReadList(sql, MakeGetID);
        }

        public OfferEntity GetOffer(string offID)
        {
            throw new NotImplementedException();
        }
        protected object[] Take(OfferEntity offer)
        {
            return new object[]{
                            "@EmpID",offer.EmpID,
                            "@SupID",offer.SupID,
                            "@OffDate",offer.OffDate,
            };
        }
        protected Func<IDataReader, OfferEntity> Make = reader =>
        {
            return new OfferEntity
            {
                OffID = reader["OffID"].ToString(),
                EmpID = reader["EmpID"].ToString(),
                EmpName = reader["Fname"].ToString(),
                SupName = reader["SupName"].ToString(),
                OffDate = reader.GetDateTime(reader.GetOrdinal("OffDate")).ToString("yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture),
                OffStatus = reader["OffStatus"].ToString(),
               // OffEnabled = reader["OffEnabled"].ToString(),
                EmpApprove = reader["EmpApprove"].ToString(),
            };
        };

        protected Func<IDataReader, WeakOfferDetailsEntity> MakeGetID = reader =>
        {
            return new WeakOfferDetailsEntity
            {
                OffID = reader["OffID"].ToString(),
                OfdNo = reader.GetInt32(reader.GetOrdinal("OfdNo")),
                OffStatus = reader["OffStatus"].ToString(),
                SupID = reader["SupID"].ToString(),
                SupName = reader["SupName"].ToString(),
                SubAddress = reader["SubAddress"].ToString(),
                PrdID = reader["PrdID"].ToString(),
                ClrID = reader["ClrID"].ToString(),
                ClrName = reader["ClrName"].ToString(),
                TypeProductID = reader["TypeProductID"].ToString(),
                TypeName = reader["TypeName"].ToString(),
                TrdID = reader["TrdID"].ToString(),
                TrdName = reader["TrdName"].ToString(),
                BrandID = reader["BrandID"].ToString(),
                BrandName = reader["BrandName"].ToString(),
                Description = reader["Description"].ToString(),
                Waranty = reader.GetInt32(reader.GetOrdinal("Waranty")),
                PrdEnabled = reader["PrdEnabled"].ToString(),
                AmountPost = reader.GetInt32(reader.GetOrdinal("AmountPost")),
                AmountApprove = reader.GetInt32(reader.GetOrdinal("AmountApprove")),
                Cost = reader.GetDecimal(reader.GetOrdinal("Cost"))
            };
        };
    }
}