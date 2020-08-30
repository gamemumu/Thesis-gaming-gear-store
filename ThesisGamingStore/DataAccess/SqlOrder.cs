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
    public class SqlOrder : IOrderDao
    {
        public string InsertOrder(OrderEntity ord, Models.OrderDetailModel[] list)
        {
            string sql = @"[sp_order_INSERT]";
            string sql_Detail = @"[sp_orderproduct_dta_INSERT]";
            // update Offer status => Approve to Purchase
            string sql_UPDATE = @"sp_orderANDoffer_UPDATE";
            var check = "";
            string retID = "";

            object[] objOrd = { "@SupID", ord.SupID, "@EmpID", ord.EmpID, "@OrdDate", ord.OrdDate, "@TotalCost", ord.TotalCost };
            using (TransactionScope ts = new TransactionScope())
            {
                try
                {
                    retID = Db.InsertReturnID(sql, objOrd);
                    if (retID != null)
                    {
                        foreach (var ls in list)
                        {
                            object[] obj = { "@OrdID", retID, "@OrdNo", ls.OrdNo, "@OffID", ls.OffID, "@OfdNo", ls.OfdNo, "@OrdAmount", ls.AmountApprove };
                            try
                            {
                                Db.Insert(sql_Detail, obj);
                                if (!check.Equals(ls.OffID))
                                {
                                    object[] objU = { "@OffID", ls.OffID };
                                    check = ls.OffID;
                                    Db.Update(sql_UPDATE, objU);
                                }
                            }
                            catch
                            {
                                return retID;
                            }
                        }
                        ts.Complete();
                        return retID;
                    }
                    else { return retID; }
                }
                catch
                {
                    return retID;
                }
            }
        }

        public bool UpdateOrder(Models.OrderDetailModel[] list, string ordID, string empApprove)
        {
            throw new NotImplementedException();
        }

        public bool DeleteOrder(string ordID)
        {
            throw new NotImplementedException();
        }

        public List<OrderEntity> ListOrder()
        {
//            string sql = @"SELECT [OrdID]
//                                  ,p.[SupID]
//	                              ,s.SupName
//                                  ,p.[EmpID]
//	                              ,e.Fname
//                                  ,[OrdDate]
//                                  ,[OrdEnabled]
//                                  ,[TotalCost]
//                              FROM [ORDER_PRODUCT] p , [SUPPLIER] s, [EMPLOYEE] e
//                              where p.SupID = s.SupID and e.EmpID = p.EmpID and OrdEnabled = 0";
            string sql = @"SELECT [OrdID]
                                  ,p.[SupID]
	                              ,s.SupName
                                  ,p.[EmpID]
	                              ,e.Fname
                                  ,[OrdDate]
                                  ,[OrdEnabled]
                                  ,[TotalCost]
                            FROM [ORDER_PRODUCT] p , [SUPPLIER] s, [EMPLOYEE] e
                            where p.SupID = s.SupID and e.EmpID = p.EmpID and OrdEnabled = 0
							and p.OrdID IN(
							select distinct aa.OrdID
							from(
							SELECT a.OrdID,a.OrdNo  , a.OrdAmount - ISNULL(sum(b.AmountRec),0)  as cal
							FROM [ORDER_PRODUCT_DTA] a
							left outer join  [RECEIVEORDER_DTA] b
							ON  a.OrdID = b.OrdID
							and a.OrdNo = b.OrdNo
							group by a.OrdID,a.OrdNo,a.OrdAmount
							) aa
							group by aa.OrdID,aa.OrdNo
							having sum(aa.cal) > 0 
							)";
            return Db.ReadList(sql, Make);
        }
        public List<WeakOrderDetailsEntity> GetListOrderNEW(string ordID)
        {
            string sql = @"SELECT 
							odta.OrdID,odta.OrdNo,o.OrdDate,o.TotalCost,
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
                              ,p.SerialStatus
                         FROM [PRODUCT] as p, [COLOR] as c , [BRAND] as b, [TYPEPRODUCT] as t, [TRADEMARK] as tr , SUPPLIER as s,[OFFERDETAIL] as offdta ,OFFER as offer
			                , [ORDER_PRODUCT] o , [ORDER_PRODUCT_DTA] odta
                        where  c.ClrID = p.ClrID and p.TypeProductID = t.TypeProductID  and b.TrdID = tr.TrdID
                        and p.BrandID = b.BrandID and s.SupID = offer.SupID and  PrdEnabled = 0 and p.PrdID = offdta.PrdID and offer.OffID = offdta.OffID  and o.SupID = s.SupID
		                and o.OrdID = odta.OrdID and odta.OffID = offdta.OffID and odta.OfdNo = offdta.OfdNo 
                        and odta.OrdID = '" + ordID + "'";
            return Db.ReadList(sql, MakeGetID);
        }
        public List<WeakOrderDetailsEntity> GetListOrderOLD(string ordID)
        {

            string sql = @"SELECT
                               ISNULL(rec_dta.[AmountRec],0) as [AmountRec]
							  ,offdta.[AmountApprove],
							  odta.OrdID,odta.OrdNo,o.OrdDate,o.TotalCost,
                              offdta.[OffID]
							  ,offdta.[OfdNo]
                              ,offer.[OffStatus]
							 ,offdta.[AmountPost]
							  ,offdta.[Cost]
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
                               ,p.SerialStatus
                         FROM [PRODUCT] as p, [COLOR] as c , [BRAND] as b, [TYPEPRODUCT] as t, [TRADEMARK] as tr , SUPPLIER as s,[OFFERDETAIL] as offdta ,OFFER as offer
			                , [ORDER_PRODUCT] o ,
						RECEIVEORDER_DTA as rec_dta right join  [ORDER_PRODUCT_DTA] odta 
							 on odta.OrdID = rec_dta.OrdID and odta.OrdNo = rec_dta.OrdNo
                        where  c.ClrID = p.ClrID and p.TypeProductID = t.TypeProductID  and b.TrdID = tr.TrdID
                        and p.BrandID = b.BrandID and s.SupID = offer.SupID and  PrdEnabled = 0 and
						 p.PrdID = offdta.PrdID and offer.OffID = offdta.OffID  and o.SupID = s.SupID
		                and o.OrdID = odta.OrdID and odta.OffID = offdta.OffID and odta.OfdNo = offdta.OfdNo 
                        and odta.OrdID = '" + ordID + "'" + "order by odta.OrdNo";
            return Db.ReadList(sql, MakeGetIDOLD);
        }

        public OrderEntity GetOrder(string ordID)
        {
            throw new NotImplementedException();
        }
        protected Func<IDataReader, OrderEntity> Make = reader =>
        {
            return new OrderEntity
            {
                OrdID = reader["OrdID"].ToString(),
                SupID = reader["SupID"].ToString(),
                SupName = reader["SupName"].ToString(),
                EmpID = reader["EmpID"].ToString(),
                EmpName = reader["Fname"].ToString(),
                OrdDate = reader.GetDateTime(reader.GetOrdinal("OrdDate")).ToString("yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture),
                OrdEnabled = reader["OrdEnabled"].ToString(),
                TotalCost = reader.GetDecimal(reader.GetOrdinal("TotalCost"))
            };
        };

        protected Func<IDataReader, WeakOrderDetailsEntity> MakeGetIDOLD = reader =>
        {
            return new WeakOrderDetailsEntity
            {
                OrdID = reader["OrdID"].ToString(),
                OrdNo = reader.GetInt32(reader.GetOrdinal("OrdNo")),
                OrdDate = reader.GetDateTime(reader.GetOrdinal("OrdDate")).ToString("yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture),
                TotalCost = reader.GetDecimal(reader.GetOrdinal("Totalcost")),
                OffID = reader["OffID"].ToString(),
                OfdNo = reader.GetInt32(reader.GetOrdinal("OfdNo")),
                PrdID = reader["PrdID"].ToString(),
                SupID = reader["SupID"].ToString(),
                SupName = reader["SupName"].ToString(),
                SubAddress = reader["SubAddress"].ToString(),
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
                Cost = reader.GetDecimal(reader.GetOrdinal("Cost")),
                AmountApprove = reader.GetInt32(reader.GetOrdinal("AmountApprove")),
                AmountRec = reader.GetInt32(reader.GetOrdinal("AmountRec")),
                SerialStatus = reader["SerialStatus"].ToString(),
            };
        };

        protected Func<IDataReader, WeakOrderDetailsEntity> MakeGetID = reader =>
        {
            return new WeakOrderDetailsEntity
            {
                OrdID = reader["OrdID"].ToString(),
                OrdNo = reader.GetInt32(reader.GetOrdinal("OrdNo")),
                OrdDate = reader.GetDateTime(reader.GetOrdinal("OrdDate")).ToString("yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture),
                TotalCost = reader.GetDecimal(reader.GetOrdinal("Totalcost")),
                OffID = reader["OffID"].ToString(),
                OfdNo = reader.GetInt32(reader.GetOrdinal("OfdNo")),
                PrdID = reader["PrdID"].ToString(),
                SupID = reader["SupID"].ToString(),
                SupName = reader["SupName"].ToString(),
                SubAddress = reader["SubAddress"].ToString(),
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
                Cost = reader.GetDecimal(reader.GetOrdinal("Cost")),
                AmountApprove = reader.GetInt32(reader.GetOrdinal("AmountApprove")),
                SerialStatus = reader["SerialStatus"].ToString(),
            };
        };
    }

}