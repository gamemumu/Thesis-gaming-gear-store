﻿//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ThesisGamingStore.Models
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class gamingstoreEntities : DbContext
    {
        public gamingstoreEntities()
            : base("name=gamingstoreEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public DbSet<C_Roles> C_Roles { get; set; }
        public DbSet<BANK> BANK { get; set; }
        public DbSet<BRAND> BRAND { get; set; }
        public DbSet<CLAIM_MEMBER> CLAIM_MEMBER { get; set; }
        public DbSet<CLAIM_MEMBER_CHANG7DAY> CLAIM_MEMBER_CHANG7DAY { get; set; }
        public DbSet<CLAIM_MEMBER_DTA> CLAIM_MEMBER_DTA { get; set; }
        public DbSet<CLAIMORDER> CLAIMORDER { get; set; }
        public DbSet<CLAIMORDER_DTA> CLAIMORDER_DTA { get; set; }
        public DbSet<CLAIMORDER_SHOP> CLAIMORDER_SHOP { get; set; }
        public DbSet<COLOR> COLOR { get; set; }
        public DbSet<DELIVER> DELIVER { get; set; }
        public DbSet<DEPARTMENT> DEPARTMENT { get; set; }
        public DbSet<EMPLOYEE> EMPLOYEE { get; set; }
        public DbSet<EMPLOYEE_PHONE> EMPLOYEE_PHONE { get; set; }
        public DbSet<MEMBER> MEMBER { get; set; }
        public DbSet<MEMBER_PHONE> MEMBER_PHONE { get; set; }
        public DbSet<OFFER> OFFER { get; set; }
        public DbSet<OFFERDETAIL> OFFERDETAIL { get; set; }
        public DbSet<ORDER_PRODUCT> ORDER_PRODUCT { get; set; }
        public DbSet<ORDER_PRODUCT_DTA> ORDER_PRODUCT_DTA { get; set; }
        public DbSet<PAYMENT> PAYMENT { get; set; }
        public DbSet<PHOTO> PHOTO { get; set; }
        public DbSet<POSITION> POSITION { get; set; }
        public DbSet<PRODUCT> PRODUCT { get; set; }
        public DbSet<PRODUCTLOT> PRODUCTLOT { get; set; }
        public DbSet<PRODUCTSUPPLIER> PRODUCTSUPPLIER { get; set; }
        public DbSet<PROMOTION> PROMOTION { get; set; }
        public DbSet<RECEIVECLAIM> RECEIVECLAIM { get; set; }
        public DbSet<RECEIVECLAIM_DTA> RECEIVECLAIM_DTA { get; set; }
        public DbSet<RECEIVEORDER> RECEIVEORDER { get; set; }
        public DbSet<RECEIVEORDER_DTA> RECEIVEORDER_DTA { get; set; }
        public DbSet<SELLPRODUCT> SELLPRODUCT { get; set; }
        public DbSet<SELLPRODUCT_DTA> SELLPRODUCT_DTA { get; set; }
        public DbSet<SELLPRODUCT_DTA_NO_SERIA> SELLPRODUCT_DTA_NO_SERIA { get; set; }
        public DbSet<SELLPRODUCT_DTA_SERIA> SELLPRODUCT_DTA_SERIA { get; set; }
        public DbSet<SERIAL> SERIAL { get; set; }
        public DbSet<SUPPLIER> SUPPLIER { get; set; }
        public DbSet<SUPPLIER_PHONE> SUPPLIER_PHONE { get; set; }
        public DbSet<TRADEMARK> TRADEMARK { get; set; }
        public DbSet<TYPEPRODUCT> TYPEPRODUCT { get; set; }
    }
}
