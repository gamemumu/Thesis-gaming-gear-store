using System;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using System.Web;
using ThesisGamingStore.DataAccess.Core;
using ThesisGamingStore.Models;

namespace ThesisGamingStore.DataAccess
{
    public class SqlPayment : IPaymentDao
    {
        public bool InsertPayment(_Payment pay)
        {
            string sql = "sp_payment_INSERT";
            object[] obj = { "@SlpID", pay.SlpID, "@BnkAccNumber", pay.BnkAccNumber, "@PayDate", pay.PayDate.ToString("yyyy-MM-dd HH:mm:ss"), "@PayPrice", pay.PayPrice, "@PayImg", pay.PayImg };
            using (TransactionScope ts = new TransactionScope())
            {
                try { Db.Insert(sql, obj); ts.Complete(); return true; }
                catch { return false; }
            }
        }
        public bool DeletePayment(string id, List<SELLPRODUCT_DTA> ls)
        {
            string sql = "sp_payment_DELETE";
            string sql_del_reserve = "sp_checkout_del_reserve";
            object[] obj = { "@SlpID", id };
            using (TransactionScope ts = new TransactionScope())
            {
                try
                {
                    Db.Delete(sql, obj);
                    foreach (var l in ls)
                    {
                        object[] obj_reverse = { "@PrdID", l.PrdID, "@Amount", l.SpdAmount };
                        Db.Update(sql_del_reserve, obj_reverse);
                    }
                    ts.Complete();
                    return true;
                }
                catch { return false; }
            }
        }
        public bool UpdateStatus(string id, string status)
        {
            string sql = "sp_payment_UPDATE";
            object[] obj = { "@SlpID", id, "@SlpStatus", status };
            using (TransactionScope ts = new TransactionScope())
            {
                try { Db.Update(sql, obj); ts.Complete(); return true; }
                catch { return false; }
            }
        }
        public bool UpdatePayError(string id, string status, decimal money)
        {
            string sql = "sp_paymentError_UPDATE";
            object[] obj = { "@SlpID", id, "@SlpStatus", status,"@PayPriceCheck",money};
            using (TransactionScope ts = new TransactionScope())
            {
                try { Db.Update(sql, obj); ts.Complete(); return true; }
                catch { return false; }
            }
        }

        public bool UpdateStock(string id, string status, List<SELLPRODUCT_DTA> ls)
        {
            string sql = "sp_payment_UPDATE";
            string sql_serial = "sp_sellproductDTAserial_INSERT";
            string sql_nserial = "sp_sellproductDTANOserial_INSERT";
            object[] obj = { "@SlpID", id, "@SlpStatus", status };

            using (TransactionScope ts = new TransactionScope())
            {
                try
                {
                    foreach (var item in ls)
                    {
                        List<String> tempSrlID = new List<String>();
                        List<String> tempLot = new List<String>();
                        int OrderAmount = item.SpdAmount;
                        if (item.PRODUCT.SerialStatus.Equals("1"))
                        {
                            var result = item.PRODUCT.PRODUCTLOT
                                        .Where(x => x.Amount > 0)
                                        .Select(g => new
                                        {
                                            sss = g.SERIAL.Where(x => x.SrlStatus == "0").ToList(),
                                        })
                                        .ToList();
                            foreach (var dd in result)
                            {
                                if (OrderAmount > 0)
                                {
                                    for (int i = 0; i < dd.sss.Count && OrderAmount > 0; i++)
                                    {
                                        if (tempSrlID.Contains(dd.sss[i].SrlID))
                                        {
                                            continue;
                                        }
                                        tempSrlID.Add(dd.sss[i].SrlID);
                                        OrderAmount--;
                                        object[] obj_serial = { "@SlpID", item.SlpID, "@SlpNo", item.SlpNo, "@SrlID", dd.sss[i].SrlID, "@PrdID", item.PrdID, "@LotNo", dd.sss[i].LotNo };
                                        Db.Insert(sql_serial, obj_serial);
                                    }
                                }
                                else
                                {
                                    break;
                                }
                            }
                        }
                        else
                        {
                            while (OrderAmount > 0)
                            {
                                var c = item.PRODUCT.PRODUCTLOT.Where(x => x.Amount > 0 && !tempLot.Contains(x.LotNo)).FirstOrDefault();
                                //สำหรับล๊อตที่มี จำนวนน้อยกว่าที่สั่งไว้ ต้องไปดึงมาจากล๊อตต่อไป
                                if (c.Amount <= OrderAmount)
                                {
                                    object[] obj_Nserial = { "@SlpID", item.SlpID, "@SlpNo", item.SlpNo, "@PrdID", item.PrdID, "@LotNo", c.LotNo, "@Amount", c.Amount };
                                    Db.Insert(sql_nserial, obj_Nserial);
                                    OrderAmount = OrderAmount - c.Amount;
                                    tempLot.Add(c.LotNo);
                                }
                                else
                                {
                                    object[] obj_Nserial = { "@SlpID", item.SlpID, "@SlpNo", item.SlpNo, "@PrdID", item.PrdID, "@LotNo", c.LotNo, "@Amount", OrderAmount };
                                    Db.Insert(sql_nserial, obj_Nserial);
                                    OrderAmount = 0;
                                }
                            }
                        }
                    }
                    Db.Update(sql, obj);
                    ts.Complete();
                    return true;
                }
                catch (Exception ex) { Console.WriteLine(ex.Message); return false; }
            }
        }
     
    }
}