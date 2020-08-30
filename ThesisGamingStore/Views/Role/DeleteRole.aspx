﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.RolesModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    DeleteRole
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<h3>Are you sure you want to delete this?</h3>
<fieldset>
    <div class="display-label">
        <%: Html.DisplayNameFor(model => model.RoleID) %> :
          <%: Html.DisplayFor(model => model.RoleID) %>
    </div>
    <div class="display-label">
        <%: Html.DisplayNameFor(model => model.RoleName) %> :
         <%: Html.DisplayFor(model => model.RoleName) %>
    </div>
</fieldset>
<% using (Html.BeginForm()) { %>
    <%: Html.AntiForgeryToken() %>
    <p>
        <input type="submit" value="Delete" /> |
        <%: Html.ActionLink("Back to List", "ListRoles") %>
    </p>
<% } %>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
