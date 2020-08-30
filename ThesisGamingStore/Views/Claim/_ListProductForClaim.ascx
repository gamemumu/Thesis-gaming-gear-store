<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<%@ Import Namespace="ThesisGamingStore.Models" %>
<table id="example" class="table  table-striped table-condensed" cellspacing="0">
    <thead>
        <tr>
            <th>
                <%: Html.DisplayName("รหัสล๊อต") %>
            </th>
            <th>
                <%: Html.DisplayName("รหัสสินค้า") %>
            </th>
            <th>
                <%: Html.DisplayName("ประเภท") %>
            </th>
            <th>
                <%: Html.DisplayName("ชื่อสินค้า") %>
            </th>
            <th>
                <%: Html.DisplayName("สีสินค้า") %>
            </th>
            <th>
                <%: Html.DisplayName("บริษัทคู่ค้า") %>
            </th>
            <th>
                <%: Html.DisplayName("Serial") %>
            </th>
            <th>
                <%: Html.DisplayName("ACTION") %>
            </th>
        </tr>
    </thead>
    <tbody>

        <% if (ViewData["Serial"] != null)
           {%>
        <%foreach (var item in ViewData["Serial"] as List<ICollection<SERIAL>>)
          {%>
        <%for (int i = 0; i < item.Count; i++)
          { %>
        <%if (item.ToList()[i].SrlStatus == "0")
          { %>
        <tr>
            <td>
                <%: Html.DisplayFor(modelItem => item.ToList()[i].PRODUCTLOT.LotNo)%>
            </td>
            <td>
                <%: Html.DisplayFor(modelItem =>  item.ToList()[i].PrdID)%>
            </td>
            <td>
                <%: Html.DisplayFor(modelItem => item.ToList()[i].PRODUCTLOT.PRODUCT.TYPEPRODUCT.TypeName)%>
            </td>
            <td>
                <span><%: Html.DisplayFor(modelItem => item.ToList()[i].PRODUCTLOT.PRODUCT.BRAND.TRADEMARK.TrdName)%> &nbsp<%: Html.DisplayFor(modelItem => item.ToList()[i].PRODUCTLOT.PRODUCT.BRAND.BrandName)%> </span>
            </td>
            <td>
                <%: Html.DisplayFor(modelItem => item.ToList()[i].PRODUCTLOT.PRODUCT.COLOR.ClrName)%>
            </td>
            <td>
                <%: Html.DisplayFor(modelItem => item.ToList()[i].PRODUCTLOT.RECEIVEORDER_DTA.ORDER_PRODUCT_DTA.ORDER_PRODUCT.SUPPLIER.SupName)%>
            </td>
            <td>
                <%=item.ToList()[i].SrlID%>
            </td>
            <td>
               <button class="btn btn-outline btn-primary btn-xs clm"
                    onclick="btnSClaim('<%=item.ToList()[i].SrlID%>')">
                    CLAIM &nbsp
                    <i id="S<%= item.ToList()[i].SrlID%>" style="color: green; visibility: hidden;" class="fa fa-check-square-o fa-lg"></i>
                </button>
            </td>
        </tr>
        <%} %>
        <%} %>
        <%}%>
        <%}
           else
           { %>
        <% foreach (var item in ViewData["ListProductForClaim"] as List<ThesisGamingStore.Models.PRODUCTLOT>)
           { %>
        <tr>
            <td>
                <%: Html.DisplayFor(modelItem => item.LotNo)%>
            </td>
            <td>
                <%: Html.DisplayFor(modelItem => item.PrdID)%>
            </td>
            <td>
                <%: Html.DisplayFor(modelItem => item.PRODUCT.TYPEPRODUCT.TypeName)%>
            </td>
            <td>
                <span><%: Html.DisplayFor(modelItem => item.PRODUCT.BRAND.TRADEMARK.TrdName)%> &nbsp<%: Html.DisplayFor(modelItem => item.PRODUCT.BRAND.BrandName)%> </span>
            </td>
            <td>
                <%: Html.DisplayFor(modelItem => item.PRODUCT.COLOR.ClrName)%>
            </td>
            <td>
                <%: Html.DisplayFor(modelItem => item.RECEIVEORDER_DTA.ORDER_PRODUCT_DTA.ORDER_PRODUCT.SUPPLIER.SupName)%>
            </td>
            <td>
                <%if (item.PRODUCT.SerialStatus.Equals("0"))
                  {  %> None<%}%>
            </td>
            <td>
                <a href="#" data-toggle="modal" data-target="#delMOrderModal" onclick="btnClaim()">DELETE</a>
            </td>
        </tr>
        <%}%>
        <% } %>
    </tbody>
</table>

<script type="text/javascript">
    jQuery(function ($) {
        table = $("#example").DataTable({
            "bDestroy": true,
            "bScrollCollapse": true,
            "bJQueryUI": true,
            "bPaginate": true,
            "bInfo": true,
            "bFilter": true,
            "bSort": true,
            "aoColumnDefs": [{ "bSortable": false, "aTargets": [7] }],
            "order": [[0, 'asc']]
        });
      
    });
</script>
