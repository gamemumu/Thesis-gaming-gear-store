using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ThesisGamingStore.Entity;
using ThesisGamingStore.Models;

namespace ThesisGamingStore.DataAccess.Core
{
    interface IOrderDao
    {
        string InsertOrder(OrderEntity ord, OrderDetailModel[] list);
        bool UpdateOrder(OrderDetailModel[] list, string ordID, string empApprove);
        bool DeleteOrder(string ordID);
        List<OrderEntity> ListOrder();
        List<WeakOrderDetailsEntity> GetListOrderNEW(string ordID);
        List<WeakOrderDetailsEntity> GetListOrderOLD(string ordID);
        OrderEntity GetOrder(string ordID);
    }
}
