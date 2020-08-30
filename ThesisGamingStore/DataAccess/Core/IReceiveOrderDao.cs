using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ThesisGamingStore.Entity;
using ThesisGamingStore.Models;

namespace ThesisGamingStore.DataAccess.Core
{
    interface IReceiveOrderDao
    {
        bool InsertReceive(ReceiveModel rec, List<ReceiveDetailModel> list, List<SERIAL> serial);
        bool UpdateReceive(ReceiveDetailModel[] list, string recID, string empApprove);
        bool DeleteReceive(string recID);
        List<ReceiveModel> ListReceive();
        List<WeakReceiveDetailsEntity> GetListReceive(string recID);
        ReceiveModel GetReceive(string recID);
    }
}
