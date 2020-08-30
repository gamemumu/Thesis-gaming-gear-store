<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.TradmarkModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    DeleteTradmark
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

       <h3 class="page-header">Delete Tradmark</h3>
<h3>Are you sure you want to delete this?</h3>
<fieldset>
    <legend>TradmarkModel</legend>

    <div class="display-label">
        <%: Html.DisplayNameFor(model => model.TrdID) %> : 
        <%: Html.DisplayFor(model => model.TrdID) %>
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
        <%: Html.ActionLink("Back to List", "ListTradmark") %>
    </p>
<% } %>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
