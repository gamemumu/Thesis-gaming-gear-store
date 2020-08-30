<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.TradmarkModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    TradmarkCreate
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h3 class="page-header">Tradmark Create</h3>
    <% using (Html.BeginForm())
       { %>
    <%: Html.AntiForgeryToken() %>
    <%: Html.ValidationSummary(true) %>

    <fieldset>

         <%--<strong><%: (string)ViewBag.StatusMessage %> !</strong>--%>
    
        <%--<div class="editor-label">
            <%: Html.LabelFor(model => model.TrdID) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.TrdID) %>
            <%: Html.ValidationMessageFor(model => model.TrdID) %>
        </div>--%>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.TrdName) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.TrdName) %>
            <%: Html.ValidationMessageFor(model => model.TrdName) %>
        </div>

        <p>
            <input type="submit" value="Create" />
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
    <%--<%: Scripts.Render("~/bundles/jqueryval") %>--%>
</asp:Content>
