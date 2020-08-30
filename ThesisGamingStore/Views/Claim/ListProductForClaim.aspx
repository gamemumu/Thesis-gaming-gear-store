<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.CLAIMORDER>" %>

<%@ Import Namespace="ThesisGamingStore.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    ListProductForClaim
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3 class="page-header">จัดการการส่งเคลมสินค้า</h3>
    <div class="row">
        <div class="panel panel-primary">
            <div class="panel-heading">
                รายการสินค้าในร้านที่จะส่งเคลม
                 <div class="pull-right"><i class="fa fa-calendar-o"></i>&nbsp<%=System.DateTime.Today.ToString("dddd") %> &nbsp<%=System.DateTime.Today.ToString("dd/MM/yyyy") %></div>
            </div>
            <div class="panel-body">
                <div class="row">
                    <!--fiter-->
                    <div class="col-xs-5 pull-left" id="SupSel">
                        <%: Html.DropDownListFor(model => model.SupID, new SelectList(Enumerable.Empty<SelectListItem>()), new { style = "width:100%;height:30px;" })%>
                        <%: Html.ValidationMessageFor(model => model.SupID) %>
                    </div>
                    <%-- <div class="col-xs-2 pull-left">
                    <select id="StatusSerial" name="StatusSerial" style="width: 100%; height: 30px;">
                        <option value="0">ไม่มีซีเรียล</option>
                        <option value="1">มีซีเรียล</option>
                    </select>
                </div>--%>
                </div>
                <!--fiter-->

                <!--data-->
                <div class="row">
                    <div class="col-sm-12">
                        <h3 class="title text-center">รายการสินค้าในร้านที่จะส่งเคลม</h3>
                        <div class="row">
                            <div class="col-md-12" id="Data">
                            </div>
                        </div>
                    </div>
                </div>
                <!--data-->
            </div>
        </div>
    </div>

    <div class="row">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    รายการเคลมสินค้าของร้าน
            <div class="pull-right"><i class="fa fa-calendar-o"></i>&nbsp<%=System.DateTime.Today.ToString("dddd") %> &nbsp<%=System.DateTime.Today.ToString("dd/MM/yyyy") %></div>
                </div>
                <div class="panel-body">
                    <%--<h2 class="title text-center">รายการสินค้า</h2>--%>
                    <table id="DataClaimStore" class="table table-striped table-condensed" cellspacing="0" width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
    </div>

    <div class="row">
        <div class="col-lg-6" style="padding-right: 5px; padding-left: 0px;">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    รายการเคลมสินค้าที่เสียภายใน 7 วัน
            <div class="pull-right"><i class="fa fa-calendar-o"></i>&nbsp<%=System.DateTime.Today.ToString("dddd") %> &nbsp<%=System.DateTime.Today.ToString("dd/MM/yyyy") %></div>
                </div>
                <div class="panel-body">
                     <div id="DataChangeStore"> </div>
                </div>
            </div>
        </div>

        <div class="col-lg-6" style="padding-right: 0px; padding-left: 0px;">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    รายการเคลมสินค้าของลูกค้า
            <div class="pull-right"><i class="fa fa-calendar-o"></i>&nbsp<%=System.DateTime.Today.ToString("dddd") %> &nbsp<%=System.DateTime.Today.ToString("dd/MM/yyyy") %></div>
                </div>
                <div class="panel-body">
                    <table id="ListOff" class="display" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th></th>
                                <th>
                                    <%: Html.DisplayName("รหัสใบเคลม") %>
                                </th>
                                <th>
                                    <%: Html.DisplayName("วันที่เคลม") %>
                                </th>
                                <th>
                                    <%: Html.DisplayName("พนักงาน") %>
                                </th>
                                <th>
                                    <%: Html.DisplayName("สถานะ") %>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
     <div class="row pull-right">
        <button class="btn btn-success" onclick="SendClaim()">ส่งเคลมสินค้า</button>
    </div><br /><hr />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    <script type="text/javascript">
        function SendClaim() {
            var win = window.open("<%= Url.Action("OClaimReport", "Claim")%>");
            win.focus();
            location.reload();
        }

        $(document).ready(function () {
            //ข้อมูล 7 วัน
            $.post("<%= Url.Action("GetData7Day","Claim")%>",
              function (data) {
                  $('#DataChangeStore').html(data);
              });

            // ดึ่ง บริษัทคู่ค้า
            $.ajax({
                type: 'Get',
                url: "<%= Url.Action("JsonListSupplier","Supplier") %>", // we are calling json method
                dataType: 'json',
                success: function (data) {
                    $.each(data, function (i, obj) {
                        $("#SupID").append('<option value="' + obj.SupID + '"data-supname="' + obj.SupName + '" data-subaddress="' + obj.SubAddress + '">' + obj.SupName + '</option>');
                    });
                    $("#SupID").val($("#SupID option:first").val())
                    getData($("#SupID").val());
                },
                error: function (ex) {
                    alert('Failed to retrieve JsonListType' + ex);
                }
            });
            $("#SupID , #StatusSerial").change(function () {
                getData($("#SupID").val());
            });

            //รายการเคลมของลูกค้า
            $.get("<%= Url.Action("JsonListMemberClaim","Claim")%>", function (data) {
                table = $('#ListOff').DataTable({
                    "bDestroy": true,
                    "bJQueryUI": true,
                    "bPaginate": true,
                    "sScrollY": "100%",
                    "sScrollHeadInner": true,
                    "bInfo": true,
                    "bFilter": true,
                    //  "bSort": false,
                    "aaData": data,
                    "aoColumns": [
                    {
                        "className": 'details-control',
                        "orderable": false,
                        "data": null,
                        "defaultContent": ''
                    },
                    { "data": "MClmID" },
                    { "data": "MClmDate" },
                    { "data": "Name" },
                     { "data": "MClmStatus" },
                    ],  //These are dynamically created columns present in JSON object.
                    "order": [[1, 'desc']]
                });
            });

            //ปุ่ม + ดูรายการ
            var data = []; var ListData = []; var listData = 0; //เอาไว้ตอนส่งข้อมูล
            $('#ListOff tbody').on('click', 'td.details-control', function () {
                var tr = $(this).closest('tr');
                var row = $('#ListOff').DataTable().row(tr);

                if (row.child.isShown()) {
                    // This row is already open - close it
                    row.child.hide();
                    tr.removeClass('shown');
                }
                else {
                    // Open this row
                    var _detail_start = '<table class="table table-bordered table-striped table-condensed" id="' + row.data().MClmID + '">' +
                        ' <thead><tr style="background-color:#DECF82 !important">'+
                        '<th style="width:60%">ชื่อสินค้า</th> <th style="width:10%">Serial </th><th style="width:30%">ปัญหา</th>' +
                        '</tr> </thead><tbody>';
                    var _detail_end = '</tbody></table>';
                    $.ajax({
                        type: 'POST',
                        url: "<%= Url.Action("JsonDetailMemberClaim","Claim") %>", // we are calling json method
                        data: { id: row.data().MClmID},
                    }).done(function (data) {
                        $.each(data, function (key, value) {
                            _detail_start += '<tr class="warning">' +
                                '<td>' + value.NameProduct + '</td>' +
                                '<td>' + value.SrlID + '</td>' +
                                '<td>' + value.MClmProp + '</td>' +
                                '</tr>'
                        });
                        var dd = _detail_start + _detail_end;
                        console.log(dd)
                        row.child(dd).show();
                        tr.addClass('shown');
                    });
                }
            });
        });//docready

        var listPro = [];
        var s_add = 0; var rowDataSet_Store = [];
        function btnSClaim(sr) {
            var bind = sr;
            if (listPro.length == 0) {
                listPro.push(bind);
            } else {
                for (ii = 0; ii < listPro.length; ii++) {
                    if (bind == listPro[ii]) {
                        alert("มีข้อมูลอยู่แล้ว")
                        return;
                    }
                }
                listPro.push(bind);
            }
            $('#S' + sr).css('visibility', 'visible').hide().fadeIn('slow');

            var rowData = [];
            rowData[0] = $.trim($('#S' + sr).closest('tr').find('td:eq(0)').text());
            rowData[1] = $.trim($('#S' + sr).closest('tr').find('td:eq(1)').text());
            rowData[2] = $.trim($('#S' + sr).closest('tr').find('td:eq(3)').text());
            rowData[3] = $.trim($('#S' + sr).closest('tr').find('td:eq(6)').text());
            rowData[4] = '<button id=d' + sr + '" class="btn btn-inverse btn-danger btn-xs" onclick="delData(\'' + sr + '\')"><i class="fa fa-trash-o"></i></button>';
            rowDataSet_Store[s_add++] = rowData;
            $('#DataClaimStore').DataTable({
                "bDestroy": true,
                "bScrollCollapse": true,
                "bJQueryUI": true,
                "bPaginate": true,
                "bInfo": true,
                "bFilter": true,
                "bSort": true,
                "aaData": rowDataSet_Store,
                "aoColumns": [
                          { "sWidth": "7%", "sTitle": "รหัสล๊อต" },
                          { "sWidth": "7%", "sTitle": "รหัสสินค้า" },
                          { "sWidth": "24%", "sTitle": "ชื่อสินค้า" },
                          { "sWidth": "10%", "sTitle": "เลขซีเรียล" },
                           { "sWidth": "2%", "sTitle": " " },
                ]  //These are dynamically created columns present in JSON object.
            });
        }

        function delData(SrlID) {
            for (index = 0; index < rowDataSet_Store.length; index++) {
                if (rowDataSet_Store[index][3] == SrlID) {
                    rowDataSet_Store.splice(index, 1);
                    --s_add;
                    //remove data in array
                    found = $.inArray(SrlID, listPro);
                    listPro.splice(found, 1);
                    $('#S' + SrlID).css('visibility', 'hidden').hide().fadeIn('slow');
                    //create tables
                    $('#DataClaimStore').DataTable({
                        "bDestroy": true,
                        "bScrollCollapse": true,
                        "bJQueryUI": true,
                        "bPaginate": true,
                        "bInfo": true,
                        "bFilter": true,
                        "bSort": true,
                        "aaData": rowDataSet_Store,
                        "aoColumns": [
                                  { "sWidth": "7%", "sTitle": "รหัสล๊อต" },
                                  { "sWidth": "7%", "sTitle": "รหัสสินค้า" },
                                  { "sWidth": "24%", "sTitle": "ชื่อสินค้า" },
                                  { "sWidth": "10%", "sTitle": "เลขซีเรียล" },
                                   { "sWidth": "2%", "sTitle": " " },
                        ]  //These are dynamically created columns present in JSON object.
                    });
                }
            }
        }
        function getData(sup) {
            $.post("<%= Url.Action("GetData","Claim")%>",
                        {
                            SupID: $("#SupID").val(), Se: '1'
                        },
                  function (data) {
                      $('#Data').html(data);
                  });
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
