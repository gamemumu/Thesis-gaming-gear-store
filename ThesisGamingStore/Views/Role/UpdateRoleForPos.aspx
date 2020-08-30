<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.UpdateRoleForPosModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    UpdateRoleForPos
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h3 class="page-header">UpdateRoleForPos</h3>
    <% using (Html.BeginForm())
       { %>
    <%: Html.AntiForgeryToken() %>
    <%: Html.ValidationSummary(true) %>

    <fieldset>
        <legend>Edit Role for Position</legend>





        <%--   <div class="editor-label">
            <%: Html.LabelFor(model => model.RoleID) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.RoleID) %>
            <%: Html.ValidationMessageFor(model => model.RoleID) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.RoleName) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.RoleName) %>
            <%: Html.ValidationMessageFor(model => model.RoleName) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.PosID) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.PosID) %>
            <%: Html.ValidationMessageFor(model => model.PosID) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.PosName) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.PosName) %>
            <%: Html.ValidationMessageFor(model => model.PosName) %>
        </div>--%>

        <p>
            <input type="submit" value="Save" />
        </p>
    </fieldset>
    <% } %>

    <div>
        <%: Html.ActionLink("Back to List", "Index") %>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%--<%: Scripts.Render("~/bundles/jqueryval") %>--%>
</asp:Content>
