<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.EMPLOYEE>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    DeleteEmp
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

        <h3 class="page-header">Delete Employee</h3>

    <h3>Are you sure you want to delete this?</h3>
    <section class="col-md-6">

        <div class="display-label">
            <%: Html.DisplayNameFor(model => model.EmpID) %>
            <%: Html.DisplayFor(model => model.EmpID) %>
        </div>

        <div class="display-label">
            <%: Html.DisplayNameFor(model => model.PosID) %>
            <%: Html.DisplayFor(model => model.PosID)%>
        </div>

        <div class="display-label">
            <%: Html.DisplayNameFor(model => model.Idcard) %>
            <%: Html.DisplayFor(model => model.Idcard) %>
        </div>

        <div class="display-label">
            <%: Html.DisplayNameFor(model => model.Email) %>
            <%: Html.DisplayFor(model => model.Email) %>
        </div>

        <div class="display-label">
            <%: Html.DisplayNameFor(model => model.Fname) %>
            <%: Html.DisplayFor(model => model.Fname) %>
        </div>

        <div class="display-label">
            <%: Html.DisplayNameFor(model => model.Lname) %>
            <%: Html.DisplayFor(model => model.Lname) %>
        </div>

        <% using (Html.BeginForm())
           { %>
        <%: Html.AntiForgeryToken() %>
        <p>
            <input type="submit" value="Delete" />
            |
        <%: Html.ActionLink("Back to List", "ListEmp2") %>
        </p>
        <% } %>
    </section>

    <section class="col-md-6">
        <div class="display-label">
            <%: Html.DisplayNameFor(model => model.Username) %>
            <%: Html.DisplayFor(model => model.Username) %>
        </div>

        <div class="display-label">
            <%: Html.DisplayNameFor(model => model.Address) %>
            <%: Html.DisplayFor(model => model.Address) %>
        </div>

        <div class="display-label">
            <%: Html.DisplayNameFor(model => model.Sex) %>
            <%: Html.DisplayFor(model => model.Sex) %>
        </div>

        <div class="display-label">
            <%: Html.DisplayNameFor(model => model.Salary) %>
            <%: Html.DisplayFor(model => model.Salary) %>
        </div>


    </section>


</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
