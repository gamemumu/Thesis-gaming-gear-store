<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.PositionModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    CreatePos
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

     <h3 class="page-header">Create Position</h3>
    <% using (Html.BeginForm())
       { %>
    <%: Html.AntiForgeryToken() %>

    <fieldset>
        <legend>PositionModel</legend>

        <%--<div class="editor-label">
            <%: Html.LabelFor(model => model.PosID) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.PosID) %>
            <%: Html.ValidationMessageFor(model => model.PosID) %>
        </div>--%>

        <div class="editor-label">
             <%: Html.Label("Department") %>
        </div>
        <div class="editor-field">
            <%: Html.DropDownListFor(model => model.DepID, new SelectList(Enumerable.Empty<SelectListItem>()), new { style = "width:32%;height:30px;" })%>
            <%: Html.ValidationMessageFor(model => model.DepID) %>
            <%--   <%: Html.LabelFor(model => model.Temp) %>--%>
            <%--<%: Html.DropDownListFor(model => model.Temp,new SelectList(Enumerable.Empty<SelectListItem>())) %>--%>
            <%--<%: Html.ValidationMessageFor(model => model.Temp) %>--%>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.PosName) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.PosName) %>
            <%: Html.ValidationMessageFor(model => model.PosName) %>
        </div>

        <%: Html.ValidationSummary(true) %>

        <p>
            <input type="submit" value="Create" />
        </p>

    </fieldset>
    <% } %>

    <div>
        <%: Html.ActionLink("Back to List", "Index") %>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            // $("#DepList").change(function () {
            $.ajax({
                type: 'Get',
                url: "<%= Url.Action("ListDepart") %>", // we are calling json method
                dataType: 'json',
                success: function (data) {
                    $.each(data, function (i, obj) {
                        $("#DepID").append('<option value="' + obj.DepID + '">' + obj.DepName + '</option>');
                    });
                },
                error: function (ex) {
                    alert('Failed to retrieve Department' + ex);
                }
            });
        });
        // });
    </script>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%--<%: Scripts.Render("~/bundles/jqueryval") %>--%>
</asp:Content>
