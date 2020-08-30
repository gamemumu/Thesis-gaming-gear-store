<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<%@ Import Namespace="ThesisGamingStore.Controllers" %>

<%decimal subtotal = 0; %>
<section id="cart_items">
    <div class="container">
        <div class="breadcrumbs">
            <ol class="breadcrumb">
                <li><a href="/Shipping/Index">Home</a></li>
                <li class="active">Shopping Cart</li>
            </ol>
        </div>
        <div class="table-responsive cart_info">
            <table class="table table-condensed">
                <thead>
                    <tr class="cart_menu">
                        <td class="image" style="width: 15%">Item</td>
                        <td class="description" style="width: 35%"></td>
                        <td class="price" style="width: 10%">Price</td>
                        <td class="quantity" style="width: 20%">Quantity</td>
                        <td class="total" style="width: 10%;text-align:right">Total</td>
                        <td style="width: 10%"></td>
                    </tr>
                </thead>
                <tbody>
                    <% if (Session["cart"] != null)
                       {%>
                    <%foreach (var item in (List<Item>)Session["cart"])
                      {%>
                    <tr>
                        <td class="cart_product">
                            <a href="#">
                                <img src="<%=item.Product.PHOTO.FirstOrDefault().Photo1%>" alt="" height="110" width="110"></a>
                        </td>
                        <td class="cart_description">
                            <h4><a href="#"><%= item.Product.BRAND.BrandName %></a></h4>
                            <%if (item.Discount.Equals("0"))
                              {%>
                            <p><%= item.Product.BRAND.TRADEMARK.TrdName %></p>
                            <%}
                              else
                              {%>
                            <p><%= item.Product.BRAND.TRADEMARK.TrdName %> &nbsp Discount : <%=item.Discount%>%</p>
                            <%}%>
                        </td>
                        <td class="cart_price">
                            <%if (item.Discount.Equals("0"))
                              { %>
                            <p><%: Html.Raw(string.Format("{0:฿#,#}", (item.Product.Price))) %></p>
                            <%}
                              else
                              { %>
                            <p><%: Html.Raw(string.Format("{0:฿#,#}", ((item.Product.Price - (item.Product.Price * (decimal.Parse(item.Discount)/100)))))) %></p>
                            <%} %>
                        </td>
                        <td class="cart_quantity">
                            <div class="cart_quantity_button">
                                <a class="cart_quantity_up" href="#" onclick="upANDdown('<%=item.Product.PrdID%>','true')">+ </a>
                                <input class="cart_quantity_input" type="text" name="quantity" value="<%=item.Quantity%>" autocomplete="off" size="2" readonly>
                                <a class="cart_quantity_down" href="#" onclick="upANDdown('<%=item.Product.PrdID%>','false')">- </a>
                            </div>
                        </td>
                        <td class="cart_total" style="text-align: right">
                            <%if (item.Discount.Equals("0"))
                              { %>
                            <% subtotal += (item.Product.Price * item.Quantity);%>
                            <p class="cart_total_price"><%: Html.Raw(string.Format("{0:฿#,#}", ((item.Product.Price * item.Quantity )))) %></p>
                            <%}
                              else
                              { %>
                            <% subtotal += (item.Product.Price - (item.Product.Price * (decimal.Parse(item.Discount) / 100))) * item.Quantity;%>
                            <p class="cart_total_price"><%: Html.Raw(string.Format("{0:฿#,#}", ( (item.Product.Price - (item.Product.Price * (decimal.Parse(item.Discount)/100))) * item.Quantity ))) %></p>
                            <%} %>
                        </td>
                        <td class="cart_delete" style="text-align: center">
                            <a class="cart_quantity_delete" href="#" onclick="deleteItem('<%=item.Product.PrdID%>')"><i class="fa fa-times"></i></a>
                        </td>
                    </tr>
                    <%}%>
                    <%} %>
                </tbody>
            </table>
        </div>
    </div>
</section>
<!--/#cart_items-->

<section id="do_action">
    <div class="container">
        <div class="row">
            <div class="col-sm-6">
            </div>
            <div class="col-sm-6">
                <div class="total_area">
                    <ul>
                        <li>Cart Sub Total <span><%: Html.Raw(string.Format("{0:฿#,#}", subtotal)) %></span></li>
                        <li>Eco Tax 7% <span><%: Html.Raw(string.Format("{0:฿#,#}", subtotal*(decimal.Parse("0.07")))) %></span></li>
                        <li>Shipping Cost<span><%: Html.Raw(string.Format("{0:฿#,#}", 100)) %></span></li>
                        <li>Total <span><%: Html.Raw(string.Format("{0:฿#,#}", (subtotal + (subtotal*(decimal.Parse("0.07"))))+100)) %></span></li>
                    </ul>
                    <a href="/Shipping/Index" class="btn btn-default btn-lg update">CONTINUE SHOPPING</a>
                    <% if (Session["cart"] != null)
                       {%>
                    <a class="btn btn-default btn-lg check_out" href="/Shipping/CheckOut">CHECK OUT</a>
                    <%}%>
                </div>
            </div>
        </div>
    </div>
</section>
<!--/#do_action-->
