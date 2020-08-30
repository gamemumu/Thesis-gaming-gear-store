<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.TradmarkModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    EditTradmark
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

     <h3 class="page-header">Edit Tradmark</h3>
<% using (Html.BeginForm()) { %>
    <%: Html.AntiForgeryToken() %>
    <%: Html.ValidationSummary(true) %>

    <fieldset>
        <legend>TradmarkModel</legend>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.TrdID) %>
        </div>
        <div class="editor-field">
            <%: Html.TextBoxFor(model => model.TrdID ,new { disabled="disabled", @readonly = "readonly",style = "background-color: ButtonFace !important;"}) %>
            <%: Html.ValidationMessageFor(model => model.TrdID) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.TrdName) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.TrdName) %>
            <%: Html.ValidationMessageFor(model => model.TrdName) %>
        </div>

        <p>
            <input type="submit" value="Save" />
        </p>
    </fieldset>
<% } %>

<div>
    <%: Html.ActionLink("Back to List", "ListTradmark") %>
</div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%: Scripts.Render("~/bundles/jqueryval") %>
</asp:Content>
