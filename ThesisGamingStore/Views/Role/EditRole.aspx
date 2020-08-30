<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.RolesModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    EditRole
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

            <h3 class="page-header">EditRole</h3>
    <% using (Html.BeginForm())
       { %>
    <%: Html.AntiForgeryToken() %>
    <%: Html.ValidationSummary(true) %>

    <fieldset>
        <legend>RolesModel</legend>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.RoleID) %>
        </div>
        <div class="editor-field">
            <%: Html.TextBoxFor(model => model.RoleID,new { disabled="disabled", @readonly = "readonly",style = "background-color: ButtonFace !important;"}) %>
            <%: Html.ValidationMessageFor(model => model.RoleID) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.RoleName) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.RoleName) %>
            <%: Html.ValidationMessageFor(model => model.RoleName) %>
        </div>

        <p>
            <input type="submit" value="Save" />
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
</asp:Content>
