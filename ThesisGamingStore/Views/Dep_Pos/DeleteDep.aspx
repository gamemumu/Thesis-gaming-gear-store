<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.DepartmentModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    DeleteDep
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h3 class="page-header">Delete Department</h3>
<h3>Are you sure you want to delete this?</h3>
<fieldset>

    <div class="display-label">
        <%: Html.DisplayNameFor(model => model.DepID) %> : 
           <%: Html.DisplayFor(model => model.DepID) %>
    </div>
    <div class="display-label">
        <%: Html.DisplayNameFor(model => model.DepName) %> : 
         <%: Html.DisplayFor(model => model.DepName) %>
    </div>
   
</fieldset>
<% using (Html.BeginForm()) { %>
    <%: Html.AntiForgeryToken() %>
    <p>
        <input type="submit" value="Delete" /> |
        <%: Html.ActionLink("Back to List", "ListDeparts") %>
    </p>
<% } %>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
