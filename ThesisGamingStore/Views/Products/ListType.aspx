<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<ThesisGamingStore.Models.TypeproductModel>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    ListType
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3 class="page-header">รายการประเภทสินค้า</h3>
<p>
        <h4><%: Html.ActionLink("สร้างประเภทใหม่","TypeCreate") %></h4>
    </p>
 <table id="tbl_typeList" class="table table-condensed table-striped table-bordered" cellspacing="0" width="100%">
        <thead>
    <tr>
        <th>
            <%: Html.DisplayName("TypeID") %>
        </th>
        <th>
            <%: Html.DisplayNameFor(model => model.TypeName) %>
        </th>
      
        <th></th>
    </tr>
</thead>
     <tbody>
<% foreach (var item in Model) { %>
    <tr>
        <td>
            <%: Html.DisplayFor(modelItem => item.TypeProductID) %>
        </td>
        <td>
            <%: Html.DisplayFor(modelItem => item.TypeName) %>
        </td>
        <td>
            <%: Html.ActionLink("Edit", "EditType", new {TypeProductID= item.TypeProductID /* id=item.PrimaryKey */ }) %> |
            <%: Html.ActionLink("Delete", "DeleteType", new {TypeProductID =item.TypeProductID /* id=item.PrimaryKey */ }) %>
        </td>
    </tr>
<% } %>
         </tbody>
</table>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $("#tbl_typeList").dataTable({
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
