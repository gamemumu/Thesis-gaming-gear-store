<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.SupplierModel>" %>
<%@ Import Namespace="ThesisGamingStore.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Edit Sup
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script src="<%: Url.Content("~/Scripts/CustomJs.js") %>" type="text/javascript"></script>
    <h3 class="page-header">EDIT SUPPLIER</h3>
    <% using (Html.BeginForm())
       { %>
    <%: Html.AntiForgeryToken() %>
    <%: Html.ValidationSummary(true) %>

    <fieldset>

        <section class="col-md-6">
            <div class="editor-label">
                <%: Html.LabelFor(model => model.SupID) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.SupID,new { disabled="disabled", @readonly = "readonly",style = "background-color: ButtonFace !important;"}) %>
                <%: Html.ValidationMessageFor(model => model.SupID) %>
            </div>
           
            <div class="editor-label">
                <%: Html.LabelFor(model => model.SupName) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.SupName,new {disabled="disabled", @readonly = "readonly",style = "background-color: ButtonFace !important;"}) %>
                  <%: Html.HiddenFor(model => model.SupName) %>
                <%: Html.ValidationMessageFor(model => model.SupName) %> 
            </div>
             <div class="editor-label">
                <%: Html.LabelFor(model => model.SubAddress) %>
            </div>
            <div class="editor-field">
                <%: Html.TextAreaFor(model => model.SubAddress,new { @style = "width:70%;" }) %>
                <%: Html.ValidationMessageFor(model => model.SubAddress) %>
            </div>
        </section>

        <section class="col-md-6">

            <div id="phoneNumbers">
            <div class="editor-field">
                <%: Html.EditorFor(model => model.Phones) %>
                <%: Html.ValidationMessageFor(model => model.Phones) %>
            </div>
                </div>
            <p>
                <%:Html.AddLink("Add More Phone Numbers", "#phoneNumbers", ".phoneNumber", "Phones", typeof(SUPPLIER_PHONE))%>
            </p>
        </section>

         <div class="col-md-2 col-md-offset-1">
            <input type="submit" value="Save" class="btn btn-lg btn-success btn-block"/>

        </div>
    </fieldset>
<% } %>

<div>
    <%: Html.ActionLink("Back to List", "ListPosit") %>
</div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
   
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
  <%--<%: Scripts.Render("~/bundles/jqueryval") %>--%>
</asp:Content>
