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
        <%decimal subtotal = 0; %>
        <%--<div class="table-responsive cart_info">--%>
        <table class="table table-striped table-condensed" style="width: 100%">
            <thead>
                <tr>
                    <th style="width: 10%">ITEM</th>
                    <th style="width: 60%"></th>
                    <th style="text-align: right">PRICE</th>
                    <th style="text-align: center">QUANTITY</th>
                    <th style="text-align: right">TOTAL</th>
                </tr>
            </thead>
            <tbody>
                <% if (ViewData["MDetailOrder"] != null)
                   {%>
                <%foreach (var item in (List<SELLPRODUCT_DTA>)ViewData["MDetailOrder"])
                  {%>
                <tr>
                    <td>
                         <a href="<%=item.PRODUCT.PHOTO.FirstOrDefault().Photo1%>" data-toggle="lightbox" data-title="<%= item.PRODUCT.BRAND.TRADEMARK.TrdName %> &nbsp<%=item.PRODUCT.BRAND.BrandName %>">
                                <img src="<%=item.PRODUCT.PHOTO.FirstOrDefault().Photo1%>" height="50" width="50">
                            </a>
                    </td>
                    <td>
                        <h4><a href="#"><%= item.PRODUCT.BRAND.BrandName %></a></h4>
                        <%if (item.Discount == 0)
                          {%>
                        <p><%= item.PRODUCT.BRAND.TRADEMARK.TrdName %></p>
                        <%}
                          else
                          {%>
                        <p><%= item.PRODUCT.BRAND.TRADEMARK.TrdName %> &nbsp Discount : <%=item.Discount%>%</p>
                        <%}%>
                    </td>
                    <td style="vertical-align: middle; text-align: right;">
                        <%if (item.Discount == 0)
                          { %>
                        <p><%: Html.Raw(string.Format("{0:฿#,#}", (item.PRODUCT.Price))) %></p>
                        <%}
                          else
                          { %>
                        <%: Html.Raw(string.Format("{0:฿#,#}", ((item.PRODUCT.Price - (item.PRODUCT.Price * (decimal.Parse(item.Discount.ToString())/100)))))) %>
                        <%} %>
                    </td>
                    <td style="vertical-align: middle; text-align: center;">
                        <%=item.SpdAmount%>
                    </td>
                    <td style="vertical-align: middle; text-align: right;">
                        <%if (item.Discount == 0)
                          { %>
                        <% subtotal += (item.PRODUCT.Price * item.SpdAmount);%>
                        <p><%: Html.Raw(string.Format("{0:฿#,#}", ((item.PRODUCT.Price * item.SpdAmount )))) %></p>
                        <%}
                          else
                          { %>
                        <% subtotal += (item.PRODUCT.Price - (item.PRODUCT.Price * (decimal.Parse(item.Discount.ToString()) / 100))) * item.SpdAmount;%>
                        <%: Html.Raw(string.Format("{0:฿#,#}", ( (item.PRODUCT.Price - (item.PRODUCT.Price * (decimal.Parse(item.Discount.ToString())/100))) * item.SpdAmount ))) %>
                        <%} %>
                    </td>
                </tr>
                <%}%>
                <%} %>
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="2">&nbsp;</td>
                    <td colspan="4">
                        <table class="table table-condensed">
                            <tr>
                                <td>Cart Sub Total</td>
                                <td style="text-align: right"><%: Html.Raw(string.Format("{0:฿#,#}", subtotal)) %></td>
                            </tr>
                            <tr>
                                <td>Exo Tax 7%</td>
                                <td style="text-align: right"><%: Html.Raw(string.Format("{0:฿#,#}", subtotal*(decimal.Parse("0.07")))) %></td>
                            </tr>
                            <tr>
                                <td>Shipping Cost</td>
                                <td style="text-align: right"><%: Html.Raw(string.Format("{0:฿#,#}", 100)) %></td>
                            </tr>
                            <tr>
                                <td>Total</td>
                                <td style="text-align: right"><span><%: Html.Raw(string.Format("{0:฿#,#}", (subtotal + (subtotal*(decimal.Parse("0.07"))))+100)) %></span></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </tfoot>
        </table>
        <%--</div>--%>
        <!--body-->
        <div class="modal-footer ">
            <!--footer-->
            <button class="btn btn-default" data-dismiss="modal" aria-hidden="true">ปิด</button>
        </div>
        <!--footer-->
    </div>
</div>
