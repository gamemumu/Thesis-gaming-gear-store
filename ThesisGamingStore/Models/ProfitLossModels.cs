using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ThesisGamingStore.Models
{
    public class ProfitLossModels
    {
        public string PrdID { get; set; } public string ProName { get; set; }
        public string type { get; set; } public decimal? Sum { get; set; }
        public decimal? INCOME { get; set; } public decimal? EXPENSES { get; set; }
        public decimal? SumEXPENSES { get; set; }  public decimal? AmountRemainEXPENSES { get; set; }
        public int AmountOrder { get; set; } public int AmountLot { get; set; }
        public int? AmountLotxx { get; set; } public int amountSell { get; set; }
        public Int32 AmountRemain { get; set; }  public decimal? ProfitLoss { get; set; }
        decimal rSum { get; set; } public decimal rProfitLoss { get; set; }
        public decimal rINCOME { get; set; } public decimal rEXPENSES { get; set; }
        public decimal rSumEXPENSES { get; set; }  public decimal rAmountRemainEXPENSES { get; set; }

    }

    public class ProfitLossReportModels
    {
        public string PrdID { get; set; } public string ProName { get; set; }
        public int AmoutAll { get; set; } public int AmoutSell { get; set; }
        public int AmountRemain { get; set; }  public decimal rSumEXPENSES { get; set; }
        public decimal rINCOME { get; set; }  public decimal rProfitLoss { get; set; }

    }
}