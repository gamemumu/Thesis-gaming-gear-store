<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.PROMOTION>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    EditPromotion
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
            <h3 class="page-header">แก้ไขโปรโมชั่น</h3>
 <div class="panel panel-primary">
        <div class="panel-heading">
            รายการสินค้า
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-md-12">
                    <table id="example" class="table  table-striped table-condensed" cellspacing="0">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-8">
            <div class="panel panel-primary">
                <div class="panel-heading">สินค้าที่จัดโปรโมชั่น</div>
                <div class="panel-body">
                    <table id="myTableId" class="table table-striped table-condensed" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th>
                                    <%: Html.DisplayName("Product ID") %>
                                </th>
                                <th>
                                    <%: Html.DisplayName("ยี่ห้อ") %>
                                </th>

                                <th>
                                    <%: Html.DisplayName("รุ่น") %>
                                </th>

                                <th>
                                    <%: Html.DisplayName("Action") %>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="panel panel-primary">
                <div class="panel-heading">กำหนดช่วงของวันที่</div>
                <div class="panel-body">
                    <div class="list-group">
                        <span class="range range-primary">
                            <output>วันเริ่มต้น</output>
                            &nbsp
                                    <span class="span12">
                                        <input id="ProMStartDate" type="text" value="" style="width: 200px;" readonly="readonly">
                                    </span>
                        </span>
                    </div>
                    <div class="list-group">
                        <span class="range range-primary">
                            <output>วันสิ้นสุด</output>
                            &nbsp
                                    <span class="span12">
                                        <input id="ProMEndDate" class="input-fix-mousewheel1" type="text" value="" style="width: 200px;" readonly>
                                    </span>
                        </span>
                    </div>
                    <div class="list-group">
                        <span class="range range-primary">
                            <output>ส่วนลด</output>
                            <input id="rangDiscount" type="range" name="range" min="5" max="50" value="25" step="5" onchange="Discount.value=value" />
                            <output id="Discount">25</output>
                            <output>%</output>
                        </span>
                    </div>
                </div>
            </div>
               <%: Html.ActionLink("Back to List", "ListPromotion") %>
            <div class="pull-right" style="padding-right: 1%">
                <button id="btnSendData" onclick="btnSendData()" class="btn btn-success btn-primary">ยืนยัน &nbsp<i class="fa fa-paper-plane fa-lg"></i></button>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    <script type="text/javascript">
        jQuery.validator.addMethod("isValid", function (value, element) {
            var startDate = $('#ProMStartDate').val();
            var finDate = $('#ProMEndDate').val();
            return Date.parse(startDate) < Date.parse(finDate);
        }, "* End date must be after start date");

        var listShow = [];
        jQuery(function () {
            $("#btnSendData").hide();
            $("#myTableId").dataTable({
                "bDestroy": true,
                "bScrollCollapse": true,
                "bJQueryUI": true,
                "bPaginate": false,
                "bInfo": true,
                "bFilter": true,
                "bSort": true,
            });
            jQuery('#ProMStartDate').datetimepicker({
                format: 'Y-m-d',
                onShow: function (ct) {
                    this.setOptions({
                        maxDate: jQuery('#ProMEndDate').val() ? jQuery('#ProMEndDate').val() : false
                    })
                },
                timepicker: false
            });
            jQuery('#ProMEndDate').datetimepicker({
                format: 'Y-m-d',
                onShow: function (ct) {
                    this.setOptions({
                        minDate: jQuery('#ProMStartDate').val() ? jQuery('#ProMStartDate').val() : false
                    })
                },
                timepicker: false
            });

            $.ajax({
                type: "GET",
                url: "<%= Url.Action("JsonGetPromotionEdit","Promotion")%>",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: { id: "<%= Model.ProMID%>" },
                success: function (result) {
                    $("#ProMStartDate").val(result[0].ProMStartDate)
                    $("#ProMEndDate").val(result[0].ProMEndDate)
                    $("#Discount").val(result[0].Discount)
                    var i = 0;
                    $.each(result, function () {
                        AddProduct(result[i].PrdID, result[i].TrdName, result[i].BrandName);
                        listShow.push(result[i].PrdID);
                        i++;
                    });
                },
            });
            getData();
        });

        function btnSendData() {
            var startDate = $('#ProMStartDate').val();
            var finDate = $('#ProMEndDate').val();
            if (Date.parse(startDate) < Date.parse(finDate)) {
                if (($("#ProMStartDate").val() != "") && ($("#ProMEndDate").val()) != "" && listPro.length > 0) {
                    var MultiOjb = [];
                    var rows = [];
                    var head = []; d_head = { ProMStartDate: $("#ProMStartDate").val(), ProMEndDate: $("#ProMEndDate").val(), Discount: $("#Discount").val(), ProMID: "<%= Model.ProMID%>" };
                    head.push(d_head)

                    $('input[type="range"].input-validation-error').addClass('input-validation-valid');
                    $('input[type="range"].input-validation-error').removeClass('input-validation-error');

                    $('#myTableId tbody tr ').each(function () {
                        rows.push(
                            $(this).find('td:eq(0)').text()
                        );
                    });
                    MultiOjb.push({
                        PROMOTION: head,
                        rows: rows
                    })
                $.ajax({
                        type: "POST",
                        url: "<%= Url.Action("EditPromotion","Promotion")%>",
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify(MultiOjb),
                        success: function (result) {
                            if (result.success) { location.reload(); }
                            else { alert("เกิดข้อผิดผลาดในการทำงาน:"); }
                        },
                    });
                } else {
                    alert("กรุณากรอกข้อมูลให้ครบถ้วน");
                }
            } else {
                alert("*กรุณาตรวจสอบ ช่วงของวันที่ ให้เรียบร้อย");
            }
        }

        var rowDataSet_ADD = [];
        var listPro = [];
        var k_add = 0; var flag = 0;
        function AddProduct(prd, trd, brand) {
            var bind = prd;
            if (listPro.length == 0) {
                listPro.push(bind);
                $("#btnSendData").show();
            } else {
                for (ii = 0; ii < listPro.length; ii++) {
                    if (bind == listPro[ii]) {
                        alert("มีข้อมูลอยู่แล้ว")
                        return;
                    }
                }
                listPro.push(bind);
            }
            $('#S' + prd).css('visibility', 'visible').hide().fadeIn('slow');

            var rowData = [];
            rowData[0] = prd;
            rowData[1] = trd;
            rowData[2] = brand;
            rowData[3] = '<button id=d' + prd + '" class="btn btn-inverse btn-danger" onclick="delData(\'' + prd + '\')">Delete</button>';
            rowDataSet_ADD[k_add++] = rowData;

            $('#myTableId').dataTable({
                "bDestroy": true,
                "bJQueryUI": true,
                "bPaginate": false,
                "sScrollY": 300,
                "sScrollHeadInner": true,
                "bInfo": true,
                "bFilter": true,
                //  "bSort": false,
                "aaData": rowDataSet_ADD,
                "aoColumns": [
                          { "sWidth": "7%", "sTitle": "Product ID" },
                          { "sWidth": "10%", "sTitle": "ยี่ห้อ", "bSortable": false },
                          { "sWidth": "20%", "sTitle": "รุ่นสินค้า", "bSortable": false },
                          { "sWidth": "7%", "sTitle": "Action", "sClass": "right", "bSortable": false },
                ]  //These are dynamically created columns present in JSON object.
            });
        }

        function delData(prd) {
            for (index = 0; index < rowDataSet_ADD.length; index++) {
                if (rowDataSet_ADD[index][0] == prd) {
                    rowDataSet_ADD.splice(index, 1);
                    --k_add;
                    //remove data in array
                    found = $.inArray(prd, listPro);
                    listPro.splice(found, 1);
                    $('#S' + prd).css('visibility', 'hidden').hide().fadeIn('slow');
                    //create tables
                    $('#myTableId').dataTable({
                        "bDestroy": true,
                        "bJQueryUI": true,
                        "bPaginate": false,
                        "sScrollY": "90%",
                        "sScrollHeadInner": true,
                        "bInfo": true,
                        "bFilter": true,
                        //  "bSort": false,
                        "aaData": rowDataSet_ADD,
                        "aoColumns": [
                                  { "sWidth": "7%", "sTitle": "Product ID" },
                                  { "sWidth": "10%", "sTitle": "ยี่ห้อ", "bSortable": false },
                                  { "sWidth": "20%", "sTitle": "รุ่นสินค้า", "bSortable": false },
                                  { "sWidth": "7%", "sTitle": "Action", "sClass": "right", "bSortable": false },
                        ]  //These are dynamically created columns present in JSON object.
                    });
                }
            }
        }

        function getData() {
            $('#example thead').empty();
            var checkID = "";
            var checkID = "";
            $.ajax({
                type: 'POST',
                url: "<%= Url.Action("JsonGetListForOffer","Products") %>", // we are calling json method
                dataType: 'json',
                success: function (obj) {

                    //  console.log(JSON.stringify(obj));
                    var JSONResult = JSON.stringify(obj);
                    var parseJSONResult = jQuery.parseJSON(JSONResult);

                    if (parseJSONResult != null && parseJSONResult.length > 0) {
                        var rowDataSet = [];
                        var i = 0;
                        $.each(parseJSONResult, function (key, value) {
                            var rowData = [];
                            // rowData[0] = '<input type="checkbox" class="checkthis" name="case[]"  />';
                            $.each(parseJSONResult[i], function (key, value) {
                                if (key == "PrdID") {
                                    var found = $.inArray(value, listShow);
                                    if(found >= 0){
                                        rowData[0] = '<i id="S' + value + '"style="color:green; visibility:visible;" class="fa fa-check-square-o fa-lg"></i>';
                                    } else{
                                        rowData[0] = '<i id="S' + value + '"style="color:green; visibility:hidden;" class="fa fa-check-square-o fa-lg"></i>';
                                    }
                                    rowData[1] = value;
                                }
                                else if (key == "TypeName")
                                    rowData[2] = value;
                                else if (key == "TrdName")
                                    rowData[3] = value;
                                else if (key == "BrandName")
                                    rowData[4] = value;
                                else if (key == "ClrName")
                                    rowData[5] = value;
                                else if (key == "PrdStatus")
                                    rowData[6] = value;
                                else if (key == "Waranty")
                                    rowData[7] = value;
                                else if (key == "Filepath")
                                    rowData[8] = '<img src="' + value + '" alt="alt" height="40" width="60">';
                                else if (key == "amount") {
                                    rowData[9] = value;
                                    rowData[10] = '<button id="' + rowData[1] + '" class="btn btn-inverse btn-primary" onclick="AddProduct(\'' + rowData[1] + '\',\'' + rowData[3] + '\',\'' + rowData[4] + '\')" >เพิ่ม &nbsp <i class="fa fa-plus"></i></button>';
                                }
                            });
                            rowDataSet[i] = rowData;
                            i++;
                        });
                        $('#example').DataTable({
                            "bDestroy": true,
                            //"bScrollCollapse": true,
                            //"bAutoWidth": true,
                            "bJQueryUI": true,
                            "bPaginate": true,
                            "iDisplayLength": 5,
                            // "sScrollY": ($(window).height() - 300),
                            "sScrollY": "100%",
                            //"sScrollX": "100%",
                            //"sScrollXInner": "100%",
                            "sScrollHeadInner": false,
                            "bInfo": true,
                            "bFilter": true,
                            "bSort": true,
                            "aaSorting": [[1, "asc"]],
                            "aaData": rowDataSet,
                            "aoColumns": [
                            { "sWidth": "3%", "sTitle": "#", "bSortable": false },
                           { "sWidth": "10%", "sTitle": "Product ID" },
                           { "sWidth": "10%", "sTitle": "ประเภทสินค้า" },
                           { "sWidth": "10%", "sTitle": "ยี่ห้อ" },
                           { "sWidth": "20%", "sTitle": "รุ่นสินค้า" },
                           { "sWidth": "10%", "sTitle": "สี" },
                           { "sWidth": "8%", "sTitle": "สถานะสินค้า", "sClass": "center" },
                           { "sWidth": "7%", "sTitle": "Waranty(Y)", "sClass": "center" },
                           { "sWidth": "5%", "sTitle": "Photo" },
                            { "sWidth": "9%", "sTitle": "จำนวนคงเหลือ", "sClass": "right" },
                             { "sWidth": "5%", "sTitle": "    " },
                            ]  //These are dynamically created columns present in JSON object.
                        });
                    } else {
                        $('#example').empty();
                    }
                    $(".dataTables_scrollHeadInner").css({ "padding-left": '0' });
                },
                error: function (ex) {
                    alert('Failed to retrieve JsonListBrand' + ex);
                }
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
    <script src="<%: Url.Content("~/Scripts/moment.min.js") %>" type="text/javascript"></script>
    <link href="../../Content/Range.css" rel="stylesheet" />
</asp:Content>
