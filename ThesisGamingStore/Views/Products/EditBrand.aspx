<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.BrandModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    EditBrand
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

       <h3 class="page-header">Edit Brand</h3>
<% using (Html.BeginForm()) { %>
    <%: Html.AntiForgeryToken() %>
    <%: Html.ValidationSummary(true) %>

    <fieldset>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.BrandID) %>
        </div>
        <div class="editor-field">
            <%: Html.TextBoxFor(model => model.BrandID,new { disabled="disabled", @readonly = "readonly",style = "background-color: ButtonFace !important;"}) %>
            <%: Html.ValidationMessageFor(model => model.BrandID) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.BrandName) %>
        </div>
        <div class="editor-field">
            <%: Html.TextBoxFor(model => model.BrandName) %>
            <%: Html.ValidationMessageFor(model => model.BrandName) %>
        </div>

        <div class="editor-label">
            <%: Html.Label("ยี่ห้อสินค้าคงเดิม") %>
        </div>
        <div class="editor-field">
            <%: Html.TextBoxFor(model => model.TrdName,new { disabled="disabled", @readonly = "readonly",style = "background-color: ButtonFace !important;"}) %>
            <%: Html.ValidationMessageFor(model => model.TrdName) %>
        </div>

          <div class="editor-label">
            <%: Html.Label("ยี่ห้อสินค้าใหม่ที่จะแก้ไข") %>
        </div>
        <div class="editor-field">
           <%: Html.DropDownListFor(model => model.TrdID, new SelectList(Enumerable.Empty<SelectListItem>()), new { style = "width:30%;height:30px;" })%>
            <%: Html.ValidationMessageFor(model => model.TrdID) %>
        </div>

        <p>
            <input type="submit" value="Save" />
        </p>
    </fieldset>
<% } %>

<div>
    <%: Html.ActionLink("Back to List", "ListBrand") %>
</div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
   <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                type: 'Get',
                url: "<%= Url.Action("JsonListTradmark") %>", // we are calling json method
                dataType: 'json',
                success: function (data) {
                    $.each(data, function (i, obj) {
                        $("#TrdID").append('<option value="' + obj.TrdID + '">' + obj.TrdName + '</option>');
                    });
                },
                error: function (ex) {
                    alert('Failed to retrieve Department' + ex);
                }
            });
        });
    </script>
</asp:Content>
