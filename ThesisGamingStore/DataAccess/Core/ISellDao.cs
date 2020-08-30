using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ThesisGamingStore.Models;

namespace ThesisGamingStore.DataAccess.Core
{
    interface ISellDao
    {
        bool InsertSellProduct(SELLPRODUCT sellpd);
        string InsertDeliver(DELIVER data);
        bool UpdateDeliver(DELIVER data);
    }

}
