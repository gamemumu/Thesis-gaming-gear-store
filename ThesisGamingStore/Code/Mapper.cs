using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ThesisGamingStore.Entity;
using ThesisGamingStore.Models;

namespace ThesisGamingStore.Code
{
    public class Mapper
    {
        #region Department
        public static DepartmentEntity ToDto(DepartmentModel model)
        {
            return new DepartmentEntity
            {
                DepID = model.DepID,
                DepName = model.DepName
            };
        }

        public static DepartmentModel ToDto(DepartmentEntity entity)
        {
            return new DepartmentModel
            {
                DepID = entity.DepID,
                DepName = entity.DepName
            };
        }

        public static List<DepartmentModel> ToDto(List<DepartmentEntity> departments)
        {
            return departments.Select(o => ToDto(o)).ToList();
        }
        #endregion Department
        #region Position
        public static PositionsEntity ToDto(PositionModel model)
        {
            return new PositionsEntity
            {
                PosID = model.PosID,
                DepID = model.DepID,
                PosName = model.PosName,
               // Temp = model.Temp
            };
        }

        public static PositionModel ToDto(PositionsEntity entity)
        {
            return new PositionModel
            {
                PosID = entity.PosID,
                DepID = entity.DepID,
                PosName = entity.PosName,
                DepName = entity.DepName,
              //  Temp = entity.Temp
            };
        }

        public static List<PositionModel> ToDto(List<PositionsEntity> positions)
        {
            return positions.Select(o => ToDto(o)).ToList();
        }

        #endregion Position
        #region PosInRole
        public static PosInRoleEntity ToDto(PosInRoleModel model)
        {
            return new PosInRoleEntity
            {
                //PosID = model.PosID,
                PosID = model.PosID,
                RoleID = model.RoleID,
                // Temp = model.Temp
            };
        }

        public static PosInRoleModel ToDto(PosInRoleEntity entity)
        {
            return new PosInRoleModel
            {
                //PosID = model.PosID,
                PosID = entity.PosID,
                RoleID = entity.RoleID,
                // Temp = model.Temp
            };
        }

        public static List<PosInRoleModel> ToDto(List<PosInRoleEntity> posInrole)
        {
            return posInrole.Select(o => ToDto(o)).ToList();
        }
        public static PosInRoleDetailDto[] _ToDto(List<PosInRole> posInrole)
        {
            if (posInrole == null) return null;
            return posInrole.Select(o => _ToDto(o)).ToArray();
        }

        public static PosInRoleDetailDto _ToDto(PosInRole entity)
        {
            if (entity == null) return null;
            return new PosInRoleDetailDto
            {
                PosID = entity.PosID,
                PosName = entity.PosName,
                RoleID = entity.RoleID,
                RoleName = entity.RoleName,
            };
        }

       

        /// <summary>
        /// Transforms list of Order BOs to list of Order DTOs.
        /// </summary>
        /// <param name="orders">List of Order BOs.</param>
        /// <returns>List of Order DTOs.</returns>
       
        #endregion PosInRole
        #region Role
        public static RoleEntity ToDto(RolesModel model)
        {
            return new RoleEntity
            {
                RoleID = model.RoleID,
                RoleName = model.RoleName,
            };
        }

        public static RolesModel ToDto(RoleEntity entity)
        {
            return new RolesModel
            {
                RoleID = entity.RoleID,
                RoleName = entity.RoleName,
            };
        }

        public static List<RolesModel> ToDto(List<RoleEntity> roles)
        {
            return roles.Select(o => ToDto(o)).ToList();
        }
        #endregion Role
        #region Employee
        public static EmployeeEntity ToDto(Employee model)
        {
            return new EmployeeEntity
            {
                    EmpID = model.EmpID,
                    PosID = model.PosID,
                    Idcard = model.Idcard,
                    Email = model.Email,
                    Fname = model.Fname,
                    Lname = model.Lname,
                    Address = model.Address,
                    Sex = model.Sex,
                    Salary = model.Salary,
                    UserName = model.UserName,
                    Password = model.Password,
            };
        }

