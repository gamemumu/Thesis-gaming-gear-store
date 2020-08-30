<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.CLAIM_MEMBER_DTA>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    ClaimMember
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <h3 class="page-header">จัดการการเคลมสินค้าของลูกค้า</h3>
    <div class="row">
        <div class="panel panel-primary">
            <div class="panel-heading">
                รายการสินค้าของลูกค้า
            <div class="pull-right"><i class="fa fa-calendar-o"></i>&nbsp<%=System.DateTime.Today.ToString("dddd") %> &nbsp<%=System.DateTime.Today.ToString("dd/MM/yyyy") %></div>
            </div>
            <div class="panel-body">
                <div class="row">
                    <!--fiter-->
                    <div class="col-xs-5 pull-left" id="SupSel">
                        <input id="input_data" style="width: 50%; height: 30px;" placeholder="เลขซีเรียลนัมเบอร์ / เลขใบขาย" />
                        <button id="btn_data" style="height: 30px;" onclick="Search()"><i class="fa fa-search"></i></button>
                    </div>
                </div>
                <!--fiter-->
                <br />
                <!--data-->
                <div class="row">
                    <div class="col-sm-12">
                        <%--<h2 class="title text-center">รายการสินค้า</h2>--%>
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
        <div class="panel panel-yellow">
            <div class="panel-heading">รายการสินค้าที่จะเคลม</div>
            <div class="panel-body">
                <table id="tClaim" class="table table-striped table-condensed" cellspacing="0" width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="panel panel-red">
            <div class="panel-heading">รายการสินค้าที่จะเปลี่ยน</div>
            <div class="panel-body">
                <table id="tChange" class="table table-striped table-condensed" cellspacing="0" width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="row pull-right">
        <button class="btn btn-success" onclick="SendClaim()">ยืนยันการเคลม</button>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    <script type="text/javascript">
        $(document).delegate('*[data-toggle="lightbox"]', 'click', function (event) {
            event.preventDefault();
            $(this).ekkoLightbox();
        });
        //jQuery(function ($) {
        //});

        var rowDataSet_Claim = []; var rowDataSet_DAY = [];
        var listPro = [];
        var c_add = 0; var d_add = 0;
        function btnClaim(flag, QuantityStock, prdID, SrlID, SlpID, SlpNo, name) {
            flagSearch = 1;
            var bind = SrlID;
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
            $('#S' + SrlID).css('visibility', 'visible').hide().fadeIn('slow');
            //<!--flag:0 อยู่ในระยะเวลา 7 วัน--> <!--flag:1 ไม่อยู่ในระยะเวลา 7 วัน-->
            if (flag == 0 && QuantityStock > 0) {
                var rowData = [];
                rowData[0] = SlpID;
                rowData[1] = SlpNo;
                rowData[2] = prdID;
                rowData[3] = name;
                rowData[4] = SrlID;
                rowData[5] = '<input id="change_data' + SrlID + '" style="width:100%; height: 30px;" placeholder="เลขซีเรียลที่เปลี่ยน" />';
                rowData[6] = '<button id=d' + SrlID + '" class="btn btn-inverse btn-danger" onclick="delData(\'' + SrlID + '\',\'' + flag + '\')">Delete</button>';
                rowDataSet_DAY[d_add++] = rowData;
                $('#tChange').dataTable({
                    "bDestroy": true,
                    "bScrollCollapse": true,
                    "bJQueryUI": true,
                    "bPaginate": true,
                    "bInfo": true,
                    "bFilter": true,
                    "bSort": true,
                    "aaData": rowDataSet_DAY,
                    "aoColumns": [
                              { "sWidth": "7%", "sTitle": "รหัสใบขาย" },
                              { "sWidth": "7%", "sTitle": "ลำดับใบขาย" },
                              { "sWidth": "7%", "sTitle": "รหัสสินค้า" },
                              { "sWidth": "24%", "sTitle": "ชื่อสินค้า" },
                              { "sWidth": "10%", "sTitle": "เลขซีเรียล" },
                              { "sWidth": "20%", "sTitle": "เลขซีเรียลที่เปลี่ยน", "bSortable": false },
                              { "sWidth": "5%", "sTitle": "ลบ", "bSortable": false },
                    ]  //These are dynamically created columns present in JSON object.
                });
            } else {
                var rowData = [];
                rowData[0] = SlpID;
                rowData[1] = SlpNo;
                rowData[2] = prdID;
                rowData[3] = name;
                rowData[4] = SrlID;
                rowData[5] = '<input id="prop_data' + SrlID + '" style="width:100%; height: 30px;" placeholder="ปัญหาสินค้า" />';
                rowData[6] = '<button id=d' + SrlID + '" class="btn btn-inverse btn-danger" onclick="delData(\'' + SrlID + '\',\'' + flag + '\')">Delete</button>';
                rowDataSet_Claim[c_add++] = rowData;
                $('#tClaim').dataTable({
                    "bDestroy": true,
                    "bScrollCollapse": true,
                    "bJQueryUI": true,
                    "bPaginate": true,
                    "bInfo": true,
                    "bFilter": true,
                    "bSort": true,
                    "aaData": rowDataSet_Claim,
                    "aoColumns": [
                              { "sWidth": "7%", "sTitle": "รหัสใบขาย" },
                              { "sWidth": "7%", "sTitle": "ลำดับใบขาย" },
                              { "sWidth": "7%", "sTitle": "รหัสสินค้า" },
                              { "sWidth": "24%", "sTitle": "ชื่อสินค้า" },
                              { "sWidth": "10%", "sTitle": "เลขซีเรียล" },
                              { "sWidth": "20%", "sTitle": "ปัญหาสินค้า", "bSortable": false },
                              { "sWidth": "5%", "sTitle": "ลบ", "bSortable": false },
                    ]  //These are dynamically created columns present in JSON object.
                });
            }
        }

        function delData(SrlID, flag) {
            if (flag == 0) {
                for (index = 0; index < rowDataSet_DAY.length; index++) {
                    if (rowDataSet_DAY[index][4] == SrlID) {
                        rowDataSet_DAY.splice(index, 1);
                        --d_add;
                        //remove data in array
                        found = $.inArray(SrlID, listPro);
                        listPro.splice(found, 1);
                        $('#S' + SrlID).css('visibility', 'hidden').hide().fadeIn('slow');
                        //create tables
                        $('#tChange').dataTable({
                            "bDestroy": true,
                            "bScrollCollapse": true,
                            "bJQueryUI": true,
                            "bPaginate": true,
                            "bInfo": true,
                            "bFilter": true,
                            "bSort": true,
                            "aaData": rowDataSet_DAY,
                            "aoColumns": [
                                      { "sWidth": "7%", "sTitle": "รหัสใบขาย" },
                                      { "sWidth": "7%", "sTitle": "ลำดับใบขาย" },
                                      { "sWidth": "7%", "sTitle": "รหัสสินค้า" },
                                      { "sWidth": "24%", "sTitle": "ชื่อสินค้า" },
                                      { "sWidth": "10%", "sTitle": "เลขซีเรียล" },
                                      { "sWidth": "20%", "sTitle": "เลขซีเรียลที่เปลี่ยน", "bSortable": false },
                                      { "sWidth": "5%", "sTitle": "ลบ", "bSortable": false },
                            ]  //These are dynamically created columns present in JSON object.
                        });
                    }
                }
            } else {
                for (index = 0; index < rowDataSet_Claim.length; index++) {
                    if (rowDataSet_Claim[index][4] == SrlID) {
                        rowDataSet_Claim.splice(index, 1);
                        --c_add;
                        //remove data in array
                        found = $.inArray(SrlID, listPro);
                        listPro.splice(found, 1);
                        $('#S' + SrlID).css('visibility', 'hidden').hide().fadeIn('slow');
                        //create tables
                        $('#tClaim').dataTable({
                            "bDestroy": true,
                            "bScrollCollapse": true,
                            "bJQueryUI": true,
                            "bPaginate": true,
                            "bInfo": true,
                            "bFilter": true,
                            "bSort": true,
                            "aaData": rowDataSet_Claim,
                            "aoColumns": [
                                      { "sWidth": "7%", "sTitle": "รหัสใบขาย" },
                                      { "sWidth": "7%", "sTitle": "ลำดับใบขาย" },
                                      { "sWidth": "7%", "sTitle": "รหัสสินค้า" },
                                      { "sWidth": "24%", "sTitle": "ชื่อสินค้า" },
                                      { "sWidth": "10%", "sTitle": "เลขซีเรียล" },
                                      { "sWidth": "20%", "sTitle": "ปัญหาสินค้า", "bSortable": false },
                                      { "sWidth": "5%", "sTitle": "ลบ", "bSortable": false },
                            ]  //These are dynamically created columns present in JSON object.
                        });
                    }
                }
            }
        }

        var flagSearch = 0;
        function Search() {
            if ($("#input_data").val().length > 3) {
                $.post("<%= Url.Action("GetDataMember","Claim")%>",
                 {
                     INPUT: $("#input_data").val()
                 },
           function (data) {
               $('#Data').html(data);
               //if (flagSearch == 1) {
               //    flagSearch = 0;
               //    rowDataSet_Claim = []; rowDataSet_DAY = [];
               //    listPro = [];
               //    c_add = 0; d_add = 0;
               //    $('#tClaim').dataTable().fnClearTable();
               //    //$('#tClaim').dataTable().fnDestroy();
               //}
               if (flagSearch == 1) {
                   listPro = [];
                   if (rowDataSet_Claim.length > 0) {
                       rowDataSet_Claim = [];
                       c_add = 0;
                       $('#tClaim').dataTable().fnClearTable();
                   }
                   if (rowDataSet_DAY.length > 0) {
                       rowDataSet_DAY = [];
                       d_add = 0;
                       $('#tChange').dataTable().fnClearTable();
                   }
               }
           });
        } else {
            alert("กรอกข้อมูลให้ครบถ้วนถูกต้อง")
        }
    }

    function SendClaim() {
        if (rowDataSet_Claim.length > 0 || rowDataSet_DAY.length > 0) {
            if (rowDataSet_DAY.length > 0) {
                location.reload();
            }
            if (rowDataSet_Claim.length > 0) {
                var win = window.open("<%= Url.Action("MClaimReport", "Claim")%>");
                win.focus();
                location.reload();
            }
        } else {
            alert("ใส่ข้อมูลสินค้าที่จะเคลม")
        }
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
