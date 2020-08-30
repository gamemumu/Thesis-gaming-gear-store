<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<%@ Import Namespace="ThesisGamingStore.Models" %>
<div class="table-responsive">
    <table class="table table-bordered table-striped">
        <thead>
            <tr>
                <th style="text-align: center">ประเภทสินค้า</th>
                <th style="text-align: center">รหัสสินค้า</th>
                <th style="text-align: center">ชื่อสินค้า</th>
                <th style="text-align: right">จำนวนชิ้นที่เคลม</th>
            </tr>
        </thead>
        <tbody>
            <% foreach (var item in ViewData["DataClaimReport"] as IEnumerable<RClaimReportModel>)
               { %>
            <tr style="text-align: right">
                <td style="text-align: left !important"><%=item.typeName %></td>
                <td style="text-align: center !important"><%=item.PrdID %></td>
                <td style="text-align: left !important"><%=item.ProName %> </td>
                <td><%:Html.Raw(string.Format("{0:#,#}",item.AmountClaim))%></td>
            </tr>
            <%}%>
        </tbody>
    </table>
    <div class="pull-right">
        <button class="btn btn-danger" onclick="GetReport()">ออกรายงาน &nbsp <i class="fa fa-file-pdf-o"></i></button>
    </div>
    <br />
    <hr />
</div>
<script type="text/javascript">
    function GetReport() {
        var win = window.open("<%= Url.Action("ClaimReport", "Report")%>");
        win.focus();
      //  location.reload();
    }
</script>
