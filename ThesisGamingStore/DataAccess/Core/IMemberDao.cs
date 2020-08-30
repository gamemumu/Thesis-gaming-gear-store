using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ThesisGamingStore.Models;

namespace ThesisGamingStore.DataAccess.Core
{
    interface IMemberDao
    {
            bool InsertMember(MEMBER member);
            bool UpdateMember(MEMBER member);
            bool DeleteMember(string MemberID);
            List<MEMBER> ListMember();
            MEMBER GetMember(string MemberID);
            bool CheckEmail(string Email, string ID);
    }
}
