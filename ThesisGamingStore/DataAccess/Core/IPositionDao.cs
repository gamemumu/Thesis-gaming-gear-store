using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ThesisGamingStore.Entity;
using ThesisGamingStore.Models;

namespace ThesisGamingStore.DataAccess.Core
{
    interface IPositionDao
    {
        bool InsertPosition(PositionsEntity position);
        bool InsertPosandRole(PositionsEntity position, PosInRoleDetailDto[] list,string UPDATEDATA);
        bool UpdatePosition(PositionsEntity position);
        bool DeletePosition(string posID);
        bool DeletePositionForEnabled(string posID);
        List<PositionsEntity> ListPosition();
        List<PositionsEntity> ListPosition(int pageSize, int pageNum);
        List<WeakPosDetailsEntity> GetListPosition(string PosID, string DepID);
        PositionsEntity GetPosition(string PosID);
        bool CheckUnique(string posName, string ID);
    }
}
