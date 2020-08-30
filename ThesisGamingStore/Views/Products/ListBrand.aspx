<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<ThesisGamingStore.Models.BrandModel>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    ListBrand
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3 class="page-header">รายการรุ่นสินค้า</h3>
    <p>
        <h4><%: Html.ActionLink("สร้างรุ่นใหม่","BrandCreate") %></h4>
    </p>
 <table id="tbl_BrandList" class="table table-condensed table-striped table-bordered" cellspacing="0" width="100%">
        <thead>
        <tr>
            <th>
                <%: Html.DisplayName("Tradmark Name") %>
            </th>
            <th>
                <%: Html.DisplayNameFor(model => model.BrandID) %>
            </th>
            <th>
                <%: Html.DisplayNameFor(model => model.BrandName) %>
            </th>
            <th></th>
        </tr>
            </thead>
     <tbody>
        <% foreach (var item in Model)
           { %>
        <tr>
            <td>
                <%: Html.DisplayFor(modelItem => item.TrdName) %>
            </td>
            <td>
                <%: Html.DisplayFor(modelItem => item.BrandID) %>
            </td>
            <td>
                <%: Html.DisplayFor(modelItem => item.BrandName) %>
            </td>
            <td>
                <%: Html.ActionLink("Edit", "EditBrand", new { BrandID = item.BrandID/* id=item.PrimaryKey */ }) %> |
            <%: Html.ActionLink("Delete", "DeleteBrand", new {  BrandID = item.BrandID/* id=item.PrimaryKey */ }) %>
            </td>
        </tr>
        <% } %>
         </tbody>
    </table>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $("#tbl_BrandList").dataTable({
                "bDestroy": true,
                "bScrollCollapse": true,
                "bJQueryUI": true,
                "bPaginate": false,
                "bInfo": true,
                "bFilter": true,
                "bSort": true,
            });
        });
    </script>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
        <script src="<%: Url.Content("~/Scripts/jquery.dataTables.min.js") %>" type="text/javascript"></script>
    <link href="/Content/bootstrap.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/dataTables.bootstrap.js"></script>
    <script src="<%: Url.Content("~/Scripts/dataTables.bootstrap.js") %>" type="text/javascript"></script>
    <script src="../../Scripts/jquery.tabletojson.min.js"></script>
    <script src="<%: Url.Content("~/Scripts/cdn.datatables.net/plug-ins/input.js") %>" type="text/javascript"></script>
    <script src="<%: Url.Content("~/Scripts/cdn.datatables.net/plug-ins/scrolling.js") %>" type="text/javascript"></script>
    <script src="<%: Url.Content("~/Scripts/cdn.datatables.net/plug-ins/select.js") %>" type="text/javascript"></script>
    <link href="../../Content/css/jquery.dataTables.css" rel="stylesheet" />
    <link href="../../Content/css/docs.min.css" rel="stylesheet" />
</asp:Content>
