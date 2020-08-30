using System;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using System.Web;
using ThesisGamingStore.DataAccess.Core;
using ThesisGamingStore.Models;

namespace ThesisGamingStore.DataAccess
{
    public class SqlSellProduct : ISellDao
    {
        public bool InsertSellProduct(SELLPRODUCT sellpd)
        {
            string sql = @"sp_sellproduct_INSERT";
            string sql_dta = @"sp_sellproductDTA_INSERT";
            string sql_reserve = @"sp_checkout_reserve";
            string retID = "";
            using (TransactionScope ts = new TransactionScope())
            {
                object[] obj = { "@MemID", sellpd.MemID, "@SlpDate", sellpd.SlpDate,"@FnameRec", sellpd.FnameRec, 
                                 "@LnameRec", sellpd.LnameRec,"@AdressRec",sellpd.AdressRec,
                                 "@SlpStatus", "ยังไม่ได้ชำระเงิน" ,"@SlpSum", sellpd.SlpSum};
                retID = Db.InsertReturnID(sql, obj);
                if (retID != null)
                {
                    int Num = 0;
                    foreach (var ls in sellpd.SELLPRODUCT_DTA)
                    {
                        object[] obj_dta = {"@SlpID", retID, "@SlpNo", Num++,"@PrdID", ls.PrdID,
                                      "@SpdAmount", ls.SpdAmount,"@SpdPrice",ls.SpdPrice,"@Discount",ls.Discount };
                        object[] obj_reserve = { "@PrdID", ls.PrdID, "@Amount", ls.SpdAmount };
                        try
                        {
                            Db.Insert(sql_dta, obj_dta);
                            Db.Update(sql_reserve, obj_reserve);
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
        public string InsertDeliver(DELIVER data)
        {
            string sql = "[sp_deliver_INSERT]";
            string retID = "";
            object[] obj = { "@EmpId", data.EmpID, "@SlpID", data.SlpID, "@DlvDate", data.DlvDate, "@DlvSerial", data.DlvSerial };
            using (TransactionScope ts = new TransactionScope())
            {
                try { retID = Db.InsertReturnID(sql, obj); ts.Complete(); return retID; }
                catch { return retID = ""; }
            }
        }
        public bool UpdateDeliver(DELIVER data)
        {
            string sql = @"sp_deliver_UPDATE";
            object[] obj = { "@DlvID", data.DlvID, "@EmpId", data.EmpID, "@SlpID", data.SlpID, "@DlvDate", data.DlvDate, "@DlvSerial", data.DlvSerial };
            using (TransactionScope ts = new TransactionScope())
            {
                try { Db.Update(sql, obj); ts.Complete(); return true; }
                catch { return false; }
            }
        }
    }
}