<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.SUPPLIER>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    DeleteEmp
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


      <h3 class="page-header">DELETE SUPPLIER</h3>
    <h3>Are you sure you want to delete this?</h3>
    <section class="col-md-6">

        <div class="display-label">
            <%: Html.DisplayNameFor(model => model.SupID) %> :
            <%: Html.DisplayFor(model => model.SupID) %>
        </div>

        <div class="display-label">
            <%: Html.DisplayNameFor(model => model.SupName) %> :
            <%: Html.DisplayFor(model => model.SupName)%>
        </div>

        <div class="display-label">
            <%: Html.DisplayNameFor(model => model.SubAddress) %> :
            <%: Html.DisplayFor(model => model.SubAddress) %>
        </div>

        <% using (Html.BeginForm())
           { %>
        <%: Html.AntiForgeryToken() %>
        <p>
            <input type="submit" value="Delete" />
            |
        <%: Html.ActionLink("Back to List", "ListSup") %>
        </p>
        <% } %>
    </section>



</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
