<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.BANK>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    EditBank
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

      <h3 class="page-header">แก้ไขบัญชีธนาคาร</h3>
<% using (Html.BeginForm()) { %>
    <%: Html.AntiForgeryToken() %>
    <%: Html.ValidationSummary(true) %>
  <fieldset>
        <div class="editor-label">
            <%: Html.Label("ชื่อธนาคาร") %>
        </div>
        <div class="editor-field">
            <%: Html.DropDownListFor(model => model.BnkName,ViewData["bankname"] as List<SelectListItem>, new { style = "width:20%;height:30px;" }) %>
            <%: Html.ValidationMessageFor(model => model.BnkName) %>
        </div>
        <br />
        <div class="editor-label">
            <%: Html.Label("หมายเลขบัญชี") %>
        </div>
        <div class="editor-field">
            <%: Html.TextBoxFor(model => model.BnkAccNumber, new { onkeypress="return isNumberKey(event);" ,@style =  "width:20%;height:30px;"})%>
            <%: Html.ValidationMessageFor(model => model.BnkAccNumber) %>
        </div>
        <br />
        <div class="editor-label">
            <%: Html.Label("ชื่อบัญชี") %>
        </div>
        <div class="editor-field">
            <%: Html.TextBoxFor(model => model.BnkConName, new { style = "width:20%;height:30px;" }) %>
            <%: Html.ValidationMessageFor(model => model.BnkConName) %>
        </div>
        <br />
        <p>
            <input type="submit" value="Save" />
        </p>
    </fieldset>
<% } %>

<div>
    <%: Html.ActionLink("Back to List", "ListBank") %>
</div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
<script type="text/javascript">
        jQuery(function ($) {
            $("#BnkAccNumber").mask("999-9-99999-9");
        });
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }
    </script>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <script src="../../Scripts/jquery.mask.js"></script>
</asp:Content>
