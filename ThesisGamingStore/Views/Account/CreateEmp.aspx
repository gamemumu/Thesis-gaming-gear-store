<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Create Employee
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script src="<%: Url.Content("~/Scripts/CustomJs.js") %>" type="text/javascript"></script>
      <h3 class="page-header">Create Employee</h3>
    <%using (Html.BeginForm())
      { %>
    <%: Html.AntiForgeryToken()%>
     <%: Html.ValidationSummary(true) %>

    <%:Html.EditorForModel()%>
    <section class="col-md-6">
        <p>
            <button type="submit">Create</button>
        </p>
    </section>
    <section class="col-md-6"></section>
    <%} %>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                type: 'Get',
                url: "<%= Url.Action("JsonListPosit","Dep_Pos") %>", // we are calling json method
                dataType: 'json',
                success: function (data) {
                    $.each(data, function (i, obj) {
                        $("#PosID").append('<option value="' + obj.PosID + '">' + obj.DepName + '  [ ' + obj.PosName + ' ]</option>');
                    });
                },
                error: function (ex) {
                    alert('Failed to retrieve Department' + ex);
                }
            });
        });

        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }
    </script>

</asp:Content>