        public static Employee ToDto(EmployeeEntity entity)
        {
            return new Employee
            {
                EmpID = entity.EmpID,
                PosID = entity.PosID,
                Idcard = entity.Idcard,
                Email = entity.Email,
                Fname = entity.Fname,
                Lname = entity.Lname,
                Address = entity.Address,
                Sex = entity.Sex,
                Salary = entity.Salary,
                UserName = entity.UserName,
                Password = entity.Password,
            };
        }

        public static List<Employee> ToDto(List<EmployeeEntity> employees)
        {
            return employees.Select(o => ToDto(o)).ToList();
        }

        public static EmployeeEntity ToDto(ThesisGamingStore.Models.EMPLOYEE entity)
        {
            return new EmployeeEntity
            {
                EmpID = entity.EmpID,
                PosID = entity.PosID,
                Idcard = entity.Idcard,
                Email = entity.Email,
                Fname = entity.Fname,
                Lname = entity.Lname,
                Address = entity.Address,
                Sex = entity.Sex,
                Salary = entity.Salary,
                UserName = entity.Username,
                Password = entity.Password,
                
            };
        }

        public static Employee ToDto2(ThesisGamingStore.Models.EMPLOYEE entity)
        {
            return new Employee
            {
                EmpID = entity.EmpID,
                PosID = entity.PosID,
                Idcard = entity.Idcard,
                Email = entity.Email,
                Fname = entity.Fname,
                Lname = entity.Lname,
                Address = entity.Address,
                Sex = entity.Sex,
                Salary = entity.Salary,
                UserName = entity.Username,
                Password = entity.Password,
                Phones = entity.EMPLOYEE_PHONE,
            };
        }

        #endregion Employee
        #region TradMark
        public static TradmarkEntity ToDto(TradmarkModel model)
        {
            return new TradmarkEntity
            {
                TrdID = model.TrdID,
                TrdName = model.TrdName
            };
        }

        public static TradmarkModel ToDto(TradmarkEntity entity)
        {
            return new TradmarkModel
            {
                TrdID = entity.TrdID,
                TrdName = entity.TrdName,
                TrdEnabled = entity.TrdEnabled
            };
        }

        public static List<TradmarkModel> ToDto(List<TradmarkEntity> tradmarks)
        {
            return tradmarks.Select(o => ToDto(o)).ToList();
        }
        #endregion TradMark
        #region Brand
        public static BrandEntity ToDto(BrandModel model)
        {
            return new BrandEntity
            {
                BrandID = model.BrandID,
                TrdID = model.TrdID,
                BrandName = model.BrandName
            };
        }

        public static BrandModel ToDto(BrandEntity entity)
        {
            return new BrandModel
            {
                TrdID = entity.TrdID,
                TrdName = entity.TrdName,
                BrandID = entity.BrandID,
                BrandName = entity.BrandName,
                BrandEnabled = entity.BrandEnabled
            };
        }

        public static List<BrandModel> ToDto(List<BrandEntity> tradmarks)
        {
            return tradmarks.Select(o => ToDto(o)).ToList();
        }
        #endregion Brand
        #region Color
        public static ColorEntity ToDto(ColorModel model)
        {
            return new ColorEntity
            {
                ClrID = model.ClrID,
                ClrName = model.ClrName,
                ClrEnabled = model.ClrEnabled,
            };
        }

        public static ColorModel ToDto(ColorEntity entity)
        {
            return new ColorModel
            {
                ClrID = entity.ClrID,
                ClrName = entity.ClrName,
                ClrEnabled = entity.ClrEnabled,
            };
        }

        public static List<ColorModel> ToDto(List<ColorEntity> colors)
        {
            return colors.Select(o => ToDto(o)).ToList();
        }
        #endregion Color
        #region Type of Product
        public static TypeproductEntity ToDto(TypeproductModel model)
        {
            return new TypeproductEntity
            {
                TypeProductID = model.TypeProductID,
                TypeName = model.TypeName,
            };
        }

        public static TypeproductModel ToDto(TypeproductEntity entity)
        {
            return new TypeproductModel
            {
                TypeProductID = entity.TypeProductID,
                TypeName = entity.TypeName,
                TypeEnabled = entity.TypeEnabled,
            };
        }

