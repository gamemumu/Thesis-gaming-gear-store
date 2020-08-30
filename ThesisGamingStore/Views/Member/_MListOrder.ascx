<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<ThesisGamingStore.Models.SELLPRODUCT>>" %>
<table id="example" class="table  table-striped table-condensed" cellspacing="0">
    <thead>
        <tr>
            <th>
                <%: Html.DisplayName("รหัสสั่ง") %>
            </th>
            <th>
                <%: Html.DisplayName("ชื่อผู้สั่ง") %>
            </th>
            <th>
                <%: Html.DisplayName("วันที่สั่ง") %>
            </th>
            <th>
                <%: Html.DisplayName("ชื่อผู้รับ") %>
            </th>
            <th>
                <%: Html.DisplayName("สถานที่จัดส่ง") %>
            </th>
            <th style="text-align: right">
                <%: Html.DisplayName("รวม") %>
            </th>
            <th>
                <%: Html.DisplayName("สถานะ") %>
            </th>
            <th>
                <%: Html.DisplayName("PAYMENT") %>
            </th>
            <th>
                <%: Html.DisplayName("INFO") %>
            </th>
            <th>
                <%: Html.DisplayName("DELETE") %>
            </th>
        </tr>
    </thead>
    <tbody>
        <% foreach (var item in Model)
           { %>
        <tr>
            <td>
                <%: Html.DisplayFor(modelItem => item.SlpID) %>
            </td>
            <td>
                <span><%: Html.DisplayFor(modelItem => item.MEMBER.MFname) %> &nbsp<%: Html.DisplayFor(modelItem => item.MEMBER.MLname) %> </span>
            </td>
            <td>
                <%:item.SlpDate.ToString("dd/MM/yyyy") %>
            </td>
            <td>
                <span><%: Html.DisplayFor(modelItem => item.FnameRec ) %> &nbsp<%: Html.DisplayFor(modelItem => item.LnameRec) %> </span>
            </td>
            <td>
                <%: Html.DisplayFor(modelItem => item.AdressRec) %>
            </td>
            <td style="text-align: right">
                <%:Html.Raw(string.Format("{0:฿#,#}", item.SlpSum))%>
            </td>
            <%
               var Sum = (from sum in item.PAYMENT select sum.PayPrice).Sum();
               if (item.SlpStatus.Equals("ยืนยันการชำระเงิน") || item.SlpStatus.Equals("เตรียมจัดส่งสินค้า") || item.SlpStatus.Equals("ส่งของแล้ว"))
               { %>
            <%if (item.SlpStatus.Equals("ส่งของแล้ว"))
              { %>
            <td style="color: #F400DE">
                <%: Html.DisplayFor(modelItem => item.SlpStatus) %>
            </td>
            <td style="color: #F400DE">&nbsp
                <label>EMS >
                    <br />
                    <%: item.DELIVER.FirstOrDefault().DlvSerial%> </label>
            </td>
            <%}
              else
              { %>
            <td style="color: #81a32f">
                <%: Html.DisplayFor(modelItem => item.SlpStatus) %>
            </td>
            <td>&nbsp
                <label style="color: #808080">PAYMENT</label>
            </td>
            <%} %>

            <td>&nbsp 
                 <%: Html.ActionLink("INFO", "Info", "Payment", new {SlpID = item.SlpID }, new {  @class = "order-data"})%>
            </td>
            <td>&nbsp 
                <label style="color: #808080">DELETE</label>
            </td>
            <%}
               else if (item.SlpStatus.Equals("ยังไม่ได้ชำระเงิน") || item.SlpStatus.Equals("ชำระเงินไม่ครบ"))
               {%>
            <td style="color: #ff0000">
                <%if (item.SlpStatus.Equals("ชำระเงินไม่ครบ"))
                  {%><%: Html.Label("ชำระเงินไม่ครบจำนวน") %>
                <%}
                  else
                  {%><%: Html.DisplayFor(modelItem => item.SlpStatus) %><%} %>
            </td>
            <td>&nbsp <%: Html.ActionLink("PAYMENT","PayMent", "Payment", new { SlpID = item.SlpID },null) %> 
            </td>
            <td>&nbsp  
                <%: Html.ActionLink("INFO", "Info", "Payment", new {SlpID = item.SlpID }, new {  @class = "order-data"})%>
            </td>
            <td>&nbsp  
                <a href="#" data-toggle="modal" data-target="#delMOrderModal" onclick="btnDelete('<%:item.SlpID %>')">DELETE</a>
            </td>
            <%}
               else
               { %>
            <td style="color: #ff6a00">
                <%: Html.DisplayFor(modelItem => item.SlpStatus) %>
            </td>
            <td>&nbsp
                <label style="color: #808080">PAYMENT</label>
            </td>
            <td>&nbsp 
                 <%: Html.ActionLink("INFO", "Info", "Payment", new {SlpID = item.SlpID }, new {  @class = "order-data"})%>
            </td>
            <td>&nbsp 
                <label style="color: #808080">DELETE</label>
            </td>
            <%} %>
        </tr>
        <%} %>
    </tbody>
</table>

