using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ThesisGamingStore.Entity;
using ThesisGamingStore.Models;

namespace ThesisGamingStore.DataAccess.Core
{
    interface ISupplierDao
    {
        bool InsertSupplier(SupplierEntity Supplier);
        bool InsertSupAndPhone(SupplierEntity Supplier, ICollection<SUPPLIER_PHONE> list);
        bool UpdateSupplier(SupplierEntity Supplier, ICollection<SUPPLIER_PHONE> list);
        bool DeleteSupplier(string supID);
        List<SupplierEntity> ListSupplier();
        List<SupplierEntity> ListSupplier(int pageSize, int pageNum);
        SupplierEntity GetSupplier(string supID);
        bool CheckNameSup(string supName);
        bool CheckPhone(string phoneNum);
    }
}
