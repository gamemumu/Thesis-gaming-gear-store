using ThesisGamingStore.DataAccess.Core;
using ThesisGamingStore.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Transactions;

namespace ThesisGamingStore.DataAccess
{
    public class SqlBank : IBankDao
    {
        public bool InsertBank(BANK Bank)
        {
            string sql = @"sp_bank_INSERT";
            object[] obj = { "@BnkAccNumber",Bank.BnkAccNumber, "@BnkName",Bank.BnkName ,"@BnkConName",Bank.BnkConName };
              using (TransactionScope ts = new TransactionScope())
              {
                  try { Db.Insert(sql, obj); ts.Complete(); return true; }
                  catch { return false; }
              }
        }

        public bool UpdateBank(BANK Bank)
        {
 	        string sql = @"sp_bank_UPDATE";
            object[] obj = { "@BnkAccNumber", Bank.BnkAccNumber, "@BnkName", Bank.BnkName, "@BnkConName", Bank.BnkConName };
            using (TransactionScope ts = new TransactionScope())
            {
                try { Db.Update(sql, obj); ts.Complete(); return true; }
                catch { return false; }
            }
        }

        public bool DeleteBank(string BankID)
        {
 	        string sql = @"sp_bank_DELETE";
            object[] obj = { "@BnkAccNumber", BankID };
            using (TransactionScope ts = new TransactionScope())
            {
                try { Db.Delete(sql, obj); ts.Complete(); return true; }
                catch { return false; }
            }
        }

        public List<BANK> ListBank()
        {
            string sql = @"SELECT *
                                  FROM [dbo].[BANK] where BnkEnabled = 0";
            return Db.ReadList(sql, Make);
        }

        public  BANK GetBank(string BankID)
        {
            string sql = @"SELECT *
                              FROM [BANK] where BnkAccNumber ='" + BankID + "'";
            return Db.Read(sql, Make);
        }

        protected Func<IDataReader, BANK> Make = reader =>
        {
            return new BANK
            {
                BnkAccNumber = reader["BnkAccNumber"].ToString(),
                BnkName = reader["BnkName"].ToString(),
                BnkConName = reader["BnkConName"].ToString(),
                BnkEnabled = reader["BnkEnabled"].ToString(),
            };
        };


        public bool CheckName(string BnkAccNumber, string ID)
        {
            if (ID.Equals("CREATE"))
            {
                string sql = @"SELECT COUNT(*) FROM BANK WHERE REPLACE(BnkAccNumber, ' ', '') = @BnkAccNumber";
                object[] obj = { "@BnkAccNumber", BnkAccNumber };
                return Db.GetCount(sql, obj) > 0;
            }
            else
            {
                string sql = @"SELECT COUNT(*) FROM BANK WHERE REPLACE(BnkAccNumber, ' ', '') = @BnkAccNumber and BnkAccNumber != @ID";
                object[] obj = { "@BnkAccNumber", BnkAccNumber, "@ID", ID };
                return Db.GetCount(sql, obj) > 0;
            }
        }
    }
}