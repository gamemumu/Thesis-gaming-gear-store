<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<%@ Import Namespace="ThesisGamingStore.Models" %>
<div class="table-responsive">
    <table class="table table-bordered">
        <thead>
            <tr>
                <%--<th>รหัสสินค้า</th>--%>
                <th>ประเภทสินค้า</th>
                <th>มกราคม</th>
                <th>กุมภาพันธ์</th>
                <th>มีนาคม</th>
                <th>เมษายน</th>
                <th>พฤษภาคม</th>
                <th>มิถุนายน</th>
                <th>กรกฎาคม</th>
                <th>สิงหาคม</th>
                <th>กันยายน </th>
                <th>ตุลาคม</th>
                <th>พฤศจิกายน</th>
                <th>ธันวาคม</th>
            </tr>
        </thead>
        <tbody>
            <% foreach (var item in ViewData["DataYearReport"] as IEnumerable<YearModel>)
               { %>
            <tr style="text-align:right">
                <%--<td><%=item.PrdID %></td>--%>
                <%--<td style="text-align:left !important"><%=item.TypeId %><br /><small><%=item.TypeName %></small></td>--%>
                  <td><%=item.TypeName %></td>
                <td><%:Html.Raw(string.Format("{0:#,#}",item.Jan==null ? 0 : item.Jan))%></td>
                 <td><%:Html.Raw(string.Format("{0:#,#}",item.Feb==null ? 0 : item.Feb))%></td>
                 <td><%:Html.Raw(string.Format("{0:#,#}",item.Mar==null ? 0 : item.Mar))%></td>
                  <td><%:Html.Raw(string.Format("{0:#,#}",item.Apr==null ? 0 : item.Apr))%></td>
                 <td><%:Html.Raw(string.Format("{0:#,#}",item.May==null ? 0 : item.May))%></td>
                 <td><%:Html.Raw(string.Format("{0:#,#}",item.Jun==null ? 0 : item.Jun))%></td>
                 <td><%:Html.Raw(string.Format("{0:#,#}",item.Jul==null ? 0 : item.Jul))%></td>
                 <td><%:Html.Raw(string.Format("{0:#,#}",item.Aug==null ? 0 : item.Aug))%></td>
                 <td><%:Html.Raw(string.Format("{0:#,#}",item.Sep==null ? 0 : item.Sep))%></td>
                 <td><%:Html.Raw(string.Format("{0:#,#}",item.Oct==null ? 0 : item.Oct))%></td>
                 <td><%:Html.Raw(string.Format("{0:#,#}",item.Nov==null ? 0 : item.Nov))%></td>
                 <td><%:Html.Raw(string.Format("{0:#,#}",item.Dec==null ? 0 : item.Dec))%></td>
            </tr>
            <%}%>
        </tbody>
         <tfoot>
            <tr>
                <%--<th>รหัสสินค้า</th>--%>
                <th>ชื่อสินค้า</th>
                <th>มกราคม</th>
                <th>กุมภาพันธ์</th>
                <th>มีนาคม</th>
                <th>เมษายน</th>
                <th>พฤษภาคม</th>
                <th>มิถุนายน</th>
                <th>กรกฎาคม</th>
                <th>สิงหาคม</th>
                <th>กันยายน </th>
                <th>ตุลาคม</th>
                <th>พฤศจิกายน</th>
                <th>ธันวาคม</th>
            </tr>
        </tfoot>
    </table>
     <div class="pull-right" >
        <button class="btn btn-danger" onclick="GetReport()">ออกรายงาน &nbsp <i class="fa fa-file-pdf-o"></i></button>
    </div><br /><hr />
</div>
<script type="text/javascript">
    function GetReport() {
        var win = window.open("<%= Url.Action("YearReport", "Report")%>");
        win.focus();
   //     location.reload();
    }
</script>