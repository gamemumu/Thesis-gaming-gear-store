<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<%@ Import Namespace="ThesisGamingStore.Controllers" %>
<script src="<%: Url.Content("~/Scripts/numeral.min.js") %>" type="text/javascript"></script>
<% if (Session["cart"] != null)
   { %>
<ul class="nav nav-pills nav-stacked">
    <%foreach (var item in (List<Item>)Session["cart"])
      { %>
    <li>
        <div class="row vertical-align">
            <div class="col-xs-2">
                <img src="<%=item.Product.PHOTO.FirstOrDefault().Photo1%>" alt="" height="50" width="50">
            </div>
            <div class="col-xs-6">
                &nbsp <%= item.Product.BRAND.BrandName %><br />
                &nbsp x <%=item.Quantity%>
            </div>
            <%if (item.Discount.Equals("0"))
              { %>
            <div class="col-xs-4"><span class="pull-right"><%: Html.Raw(string.Format("{0:฿#,#}", (item.Product.Price * item.Quantity))) %></span></div>
            <%}
              else
              { %>
            <div class="col-xs-4"><span class="pull-right"><%: Html.Raw(string.Format("{0:฿#,#}", ( (item.Product.Price - (item.Product.Price * (decimal.Parse(item.Discount)/100))) * item.Quantity ))) %></span></div>
            <%} %>
        </div>
    </li>
    <%} %>
</ul>
<br />
<div class="btnCart">
    <span class="pull-right">
        <button onclick="clearCart()" class="btn btn-default btn-sm">Clear</button>&nbsp
         <%: Html.ActionLink("View Full Cart", "Cart", "Shipping", null, new {  @class = "btn btn-warning btn-sm" })%> &nbsp
        <a href="/Shipping/CheckOut" class="btn btn-success btn-sm">Check Out</a></span>
</div>
<%} %>