using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ThesisGamingStore.Entity
{
    public class PositionsEntity
    {
        public string PosID { get; set; }
        public string DepID { get; set; }
        public string PosName { get; set; }
        public string DepName { get; set; }
       // public List<PosInRoleEntity> PosInRoleDetails { get; set; }
    }
}