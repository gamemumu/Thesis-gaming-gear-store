<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.DepartmentModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    EditDep
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h3 class="page-header">Edit Department</h3>
<% using (Html.BeginForm()) { %>
    <%: Html.AntiForgeryToken() %>
    <%: Html.ValidationSummary(true) %>

    <fieldset>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.DepID) %>
        </div>
        <div class="editor-field">
            <%: Html.TextBoxFor(model => model.DepID ,new { disabled="disabled", @readonly = "readonly",style = "background-color: ButtonFace !important;"}) %>
            <%: Html.ValidationMessageFor(model => model.DepID) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.DepName) %>
        </div>
        <div class="editor-field">
            <%: Html.TextBoxFor(model => model.DepName) %>
            <%: Html.ValidationMessageFor(model => model.DepName) %>
        </div>

        <p>
            <input type="submit" value="Save" />
        </p>
    </fieldset>
<% } %>

<div>
    <%: Html.ActionLink("Back to List", "ListDeparts") %>
</div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
