using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ThesisGamingStore.Models;

namespace ThesisGamingStore.DataAccess.Core
{
    interface IPromotionDao
    {
        bool InsertPROMOTION(PROMOTION PROMOTION);
        bool UpdatePROMOTION(PROMOTION PROMOTION);
        bool DeletePROMOTION(string PROMOTIONID);
        List<PROMOTION> ListPROMOTION();
        List<ThesisGamingStore.DataAccess.SqlPromotion.PROMOTION_DTA> GetPROMOTION(string PROMOTIONID);
        List<ThesisGamingStore.DataAccess.SqlPromotion.PROMOTION_DTA> GetPROMOTION2(string PROMOTIONID);
    }
}
