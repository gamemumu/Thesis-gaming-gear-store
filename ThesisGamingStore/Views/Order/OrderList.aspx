<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<ThesisGamingStore.Models.OrderModel>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    OrderList
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

     <h3 class="page-header">รับสินค้า</h3>
    <table id="tbl_orderList" class="table table-condensed table-striped table-bordered" cellspacing="0" width="100%">
        <thead>
            <tr>
                <th>
                    <%: Html.DisplayNameFor(model => model.OrdID) %>
                </th>
                <th>
                    <%: Html.DisplayNameFor(model => model.EmpID) %>
                </th>
                <th>
                    <%: Html.DisplayNameFor(model => model.EmpName) %>
                </th>
                <th>
                    <%: Html.DisplayNameFor(model => model.SupID) %>
                </th>
                <th>
                    <%: Html.DisplayNameFor(model => model.SupName) %>
                </th>
                <th>
                    <%: Html.DisplayNameFor(model => model.OrdDate) %>
                </th>
                <th>
                    <%: Html.DisplayNameFor(model => model.TotalCost) %>
                </th>
                <%--   <th>
            <%: Html.DisplayNameFor(model => model.OrdStatus) %>
        </th>
        <th>
            <%: Html.DisplayNameFor(model => model.OrdEnabled) %>
        </th>--%>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <% foreach (var item in Model)
               { %>
            <tr>
                <td>
                    <%: Html.DisplayFor(modelItem => item.OrdID) %>
                </td>
                <td>
                    <%: Html.DisplayFor(modelItem => item.EmpID) %>
                </td>
                <td>
                    <%: Html.DisplayFor(modelItem => item.EmpName) %>
                </td>
                <td>
                    <%: Html.DisplayFor(modelItem => item.SupID) %>
                </td>
                <td>
                    <%: Html.DisplayFor(modelItem => item.SupName) %>
                </td>
                <td>
                    <%: Html.DisplayFor(modelItem => item.OrdDate) %>
                </td>
                <td class="_Costt" style="text-align: right">
                    <%: Html.DisplayFor(modelItem => item.TotalCost) %>
                </td>
                <%--  <td>
            <%: Html.DisplayFor(modelItem => item.OrdStatus) %>
        </td>
        <td>
            <%: Html.DisplayFor(modelItem => item.OrdEnabled) %>
        </td>--%>
                <td>
                    <%--<%: Html.ActionLink("Details", "OrderDetails", "Order", new { id = item.OrdID,@SupName = item.SupName}, new {  @class = "btn btn-small btn-primary edit-person" })%>--%>
                    <%: Html.ActionLink("Details", "Test", "Order", new { id = item.OrdID,@SupName = item.SupName}, new {  @class = "btn btn-small btn-primary open-wizard "})%>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>

    <div class="modal  fade in" id="edit-person" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div id="edit-person-container" class="modal-dialog modal-lg"></div>
    </div>
    <div class="modal  fade in" id="open-wizard" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
        <div id="open-wizard-container" class="modal-dialog modal-lg"></div>
    </div>

    <div class="modal" id="myModal2" data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title"></h4>
                </div>
                <div class="container"></div>
                <div class="modal-body">
                    Content for the dialog / modal goes here.
                </div>
                <div class="modal-footer">
                     <button id="sr_valid" class="btn btn-inverse btn btn-danger pull-left" type="submit" onclick="#" style="visibility: hidden;">* กรุณากรอกข้อมูลให้ถูกต้อง !!</button>
                    <a href="#" data-dismiss="modal" class="btn">Close</a>
                     <%-- <a href="#" id="myLink" class="btn btn-primary">Save changes</a>--%>
                    <button class="btn btn-inverse btn-primary" type="button" onclick="confrimSerial()" >Save changes</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $("._Costt").each(function (i) {
                $(this).html(numeral($.trim($("._Costt")[i].innerText).toString()).format('0,0.00'));
            });
            $("#tbl_orderList").dataTable({
                "bDestroy": true,
                "bScrollCollapse": true,
                "bJQueryUI": true,
                "bPaginate": false,
                "bInfo": true,
                "bFilter": true,
                "bSort": true,
                "aaSorting": [[5, 'desc']],
            });
            $('.edit-person').click(function () {
                //var url = "/Bootstrap/EditPerson"; // the url to the controller
                var id = $(this).attr('id');

                $('#edit-person-container').load(this.href + '/' + id, function () {
                    $('#edit-person').modal({
                        backdrop: 'static',
                        keyboard: true
                    }, 'show');
                    bindForm(this);
                });
                return false;
            });
            $('.open-wizard').click(function () {
                //var url = "/Bootstrap/EditPerson"; // the url to the controller
                var id = $(this).attr('id');
                $('#open-wizard-container').load(this.href + '/' + id, function () {
                    $('#open-wizard').modal({
                        backdrop: 'static',
                        keyboard: true
                    }, 'show');
                    bindForm(this);
                });
                return false;
            });

        });

        function bindForm(dialog) {
            $('form', dialog).submit(function () {
                $.ajax({
                    url: this.action,
                    type: this.method,
                    data: $(this).serialize(),
                    success: function (result) {
                        $('#edit-person').modal('hide');
                        location.reload();
                    }
                });
                return false;
            });
            $('form', dialog).submit(function () {
                $.ajax({
                    url: this.action,
                    type: this.method,
                    data: $(this).serialize(),
                    success: function (result) {
                        $('#open-wizard').modal('hide');
                        location.reload();
                    }
                });
                return false;
            });
        }

    </script>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <style type="text/css">
        .modal:nth-of-type(even) {
            z-index: 1042 !important;
        }
        .modal-backdrop.in:nth-of-type(even) {
            z-index: 1041 !important;
        }
    </style>
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
    <script src="../../Scripts/jquery-bootstrap-modal-steps.js"></script>
</asp:Content>
