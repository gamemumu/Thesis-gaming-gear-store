using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ThesisGamingStore.DataAccess.Core;
using ThesisGamingStore.Entity;

namespace ThesisGamingStore.DataAccess
{
    public class SqlProductLot :IProductLotDao
    {
        public bool InsertProductLot(ProductLotEntity productLot)
        {
            throw new NotImplementedException();
        }

        public bool UpdateProductLot(ProductLotEntity productLot)
        {
            throw new NotImplementedException();
        }

        public bool DeleteProductLot(string productLotID)
        {
            //string sql = @"sp_tradmark_DELETE";
            //object[] obj = { "@TrdID ", tradmarkID };
            //Db.Delete(sql, obj);
            //return true;
            throw new NotImplementedException();
        }

        public List<ProductLotEntity> ListProductLot()
        {
            throw new NotImplementedException();
        }

        public List<ProductLotEntity> ListProductLot(int pageSize, int pageNum)
        {
            throw new NotImplementedException();
        }

        public ProductLotEntity GetProductLot(string productLotID)
        {
            throw new NotImplementedException();
        }


        public bool CheckNameUnique(string producName)
        {
            throw new NotImplementedException();
        }
    }
}