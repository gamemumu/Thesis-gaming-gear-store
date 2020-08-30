using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ThesisGamingStore.Models
{
    public class SellReportModel
    {
        public string PrdID { get; set; } public string ProName { get; set; }
        public string type { get; set; } public decimal? Sum { get; set; }
        public decimal Sumxx { get; set; }
        public decimal? INCOME { get; set; } public decimal? EXPENSES { get; set; }
        public decimal? SumEXPENSES { get; set; }  public decimal? AmountRemainEXPENSES { get; set; }
        public int AmountOrder { get; set; } public int AmountLot { get; set; }
        public int AmountRemain { get; set; }  public decimal? ProfitLoss { get; set; }
        public int Amount { get; set; }
    
    }
    public class TempSellReportModel
    {
        public string PrdID { get; set; } public string ProName { get; set; }
        public decimal Sumxx { get; set; }  public int Amount { get; set; }
    }
}