        public static List<TypeproductModel> ToDto(List<TypeproductEntity> types)
        {
            return types.Select(o => ToDto(o)).ToList();
        }
        #endregion Type of Product
        #region Product
        public static ProductEntity ToDto(ProductModel model)
        {
            return new ProductEntity
            {
                PrdID = model.PrdID,
                BrandID = model.BrandID,
                TypeProductID = model.TypeProductID,
                ClrID = model.ClrID,
                Description = model.Description,
                Waranty = model.Waranty,
              //  Filepath = model.Filepath,
               SupID= model.SupID,
               SupName= model.SupName,
               SubAddress= model.SubAddress,
               Price = model.Price,
               ReorderPoint = model.ReorderPoint,
               PrdStatus = model.PrdStatus,
               amount = model.amount,
               SerialStatus = model.SerialStatus
            };
        }

        public static ProductModel ToDto(ProductEntity entity)
        {
            return new ProductModel
            {
                
                PrdID = entity.PrdID,
                ClrID = entity.ClrID,
                ClrName = entity.ClrName,
                TypeProductID = entity.TypeProductID,
                TypeName = entity.TypeName,
                TrdID = entity.TrdID,
                TrdName = entity.TrdName,
                BrandID = entity.BrandID,
                BrandName = entity.BrandName,
                Filepath = entity.Filepath,
                Description = entity.Description,
                Waranty = entity.Waranty,
                PrdEnabled = entity.PrdEnabled,
                check = entity.PrdID,
                SupID = entity.SupID,
                SupName = entity.SupName,
                SubAddress = entity.SubAddress,
                Price = entity.Price,
                ReorderPoint = entity.ReorderPoint,
                PrdStatus = entity.PrdStatus,
                PsUpdate = entity.PsUpdate,
                amount = entity.amount,
                SerialStatus = entity.SerialStatus,
                SellPrice = entity.SellPrice,
            };
        }

        public static List<ProductModel> ToDto(List<ProductEntity> products)
        {
            return products.Select(o => ToDto(o)).ToList();
        }
        #endregion Product
        #region Supplier
        public static SupplierEntity ToDto(SupplierModel model)
        {
            return new SupplierEntity
            {
                SupID = model.SupID,
                SupName = model.SupName,
                SubAddress = model.SubAddress,
            };
        }

        public static SupplierModel ToDto(SupplierEntity entity)
        {
            return new SupplierModel
            {
                SupID = entity.SupID,
                SupName = entity.SupName,
                SubAddress = entity.SubAddress,
                SubEnabled = entity.SubEnabled
            };
        }

        public static List<SupplierModel> ToDto(List<SupplierEntity> sups)
        {
            return sups.Select(o => ToDto(o)).ToList();
        }

        public static SupplierEntity ToDto(ThesisGamingStore.Models.SUPPLIER entity)
        {
            return new SupplierEntity
            {
                SupID = entity.SupID,
                SupName = entity.SupName,
                SubAddress = entity.SubAddress,
                SubEnabled = entity.SubEnabled,

            };
        }

        public static SupplierModel ToDto2(ThesisGamingStore.Models.SUPPLIER entity)
        {
            return new SupplierModel
            {
                SupID = entity.SupID,
                SupName = entity.SupName,
                SubAddress = entity.SubAddress,
                SubEnabled = entity.SubEnabled,
                Phones = entity.SUPPLIER_PHONE,
            };
        }

        #endregion Supplier
        #region Offer
        public static OfferEntity ToDto(OfferModel model)
        {
            return new OfferEntity
            {
               OffID  = model.OffID,
              EmpID = model.EmpID ,
              EmpName = model.EmpName ,
              SupID= model.SupID ,
              SupName = model.SupName ,
               OffDate = model.OffDate,
              OffStatus = model.OffStatus ,
              OffEnabled = model.OffEnabled ,
            };
        }

        public static OfferModel ToDto(OfferEntity entity)
        {
            return new OfferModel
            {
                OffID = entity.OffID,
                EmpID = entity.EmpID,
                EmpName = entity.EmpName,
                SupID = entity.SupID,
                SupName = entity.SupName,
                OffDate = entity.OffDate,
                OffStatus = entity.OffStatus,
                OffEnabled = entity.OffEnabled,
                EmpApprove = entity.EmpApprove
            };
        }

        public static List<OfferModel> ToDto(List<OfferEntity> offer)
        {
            return offer.Select(o => ToDto(o)).ToList();
        }

