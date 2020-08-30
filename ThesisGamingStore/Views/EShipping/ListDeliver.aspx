<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<%@ Import Namespace="ThesisGamingStore.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    ListDeliver
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3 class="page-header">ข้อมูลการส่งสินค้า</h3>
    <div class="panel panel-primary">
        <div class="panel-heading">
            รายการส่งสินค้า 
    <div class="pull-right">
        <i class="fa fa-calendar-o"></i>&nbsp<%=System.DateTime.Today.ToString("dddd") %> &nbsp<%=System.DateTime.Today.ToString("dd/MM/yyyy") %>
    </div>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-md-12">
                    <table id="List" class="display" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th>
                                    <%: Html.DisplayName("รหัสส่งสินค้า") %>
                                </th>
                                <th>
                                    <%: Html.DisplayName("วันเส่งสินค้า") %>
                                </th>
                                <th>
                                    <%: Html.DisplayName("เลขพัสดุ") %>
                                </th>
                                <th>
                                    <%: Html.DisplayName("ที่อยู่่จัดส่ง") %>
                                </th>
                                <th>
                                    <%: Html.DisplayName("ผู้ออกใบส่ง") %>
                                </th>
                                <th>
                                    <%: Html.DisplayName("รายละเอียด") %>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <% foreach (var item in ViewData["ListDeliver"] as List<DELIVER>)
                               { %>
                            <tr>
                                <td>
                                    <%: Html.DisplayFor(modelItem => item.DlvID) %>
                                </td>
                                <td>
                                    <%=item.DlvDate.ToString("dd/MM/yyyy")%>
                                </td>
                                <td>
                                    <%: Html.DisplayFor(modelItem => item.DlvSerial) %>
                                </td>
                                <td>
                                    <%: Html.DisplayFor(modelItem => item.SELLPRODUCT.AdressRec) %>
                                </td>
                                <td>
                                    <p><%: Html.DisplayFor(modelItem => item.EMPLOYEE.Fname) %>&nbsp<%: Html.DisplayFor(modelItem => item.EMPLOYEE.Lname) %></p>
                                </td>
                                <td>
                                    <%: Html.ActionLink("รายละเอียด", "ModalListDelivery", "EShipping", new {SlpID = item.SlpID }, new {  @class = "shipping-data"})%>
                                    <button class="btn btn-danger btn-sm" onclick="GetReportDeliver('<%= item.DlvID %>')"><i class="fa fa-file-pdf-o"></i></button>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>


    <div class="modal  fade in" id="shipping-data" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div id="shipping-data-container" class="modal-dialog modal-lg"></div>
    </div>
    <div class="modal" id="myModal2" data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">รายการหมายเลขซีเรียล</h4>
                </div>
                <div class="container"></div>
                <div class="modal-body" id="serial-data">
                </div>
                <div class="modal-footer">
                    <a href="#" data-dismiss="modal" class="btn btn-default">Close</a>
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
            table = $("#List").DataTable({
                "bDestroy": true,
                "bScrollCollapse": true,
                "bJQueryUI": true,
                "bPaginate": true,
                "sScrollY": "100%",
                "sScrollHeadInner": true,
                "bInfo": true,
                "bFilter": true,
                "bSort": true,
                "aoColumnDefs": [{ "bSortable": false, "aTargets": [5] }],
                "order": [[0, 'desc']]
            });
            $('.shipping-data').click(function () {
                //var url = "/Bootstrap/EditPerson"; // the url to the controller
                var id = $(this).attr('id');
                $('#shipping-data-container').load(this.href + '/' + id, function () {
                    $('#shipping-data').modal({
                        backdrop: 'static',
                        keyboard: true
                    }, 'show');
                    //   bindForm(this);
                });
                return false;
            });
        });//docready

        function EditDeliver(DivID, SldID) {
            if ($.trim($("#EMS_serial").val()).length > 0) {
                $.post("<%= Url.Action("EditDeliver","EShipping")%>",
            {
                DivID: DivID,
                SlpID: SldID,
                EMS: $.trim($("#EMS_serial").val())
            },
      function (data) {
          if (data) {
              alert("ทำรายการเสร็จสบูรณ์");
              setTimeout(function () {
                  window.location.href = "/EShipping/ListDeliver";
              }, 500);
          } else {
              alert("ทำรายการล้มเหลวกรุณาทำใหม่");
          }
      });
        } else {
            alert("กรุณากรอกหมายเลขพัสดุก่อน");
        }
    }
    function GetSerial(slp, prd) {
        $.post("<%= Url.Action("JGetSerial","EShipping")%>",
                         {
                             SlpID: slp,
                             PrdID: prd
                         },
                   function (data) {
                       $('#serial-data').html(data);
                   });
    }

    function GetReportDeliver(id) {
        var actionUrl = '<%= Url.Action("DeliverReportID", "EShipping", new { id = "PLACEHOLDER" } ) %>';
            var win = window.open(actionUrl.replace('PLACEHOLDER', id), 'mywindow', 'fullscreen=yes, scrollbars=auto');
            //  var win = window.open("<%= Url.Action("DeliverReport", "EShipping")%>");
            win.focus();
        }
    </script>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <script src="<%: Url.Content("~/Scripts/jquery.dataTables.min.js") %>" type="text/javascript"></script>
    <link href="/Content/bootstrap.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/dataTables.bootstrap.js"></script>
    <script src="../../Scripts/jquery.tabletojson.min.js"></script>
    <script src="<%: Url.Content("~/Scripts/cdn.datatables.net/plug-ins/input.js") %>" type="text/javascript"></script>
    <script src="<%: Url.Content("~/Scripts/cdn.datatables.net/plug-ins/scrolling.js") %>" type="text/javascript"></script>
    <script src="<%: Url.Content("~/Scripts/cdn.datatables.net/plug-ins/select.js") %>" type="text/javascript"></script>
    <link href="../../Content/css/jquery.dataTables.css" rel="stylesheet" />
    <link href="../../Content/css/docs.min.css" rel="stylesheet" />
    <link href="../../Scripts/bootstrap-lightbox/ekko-lightbox.min.css" rel="stylesheet" />
    <script src="../../Scripts/bootstrap-lightbox/ekko-lightbox.min.js"></script>
</asp:Content>
