<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<%@ Import Namespace="ThesisGamingStore.Models" %>
<div class="table-responsive">
    <table class="table table-bordered table-striped">
        <thead>
            <tr>
                 <th style="text-align: center;width:7%">ลำดับที่</th>
                <th style="text-align: center">รหัสสินค้า</th>
                <th style="text-align: center">ชื่อสินค้า</th>
               <th style="text-align: center">จำนวนที่ขาย</th>
                <th style="text-align: right">ราคารวม</th>
            </tr>
        </thead>
        <tbody>
            <%int i = 1; %>
            <%decimal sumGrand =0; %>
            <% foreach (var item in ViewData["DataSellReport"] as IEnumerable<TempSellReportModel>)
               { %>
                <tr style="text-align: right">
                     <td style="text-align: center !important"><%=i++ %></td>
                <td style="text-align: center !important"><%=item.PrdID %></td>
                <td style="text-align: left !important"><%=item.ProName %> </td>
                <td><%:Html.Raw(string.Format("{0:#,#}",item.Amount))%></td>
                <td><%:Html.Raw(string.Format("{0:#,#}",item.Sumxx))%></td>
                   <%sumGrand += item.Sumxx;%>
            </tr>
        <%}%>
             <tr style="text-align: right">
                 <td colspan="4">ราคารวมทั้งหมด</td>
                 <td><%:Html.Raw(string.Format("{0:#,#}",sumGrand))%></td>
             </tr>
        </tbody>
    </table>
    <div class="pull-right" >
        <button class="btn btn-danger" onclick="GetReport()">ออกรายงาน &nbsp <i class="fa fa-file-pdf-o"></i></button>
    </div><br /><hr />
</div>
<script type="text/javascript">
    function GetReport() {
        var win = window.open("<%= Url.Action("SellReport", "Report")%>");
        win.focus();
  //      location.reload();
    }
</script>