        public static OfferModel[] _ToDto(List<OfferModel> offer)
        {
            if (offer == null) return null;
            return offer.Select(o => _ToDto(o)).ToArray();
        }

        public static OfferModel _ToDto(OfferModel entity)
        {
            if (entity == null) return null;
            return new OfferModel
            {
                OffID = entity.OffID,
                EmpID = entity.EmpID,
                EmpName = entity.EmpName,
                SupID = entity.SupID,
                SupName = entity.SupName,
                OffDate = entity.OffDate,
                OffStatus = entity.OffStatus,
                OffEnabled = entity.OffEnabled,
                EmpApprove = entity.EmpApprove,
            };
        }
        public static OfferDetailModel[] _ToDto(List<OfferDetailModel> offerDetail)
        {
            if (offerDetail == null) return null;
            return offerDetail.Select(o => _ToDto(o)).ToArray();
        }

        public static OfferDetailModel _ToDto(OfferDetailModel entity)
        {
            if (entity == null) return null;
            return new OfferDetailModel
            {
                OfdNo = entity.OfdNo,
                OffID = entity.OffID,
                PrdID = entity.PrdID,
                AmountPost = entity.AmountPost,
                AmountApprove = entity.AmountApprove,
                Cost = entity.Cost,
                OfdEnabled = entity.OfdEnabled,
                TrdID = entity.TrdID,
                TrdName = entity.TrdName,
                BrandID = entity.BrandID,
                BrandName = entity.BrandName,
                ClrID = entity.ClrID,
                ClrName = entity.ClrName,
                TypeProductID = entity.TypeProductID,
                TypeName = entity.TypeName,
            };
        }
        #endregion offer
        #region OfferWeak
        public static WeakOfferDetailsEntity ToDto(OfferDetailModel model)
        {
            return new WeakOfferDetailsEntity
            {
                OffID =  model.OffID,
                OfdNo = model.OfdNo,
                SupID = model.SupID,
                SupName = model.SupName,
                SubAddress = model.SubAddress,
                PrdID = model.PrdID,
                ClrID = model.ClrID,
                ClrName = model.ClrName,
                TypeProductID = model.TypeProductID,
                TypeName = model.TypeName,
                TrdID = model.TrdID,
                TrdName = model.TrdName,
                BrandID = model.BrandID,
                BrandName = model.BrandName,
                Description = model.Description,
                Waranty = model.Waranty,
                PrdEnabled = model.PrdEnabled,
                AmountPost = model.AmountPost,
                AmountApprove = model.AmountApprove,
                Cost = model.Cost,
            };
        }

        public static OfferDetailModel ToDto(WeakOfferDetailsEntity entity)
        {
            return new OfferDetailModel
            {
                OffID = entity.OffID,
                OfdNo = entity.OfdNo,
                SupID = entity.SupID,
                SupName = entity.SupName,
                SubAddress = entity.SubAddress,
                PrdID = entity.PrdID,
                ClrID = entity.ClrID,
                ClrName = entity.ClrName,
                TypeProductID = entity.TypeProductID,
                TypeName = entity.TypeName,
                TrdID = entity.TrdID,
                TrdName = entity.TrdName,
                BrandID = entity.BrandID,
                BrandName = entity.BrandName,
                Description = entity.Description,
                Waranty = entity.Waranty,
                PrdEnabled = entity.PrdEnabled,
                AmountPost = entity.AmountPost,
                AmountApprove = entity.AmountApprove,
                Cost = entity.Cost,
            };
        }

        public static List<OfferDetailModel> ToDto(List<WeakOfferDetailsEntity> offdta)
        {
            return offdta.Select(o => ToDto(o)).ToList();
        }


        public static OfferDetailModel[] _ToDto2(List<OfferDetailModel> offerDetail)
        {
            if (offerDetail == null) return null;
            return offerDetail.Select(o => _ToDto2(o)).ToArray();
        }

