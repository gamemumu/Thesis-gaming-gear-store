<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<ThesisGamingStore.Models.PROMOTION>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    ListPromotion
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
            <h3 class="page-header">รายการโปรโมชั่น</h3>
    <div class="panel panel-primary">
        <div class="panel-heading">
            รายการสินค้า 
            <div class="pull-right"><%: Html.ActionLink("สร้างโปรโมชั่นใหม่", "CreatePromotion",null, new { @style = "color:#ffffff !important" })%></div>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-md-12">
                    <table id="List" class="display" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th></th>
                                <th>
                                    <%: Html.DisplayName("รหัสโปรโมชั่น") %>
                                </th>
                                <th>
                                    <%: Html.DisplayName("วันเริ่มต้น") %>
                                </th>
                                <th>
                                    <%: Html.DisplayName("วันสิ้นสุด") %>
                                </th>
                                <th>
                                    <%: Html.DisplayName("ส่วนลด(%)") %>
                                </th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <% foreach (var item in Model)
                               { %>
                            <tr>
                                <td class=" details-control"></td>
                                <td>
                                    <%: Html.DisplayFor(modelItem => item.ProMID) %>
                                </td>
                                <td>
                                   <%=item.ProMStartDate.ToString("dd/MM/yyyy") %>
                                </td>
                                <td>
                                      <%=item.ProMEndDate.ToString("dd/MM/yyyy") %>
                                </td>
                                <td>
                                    <%: Html.DisplayFor(modelItem => item.Discount) %>
                                </td>
                                <td>
                                    <%: Html.ActionLink("Edit", "EditPromotion", new { ProMID = item.ProMID/* id=item.PrimaryKey */ }) %> |
                                 <button type="button" class="btn btn-sm btn-link" data-toggle="modal" data-target="#proModal" onclick="btnDelete('<%=item.ProMID %>')">Delete</button>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- ModalProduct -->
    <div class="modal fade" id="proModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
        var table; var aa; var _id;
        $(document).ready(function () {
            table = $("#List").DataTable({
                "bDestroy": true,
                "bScrollCollapse": true,
                "bJQueryUI": true,
                "bPaginate": false,
                "bInfo": true,
                "bFilter": true,
                "bSort": true,
                "order": [[1, 'desc']]
            });

            // Add event listener for opening and closing details
            $('#List tbody').on('click', 'td.details-control', function () {
                var tr = $(this).closest('tr');
                var row = table.row(tr);
                var i = 0;
                if (row.child.isShown()) {
                    // This row is already open - close it
                    row.child.hide();
                    tr.removeClass('shown');
                    _id = 0;
                }
                else {
                    // Open this row
                    var _detail_start = '<div class="panel panel-warning"><div class="panel-heading">รายการสินค้า</div><div class="panel-body"><div class="row"><div class="col-md-12">' +
                        '<table class="table table-bordered table-striped table-condensed" id="' + row.data()[1] + '"> <thead><tr><th style="width:6%">ลำดับ </th>' +
                         '<th style="width:9%">ProductID</th> <th style="width:10%">ประเภท</th><th style="width:10%">ยี่ห้อ </th><th style="width:20%">รุ่น</th> <th style="width:5%">สี </th>' +
                         '</tr> </thead><tbody>';

                    var _detail_end = '</tbody></table></div></div></div></div>';

                    $.ajax({
                        type: 'POST',
                        url: "<%= Url.Action("JsonGetPromotion","Promotion") %>", // we are calling json method
                        data: { id: row.data()[1] },
                    }).done(function (data) {
                        $.each(data, function () {
                            _detail_start += '<tr">' +
                                '<td>' + (i + 1) + '</td>' +
                                '<td>' + data[i].PrdID + '</td>' +
                                '<td>' + data[i].TypeName + '</td>' +
                                '<td>' + data[i].TrdName + '</td>' +
                                '<td>' + data[i].BrandName + '</td>' +
                                '<td>' + data[i++].ClrName + '</td>' +
                                '</tr>'
                        });
                        var dd = _detail_start + _detail_end;
                        console.log(dd)
                        row.child(dd).show();
                        tr.addClass('shown');
                    }).error(function (response, q, t) {
                        var r = jQuery.parseJSON(response.responseText);
                        alert(r);
                    })
                }
            });
        }); //doc ready
        function btnDelete(id) {
            $(".modal-body").html("ต้องการลบโปรโมชั่นนี้หรือไม่" + "  : " + '<span id="delPro">' + id + '</span>');
        }
        function btnSend() {
            $.post("<%= Url.Action("DeletePromotion","Promotion")%>",
                           { id: $("#delPro").html(), }
                       , function (data, status) {
                           $('#proModal').modal('hide');
                           //Refresh
                           location.reload();
                       });
        }
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
