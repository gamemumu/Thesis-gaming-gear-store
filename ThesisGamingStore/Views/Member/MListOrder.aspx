<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Cart.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    MListOrder
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="contact-page" class="container">
        <div class="row">
            <div class="col-sm-12">
                <h2 class="title text-center">ประวัติการสั่งซื้อสินค้า</h2>
                    <div class="row">
                        <div class="col-md-12">
                             <%: Html.Partial("_MListOrder",  ViewData["Data"]) %>
                        </div>
                    </div>
            </div>
        </div>
    </div>
    <!--/#contact-page-->


    <div class="modal  fade in" id="order-data" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div id="order-data-container" class="modal-dialog modal-lg"></div>
    </div>

     <!-- ModalDelete -->
    <div class="modal fade" id="delMOrderModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title" id="myModalLabel">Are you sure you want to delete this?</h4>
                    <br />
                </div>
                <div class="modal-body">
                    .....
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <%--<button type="button" class="btn btn-primary">Save changes</button>--%>
                    <button type="button" id="btnDel" class="btn btn-danger" onclick="btnSend()">ยืนยันการลบ &nbsp<i class="fa fa-eraser fa-1x"></i></button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    <script type="text/javascript">
        $(document).delegate('*[data-toggle="lightbox"]', 'click', function (event) {
            event.preventDefault();
            $(this).ekkoLightbox();
        });
        jQuery(function ($) {
            table = $("#example").DataTable({
                "bDestroy": true,
                "bScrollCollapse": true,
                "bJQueryUI": true,
                "bPaginate": true,
                "bInfo": true,
                "bFilter": true,
                "bSort": true,
                "aoColumnDefs": [{ "bSortable": false, "aTargets": [7, 8, 9] }],
                "order": [[0, 'desc']]
            });
            $('.order-data').click(function () {
                //var url = "/Bootstrap/EditPerson"; // the url to the controller
                var id = $(this).attr('id');

                $('#order-data-container').load(this.href + '/' + id, function () {
                    $('#order-data').modal({
                        backdrop: 'static',
                        keyboard: true
                    }, 'show');
                   // bindForm(this);
                });
                return false;
            });
        });//docready

        function btnDelete(id) {
            $(".modal-body").html("ต้องการลบรายการสั่งสินค้านี้หรือไม่" + "  : " + '<span id="delOder">' + id + '</span>');
        }
        function btnSend() {
            $.post("<%= Url.Action("DeleteMOrder","Payment")%>",
                          { id: $("#delOder").html(), }
                         , function (data, status) {
                          $('#delMOrderModal').modal('hide');
                          //Refresh
                          location.reload();
                      });
        }
    </script>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <script src="<%: Url.Content("~/Scripts/jquery.dataTables.min.js") %>" type="text/javascript"></script>
    <script src="../../Scripts/dataTables.bootstrap.js"></script>
    <script src="../../Scripts/jquery.tabletojson.min.js"></script>
    <script src="<%: Url.Content("~/Scripts/cdn.datatables.net/plug-ins/input.js") %>" type="text/javascript"></script>
    <script src="<%: Url.Content("~/Scripts/cdn.datatables.net/plug-ins/scrolling.js") %>" type="text/javascript"></script>
    <script src="<%: Url.Content("~/Scripts/cdn.datatables.net/plug-ins/select.js") %>" type="text/javascript"></script>
    <link href="../../Content/css/jquery.dataTables.css" rel="stylesheet" />
</asp:Content>
