<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    CreateSup
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
 <script src="<%: Url.Content("~/Scripts/CustomJs.js") %>" type="text/javascript"></script>
      <h3 class="page-header">Create Supplier</h3>
    <fieldset>
    <%using (Html.BeginForm())
      { %>
    <%: Html.AntiForgeryToken()%>
     <%: Html.ValidationSummary(true) %>

    <%:Html.EditorForModel()%>
    <section class="col-md-6">
       <%-- <p>
            <button type="submit">Create</button>
        </p>--%>
         <div class="col-md-3">
            <input type="submit" value="Create" class="btn btn-lg btn-success btn-block" />
        </div>
    </section>
    <section class="col-md-6"></section>
    <%} %>
    </fieldset>

<div class="col-md-3">
    <%: Html.ActionLink("Back to List", "ListSup") %>
</div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%--<%: Scripts.Render("~/bundles/jqueryval") %>--%>
</asp:Content>
