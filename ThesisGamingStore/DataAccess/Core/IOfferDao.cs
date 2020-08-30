using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ThesisGamingStore.Entity;
using ThesisGamingStore.Models;

namespace ThesisGamingStore.DataAccess.Core
{
    interface IOfferDao
    {
        bool InsertOffer(OfferModel[] off, OfferDetailModel[] list);
        bool UpdateOffer(OfferDetailModel[] list, string OffID, string empApprove);
        bool DeleteOffer(string offID);
        List<OfferEntity> ListOffer();
        List<OfferEntity> ListOfferForOrder(string id);
        List<OfferEntity> ListOffer(int pageSize, int pageNum);
        List<WeakOfferDetailsEntity> GetListOffer(string offID);
        OfferEntity GetOffer(string offID);
    }
}
