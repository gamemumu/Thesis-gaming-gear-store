<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.TypeproductModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    EditType
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h3 class="page-header">Edit Type</h3>
    <% using (Html.BeginForm())
       { %>
    <%: Html.AntiForgeryToken() %>
    <%: Html.ValidationSummary(true) %>

    <fieldset>
        <legend>TYPE OF PRODUCT</legend>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.TypeProductID) %>
        </div>
        <div class="editor-field">
            <%: Html.TextBoxFor(model => model.TypeProductID ,new { disabled="disabled", @readonly = "readonly",style = "background-color: ButtonFace !important;"}) %>
            <%: Html.ValidationMessageFor(model => model.TypeProductID) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.TypeName) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.TypeName) %>
            <%: Html.ValidationMessageFor(model => model.TypeName) %>
        </div>

        <p>
            <input type="submit" value="Save" />
        </p>
    </fieldset>
    <% } %>

    <div>
        <%: Html.ActionLink("Back to List", "ListType") %>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
