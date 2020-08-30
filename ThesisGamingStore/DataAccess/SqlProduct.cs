using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Transactions;
using System.Web;
using ThesisGamingStore.DataAccess.Core;
using ThesisGamingStore.Entity;
using ThesisGamingStore.Models;

namespace ThesisGamingStore.DataAccess
{
    public class SqlProduct : IProductDao
    {

        public bool InsertProductForSup(List<ProductSup> list)
        {
            string sql_productsup = "sp_PRODUCTSUPPLIER_INSERT";
            using (TransactionScope ts = new TransactionScope())
            {
                try
                {
                    foreach (var ls in list)
                    {
                        object[] ojbProSup = { "@PrdID", ls.PrdID, "@SupID", ls.SupID, "@Price", ls.Price, "@PsUpdate", System.DateTime.Now.ToString("yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture) };
                        Db.Insert(sql_productsup, ojbProSup);
                    }
                    ts.Complete();
                    return true;
                }
                catch { return false; }
            }
        }

        public bool UpdateProductForSup(List<ProductSup> list)
        {
            string sql_productsup = "sp_PRODUCTSUPPLIER_UPDATE";
            using (TransactionScope ts = new TransactionScope())
            {
                try
                {
                    foreach (var ls in list)
                    {
                        object[] ojbProSup = { "@PrdID", ls.PrdID, "@SupID", ls.SupID, "@Price", ls.Price, "@PsUpdate", System.DateTime.Now.ToString("yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture) };
                        Db.Update(sql_productsup, ojbProSup);
                    }
                    ts.Complete();
                    return true;
                }
                catch { return false; }
            }
        }

        public bool InsertProduct(ProductEntity product, List<string> dataPhoto)
        {
            string sql = "sp_product_INSERT";
            //string sql_productsup = "sp_PRODUCTSUPPLIER_INSERT";
            string retID = "";
            int i = 1;
            object[] objProduct = { "@Description", product.Description, "@Waranty", product.Waranty, "@ClrID", product.ClrID, "@TypeProductID", product.TypeProductID, "@BrandID", product.BrandID, "@ReorderPoint", product.ReorderPoint, "@Price", product.Price, "@SerialStatus", product.SerialStatus };
            using (TransactionScope ts = new TransactionScope())
            {
                try
                {
                    retID = Db.InsertReturnID(sql, objProduct);
                    //object[] ojbProSup = { "@PrdID", retID, "@SupID", product.SupID };
                    //try { Db.Insert(sql_productsup, ojbProSup); }
                    //catch { return false; }
                    string sql_path = "sp_photo_INSERT";
                    foreach (var ls in dataPhoto)
                    {
                        object[] objPh = { "@PhotoID", i++, "@PrdID", retID, "@Photo", ls };
                        try { Db.Insert(sql_path, objPh); }
                        catch { return false; }
                    }
                    ts.Complete();
                    return true;
                }
                catch { return false; }
            }
        }
        public bool UpdateProduct(ProductEntity product, List<string> dataPhoto)
        {
            string sql = "sp_product_UPDATE";
            //string sql_productsup = "sp_PRODUCTSUPPLIER_UPDATE";
            string sql_findID = @"SELECT max(PhotoID) +1 as PhotoID
                      FROM [dbo].[PHOTO]
                      where PrdID = '" +  product.PrdID + "'";
            var maxNo = Db.Read(sql_findID,MakeMaxNo);
            int i = maxNo.PhotoID;
            object[] objProduct = { "@PrdID", product.PrdID, "@Description", product.Description, "@Waranty", product.Waranty, "@ClrID", product.ClrID, "@TypeProductID", product.TypeProductID, "@BrandID", product.BrandID,"@SerialStatus",product.SerialStatus,"@Price", product.Price,"@ReorderPoint", product.ReorderPoint,"@PrdStatus",product.PrdStatus};
            using (TransactionScope ts = new TransactionScope())
            {
                try
                {
                    Db.Update(sql, objProduct);
                    //object[] ojbProSup = { "@PrdID", product.PrdID, "@SupID", product.SupID };
                    //try { Db.Update(sql_productsup, ojbProSup); }
                    //catch { return false; }
                    if (dataPhoto.Count > 0)
                    {
                        string sql_path = "sp_photo_INSERT";
                        foreach (var ls in dataPhoto)
                        {
                            object[] objPh = { "@PhotoID", i++, "@PrdID", product.PrdID, "@Photo", ls };
                            try { Db.Insert(sql_path, objPh); }
                            catch { return false; }
                        }
                    }
                    ts.Complete();
                    return true;
                }
                catch { return false; }
            }
        }

        public bool DeleteProduct(string productID)
        {
            string sql = @"[sp_product_DELETE]";
            object[] obj = { "@PrdID", productID };
            using (TransactionScope ts = new TransactionScope())
            {
                try { Db.Delete(sql, obj); ts.Complete(); return true; }
                catch { return false; }
            }
        }

        public List<ProductEntity> ListProduct()
        {
            string sql = @"SELECT p.[PrdID]
                              ,p.[ClrID]
	                          ,c.ClrName
                              ,p.[TypeProductID]
	                          ,t.TypeName
                              ,b.TrdID
	                          ,tr.TrdName
                              ,p.[BrandID]
	                          ,b.BrandName
	                          ,[Photo]
	                          ,[Description]
                              ,[Waranty]
                              ,PrdEnabled
                              ,PrdStatus
  FROM [PRODUCT] as p, [PHOTO] as ph , [COLOR] as c , [BRAND] as b, [TYPEPRODUCT] as t, [TRADEMARK] as tr
  where p.PrdID = ph.PrdID and c.ClrID = p.ClrID and p.TypeProductID = t.TypeProductID  and b.TrdID = tr.TrdID
        and p.BrandID = b.BrandID and PrdEnabled = 0";
            return Db.ReadList(sql, Make);
        }

        public List<ProductEntity> ListProductAddSup(string SupID)
        {
            string sql = @"SELECT						  p.[PrdID]
                              ,p.[ClrID]
	                          ,c.ClrName
                              ,p.[TypeProductID]
	                          ,t.TypeName
                              ,b.TrdID
	                          ,tr.TrdName
                              ,p.[BrandID]
	                          ,b.BrandName
	                          ,[Photo]
	                          ,[Description]
                              ,[Waranty]
                              ,PrdEnabled
                              ,PrdStatus,ReorderPoint,Price
	          FROM [PRODUCT] as p, [PHOTO] as ph , [COLOR] as c , [BRAND] as b, [TYPEPRODUCT] as t, [TRADEMARK] as tr
	          where p.PrdID = ph.PrdID and c.ClrID = p.ClrID and p.TypeProductID = t.TypeProductID  and b.TrdID = tr.TrdID
              and p.BrandID = b.BrandID and PrdEnabled = 0 
			  and ph.PhotoID= 1
			  and p.PrdID not in(select prdID from PRODUCTSUPPLIER where  SupID = '" + SupID + "')";
            return Db.ReadList(sql, Make);
        }

        public List<ProductEntity> ListProductEditSup(string SupID)
        {
            string sql = @"SELECT						  p.[PrdID]
                              ,p.[ClrID]
	                          ,c.ClrName
                              ,p.[TypeProductID]
	                          ,t.TypeName
                              ,b.TrdID
	                          ,tr.TrdName
                              ,p.[BrandID]
	                          ,b.BrandName
	                          ,[Photo]
	                          ,[Description]
                              ,[Waranty]
                              ,PrdEnabled
                               ,PrdStatus
                               ,p.Price as SellPrice
                               ,ps.Price
                               ,ps.PsUpdate
	          FROM [PRODUCT] as p, [PHOTO] as ph , [COLOR] as c , [BRAND] as b, [TYPEPRODUCT] as t, [TRADEMARK] as tr, [PRODUCTSUPPLIER] ps
	          where p.PrdID = ph.PrdID and c.ClrID = p.ClrID and p.TypeProductID = t.TypeProductID  and b.TrdID = tr.TrdID and ps.PrdID = p.PrdID
              and p.BrandID = b.BrandID and PrdEnabled = 0 
			  and ph.PhotoID= 1
			  and p.PrdID in(select prdID from PRODUCTSUPPLIER where ps.SupID = SupID and SupID = '" + SupID + "')";
            return Db.ReadList(sql, MakeProSup);
        }
        public List<ProductEntity> ListProduct(string SupID)
        {

            string sql = @"SELECT p.[PrdID]
                              ,p.[ClrID]
	                          ,c.ClrName
                              ,p.[TypeProductID]
	                          ,t.TypeName
                              ,b.TrdID
	                          ,tr.TrdName
                              ,p.[BrandID]
	                          ,b.BrandName
	                          ,[Photo]
	                          ,[Description]
                              ,[Waranty]
                              ,PrdEnabled
                              ,PrdStatus
                              ,ps.Price
							  ,ps.PsUpdate
	          FROM [PRODUCT] as p, [PHOTO] as ph , [COLOR] as c , [BRAND] as b, [TYPEPRODUCT] as t, [TRADEMARK] as tr, PRODUCTSUPPLIER ps,SUPPLIER s
	          where p.PrdID = ph.PrdID and c.ClrID = p.ClrID and p.TypeProductID = t.TypeProductID  and b.TrdID = tr.TrdID
              and p.BrandID = b.BrandID and PrdEnabled = 0 and p.PrdID = ps.PrdID and ps.SupID = s.SupID  and ph.PhotoID= 1 and ps.SupID = '" + SupID + "'";
            return Db.ReadList(sql, MakeProSup);
        }




        public List<ProductEntity> ListProductPic1()
        {
            string sql = @"SELECT p.[PrdID]
                              ,p.[ClrID]
	                          ,c.ClrName
                              ,p.[TypeProductID]
	                          ,t.TypeName
                              ,b.TrdID
	                          ,tr.TrdName
                              ,p.[BrandID]
	                          ,b.BrandName
	                          ,[Photo]
	                          ,[Description]
                              ,[Waranty]
                              ,PrdEnabled
                              ,PrdStatus,ReorderPoint,Price
	          FROM [PRODUCT] as p, [PHOTO] as ph , [COLOR] as c , [BRAND] as b, [TYPEPRODUCT] as t, [TRADEMARK] as tr
	          where p.PrdID = ph.PrdID and c.ClrID = p.ClrID and p.TypeProductID = t.TypeProductID  and b.TrdID = tr.TrdID
              and p.BrandID = b.BrandID and PrdEnabled = 0 and ph.PhotoID = 1";
            return Db.ReadList(sql, MakeL);
        }
        public List<ProductEntity> ListProductNoPic(string SupID)
        {
            string sql = @"SELECT p.[PrdID]
                              ,p.[ClrID]
	                          ,c.ClrName
                              ,p.[TypeProductID]
	                          ,t.TypeName
                              ,b.TrdID
	                          ,tr.TrdName
                              ,p.[BrandID]
	                          ,b.BrandName
	                          ,[Description]
                              ,[Waranty]
                              ,PrdEnabled ,PrdStatus
	          FROM [PRODUCT] as p, [COLOR] as c , [BRAND] as b, [TYPEPRODUCT] as t, [TRADEMARK] as tr, PRODUCTSUPPLIER ps,SUPPLIER s
	          where  c.ClrID = p.ClrID and p.TypeProductID = t.TypeProductID  and b.TrdID = tr.TrdID
              and p.BrandID = b.BrandID and PrdEnabled = 0 and p.PrdID = ps.PrdID and ps.SupID = s.SupID and ps.SupID = '" + SupID + "'";
            return Db.ReadList(sql, Make2);
        }

        public ProductEntity GetProduct(string productID)
        {
            throw new NotImplementedException();
        }
        public List<ProductEntity> ListProductForOffer()
        {
            string sql = @"SELECT	 distinct p.[PrdID]
                              ,p.[ClrID]
	                          ,c.ClrName
                              ,p.[TypeProductID]
	                          ,t.TypeName
                              ,b.TrdID
	                          ,tr.TrdName
                              ,p.[BrandID]
	                          ,b.BrandName
	                          ,[Photo]
	                          ,[Description]
                              ,[Waranty]
                              ,PrdEnabled
                              ,PrdStatus,ReorderPoint,p.Price
							  ,ISNULL(sum(Amount),0) as amount
	          FROM [PHOTO] as ph , [COLOR] as c , [BRAND] as b, [TYPEPRODUCT] as t, [TRADEMARK] as tr,PRODUCTSUPPLIER ps,
			  PRODUCTLOT pl right join PRODUCT p
			  on  p.PrdID=pl.PrdID
	          where p.PrdID = ph.PrdID and c.ClrID = p.ClrID and p.TypeProductID = t.TypeProductID  and b.TrdID = tr.TrdID
              and p.BrandID = b.BrandID and PrdEnabled = 0 and ph.PhotoID = 1 and ps.PrdID = p.PrdID
			  group by p.PrdID,p.ClrID,c.ClrName,p.TypeProductID,t.TypeName,b.TrdID,tr.TrdName,p.BrandID,b.BrandName,ph.Photo
			  ,p.Description,p.Waranty,p.PrdEnabled,p.PrdStatus,p.ReorderPoint,p.Price,ps.SupID";

            return Db.ReadList(sql, MakeOFF);
        }
        public List<ProductEntity> GetProductList(string productID)
        {
            string sql = @"SELECT p.[PrdID]
							  ,s.SupID,s.SupName
                              ,p.[ClrID]
	                          ,c.ClrName
                              ,p.[TypeProductID]
	                          ,t.TypeName
                              ,b.TrdID
	                          ,tr.TrdName
                              ,p.[BrandID]
	                          ,b.BrandName
	                          ,[Description]
                              ,[Waranty]
                              ,PrdEnabled ,PrdStatus
                              ,ReorderPoint
                              ,ps.Price
							  ,ps.PsUpdate
	          FROM [PRODUCT] as p,[COLOR] as c , [BRAND] as b, [TYPEPRODUCT] as t, [TRADEMARK] as tr,SUPPLIER s, PRODUCTSUPPLIER ps
	          where c.ClrID = p.ClrID and p.TypeProductID = t.TypeProductID  and b.TrdID = tr.TrdID
              and p.BrandID = b.BrandID and PrdEnabled = 0
			  and s.SupID = ps.SupID and p.PrdID = ps.PrdID
			   and p.PrdID = '" + productID + "'";
            return Db.ReadList(sql, MakeProList);
        }
        public Tuple<ProductEntity, List<PhotoEntity>> GetProductTuple(string productID)
        {
            string sql = @"SELECT p.[PrdID]
                              ,p.[ClrID]
	                          ,c.ClrName
                              ,p.[TypeProductID]
	                          ,t.TypeName
                              ,b.TrdID
	                          ,tr.TrdName
                              ,p.[BrandID]
	                          ,b.BrandName
	                          ,[Photo]
	                          ,[Description]
                              ,[Waranty]
                              ,PrdEnabled ,PrdStatus
                              ,ReorderPoint
                              ,Price,SerialStatus
	          FROM [PRODUCT] as p, [PHOTO] as ph , [COLOR] as c , [BRAND] as b, [TYPEPRODUCT] as t, [TRADEMARK] as tr
	          where p.PrdID = ph.PrdID and c.ClrID = p.ClrID and p.TypeProductID = t.TypeProductID  and b.TrdID = tr.TrdID
              and p.BrandID = b.BrandID and PrdEnabled = 0 and p.PrdID = '" + productID + "'";

            string sql_photo = @" SELECT ph.[PrdID]
	                                                      ,ph.[Photo]
                                                         ,ph.PhotoID
	                                      FROM [PRODUCT] as p, [PHOTO] as ph 
	                                      where p.PrdID = ph.PrdID and
			                               ph.PrdID = '" + productID + "'";
            return Tuple.Create(Db.Read(sql, MakePro), Db.ReadList(sql_photo, MakePhoto));
        }
        public bool CheckNameUnique(string roleName)
        {
            throw new NotImplementedException();
        }

        protected Func<IDataReader, PhotoEntity> MakeMaxNo = reader =>
        {
            return new PhotoEntity
            {
                PhotoID = reader.GetInt32(reader.GetOrdinal("PhotoID")),
            };
        };
        protected Func<IDataReader, ProductEntity> MakeL = reader =>
        {
            return new ProductEntity
            {
                PrdID = reader["PrdID"].ToString(),
                ClrID = reader["ClrID"].ToString(),
                ClrName = reader["ClrName"].ToString(),
                TypeProductID = reader["TypeProductID"].ToString(),
                TypeName = reader["TypeName"].ToString(),
                TrdID = reader["TrdID"].ToString(),
                TrdName = reader["TrdName"].ToString(),
                BrandID = reader["BrandID"].ToString(),
                BrandName = reader["BrandName"].ToString(),
                Filepath = reader["Photo"].ToString(),
                Description = reader["Description"].ToString(),
                PrdEnabled = reader["PrdEnabled"].ToString(),
                Waranty = reader.GetInt32(reader.GetOrdinal("Waranty")),
                PrdStatus = reader["PrdStatus"].ToString(),
                ReorderPoint = reader.GetInt32(reader.GetOrdinal("ReorderPoint")),
                Price = reader.GetDecimal(reader.GetOrdinal("Price")),
            };
        };  

        protected Func<IDataReader, ProductEntity> Make = reader =>
        {
            return new ProductEntity
            {
                PrdID = reader["PrdID"].ToString(),
                ClrID = reader["ClrID"].ToString(),
                ClrName = reader["ClrName"].ToString(),
                TypeProductID = reader["TypeProductID"].ToString(),
                TypeName = reader["TypeName"].ToString(),
                TrdID = reader["TrdID"].ToString(),
                TrdName = reader["TrdName"].ToString(),
                BrandID = reader["BrandID"].ToString(),
                BrandName = reader["BrandName"].ToString(),
                Filepath = reader["Photo"].ToString(),
                Description = reader["Description"].ToString(),
                PrdEnabled = reader["PrdEnabled"].ToString(),
                Waranty = reader.GetInt32(reader.GetOrdinal("Waranty")),
                PrdStatus = reader["PrdStatus"].ToString(),
                ReorderPoint = reader.GetInt32(reader.GetOrdinal("ReorderPoint")),
                Price = reader.GetDecimal(reader.GetOrdinal("Price")),
            };
        };

        protected Func<IDataReader, ProductEntity> MakeOFF = reader =>
        {
            return new ProductEntity
            {
                PrdID = reader["PrdID"].ToString(),
                ClrID = reader["ClrID"].ToString(),
                ClrName = reader["ClrName"].ToString(),
                TypeProductID = reader["TypeProductID"].ToString(),
                TypeName = reader["TypeName"].ToString(),
                TrdID = reader["TrdID"].ToString(),
                TrdName = reader["TrdName"].ToString(),
                BrandID = reader["BrandID"].ToString(),
                BrandName = reader["BrandName"].ToString(),
                Filepath = reader["Photo"].ToString(),
                Description = reader["Description"].ToString(),
                PrdEnabled = reader["PrdEnabled"].ToString(),
                Waranty = reader.GetInt32(reader.GetOrdinal("Waranty")),
                PrdStatus = reader["PrdStatus"].ToString(),
                ReorderPoint = reader.GetInt32(reader.GetOrdinal("ReorderPoint")),
                Price = reader.GetDecimal(reader.GetOrdinal("Price")),
                amount = reader.GetInt32(reader.GetOrdinal("amount")),
            };
        };

        protected Func<IDataReader, ProductEntity> MakeProSup = reader =>
        {
            return new ProductEntity
            {
                PrdID = reader["PrdID"].ToString(),
                ClrID = reader["ClrID"].ToString(),
                ClrName = reader["ClrName"].ToString(),
                TypeProductID = reader["TypeProductID"].ToString(),
                TypeName = reader["TypeName"].ToString(),
                TrdID = reader["TrdID"].ToString(),
                TrdName = reader["TrdName"].ToString(),
                BrandID = reader["BrandID"].ToString(),
                BrandName = reader["BrandName"].ToString(),
                Filepath = reader["Photo"].ToString(),
                Description = reader["Description"].ToString(),
                PrdEnabled = reader["PrdEnabled"].ToString(),
                Waranty = reader.GetInt32(reader.GetOrdinal("Waranty")),
                PrdStatus = reader["PrdStatus"].ToString(),
                Price = reader.GetDecimal(reader.GetOrdinal("Price")),
                PsUpdate = reader.GetDateTime(reader.GetOrdinal("PsUpdate")).ToString("yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture),
                SellPrice = reader.GetDecimal(reader.GetOrdinal("SellPrice")),
            };
        };

        
        protected Func<IDataReader, ProductEntity> Make2 = reader =>
        {
            return new ProductEntity
            {
                PrdID = reader["PrdID"].ToString(),
                ClrID = reader["ClrID"].ToString(),
                ClrName = reader["ClrName"].ToString(),
                TypeProductID = reader["TypeProductID"].ToString(),
                TypeName = reader["TypeName"].ToString(),
                TrdID = reader["TrdID"].ToString(),
                TrdName = reader["TrdName"].ToString(),
                BrandID = reader["BrandID"].ToString(),
                BrandName = reader["BrandName"].ToString(),
                // Filepath = reader["Photo"].ToString(),
                Description = reader["Description"].ToString(),
                PrdEnabled = reader["PrdEnabled"].ToString(),
                Waranty = reader.GetInt32(reader.GetOrdinal("Waranty")),
              
            };
        };
        protected Func<IDataReader, ProductEntity> MakeSup = reader =>
        {
            return new ProductEntity
            {
                PrdID = reader["PrdID"].ToString(),
                ClrID = reader["ClrID"].ToString(),
                ClrName = reader["ClrName"].ToString(),
                TypeProductID = reader["TypeProductID"].ToString(),
                TypeName = reader["TypeName"].ToString(),
                TrdID = reader["TrdID"].ToString(),
                TrdName = reader["TrdName"].ToString(),
                BrandID = reader["BrandID"].ToString(),
                BrandName = reader["BrandName"].ToString(),
                Filepath = reader["Photo"].ToString(),
                Description = reader["Description"].ToString(),
                PrdEnabled = reader["PrdEnabled"].ToString(),
                Waranty = reader.GetInt32(reader.GetOrdinal("Waranty")),
                SupID = reader["SupID"].ToString(),
                SupName = reader["SupName"].ToString(),
                SubAddress = reader["SubAddress"].ToString(),
            };
        };
        protected Func<IDataReader, ProductEntity> MakePro = reader =>
        {
            return new ProductEntity
            {
                PrdID = reader["PrdID"].ToString(),
                ClrID = reader["ClrID"].ToString(),
                ClrName = reader["ClrName"].ToString(),
                TypeProductID = reader["TypeProductID"].ToString(),
                TypeName = reader["TypeName"].ToString(),
                TrdID = reader["TrdID"].ToString(),
                TrdName = reader["TrdName"].ToString(),
                BrandID = reader["BrandID"].ToString(),
                BrandName = reader["BrandName"].ToString(),
                Filepath = reader["Photo"].ToString(),
                Description = reader["Description"].ToString(),
                PrdEnabled = reader["PrdEnabled"].ToString(),
                Waranty = reader.GetInt32(reader.GetOrdinal("Waranty")),
                ReorderPoint = reader.GetInt32(reader.GetOrdinal("ReorderPoint")),
                Price = reader.GetDecimal(reader.GetOrdinal("Price")),
                SerialStatus = reader["SerialStatus"].ToString(),
                PrdStatus = reader["PrdStatus"].ToString(),
            };
        };
        protected Func<IDataReader, PhotoEntity> MakePhoto = reader =>
        {
            return new PhotoEntity
            {
                PrdID = reader["PrdID"].ToString(),
                //PhotoID = reader["PhotoID"].ToString(),
                PhotoID= reader.GetInt32(reader.GetOrdinal("PhotoID")),
                Photo = reader["Photo"].ToString(),
            };
        };

        protected Func<IDataReader, ProductEntity> MakeProList = reader =>
        {
            return new ProductEntity
            {
                PrdID = reader["PrdID"].ToString(),
                SupID = reader["SupID"].ToString(),
                SupName = reader["SupName"].ToString(),
                ClrID = reader["ClrID"].ToString(),
                ClrName = reader["ClrName"].ToString(),
                TypeProductID = reader["TypeProductID"].ToString(),
                TypeName = reader["TypeName"].ToString(),
                TrdID = reader["TrdID"].ToString(),
                TrdName = reader["TrdName"].ToString(),
                BrandID = reader["BrandID"].ToString(),
                BrandName = reader["BrandName"].ToString(),
                Description = reader["Description"].ToString(),
                PrdEnabled = reader["PrdEnabled"].ToString(),
                Waranty = reader.GetInt32(reader.GetOrdinal("Waranty")),
                ReorderPoint = reader.GetInt32(reader.GetOrdinal("ReorderPoint")),
                Price = reader.GetDecimal(reader.GetOrdinal("Price")),
                PrdStatus = reader["PrdStatus"].ToString(),
            };
        };


    }
}