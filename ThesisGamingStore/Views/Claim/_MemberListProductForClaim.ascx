<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<%@ Import Namespace="ThesisGamingStore.Models" %>
<table id="example" class="table  table-striped table-condensed" cellspacing="0">
    <thead>
        <tr>
            <th>
                <%: Html.DisplayName("รหัสใบขาย") %>
            </th>
            <th>
                <%: Html.DisplayName("รหัสสินค้า") %>
            </th>
            <th>
                <%: Html.DisplayName("สินค้า") %>
            </th>
            <th style="text-align:center">
                <%: Html.DisplayName("วันหมดประกัน") %>
            </th>
            <th>
                <%: Html.DisplayName("Serial") %>
            </th>
            <th>
                <%: Html.DisplayName("ประกัน7วัน") %>
            </th>
             <th style="width:10%">
                <%: Html.DisplayName("สินค้าในสต๊อก") %>
            </th>
            <th>
                <%: Html.DisplayName("ACTION") %>
            </th>
        </tr>
    </thead>
    <tbody>
        <% foreach (var item in ViewData["ListMemberClaim"] as List<SELLPRODUCT_DTA_SERIA>)
           { %>
        <tr>
            <td>
                <%: Html.DisplayFor(modelItem => item.SlpID)%>
            </td>
            <td>
                <%: Html.DisplayFor(modelItem => item.PrdID)%>
            </td>
            <td>
               <%var name = item.SERIAL.PRODUCTLOT.PRODUCT.TYPEPRODUCT.TypeName + " " +
              item.SERIAL.PRODUCTLOT.PRODUCT.BRAND.TRADEMARK.TrdName + " " + item.SERIAL.PRODUCTLOT.PRODUCT.BRAND.BrandName + " " +
                item.SERIAL.PRODUCTLOT.PRODUCT.COLOR.ClrName;%>
              <span><%: Html.DisplayFor(modelItem => item.SERIAL.PRODUCTLOT.PRODUCT.TYPEPRODUCT.TypeName)%>&nbsp
               <%: Html.DisplayFor(modelItem => item.SERIAL.PRODUCTLOT.PRODUCT.BRAND.TRADEMARK.TrdName)%> &nbsp<%: Html.DisplayFor(modelItem => item.SERIAL.PRODUCTLOT.PRODUCT.BRAND.BrandName)%>
               &nbsp <%: Html.DisplayFor(modelItem => item.SERIAL.PRODUCTLOT.PRODUCT.COLOR.ClrName)%>
              </span>
            </td>
             <td style="text-align:center">
                <%var flagex = 0; %>
                <%var waranty = item.SERIAL.PRODUCTLOT.PRODUCT.Waranty; %>
                 <%var expire = item.SELLPRODUCT_DTA.SELLPRODUCT.SlpDate.AddYears(waranty); %>
                  <%if(expire >= DateTime.Now){%>
                   <%= expire.ToString("dd/MM/yyy") %><i class="fa fa-check pull-right" style="color:#1d9d74"></i>
                 <%}else{ %>
                   <%= expire.ToString("dd/MM/yyy") %> <i class="fa fa-times pull-right"  style="color:#ff0000"></i> 
                     <%flagex = 1; %>
                 <%} %>
            </td>
            <td>
                <%: Html.DisplayFor(modelItem => item.SERIAL.SrlID)%>
            </td>
             <td style="text-align:center">
                 <%var flag = 0; %>
                 <%if(item.SELLPRODUCT_DTA.SELLPRODUCT.SlpDate.AddDays(7) >= DateTime.Now){%>
                   <i class="fa fa-check" style="color:#1d9d74"></i>
                 <%}else{ %>
                    <i class="fa fa-times"  style="color:#ff0000"></i>
                 <%flag = 1; %>
                 <%} %>
            </td>
             <td style="text-align:right">
                <%: Html.DisplayFor(modelItem => item.SERIAL.PRODUCTLOT.PRODUCT.StockQuantity)%>
            </td>
             <td style="text-align:center">
                 <!--flagex:0 อยู่ในช่วงประกัน--> <!--flagex:1 ไม่อยู่ในช่วงประกัน-->
                 <!--flag:0 อยู่ในระยะเวลา 7 วัน--> <!--flag:1 ไม่อยู่ในระยะเวลา 7 วัน-->
                   <%if(flagex == 1){ %>
                  <button class="btn btn-info btn-sm" disabled="disabled">CLAIM</button>
                 <%}else{ %>
                  <button class="btn btn-outline btn-primary btn-xs" 
                      onclick="btnClaim('<%=flag%>','<%=item.SERIAL.PRODUCTLOT.PRODUCT.StockQuantity%>','<%=item.PrdID %>','<%=item.SERIAL.SrlID %>','<%=item.SlpID %>','<%=item.SlpNo%>','<%=name %>')"
                      >CLAIM &nbsp<i id="S<%= item.SERIAL.SrlID%>" style="color:green; visibility:hidden;" class="fa fa-check-square-o fa-lg"></i></button>
                 <%} %>
            </td>
        </tr>
        <%}%>
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
