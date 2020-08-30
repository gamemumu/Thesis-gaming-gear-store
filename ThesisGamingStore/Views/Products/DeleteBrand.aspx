<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.BrandModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    DeleteBrand
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

     <h3 class="page-header">Delete Brand</h3>
<h3>Are you sure you want to delete this?</h3>
<fieldset>
    <legend>BrandModel</legend>

    <div class="display-label">
        <%: Html.DisplayNameFor(model => model.BrandID) %> :
        <%: Html.DisplayFor(model => model.BrandID) %>
    </div>

    <div class="display-label">
        <%: Html.DisplayNameFor(model => model.BrandName) %>
        <%: Html.DisplayFor(model => model.BrandName) %>
    </div>

    <div class="display-label">
        <%: Html.DisplayNameFor(model => model.TrdName) %> :
        <%: Html.DisplayFor(model => model.TrdName) %>
    </div>
  
</fieldset>
<% using (Html.BeginForm()) { %>
    <%: Html.AntiForgeryToken() %>
    <p>
        <input type="submit" value="Delete" /> |
        <%: Html.ActionLink("Back to List", "ListBrand") %>
    </p>
<% } %>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
