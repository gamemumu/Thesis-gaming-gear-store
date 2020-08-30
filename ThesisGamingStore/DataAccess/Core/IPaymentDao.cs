using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ThesisGamingStore.Models;

namespace ThesisGamingStore.DataAccess.Core
{
    interface IPaymentDao
    {
        bool InsertPayment(_Payment pay);
        bool DeletePayment(string id,List<SELLPRODUCT_DTA> ls);
        bool UpdateStatus(string id,string status);
        bool UpdateStock(string id, string status, List<SELLPRODUCT_DTA> ls);
        bool UpdatePayError(string id, string status,decimal money);
    }
}
