<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.ProductModel>" %>

<%@ Import Namespace="ThesisGamingStore.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    ListProduct
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <h3 class="page-header">รายการสินค้า</h3>
    <p>
        <h4><%: Html.ActionLink("Create New", "ProductCreate") %></h4>
    </p>
<%--    <div class="row">
        <div class="col-md-5 pull-left" id="SupSel">
            <h4><span class="label label-warning">Supplier</span>
                <%: Html.DropDownListFor(model => model.SupID, new SelectList(Enumerable.Empty<SelectListItem>()), new { style = "width:50%;height:25px;font-size:70%"  })%></h4>
            <%: Html.ValidationMessageFor(model => model.SupID) %>
        </div>
    </div>--%>

    <br />
    <div class="row">
        <div class="col-md-12">
            <table id="tbl_productList" class="table table-hover table-striped table-condensed col-md-8" cellspacing="0">
                <%--<thead>
                    <tr>
                        <th style="width: 15%">
                            <%: Html.DisplayName("Product ID") %>
                        </th>
                        <th style="width: 15%">
                            <%: Html.DisplayName("ประเภทสินค้า") %>
                        </th>

                        <th style="width: 15%">
                            <%: Html.DisplayName("ยี่ห้อ") %>
                        </th>

                        <th style="width: 20%">
                            <%: Html.DisplayName("รุ่น") %>
                        </th>
                        <th style="width: 10%">
                            <%: Html.DisplayName("สี") %>
                        </th>
                        <th style="width: 10%">
                            <%: Html.DisplayName("ระยะประกัน") %>
                        </th>
                        <th style="width: 13%">
                            <%: Html.DisplayName("Photo") %>
                        </th>
                        <th></th>
                    </tr>
                </thead>--%>
                <%--<tbody>
                </tbody>--%>
            </table>
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
        $(document).ready(function () {
                    $.ajax({
                        type: 'GET',
                        url: "<%= Url.Action("JsonListProduct2","Products") %>", // we are calling json method
                        dataType: 'json',
                        success: function (obj) {
                            console.log(JSON.stringify(obj));
                            var JSONResult = JSON.stringify(obj);
                            var parseJSONResult = jQuery.parseJSON(JSONResult);

                            if (parseJSONResult != null && parseJSONResult.length > 0) {
                                var rowDataSet = [];
                                var i = 0;
                                $.each(parseJSONResult, function (key, value) {
                                    var rowData = [];
                                    //if (checkID != value.PrdID) {
                                    $.each(parseJSONResult[i], function (key, value) {
                                        if (key == "PrdID") {
                                            rowData[0] = value;
                                            rowData[8] = '<a href="#"><input type="button" class="btn btn-sm btn-warning" value="Edit" onClick="btnEdit(\'' + value + '\')" /></a> &nbsp' +
                                                         //'&nbsp&nbsp<a href="#"><input type="button" class="btn btn-sm btn-default" value="Delete" onClick="btnDelete(\'' + value + '\')" /></a>' +
                                                          '<button type="button" class="btn btn-sm btn-danger"" data-toggle="modal" data-target="#proModal" onclick="btnDelete(\'' + value + '\')">Delete</button>'
                                            checkID = value;
                                        }
                                        else if (key == "TypeName")
                                            rowData[1] = value;
                                        else if (key == "TrdName")
                                            rowData[2] = value;
                                        else if (key == "BrandName")
                                            rowData[3] = value;
                                        else if (key == "ClrName")
                                            rowData[4] = value;
                                        else if (key == "PrdStatus")
                                            rowData[5] = value;
                                        else if (key == "Waranty")
                                            rowData[6] = value;
                                        else if (key == "Filepath")
                                            rowData[7] = '<img src="' + value + '" alt="alt" height="40" width="60">';
                                    });
                                    rowDataSet[i] = rowData;
                                    i++;
                                });
                                $('#tbl_productList').dataTable({
                                    "aaSorting": [[0, 'desc']],
                                    "bDestroy": true,
                                    "bScrollCollapse": true,
                                    //"bJQueryUI": true,
                                    "bPaginate": true,
                                    //"sScrollY": "400px",
                                    "bInfo": true,
                                    "bFilter": true,
                                    "bSort": true,
                                    "aaData": rowDataSet,
                                    "aoColumns": [
                                   { "sWidth": "10%", "sTitle": "Product ID" },
                                   { "sWidth": "10%", "sTitle": "ประเภทสินค้า" },
                                   { "sWidth": "10%", "sTitle": "ยี่ห้อ" },
                                   { "sWidth": "25%", "sTitle": "รุ่นสินค้า" },
                                   { "sWidth": "5%", "sTitle": "สี" },
                                   { "sWidth": "10%", "sTitle": "สถานะสินค้า" },
                                   { "sWidth": "5%", "sTitle": "Waranty(Y)" },
                                   { "sWidth": "10%", "sTitle": "Photo" },
                                   { "sWidth": "15%", "sTitle": "Action" }
                                    ]  //These are dynamically created columns present in JSON object.
                                });
                            } else {
                                $('#tbl_productList').empty();
                            }
                        },
                        error: function (ex) {
                            alert('Failed to retrieve JsonListBrand' + ex);
                        }
                    });
            });
        function btnEdit(id) {
            window.location = '/Products/EditProduct/' + id;
        }
        function btnDelete(id) {
            $(".modal-body").html("ต้องการลบสินค้านี้หรือไม่" + "  : " + '<span id="delPro">' + id +'</span>');
        }
        function btnSend() {
         $.post("<%= Url.Action("DeleteProduct","Products")%>",
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
