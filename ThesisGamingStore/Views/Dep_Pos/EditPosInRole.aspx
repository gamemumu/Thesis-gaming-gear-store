<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.PositionModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    EditPosInRole
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

       <h3 class="page-header">Edit Roles</h3>
<% using (Html.BeginForm()) { %>
    <%: Html.AntiForgeryToken() %>
    <%: Html.ValidationSummary(true) %>

    <fieldset>
        
 <table style="width:100%;">

            <tr>
                <td style="width: 10%"></td>
                <td><%: Html.Label("Department") %> </td>
                <td style = "padding-left:15px;"><%: Html.Label("Position") %> </td>
            </tr>
            <tr>
                <td style="width: 10%"></td>
                <td>
                    <%--<%: Html.DropDownListFor(model => model.DepID, new SelectList(Enumerable.Empty<SelectListItem>()), new { disabled="disabled", @readonly = "readonly" ,style = "width:100%;height:30px;" })%>--%>
                    <%: Html.TextBoxFor(model => Model.DepName,new { disabled="disabled", @readonly = "readonly",style = "width:50%;height:32px;background-color: ButtonFace !important;" }) %>
                    <%: Html.ValidationMessageFor(model => model.DepID) %>
                </td>
                <td style = "padding-left:15px;"><%: Html.TextBoxFor(model => Model.PosName) %>
                </td>
            </tr>
        </table>

        <%--                              #### Temp ####                             --%>
        <%: Html.HiddenFor(model => model.Temp) %>


        <%--                              #### Drag Drop ####                             --%>
        <%: Html.Partial("_EditPosPartial") %>

         

          <%: Html.ValidationMessageFor(model => model.PosName) %>

        <div class="col-md-2 col-md-offset-1">
            <input type="submit" value="Save" class="btn btn-lg btn-success btn-block" onclick="e_submit()" />
        </div>
    </fieldset>
<% } %>

<div>
    <%: Html.ActionLink("Back to List", "ListPosit") %>
</div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    <!-- Scripts --->
    <script src="<%: Url.Content("~/Scripts/lvl-drag-drop.js") %>" type="text/javascript"></script>
    <%--<script src="<%: Url.Content("~/Scripts/jquery-2.0.2.min.js") %>" type="text/javascript"></script>--%>
    <script src="<%: Url.Content("~/Scripts/angular.min.js") %>" type="text/javascript"></script>
    <!-- Styles --->
    <link href="<%: Url.Content("~/Content/css/bootstrap.min.css") %>" rel="stylesheet" type="text/css" />
    <link href="<%: Url.Content("~/Content/dragg.css") %>" rel="stylesheet" type="text/css" />

    <%--<script type="text/javascript">
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
    </script>--%>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
