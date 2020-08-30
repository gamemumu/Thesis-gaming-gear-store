﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ThesisGamingStore.Models
{
    public class YearModel
    {
        public string PrdID { get; set; } public string ProName { get; set; }
        public string TypeId { get; set; } public string TypeName { get; set; }
        public decimal? Jan { get; set; } public decimal? Feb { get; set; }
        public decimal? Mar { get; set; } public decimal? Apr { get; set; }
        public decimal? May { get; set; } public decimal? Jun { get; set; }
        public decimal? Jul { get; set; } public decimal? Aug { get; set; }
        public decimal? Sep { get; set; } public decimal? Oct { get; set; }
        public decimal? Nov { get; set; } public decimal? Dec { get; set; }
    }
    public class YearModelReport
    {
        public string PrdID { get; set; } public string ProName { get; set; }
        public string TypeId { get; set; } public string TypeName { get; set; }
        public decimal Jan { get; set; } public decimal Feb { get; set; }
        public decimal Mar { get; set; } public decimal Apr { get; set; }
        public decimal May { get; set; } public decimal Jun { get; set; }
        public decimal Jul { get; set; } public decimal Aug { get; set; }
        public decimal Sep { get; set; } public decimal Oct { get; set; }
        public decimal Nov { get; set; } public decimal Dec { get; set; }
    }
}