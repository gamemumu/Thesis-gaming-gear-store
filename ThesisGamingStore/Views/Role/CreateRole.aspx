<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.RolesModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    CreateRole
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
            <h3 class="page-header">Create Roles</h3>
    <% using (Html.BeginForm())
       { %>
    <%: Html.AntiForgeryToken() %>
    <%: Html.ValidationSummary(true) %>

    <fieldset>

        <%-- <div class="editor-label">
            <%: Html.LabelFor(model => model.RoleID) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.RoleID) %>
            <%: Html.ValidationMessageFor(model => model.RoleID) %>
        </div>--%>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.RoleName) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.RoleName) %>
            <%: Html.ValidationMessageFor(model => model.RoleName) %>
        </div>

        <p>
            <input type="submit" value="Create" />
        </p>
    </fieldset>
    <% } %>

    <div>
        <%: Html.ActionLink("Back to List", "ListRoles") %>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%--<%: Scripts.Render("~/bundles/jqueryval") %>--%>
</asp:Content>
