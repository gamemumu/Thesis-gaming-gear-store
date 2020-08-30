using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using System.Web;
using ThesisGamingStore.DataAccess.Core;
using ThesisGamingStore.Models;

namespace ThesisGamingStore.DataAccess
{
    public class SqlReceive : IReceiveOrderDao
    {
        public bool InsertReceive(ReceiveModel rec, List<ReceiveDetailModel> list, List<SERIAL> serial)
        {
            string sql = @"[sp_receiveorder_INSERT]";
            string sql_Detail = @"[sp_receiveorder_dta_INSERT]";
            string sql_Lot = @"[sp_productlot_INSERT]";
            string sql_serial = @"[sp_serial_INSERT]";

            // update Offer status => Approve to Purchase
            // string sql_UPDATE = @"sp_orderANDoffer_UPDATE";
            string retID = "";
            string tempID = "";
            object[] objRec = { "@EmpID", rec.EmpID, "@RecODate", rec.RecODate };
            using (TransactionScope ts = new TransactionScope())
            {
                try
                {
                    retID = Db.InsertReturnID(sql, objRec);
                    if (retID != null)
                    {
                        foreach (var ls in list)
                        {
                            object[] obj = { "@RecOID", retID, "@RecONo", ls.RecONo, "@OrdID", ls.OrdID, "@OrdNo", ls.OrdNo, "@AmountRec", ls.AmountRec};
                            object[] obj_lot = { "@LotNo", tempID, "@PrdID", ls.PrdID, "@RecOID", retID, "@RecONo", ls.RecONo,"@AmountRec",ls.AmountRec,"@Amount", ls.AmountRec, "@Price", ls.Cost, "@LotDate", System.DateTime.Now.ToString("yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture) };
                            //object[] obj_stock = 
                            try
                            {
                                Db.Insert(sql_Detail, obj);
                                tempID = Db.InsertReturnID(sql_Lot, obj_lot);
                            }
                            catch
                            {
                                return false;
                            }
                        }
                        foreach (var ls in serial)
                        {

                            object[] obj_serial = { "@LotNo", tempID, "@PrdID", ls.PrdID, "@SrlID", ls.SrlID };
                            try
                            {
                                Db.Insert(sql_serial, obj_serial);
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
                catch
                {
                    return false;
                }
            }
        }

        public bool UpdateReceive(ReceiveDetailModel[] list, string recID, string empApprove)
        {
            throw new NotImplementedException();
        }

        public bool DeleteReceive(string recID)
        {
            throw new NotImplementedException();
        }

        public List<ReceiveModel> ListReceive()
        {
            throw new NotImplementedException();
        }

        public List<Entity.WeakReceiveDetailsEntity> GetListReceive(string recID)
        {
            throw new NotImplementedException();
        }

        public ReceiveModel GetReceive(string recID)
        {
            throw new NotImplementedException();
        }
    }
}