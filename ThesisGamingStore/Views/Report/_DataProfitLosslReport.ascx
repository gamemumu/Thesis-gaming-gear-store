<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<%@ Import Namespace="ThesisGamingStore.Models" %>
<div class="table-responsive">
    <table class="table table-bordered table-striped">
        <thead>
            <tr>
                <th style="text-align: center">รหัสสินค้า</th>
                <th style="text-align: center">ชื่อสินค้า</th>
                <th style="text-align: right">จำนวนทั้งหมด</th>
                <th style="text-align: right">ราคาต้นทุน</th>
                 <th style="text-align: right">จำนวนที่ขาย</th>
                 <%--<th style="text-align: right">คงเหลือ</th>--%>
                 <th style="text-align: right">ยอดขาย</th>
                <th style="text-align: center">กำไรขาดทุน</th>
            </tr>
        </thead>
        <tbody>
            <% foreach (var item in ViewData["DataProfitAndLossReport"] as IEnumerable<ProfitLossReportModels>)
               { %>
                <tr style="text-align: right">
                <td style="text-align: center !important"><%=item.PrdID %></td>
                <td style="text-align: left !important"><%=item.ProName %> </td>
                <td><%= item.AmoutAll%></td>
                <td><%:Html.Raw(string.Format("{0:#,#}",item.rSumEXPENSES))%></td>
                <td><%:Html.Raw(string.Format("{0:#,#}",item.AmoutSell))%></td>
                <%--<td><%if(item.AmountRemain == 0){%>0<%}else{ %><%:Html.Raw(string.Format("{0:#,#}",item.AmountRemain))%><%} %></td>--%>
                <td><%:Html.Raw(string.Format("{0:#,#}",item.rINCOME))%></td>
                <td><%if (item.rProfitLoss == 0){%>0<%}else{ %><%:Html.Raw(string.Format("{0:#,#}",item.rProfitLoss))%><%} %></td>
            </tr>
        <%}%>
        </tbody>
    </table>
    <div class="pull-right" >
        <button class="btn btn-danger" onclick="GetReport()">ออกรายงาน &nbsp <i class="fa fa-file-pdf-o"></i></button>
    </div><br /><hr />
</div>
<script type="text/javascript">
    function GetReport() {
        var win = window.open("<%= Url.Action("ProfitAndLossReport", "Report")%>");
        win.focus();
    //    location.reload();
    }
</script>
<%--<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<%@ Import Namespace="ThesisGamingStore.Models" %>
<div class="table-responsive">
    <table class="table table-bordered table-striped">
        <thead>
            <tr>
                <th style="text-align: center">รหัสสินค้า</th>
                <th style="text-align: center">ชื่อสินค้า</th>
                <th style="text-align: right">คงเหลือ</th>
                <th style="text-align: right">รายจ่าย</th>
                 <th style="text-align: right">รายรับ</th>
                 <th style="text-align: right">กำไรขาดทุน</th>
            </tr>
        </thead>
        <tbody>
            <% foreach (var item in ViewData["DataExpenses"] as IEnumerable<ProfitLossModels>)
               { %>
            <% foreach (var item2 in ViewData["DataIncome"] as IEnumerable<ProfitLossModels>)
               { %>
              <%if(item2.PrdID == item.PrdID){ %>
            <tr style="text-align: right">
                <td style="text-align: center !important"><%=item.PrdID %></td>
                <td style="text-align: left !important"><%=item.ProName %> </td>
                <td><%= item.AmountOrder-item.AmountLot == 0 ? item.AmountRemain : item.AmountRemain + (item.AmountOrder-item.AmountLot)%></td>
                <td><%:Html.Raw(string.Format("{0:#,#}",item.Sum==null ? 0 : item.Sum))%></td>
                <td><%:Html.Raw(string.Format("{0:#,#}",item2.INCOME==null ? 0 : item2.INCOME))%></td>
                <td><%:Html.Raw(string.Format("{0:#,#}",item2.INCOME-item.Sum))%></td>
            </tr>
            <%}else{
                    continue;
               }%>
            <%}%>
        <%}%>
        </tbody>
    </table>
    <div class="row pull-right">
        <button class="btn btn-success" onclick="GetReport()">ออกรายงาน</button>
    </div><br /><hr />
</div>--%>

