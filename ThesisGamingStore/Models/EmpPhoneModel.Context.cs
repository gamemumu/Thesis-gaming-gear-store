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
    
    public partial class EmpPhoneEntities : DbContext
    {
        public EmpPhoneEntities()
            : base("name=EmpPhoneEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public DbSet<EMPLOYEE> EMPLOYEE { get; set; }
        public DbSet<EMPLOYEE_PHONE> EMPLOYEE_PHONE { get; set; }
        public DbSet<POSITION> POSITION { get; set; }
        public DbSet<C_Roles> C_Roles { get; set; }
        public DbSet<DEPARTMENT> DEPARTMENT { get; set; }
    }
}