        public static OfferDetailModel _ToDto2(OfferDetailModel entity)
        {
            if (entity == null) return null;
            return new OfferDetailModel
            {
                OffID = entity.OffID,
                OfdNo = entity.OfdNo,
                SupID = entity.SupID,
                SupName = entity.SupName,
                SubAddress = entity.SubAddress,
                PrdID = entity.PrdID,
                ClrID = entity.ClrID,
                ClrName = entity.ClrName,
                TypeProductID = entity.TypeProductID,
                TypeName = entity.TypeName,
                TrdID = entity.TrdID,
                TrdName = entity.TrdName,
                BrandID = entity.BrandID,
                BrandName = entity.BrandName,
                Description = entity.Description,
                Waranty = entity.Waranty,
                PrdEnabled = entity.PrdEnabled,
                AmountPost = entity.AmountPost,
                AmountApprove = entity.AmountApprove,
                Cost = entity.Cost,
            };
        }
        #endregion OfferWeak

        #region Order
        public static OrderEntity ToDto(OrderModel model)
        {
            return new OrderEntity
            {
                OrdID = model.OrdID,
                EmpID = model.EmpID,
                EmpName = model.EmpName,
                SupID = model.SupID,
                SupName = model.SupName,
                OrdDate = model.OrdDate,
                TotalCost = model.TotalCost,
                OrdStatus = model.OrdStatus,
                OrdEnabled = model.OrdEnabled
            };
        }

        public static OrderModel ToDto(OrderEntity entity)
        {
            return new OrderModel
            {
                OrdID = entity.OrdID,
                EmpID = entity.EmpID,
                EmpName = entity.EmpName,
                SupID = entity.SupID,
                SupName = entity.SupName,
                OrdDate = entity.OrdDate,
                TotalCost = entity.TotalCost,
                OrdStatus = entity.OrdStatus,
                OrdEnabled = entity.OrdEnabled
            };
        }

        public static List<OrderModel> ToDto(List<OrderEntity> offer)
        {
            return offer.Select(o => ToDto(o)).ToList();
        }
        public static OrderDetailModel[] _ToDto(List<OrderDetailModel> offerDetail)
        {
            if (offerDetail == null) return null;
            return offerDetail.Select(o => _ToDto(o)).ToArray();
        }

        public static OrderDetailModel _ToDto(OrderDetailModel entity)
        {
            if (entity == null) return null;
            return new OrderDetailModel
            {
                 OrdID  = entity.TypeName,
                 OrdNo  = entity.OrdNo,
                 OffID = entity.OffID,
                 OfdNo = entity.OfdNo,
                 PrdID = entity.PrdID,
                 //Amount = entity.Amount,
                 Cost = entity.Cost,
                 TotalCost = entity.TotalCost,
                 TrdID = entity.TrdID,
                 TrdName = entity.TrdName,
                 BrandID = entity.BrandID,
                 BrandName = entity.BrandName,
                 ClrID = entity.ClrID,
                 ClrName = entity.ClrName,
                 TypeProductID = entity.TypeProductID,
                 TypeName = entity.TypeName,
                 Description = entity.Description,
                 Waranty = entity.Waranty,
                 PrdEnabled = entity.PrdEnabled,
                 SupID = entity.SupID,
                 SupName = entity.SupName,
                 SubAddress = entity.SubAddress,
                 AmountApprove = entity.AmountApprove,
                 AmountRec = entity.AmountRec,
            };
        }
        #endregion offer
        #region OrderWeak
        public static WeakOrderDetailsEntity ToDto(OrderDetailModel model)
        {
            return new WeakOrderDetailsEntity
            {
                OrdID = model.OrdID,
                OrdNo = model.OrdNo,
                OrdDate = model.OrdDate,
                OffID = model.OffID,
                OfdNo = model.OfdNo,
                PrdID = model.PrdID,
                SupID = model.SupID,
                SupName = model.SupName,
                SubAddress = model.SubAddress,
                ClrID = model.ClrID,
                ClrName = model.ClrName,
                TypeProductID = model.TypeProductID,
                TypeName = model.TypeName,
                TrdID = model.TrdID,
                TrdName = model.TrdName,
                BrandID = model.BrandID,
                BrandName = model.BrandName,
                Description = model.Description,
                Waranty = model.Waranty,
                PrdEnabled = model.PrdEnabled,
                //Amount = model.Amount,
                TotalCost = model.TotalCost,
                Cost = model.Cost,
                AmountApprove = model.AmountApprove,
                AmountRec = model.AmountRec,
                SerialStatus = model.SerialStatus,
            };
        }

