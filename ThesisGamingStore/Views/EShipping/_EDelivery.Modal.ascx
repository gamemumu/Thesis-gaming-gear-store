<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<%@ Import Namespace="ThesisGamingStore.Models" %>
<div class="modal-content">
    <div class="modal-header">
        <!--head-->
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 id="myModalLabel">รายละเอียดสินค้า <small>รหัสการขาย : <%= ViewBag.SldID %> </small></h3>
    </div>
    <!--head-->
    <div style="padding: 15px">
        <!--body-->
        <%--<div class="table-responsive cart_info">--%>
        <table class="table table-striped table-condensed" style="width: 100%">
            <thead>
                <tr>
                    <th style="width: 10%">ITEM</th>
                    <th style="width: 60%"></th>
                    <th style="text-align: right">PRICE</th>
                    <th style="text-align: center">QUANTITY</th>
                    <th style="text-align: right">TOTAL</th>
                    <th style="text-align: right">SERIAL</th>
                </tr>
            </thead>
            <tbody>
                <% if (ViewData["EDelivery"] != null)
                   {%>
                <%foreach (var item in (List<SELLPRODUCT_DTA>)ViewData["EDelivery"])
                  {%>
                <tr>
                    <td>
                        <a href="<%=item.PRODUCT.PHOTO.FirstOrDefault().Photo1%>" data-toggle="lightbox" data-title="<%=item.PrdID %> &nbsp<%= item.PRODUCT.BRAND.TRADEMARK.TrdName %> &nbsp <%=item.PRODUCT.BRAND.BrandName %>">
                            <img src="<%=item.PRODUCT.PHOTO.FirstOrDefault().Photo1%>"  height="60" width="60">
                        </a>
                    </td>
                    <td>
                        <h4><a href="#"><%= item.PRODUCT.BRAND.BrandName %></a></h4>
                        <%if (item.Discount == 0)
                          {%>
                        <p><%=item.PrdID %> &nbsp<%= item.PRODUCT.BRAND.TRADEMARK.TrdName %></p>
                        <%}
                          else
                          {%>
                        <p><%=item.PrdID %> &nbsp<%= item.PRODUCT.BRAND.TRADEMARK.TrdName %> &nbsp Discount : <%=item.Discount%>%</p>
                        <%}%>
                    </td>
                    <td style="vertical-align: middle; text-align: right;">
                        <%if (item.Discount == 0)
                          { %>
                        <p><%: Html.Raw(string.Format("{0:฿#,#}", (item.PRODUCT.Price))) %></p>
                        <%}
                          else
                          { %>
                       <p>  <%: Html.Raw(string.Format("{0:฿#,#}", ((item.PRODUCT.Price - (item.PRODUCT.Price * (decimal.Parse(item.Discount.ToString())/100)))))) %></p>
                        <%} %>
                    </td>
                    <td style="vertical-align: middle; text-align: center;">
                        <%=item.SpdAmount%>
                    </td>
                    <td style="vertical-align: middle; text-align: right;">
                        <%if (item.Discount == 0)
                          { %>
                        <p><%: Html.Raw(string.Format("{0:฿#,#}", ((item.PRODUCT.Price * item.SpdAmount )))) %></p>
                        <%}
                          else
                          { %>
                     <p>   <%: Html.Raw(string.Format("{0:฿#,#}", ( (item.PRODUCT.Price - (item.PRODUCT.Price * (decimal.Parse(item.Discount.ToString())/100))) * item.SpdAmount ))) %></p>
                        <%} %>
                    </td>
                    <td style="vertical-align: middle; text-align: center;">
                        <%if (item.PRODUCT.SerialStatus.Equals("1"))
                          { %>
                        <p><a data-toggle="modal" href="#myModal2" onclick="GetSerial('<%=item.SlpID %>','<%=item.PrdID %>')"><span class="fa fa-wrench"></span></a></p>
                           <%--<p style="text-align: right"><%: Html.ActionLink("S", "GetSerial", "EShipping", new {SlpID = item.SlpID, PrdID = item.PrdID}, new {  @class = "serial-data"})%></p>--%>
                        <%}%>
                    </td>
                </tr>
                <%}%>
                <%} %>
            </tbody>
        </table>
        <!--body-->
        <div class="modal-footer ">
             <p><strong>เลขพัสดุ :</strong> <input id="EMS_serial" style="width:113px" placeholder="ใส่เลขพัสดุ"/></p>
            <!--footer-->
            <button class="btn btn-default" data-dismiss="modal" aria-hidden="true">ปิด</button>
            <button class="btn btn-inverse btn-primary" type="submit" onclick="sendDeliver('<%= ViewBag.SldID %>')">ยืนยันการจัดส่ง</button>
        </div>
        <!--footer-->
    </div>
</div>
