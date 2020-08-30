<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<%@ Import Namespace="ThesisGamingStore.Models" %>
<table id="t7day" class="table  table-striped table-condensed" cellspacing="0">
    <thead>
        <tr>
            <th>
                <%: Html.DisplayName("วันที่") %>
            </th>
            <th>
                <%: Html.DisplayName("รหัส") %>
            </th>
            <th>
                <%: Html.DisplayName("ชื่อสินค้า") %>
            </th>
            <th>
                <%: Html.DisplayName("Serial") %>
            </th>
            <th>
                <%: Html.DisplayName("ปัญหา") %>
            </th>
        </tr>
    </thead>
    <tbody>
        <% foreach (var item in ViewData["List7Day"] as List<CLAIM_MEMBER_CHANG7DAY>)
           { %>
        <tr>
            <td>
               <%=item.CcmDate.ToString("dd/MM/yyyy")%>
            </td>
            <td>
                <%: Html.DisplayFor(modelItem => item.PrdID)%>
            </td>
            <td>
                <span>
                    <%: Html.DisplayFor(modelItem => item.SERIAL.PRODUCTLOT.PRODUCT.BRAND.TRADEMARK.TrdName)%> &nbsp<%: Html.DisplayFor(modelItem => item.SERIAL.PRODUCTLOT.PRODUCT.BRAND.BrandName)%>
                </span>
            </td>
            <td>
                <%: Html.DisplayFor(modelItem => item.SlpSrlID)%>
            </td>
            <td>
                <%: Html.DisplayFor(modelItem => item.CcmProp)%>
            </td>
        </tr>
        <%}%>
    </tbody>
</table>

<script type="text/javascript">
    jQuery(function ($) {
        table = $("#t7day").DataTable({
            "bDestroy": true,
            "bScrollCollapse": true,
            "bJQueryUI": true,
            "bPaginate": true,
            "bInfo": true,
            "bFilter": true,
            "bSort": true,
            //  "aoColumnDefs": [{ "bSortable": false, "aTargets": [7] }],
            "order": [[0, 'asc']]
        });
    });
</script>
