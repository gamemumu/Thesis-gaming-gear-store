<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<ThesisGamingStore.Models.Employee>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    ListEmp2
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

      <h3 class="page-header">Data Employee</h3>
    <p>
        <h4><%: Html.ActionLink("Create New", "CreateEmp","Account") %></h4>
    </p>
    <table id="tbl_empList" class="table table-condensed table-striped table-bordered" cellspacing="0" width="100%">
        <thead>
            <tr>
                <th>
                    <%: Html.DisplayName("EmpID") %>
                </th>
                <th>
                    <%: Html.DisplayName("Position") %>
                </th>
                <th>
                    <%: Html.DisplayName("Username") %>
                </th>
                <th>
                    <%: Html.DisplayName("E-mail") %>
                </th>

                <th>
                    <%: Html.DisplayName("First name") %>
                </th>
                <th>
                    <%: Html.DisplayName("Last name") %>
                </th>
                <%--<th>
           <%: Html.DisplayName("Address") %>
        </th>--%>
                <%--<th>
            <%: Html.DisplayNameFor(model => model.Idcard) %>
        </th>--%>
                <th>
                    <%: Html.DisplayName("Salary") %>
                </th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <% foreach (var item in ViewData["ListEmp"] as List<ThesisGamingStore.Entity.EmpPosDetial>)
               { %>
            <tr>
                <td>
                    <%: Html.DisplayFor(modelItem => item.EmpID) %>
                </td>
                <td>
                    <%: Html.DisplayFor(modelItem => item.PosName) %>
                </td>
                <td>
                    <%: Html.DisplayFor(modelItem => item.Username) %>
                </td>
                <td>
                    <%: Html.DisplayFor(modelItem => item.Email) %>
                </td>
                <td>
                    <%: Html.DisplayFor(modelItem => item.Fname) %>
                </td>
                <td>
                    <%: Html.DisplayFor(modelItem => item.Lname) %>
                </td>
                <%-- <td>
            <%: Html.DisplayFor(modelItem => item.Address) %>
        </td>--%>
                <td>
                    <%: Html.DisplayFor(modelItem => item.Salary) %>
                </td>
                <td>
                    <%: Html.ActionLink("Edit", "Edit", new { EmpID = item.EmpID/* id=item.PrimaryKey */ }) %> |
            <%: Html.ActionLink("Delete", "DeleteEmp", new { EmpID = item.EmpID/* id=item.PrimaryKey */ }) %>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $("#tbl_empList").dataTable({
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
