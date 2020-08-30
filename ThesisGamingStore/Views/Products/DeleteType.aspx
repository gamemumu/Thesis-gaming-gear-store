<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.TypeproductModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    DeleteType
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

       <h3 class="page-header">Delete Type</h3>
<h3>Are you sure you want to delete this?</h3>
<fieldset>

    <div class="display-label">
        <%: Html.DisplayNameFor(model => model.TypeProductID) %> : 
        <%: Html.DisplayFor(model => model.TypeProductID) %>
    </div>

    <div class="display-label">
        <%: Html.DisplayNameFor(model => model.TypeName) %> : 
        <%: Html.DisplayFor(model => model.TypeName) %>
    </div>

</fieldset>
<% using (Html.BeginForm()) { %>
    <%: Html.AntiForgeryToken() %>
    <p>
        <input type="submit" value="Delete" /> |
        <%: Html.ActionLink("Back to List", "ListType") %>
    </p>
<% } %>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
