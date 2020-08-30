using System;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using System.Web;
using ThesisGamingStore.DataAccess.Core;
using ThesisGamingStore.Models;

namespace ThesisGamingStore.DataAccess
{
    public class SqlMember : IMemberDao
    {
        public bool InsertMember(MEMBER member)
        {
            string sql = @"sp_member_INSERT";
            string sql_phone = @"sp_memAndPhone_INSERT";
            string retID = "";

            using (TransactionScope ts = new TransactionScope())
            {
                object[] obj_mem = {"@MFname",member.MFname,"@MLname",member.MLname,"@MAddress",member.MAddress,"@MSex",member.MSex,"@MEmail",member.MEmail,"@MPassword",member.MPassword};
                retID = Db.InsertReturnID(sql, obj_mem);
                if (retID != null)
                {
                    if (member.MEMBER_PHONE.Count == 0)
                        return false;
                    else
                    {
                        foreach (var ls in member.MEMBER_PHONE)
                        {
                            object[] obj = { "@MemID", retID, "@Phone", ls.Phone };
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

        public bool UpdateMember(MEMBER member)
        {
            string sql = @"sp_member_UPDATE";
            string sql_phone = @"sp_memAndPhone_UPDATE";
            string sql_del = @"sp_memAndPhone_DELETE";

            using (TransactionScope ts = new TransactionScope())
            {
                object[] obj_mem = { "@MFname", member.MFname, "@MLname", member.MLname, "@MAddress", member.MAddress, "@MSex", member.MSex, "@MemID", member.MemID };
                Db.Update(sql, obj_mem);
                 object[] obj_del = {"@MemID", member.MemID };
                 Db.Delete(sql_del, obj_del);
                    if (member.MEMBER_PHONE.Count == 0)
                        return false;
                    else
                    {
                        foreach (var ls in member.MEMBER_PHONE)
                        {
                            object[] obj = { "@MemID", member.MemID, "@Phone", ls.Phone };
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
        }

        public bool DeleteMember(string MemberID)
        {
            string sql = @"sp_member_DELETE";
            object[] obj = { "@MemID", MemberID };
            using (TransactionScope ts = new TransactionScope())
            {
                try { Db.Delete(sql, obj); ts.Complete(); return true; }
                catch { return false; }
            }
        }

        public List<MEMBER> ListMember()
        {
            throw new NotImplementedException();
        }

        public MEMBER GetMember(string MemberID)
        {
            throw new NotImplementedException();
        }

        public bool CheckEmail(string Email, string ID)
        {
            throw new NotImplementedException();
        }
    }
}