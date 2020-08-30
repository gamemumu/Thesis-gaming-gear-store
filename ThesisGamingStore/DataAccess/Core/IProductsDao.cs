using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using ThesisGamingStore.Entity;
using ThesisGamingStore.Models;

namespace ThesisGamingStore.DataAccess.Core
{

    interface IProductDao
    {
        bool InsertProduct(ProductEntity product,List<string> dataPhoto);
        bool InsertProductForSup(List<ProductSup> list);
        bool UpdateProductForSup(List<ProductSup> list);
        bool UpdateProduct(ProductEntity product, List<string> dataPhoto);
        bool DeleteProduct(string productID);
        List<ProductEntity> ListProduct();
        List<ProductEntity> ListProductPic1();
        List<ProductEntity> ListProductForOffer();
        List<ProductEntity> ListProduct(string SupID);
        List<ProductEntity> ListProductAddSup(string SupID);
        List<ProductEntity> ListProductEditSup(string SupID);
        List<ProductEntity> ListProductNoPic(string SupID);
        List<ProductEntity> GetProductList(string productID);
        ProductEntity GetProduct(string productID);
        Tuple<ProductEntity, List<PhotoEntity>> GetProductTuple(string productID);
        bool CheckNameUnique(string roleName);
    }
    interface IProductLotDao
    {
        bool InsertProductLot(ProductLotEntity productLot);
        bool UpdateProductLot(ProductLotEntity productLot);
        bool DeleteProductLot(string productLotID);
        List<ProductLotEntity> ListProductLot();
        List<ProductLotEntity> ListProductLot(int pageSize, int pageNum);
        ProductLotEntity GetProductLot(string productLotID);
        bool CheckNameUnique(string producName);
    }
    interface IColorDao
    {
        bool InsertColor(ColorEntity color);
        bool UpdateColor(ColorEntity color);
        bool DeleteColor(string colorID);
        List<ColorEntity> ListColor();
        List<ColorEntity> ListColor(int pageSize, int pageNum);
        ColorEntity GetColor(string colorID);
        bool CheckNameUnique(string colorName, string colorID);
    }
    interface IBrandDao
    {
        bool InsertBrand(BrandEntity brand);
        bool UpdateBrand(BrandEntity brand);
        bool DeleteBrand(string brandID);
        List<BrandEntity> ListBrand();
        List<BrandEntity> ListBrandEdit(string id);
        List<BrandEntity> ListBrandCheckProduct();
        List<BrandEntity> ListBrand(string id);
        List<BrandEntity> ListBrandAll();
        List<BrandEntity> ListBrand(int pageSize, int pageNum);
        BrandEntity GetBrand(string brandID);
        bool CheckNameUnique(string brandName, string BrandID);
    }
    interface ITypeproductDao
    {
        bool InsertTypeproduct(TypeproductEntity typeproduct);
        bool UpdateTypeproduct(TypeproductEntity typeproduct);
        bool DeleteTypeproduct(string typeproductID);
        List<TypeproductEntity> ListTypeproduct();
        List<TypeproductEntity> ListTypeproduct(int pageSize, int pageNum);
        TypeproductEntity GetTypeproduct(string typeproductID);
        bool CheckNameUnique(string typeproductName,string ID);
    }
    interface ITradmarkDao
    {
        bool InsertTradmark(TradmarkEntity tradmark);
        bool UpdateTradmark(TradmarkEntity tradmark);
        bool DeleteTradmark(string tradmarkID);
        List<TradmarkEntity> ListTradmark();
        List<TradmarkEntity> ListTradmark(int pageSize, int pageNum);
        TradmarkEntity GetTradmark(string tradmarkID);
        bool CheckNameUnique(string tradmarkName, string ID);
    }
}
