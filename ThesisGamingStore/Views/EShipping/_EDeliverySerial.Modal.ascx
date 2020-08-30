<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<%@ Import Namespace="ThesisGamingStore.Models" %>
<table class="table table-striped table-condensed table-hover" style="width: 100%">
    <thead>
        <tr>
            <th style="width: 10%">#</th>
            <th style="width: 25%">หมายเลขล๊อต</th>
            <th style="width: 25%">หมายเลขซีเรียล</th>
            <th style="width: 40%">ชื่อสินค้า</th>
        </tr>
    </thead>
    <tbody>
        <% if (ViewData["EDeliverySerial"] != null)
           {
               int i = 1;%>
        <%foreach (var item in ViewData["EDeliverySerial"] as IEnumerable<SERIAL>)
          {%>
        <tr>
            <td><%= i++ %></td>
            <td><%=item.LotNo %></td>
            <td><%=item.SrlID %></td>
             <td><%=item.SELLPRODUCT_DTA_SERIA.FirstOrDefault().SELLPRODUCT_DTA.PRODUCT.BRAND.BrandName%>
        </tr>
        <%}%>
        <%} %>
    </tbody>
</table>
