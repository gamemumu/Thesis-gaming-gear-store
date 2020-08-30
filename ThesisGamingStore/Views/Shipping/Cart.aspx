<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Cart.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<%@ Import Namespace="ThesisGamingStore.Controllers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Cart
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="your_cart_items"></div>
    <!--/#cart_items-->
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $.post("<%= Url.Action("getSessionCart","Shipping") %>", { Status: "CheckOut" }, function (data, status) { $("#your_cart_items").html(data); nofi(); });
        });//docready
        function deleteItem(id) {
            event.preventDefault();
            $.post("<%= Url.Action("DeleteCart","Shipping") %>", { id: id, Status: "CheckOut" }, function (data, status) {
                if (data == false)
                    window.location.href = "/Shipping/Index";
                $("#your_cart_items").html(data); nofi();
            });
        }
        function upANDdown(id, flag) {
            event.preventDefault();
            $.post("<%= Url.Action("Quantity","Shipping") %>", { id: id, flag: flag,Status: "CheckOut" }, function (data, status) { $("#your_cart_items").html(data); nofi(); });
        }
    </script>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
