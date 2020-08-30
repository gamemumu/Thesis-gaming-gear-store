<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<ThesisGamingStore.Models.EMPLOYEE>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    ListEmp
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

     <h3 class="page-header">Data Employee</h3>
<p>
    <%: Html.ActionLink("Create New", "CreateEmp","Account") %>
</p>
<table class="table table-hover table-condensed table-striped" >
    <tr>
        <th>
            <%: Html.DisplayNameFor(model => model.EmpID) %>
        </th>
        <th>
            <%: Html.DisplayNameFor(model => model.PosID) %>
        </th>
        <%--<th>
            <%: Html.DisplayNameFor(model => model.Idcard) %>
        </th>--%>
        <th>
            <%: Html.DisplayNameFor(model => model.Email) %>
        </th>
        <th>
            <%: Html.DisplayNameFor(model => model.Fname) %>
        </th>
        <th>
            <%: Html.DisplayNameFor(model => model.Lname) %>
        </th>
       <%-- <th>
            <%: Html.DisplayNameFor(model => model.Address) %>
        </th>
        <th>
            <%: Html.DisplayNameFor(model => model.Sex) %>
        </th>--%>
        <th>
            <%: Html.DisplayNameFor(model => model.Salary) %>
        </th>
        <th>
            <%: Html.DisplayNameFor(model => model.Username) %>
        </th>
        <th>
            <%: Html.DisplayNameFor(model => model.Password) %>
        </th>
         <th>
            <%: Html.Label("Phones")%>
        </th>
        <th></th>
    </tr>

<% foreach (var item in Model) { %>
    <tr>
        <td>
            <%: Html.DisplayFor(modelItem => item.EmpID) %>
        </td>
        <td>
            <%: Html.DisplayFor(modelItem => item.PosID) %>
        </td>
       <%-- <td>
            <%: Html.DisplayFor(modelItem => item.Idcard) %>
        </td>--%>
        <td>
            <%: Html.DisplayFor(modelItem => item.Email) %>
        </td>
        <td>
            <%: Html.DisplayFor(modelItem => item.Fname) %>
        </td>
        <td>
            <%: Html.DisplayFor(modelItem => item.Lname) %>
        </td>
      <%--  <td>
            <%: Html.DisplayFor(modelItem => item.Address) %>
        </td>--%>
       <%-- <td>
            <%: Html.DisplayFor(modelItem => item.Sex) %>
        </td>--%>
        <td>
            <%: Html.DisplayFor(modelItem => item.Salary) %>
        </td>
        <td>
            <%: Html.DisplayFor(modelItem => item.Username) %>
        </td>
        <td>
            <%: Html.DisplayFor(modelItem => item.Password) %>
        </td>
         <th>
            <%:Html.DisplayFor(modelItem => item.EMPLOYEE_PHONE) %>
        </th>
        <td>
            <%: Html.ActionLink("Edit", "Edit", new { EmpID = item.EmpID/* id=item.PrimaryKey */ }) %> |
            <%: Html.ActionLink("Delete", "DeleteEmp", new { EmpID = item.EmpID/* id=item.PrimaryKey */ }) %>
        </td>
    </tr>
<% } %>

</table>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