        public static OrderDetailModel ToDto(WeakOrderDetailsEntity entity)
        {
            return new OrderDetailModel
            {
                OrdID = entity.OrdID,
                OrdNo = entity.OrdNo,
                OrdDate = entity.OrdDate,
                OffID = entity.OffID,
                OfdNo = entity.OfdNo,
                PrdID = entity.PrdID,
                SupID = entity.SupID,
                SupName = entity.SupName,
                SubAddress = entity.SubAddress,
                ClrID = entity.ClrID,
                ClrName = entity.ClrName,
                TypeProductID = entity.TypeProductID,
                TypeName = entity.TypeName,
                TrdID = entity.TrdID,
                TrdName = entity.TrdName,
                BrandID = entity.BrandID,
                BrandName = entity.BrandName,
                Description = entity.Description,
                Waranty = entity.Waranty,
                PrdEnabled = entity.PrdEnabled,
                TotalCost = entity.TotalCost,
                Cost = entity.Cost,
                AmountApprove = entity.AmountApprove,
                AmountRec = entity.AmountRec,
                SerialStatus = entity.SerialStatus,
            };
        }

        public static List<OrderDetailModel> ToDto(List<WeakOrderDetailsEntity> order)
        {
            return order.Select(o => ToDto(o)).ToList();
        }


        public static OrderDetailModel[] _ToDto2(List<OrderDetailModel> orderDetail)
        {
            if (orderDetail == null) return null;
            return orderDetail.Select(o => _ToDto2(o)).ToArray();
        }

        public static OrderDetailModel _ToDto2(OrderDetailModel entity)
        {
            if (entity == null) return null;
            return new OrderDetailModel
            {
                OrdID = entity.OrdID,
                OrdNo = entity.OrdNo,
                OrdDate = entity.OrdDate,
                OffID = entity.OffID,
                OfdNo = entity.OfdNo,
                PrdID = entity.PrdID,
                SupID = entity.SupID,
                SupName = entity.SupName,
                SubAddress = entity.SubAddress,
                ClrID = entity.ClrID,
                ClrName = entity.ClrName,
                TypeProductID = entity.TypeProductID,
                TypeName = entity.TypeName,
                TrdID = entity.TrdID,
                TrdName = entity.TrdName,
                BrandID = entity.BrandID,
                BrandName = entity.BrandName,
                Description = entity.Description,
                Waranty = entity.Waranty,
                PrdEnabled = entity.PrdEnabled,
             //   Amount = entity.Amount,
                TotalCost = entity.TotalCost,
                Cost = entity.Cost,
                AmountApprove = entity.AmountApprove,
                AmountRec = entity.AmountRec,
                SerialStatus = entity.SerialStatus,
            };
        }
        #endregion OrderWeak

        #region Receive
        public static ReceiveEntity ToDto(ReceiveModel model)
        {
            return new ReceiveEntity
            {
                RecOID = model.RecOID,
                EmpID = model.EmpID,
                EmpName = model.EmpName,
                RecODate = model.RecODate,
                RecEnabled = model.RecEnabled,
            };
        }

        public static ReceiveModel ToDto(ReceiveEntity entity)
        {
            return new ReceiveModel
            {
                RecOID = entity.RecOID,
                EmpID = entity.EmpID,
                EmpName = entity.EmpName,
                RecODate = entity.RecODate,
                RecEnabled = entity.RecEnabled,
            };
        }

        public static List<ReceiveModel> ToDto(List<ReceiveEntity> rec)
        {
            return rec.Select(o => ToDto(o)).ToList();
        }
        public static ReceiveDetailModel[] _ToDto(List<ReceiveDetailModel> recDetail)
        {
            if (recDetail == null) return null;
            return recDetail.Select(o => _ToDto(o)).ToArray();
        }

