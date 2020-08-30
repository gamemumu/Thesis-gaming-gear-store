<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.ColorModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    DeleteColor
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

     <h3 class="page-header">Delete Color</h3>
<h3>Are you sure you want to delete this?</h3>
<fieldset>
    <legend>ColorModel</legend>

    <div class="display-label">
        <%: Html.DisplayNameFor(model => model.ClrID) %> :
        <%: Html.DisplayFor(model => model.ClrID) %>
    </div>

    <div class="display-label">
        <%: Html.DisplayNameFor(model => model.ClrName) %> :
        <%: Html.DisplayFor(model => model.ClrName) %>
    </div>

</fieldset>
<% using (Html.BeginForm()) { %>
    <%: Html.AntiForgeryToken() %>
    <p>
        <input type="submit" value="Delete" /> |
        <%: Html.ActionLink("Back to List", "ListColor") %>
    </p>
<% } %>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
