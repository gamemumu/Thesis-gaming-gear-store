﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.ColorModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    EditColor
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

        <h3 class="page-header">Edit Color</h3>
<% using (Html.BeginForm()) { %>
    <%: Html.AntiForgeryToken() %>
    <%: Html.ValidationSummary(true) %>

    <fieldset>

        <div class="editor-label">
            <%: Html.Label("COLOR ID") %>
        </div>
        <div class="editor-field">
            <%: Html.TextBoxFor(model => model.ClrID,new { disabled="disabled", @readonly = "readonly",style = "background-color: ButtonFace !important;"}) %>
            <%: Html.ValidationMessageFor(model => model.ClrID) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.ClrName) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.ClrName) %>
            <%: Html.ValidationMessageFor(model => model.ClrName) %>
        </div>


        <p>
            <input type="submit" value="Save" />
        </p>
    </fieldset>
<% } %>

<div>
    <%: Html.ActionLink("Back to List", "ListColor") %>
</div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%: Scripts.Render("~/bundles/jqueryval") %>
</asp:Content>