        public static ReceiveDetailModel _ToDto(ReceiveDetailModel entity)
        {
            if (entity == null) return null;
            return new ReceiveDetailModel
            {
                RecOID = entity.RecOID,
                AmountRec = entity.AmountRec,
                OrdID = entity.TypeName,
                OrdNo = entity.OrdNo,
                OffID = entity.OffID,
                OfdNo = entity.OfdNo,
                PrdID = entity.PrdID,
                Cost = entity.Cost,
                TotalCost = entity.TotalCost,
                TrdID = entity.TrdID,
                TrdName = entity.TrdName,
                BrandID = entity.BrandID,
                BrandName = entity.BrandName,
                ClrID = entity.ClrID,
                ClrName = entity.ClrName,
                TypeProductID = entity.TypeProductID,
                TypeName = entity.TypeName,
                Description = entity.Description,
                Waranty = entity.Waranty,
                PrdEnabled = entity.PrdEnabled,
                SupID = entity.SupID,
                SupName = entity.SupName,
                SubAddress = entity.SubAddress,
            };
        }
        #endregion Receive
        #region ReceiveWeak
        public static WeakReceiveDetailsEntity ToDto(ReceiveDetailModel model)
        {
            return new WeakReceiveDetailsEntity
            {
                RecOID = model.RecOID,
                AmountRec = model.AmountRec,
                OrdID = model.OrdID,
                OrdNo = model.OrdNo,
                OrdDate = model.OrdDate,
                OffID = model.OffID,
                OfdNo = model.OfdNo,
                PrdID = model.PrdID,
                SupID = model.SupID,
                SupName = model.SupName,
                SubAddress = model.SubAddress,
                ClrID = model.ClrID,
                ClrName = model.ClrName,
                TypeProductID = model.TypeProductID,
                TypeName = model.TypeName,
                TrdID = model.TrdID,
                TrdName = model.TrdName,
                BrandID = model.BrandID,
                BrandName = model.BrandName,
                Description = model.Description,
                Waranty = model.Waranty,
                PrdEnabled = model.PrdEnabled,
                //Amount = model.Amount,
                TotalCost = model.TotalCost,
                Cost = model.Cost,
            };
        }

        public static ReceiveDetailModel ToDto(WeakReceiveDetailsEntity entity)
        {
            return new ReceiveDetailModel
            {
                RecOID = entity.RecOID,
                AmountRec = entity.AmountRec,
                OrdID = entity.OrdID,
                OrdNo = entity.OrdNo,
                OrdDate = entity.OrdDate,
                OffID = entity.OffID,
                OfdNo = entity.OfdNo,
                PrdID = entity.PrdID,
                SupID = entity.SupID,
                SupName = entity.SupName,
                SubAddress = entity.SubAddress,
                ClrID = entity.ClrID,
                ClrName = entity.ClrName,
                TypeProductID = entity.TypeProductID,
                TypeName = entity.TypeName,
                TrdID = entity.TrdID,
                TrdName = entity.TrdName,
                BrandID = entity.BrandID,
                BrandName = entity.BrandName,
                Description = entity.Description,
                Waranty = entity.Waranty,
                PrdEnabled = entity.PrdEnabled,
                TotalCost = entity.TotalCost,
                Cost = entity.Cost,
            };
        }

        public static List<ReceiveDetailModel> ToDto(List<WeakReceiveDetailsEntity> order)
        {
            return order.Select(o => ToDto(o)).ToList();
        }


        public static ReceiveDetailModel[] _ToDto2(List<ReceiveDetailModel> orderDetail)
        {
            if (orderDetail == null) return null;
            return orderDetail.Select(o => _ToDto2(o)).ToArray();
        }

        public static ReceiveDetailModel _ToDto2(ReceiveDetailModel entity)
        {
            if (entity == null) return null;
            return new ReceiveDetailModel
            {
                RecOID = entity.RecOID,
                AmountRec = entity.AmountRec,
                OrdID = entity.OrdID,
                OrdNo = entity.OrdNo,
                OrdDate = entity.OrdDate,
                OffID = entity.OffID,
                OfdNo = entity.OfdNo,
                PrdID = entity.PrdID,
                SupID = entity.SupID,
                SupName = entity.SupName,
                SubAddress = entity.SubAddress,
                ClrID = entity.ClrID,
                ClrName = entity.ClrName,
                TypeProductID = entity.TypeProductID,
                TypeName = entity.TypeName,
                TrdID = entity.TrdID,
                TrdName = entity.TrdName,
                BrandID = entity.BrandID,
                BrandName = entity.BrandName,
                Description = entity.Description,
                Waranty = entity.Waranty,
                PrdEnabled = entity.PrdEnabled,
                TotalCost = entity.TotalCost,
                Cost = entity.Cost,
            };
        }
        #endregion ReceiveWeak
    }
}