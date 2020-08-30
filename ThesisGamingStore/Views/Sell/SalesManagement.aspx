<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<%@ Import Namespace="ThesisGamingStore.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    SalesManagement
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
      <h3 class="page-header">จัดการการขายสินค้า</h3>
    <div class="panel panel-primary">
        <div class="panel-heading">
               จัดการการขายสินค้า
                 <div class="pull-right" ><i class="fa fa-calendar-o"></i>&nbsp<%=System.DateTime.Today.ToString("dddd") %> &nbsp<%=System.DateTime.Today.ToString("dd/MM/yyyy") %></div>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-md-12">
                    <table id="example" class="table  table-striped table-condensed" cellspacing="0">
                        <thead>
                            <tr>
                                <th style="width: 6%">รหัสสั่ง</th>
                                <th style="width: 6%">วันที่สั่ง</th>
                                <th style="width: 13%">ชื่อผู้รับ</th>
                                <th style="width: 20%">สถานที่จัดส่ง</th>
                                <th style="width: 10%">ราคารวม</th>
                                <th style="width: 13%">สถานะชำระเงิน</th>
                                <th style="width: 6%">รายละเอียด</th>
                                <th style="width: 6%">ยืนยันการขาย</th>
                                <%--<th style="width: 6%">ยืนยันการขาย</th>--%>
                                <th style="width: 6%">ลบ</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (ViewData["LSalesManagement"] != null)
                               {%>
                            <%foreach (var item in (List<SELLPRODUCT>)ViewData["LSalesManagement"])
                              {%>
                            <tr <%if((DateTime.Now - item.SlpDate).TotalDays >3){%> style="background-color:#EFADAD"<%}%>>
                                <td><%:item.SlpID%></td>
                                <td><%:item.SlpDate.ToString("dd/MM/yyyy")%> </td>
                                <td><%:item.FnameRec%> &nbsp<%:item.LnameRec%>  </td>
                                <td><%:item.AdressRec%>  </td>
                                <td style="text-align: right"><%:Html.Raw(string.Format("{0:฿#,#}", item.SlpSum))%></td>
                                 <%if (item.SlpStatus.Equals("ยืนยันการชำระเงิน") || item.SlpStatus.Equals("เตรียมจัดส่งสินค้า"))
                                   { %>
                                     <td style="text-align: right;color: #81a32f;" ><%:item.SlpStatus%></td>
                                <%}
                                else if (item.SlpStatus.Equals("ยังไม่ได้ชำระเงิน")){ %>
                                     <td style="text-align: right;color: #808080;"><%:item.SlpStatus%></td>
                                <%}else{%>
                                      <td style="text-align: right; color: #ff9017;"><%:item.SlpStatus%></td>
                                <%} %>
                                <td style="text-align: right"><%: Html.ActionLink("รายละเอียด", "Info", "Sell", new {SlpID = item.SlpID }, new {  @class = "order-data"})%></td>
                                 <%if (item.SlpStatus.Equals("ยังไม่ได้ชำระเงิน")){ %>
                                        <td style="text-align: right"><a href="#">ยังไม่ชำระ</a></td>
                                <%}else{%>
                                     <td style="text-align: right"><%: Html.ActionLink("ยอดชำระ", "DetailPayment", "Sell", new {SlpID = item.SlpID }, new {  @class = "payment-data"})%></td>
                                <%} %>
                                <%-- <%if (item.SlpStatus.Equals("ยืนยันการชำระเงิน"))
                                   {%>
                                    <td style="text-align: right"><a onclick="MOrderConfirm('<%= item.SlpID %>')">ยืนยันการขาย</a></td>
                                <%}
                                   else if (item.SlpStatus.Equals("เตรียมจัดส่งสินค้า"))
                                   {%>
                                    <td style="text-align: right"><a href="#" style="color:#808080">ยืนยันการขาย</a></td>
                                <%}else{%>
                                <td style="text-align: right">ยืนยันขำระก่อน</td>
                                <%} %>--%>
                                <td style="text-align: right"><a href="#" data-toggle="modal" data-target="#delMOrderModal" onclick="btnDelete('<%:item.SlpID %>')">DELETE</a></td>
                            </tr>
                            <%}%>
                            <%}%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div><!--list-->
    <div class="modal  fade in" id="order-data" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div id="order-data-container" class="modal-dialog modal-lg"></div>
    </div>
    <div class="modal  fade in" id="payment-data" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div id="payment-data-container" class="modal-dialog modal-lg"></div>
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
                    <button type="button" id="btnDel" class="btn btn-danger" onclick="btnDel()">ยืนยันการลบ &nbsp<i class="fa fa-eraser fa-1x"></i></button>
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
                "aoColumnDefs": [{ "bSortable": false, "aTargets": [6,7, 8] }],
                "order": [[5, 'asc']]
            });
            $('.payment-data').click(function () {
                //var url = "/Bootstrap/EditPerson"; // the url to the controller
                var id = $(this).attr('id');
                $('#payment-data-container').load(this.href + '/' + id, function () {
                    $('#payment-data').modal({
                        backdrop: 'static',
                        keyboard: true
                    }, 'show');
                //   bindForm(this);
                });
                return false;
            });
            $('.order-data').click(function () {
                //var url = "/Bootstrap/EditPerson"; // the url to the controller
                var id = $(this).attr('id');
                $('#order-data-container').load(this.href + '/' + id, function () {
                    $('#order-data').modal({
                        backdrop: 'static',
                        keyboard: true
                    }, 'show');
                    //   bindForm(this);
                });
                return false;
            });
        });//docready

        function PaymentNofi(SldID) {
            if ($("#iNofi").val() != "") {
                $.post("<%= Url.Action("MOrderError","Sell")%>",
                   { SldID: SldID, PayCheck: $("#iNofi").val() }
                  , function (data, status) {
                      //Refresh
                      location.reload();
                  });
            } else {
                alert("กรอกจำนวนเงินที่ชำระไม่ครบ")
            }
        }
    
        function PaymentConfirm(SldID) {
              <%--  $.post("<%= Url.Action("ConfirmPayment","Sell")%>",
                          { SldID: SldID, }
                         , function (data, status) {
                             $('#payment-data').modal('hide');
                             //Refresh
                             location.reload();
                         });--%>
            $.post("<%= Url.Action("MOrderConfirm","Sell")%>",
                     { SldID: SldID, }
                    , function (data, status) {
                        //Refresh
                        location.reload();
                    });
        }
        function MOrderConfirm(SldID) {
            $.post("<%= Url.Action("MOrderConfirm","Sell")%>",
                       { SldID: SldID, }
                      , function (data, status) {
                          //Refresh
                          location.reload();
                      });
        }
        function btnDelete(id) {
            $(".modal-body").html("ต้องการลบรายการสั่งสินค้านี้หรือไม่" + "  : " + '<span id="delOder">' + id + '</span>');
        }
        function btnDel() {
            $.post("<%= Url.Action("DeleteMOrderByEmp","Payment")%>",
                           { id: $("#delOder").html(), }
                          , function (data, status) {
                              $('#delMOrderModal').modal('hide');
                              //Refresh
                              location.reload();
          });
        }

        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
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
