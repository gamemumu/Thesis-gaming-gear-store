using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ThesisGamingStore.Models;

namespace ThesisGamingStore.DataAccess.Core
{
    interface IBankDao
    {
        bool InsertBank(BANK Bank);
        bool UpdateBank(BANK Bank);
        bool DeleteBank(string BankID);
        List<BANK> ListBank();
        BANK GetBank(string BankID);
        bool CheckName(string Email, string ID);
    }
}
