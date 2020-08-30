<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<ThesisGamingStore.Models.SUPPLIER>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    List SUPPLIER
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h3 class="page-header">Data SUPPLIER</h3>
<p>
    <%: Html.ActionLink("Create New", "CreateSup","Supplier") %>
</p>
 <table id="tbl_supList" class="table table-condensed table-striped table-bordered" cellspacing="0" width="100%">
        <thead>
    <tr>
        <th>
            <%: Html.DisplayNameFor(model => model.SupID) %>
        </th>
        <th>
            <%: Html.DisplayNameFor(model => model.SupName) %>
        </th>
      
        <th>
            <%: Html.DisplayNameFor(model => model.SubAddress) %>
        </th>
         <th>
            <%: Html.Label("Phones")%>
        </th>
        <th></th>
    </tr>
</thead>
     <tbody>
<% foreach (var item in Model) { %>
    <tr>
        <td>
            <%: Html.DisplayFor(modelItem => item.SupID) %>
        </td>
        <td>
            <%: Html.DisplayFor(modelItem => item.SupName) %>
        </td>
        <td>
            <%: Html.DisplayFor(modelItem => item.SubAddress) %>
        </td>
       
         <th>
            <%:Html.DisplayFor(modelItem => item.SUPPLIER_PHONE) %>
        </th>
        <td>
            <%: Html.ActionLink("Edit", "EditSup", new { SupID = item.SupID/* id=item.PrimaryKey */ }) %> 
            <%: Html.ActionLink("Delete", "DeleteSup", new { SupID = item.SupID/* id=item.PrimaryKey */ }) %>
        </td>
    </tr>
<% } %>
         </tbody>
</table>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $("#tbl_supList").dataTable({
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
