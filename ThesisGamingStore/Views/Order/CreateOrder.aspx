<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.OfferModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    CreateOrder
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <h3 class="page-header">จัดการสั่งซื้อสินค้า</h3>
    <div class="row">
        <div class="col-md-12">
            <div class="bs-example" data-content="Example Header">
                <hr />

                <div class="row">
                    <div class="col-md-5 pull-left" id="SupSel">
                        <h4><span class="label label-warning">Supplier</span>
                            <%: Html.DropDownListFor(model => model.SupID, new SelectList(Enumerable.Empty<SelectListItem>()), new { style = "width:50%;height:25px;font-size:70%"  })%></h4>
                        <%: Html.ValidationMessageFor(model => model.SupID) %>
                    </div>
                </div>
                <table id="ListOff" class="table table-hover table-striped table-condensed" cellspacing="0">
                    <thead>
                        <tr>
                            <th style="width: 10%">
                                <%: Html.DisplayName("Offer ID") %>
                            </th>
                            <th style="width: 10%">
                                <%: Html.DisplayName("Emp ID") %>
                            </th>
                            <th style="width: 15%">
                                <%: Html.DisplayName("ผู้เสนอ") %>
                            </th>
                            <th style="width: 15%">
                                <%: Html.DisplayName("ผู้อนุมัติ") %>
                            </th>
                            <th style="width: 20%">
                                <%: Html.DisplayName("บริษัทคู่ค้า") %>
                            </th>
                            <th style="width: 10%">
                                <%: Html.DisplayName("วันที่เสนอ") %>
                            </th>
                            <th style="width: 10%">
                                <%: Html.DisplayName("สถานะ") %>
                            </th>
                            <th style="width: 10%">
                                <%: Html.DisplayName("Action") %>
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                    <tfoot>
                    </tfoot>
                </table>
            </div>
            <%--## Send json ##--%>
          <%--  <div class="pull-right">
                <button type="button" class="btn btn-block btn-primary" data-toggle="modal" data-target="#orderModal" onclick="btnT()">ทำรายการสั่งซื้อ &nbsp <i class="fa fa-shopping-cart"></i></button>
            </div>--%>
        </div>
    </div>
    <br />

    <div id="showDetails">
        <h4>แสดงสินค้าที่ผ่านอนุมัติ</h4>
        <div class="row">
            <div class="col-md-6">
                <h5 id="showOffer">รหัสใบเสนอ : </h5>
            </div>
            <div class="col-md-6 pull-right">
                <h5 id="showSup">บริษัท : </h5>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-striped table-condensed" id="tbl_showDetails" style="width: 100%">
                    <thead>
                        <tr>
                            <th>
                                <%: Html.DisplayName("No") %>
                            </th>
                            <th>
                                <%: Html.DisplayName("ProductID") %>
                            </th>
                            <th>
                                <%: Html.DisplayName("ประเภท") %>
                            </th>
                            <th>
                                <%: Html.DisplayName("ยี่ห้อ") %>
                            </th>
                            <th>
                                <%: Html.DisplayName("รุ่น") %>
                            </th>
                            <th>
                                <%: Html.DisplayName("สี") %>
                            </th>
                            <th>
                                <%: Html.DisplayName("ราคา") %>
                            </th>
                            <th>
                                <%: Html.DisplayName("จำนวนที่เสนอ") %>
                            </th>
                            <th>
                                <%: Html.DisplayName("จำนวนที่อนุมัติ") %>
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
                <div class="pull-right" style="padding-right: 15px">
                    <div>ราคารวม :<span id="tblSubTotal">0.00</span> &nbsp Bath</div>
                </div>
                <br />
                <div class="pull-right" style="padding-right: 15px">
                    <div>TAX 7% :<span id="tblCalTax">0.00</span> &nbsp Bath</div>
                </div>
                <br />
                <div class="pull-right" style="padding-right: 15px">
                    <div>ราคารวมทั้งหมด :<span id="tblGrandTotal">0.00</span> &nbsp Bath</div>
                </div>
                <br />
                <div class="modal-footer ">
                    <button class="btn  btn-default" onclick="btnClr()">ปิด</button>
                </div>
            </div>
        </div>
    </div>

    <%--   <!-- ModalList Product from Offer -->
    <div class="modal  fade in" id="edit-person" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div id="edit-person-container" class="modal-dialog modal-lg"></div>
    </div>--%>


    <!-- ModalOrder -->
    <div class="modal fade" id="orderModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog  modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title" id="myModalLabel">รายการใบสั่งซื้อที่เลือก</h4>
                    <%--<p class="pull-right"><%= ViewBag.DateNowOrder %></p>--%>
                    <br />
                </div>
                <div class="modal-body">
                    .....
                </div>
                <div id="DataTT">
                    <div class="pull-right" style="padding-right: 15px">
                        <%--TAX 7% : <%=tax%> Baht--%>
                        <div>ราคารวม :<span id="modalOSubTotal">0.00</span> &nbsp Bath</div>
                    </div>
                    <br />
                    <div class="pull-right" style="padding-right: 15px">
                        <%--TAX 7% : <%=tax%> Baht--%>
                        <div>TAX 7% :<span id="modalOCalTax">0.00</span> &nbsp Bath</div>
                    </div>
                    <br />
                    <div class="pull-right" style="padding-right: 15px">
                        <%--ราคารวมทั้งหมด : <%=total-tax%> Baht--%>
                        <div>ราคารวมทั้งหมด :<span id="modalOGrandTotal">0.00</span> &nbsp Bath</div>
                    </div>
                    <br />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <%--<button type="button" class="btn btn-primary">Save changes</button>--%>
                    <button type="button" id="btnOrder" class="btn btn-primary" onclick="btnSend()">ยืนยันการสั่งซื้อ &nbsp<i class="fa fa-shopping-cart fa-1x"></i></button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    <script type="text/javascript">

        $(document).ready(function () {
            $("#showDetails").hide();
            $('#myTableId tbody').empty();
            $('.bs-example').attr('data-content', "รายการใบเสนอที่ผ่านอนุมัติ ");
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

            function getData(sup) {
                if ($("#SupID").val() != 0) {
                    // ดึ่ง ใบเสนอจากไอดีบริษัทคู่ค้า
                    $('#tbl_showDetails tbody').empty();
                    $("#ListOff").dataTable({
                        "bDestroy": true,
                        "bScrollCollapse": true,
                        "bJQueryUI": true,
                        "bPaginate": false,
                        "bInfo": true,
                        "bFilter": true,
                        "bSort": true,
                    });
                    $("#showDetails").hide();
                    $.ajax({
                        type: 'POST',
                        url: "<%= Url.Action("JsonOffApprove","Order") %>", // we are calling json method
                        dataType: 'json',
                        data: { id: $("#SupID").val() },
                        success: function (obj) {

                            // $('#ListOff tbody').empty();
                            console.log(JSON.stringify(obj));
                            var JSONResult = JSON.stringify(obj);
                            var parseJSONResult = jQuery.parseJSON(JSONResult);

                            if (parseJSONResult != null && parseJSONResult.length > 0) {
                                var rowDataSet = [];
                                var i = 0;
                                $.each(parseJSONResult, function (key, value) {
                                    var rowData = [];
                                    var j = 0;
                                    // rowData[0] = '<input type="checkbox" class="checkthis" name="case[]"  />';
                                    //rowData[0] = '<input type="checkbox" class="checkthis" name="case[]"  />';
                                    $.each(parseJSONResult[i], function (key, value) {
                                        if (key == "OffID")
                                            rowData[0] = value;
                                        else if (key == "EmpID")
                                            rowData[1] = value;
                                        else if (key == "EmpName")
                                            rowData[2] = value;
                                        else if (key == "EmpApprove")
                                            rowData[3] = value;
                                        else if (key == "SupName")
                                            rowData[4] = value;
                                        else if (key == "OffDate")
                                            rowData[5] = value;
                                        else if (key == "OffStatus")
                                            rowData[6] = value;
                                        else
                                            rowData[7] = '<button type="button" class="btn btn-block btn-primary btn-sm" data-toggle="modal" data-target="#orderModal" onclick="btnT(\'' + rowData[0] + '\')">ทำรายการสั่งซื้อ &nbsp <i class="fa fa-shopping-cart"></i></button>'
                                            //rowData[7] = '<a href="#tbl_showDetails"><input type="button" class="btn btn-sm btn-primary" value="ดูรายการสินค้า" onClick="btnDetails(\'' + rowData[0] + '\',\'' + rowData[4] + '\')" /></a>'
                                        // j++;
                                    });
                                    rowDataSet[i] = rowData;
                                    i++;
                                });
                                //สร้างตารางแสดงรายการ ใบเสนอที่อนุมัติ
                                $('#ListOff').DataTable({
                                    "bDestroy": true,
                                    "bJQueryUI": true,
                                    "bPaginate": false,
                                    "sScrollY": "100%",
                                    "sScrollHeadInner": true,
                                    "bInfo": true,
                                    "bFilter": true,
                                    "aaData": rowDataSet,
                                    "aaSorting": [[5, 'desc']],
                                    "aoColumns": [
                                   { "sWidth": "10%", "sTitle": "Offer ID" },
                                    { "sWidth": "10%", "sTitle": "Emp ID" },
                                    { "sWidth": "15%", "sTitle": "ผู้เสนอ" },
                                    { "sWidth": "15%", "sTitle": "ผู้อนุมัติ" },
                                    { "sWidth": "20%", "sTitle": "บริษัทคู่ค้า" },
                                    { "sWidth": "10%", "sTitle": "วันที่เสนอ" },
                                    { "sWidth": "10%", "sTitle": "สถานะ" },
                                    { "sWidth": "10%", "sTitle": "" }]
                                });
                            } else {
                                var rowDataSet = [];
                                $('#ListOff').DataTable({
                                    "bDestroy": true,
                                    "bJQueryUI": true,
                                    "bPaginate": false,
                                    "sScrollY": "100%",
                                    "sScrollHeadInner": true,
                                    "bInfo": true,
                                    "bFilter": true,
                                    "aaData": rowDataSet,
                                    "aaSorting": [[5, 'desc']],
                                    "aoColumns": [
                                   { "sWidth": "10%", "sTitle": "Offer ID" },
                                    { "sWidth": "10%", "sTitle": "Emp ID" },
                                    { "sWidth": "15%", "sTitle": "ผู้เสนอ" },
                                    { "sWidth": "15%", "sTitle": "ผู้อนุมัติ" },
                                    { "sWidth": "20%", "sTitle": "บริษัทคู่ค้า" },
                                    { "sWidth": "10%", "sTitle": "วันที่เสนอ" },
                                    { "sWidth": "10%", "sTitle": "สถานะ" },
                                    { "sWidth": "10%", "sTitle": "" }]
                                });
                            }
                        },
                        error: function (ex) {
                            alert('Failed to retrieve JsonListBrand' + ex);
                        }
                    });
                }
            }

            $("#SupID").change(function () {
                getData($("#SupID").val());
            });
        }); //doc ready

        function btnT(OffID) {
            // ########### MODAL BODY #################
            var obj = [];
           // tmpObj = { OffID: "", EmpID: "", EmpName: "", EmpApprove: "", SupName: "", OffDate: "", OffStatus: "" };
            var index = 0;
            var _OffID = [];
            var _sum = 0;
            $(".modal-body").html('<table id="myTableId"  class="table table-striped table-condensed" ><thead><th>ลำดับ</th><th> รหัสใบเสนอ </th><th> รหัสสินค้า </th><th> ประเภท </th><th> ยี่ห้อสินค้า </th><th> รุ่นสินค้า </th><th> ราคา/หน่วย </th><th> จำนวน </th><th>รวมราคา</th></thead><tbody></tbody><tfoot></tfoot></table>');
            //var checkLenght = $('#ListOff  > tbody  > tr ').each(function () {
            //    tmpObj = { OffID: "" };
            //   tmpObj.OffID = $.trim($(this).find('td:first').text()).split(/\r\n|\r|\n/g).toString();
            //    _OffID.push($.trim($(this).find('td:first').text()).split(/\r\n|\r|\n/g).toString());
            //    obj.push(tmpObj);
            //});
            tmpObj = { OffID: "" };
            tmpObj.OffID = OffID;
            obj.push(tmpObj);
                $("#DataTT").show();
                $("#btnOrder").show();
                var jsonstring = JSON.stringify(obj);
                console.log(jsonstring);
                var runno = 1;
                var sumTotal = 0;
                var tax = 0;
                $.ajax({
                    type: 'POST',
                    url: "<%= Url.Action("JsonOrderDetailsList","Order") %>", // we are calling json method
                    dataType: 'json',
                    data: jsonstring,
                    success: function (data) {
                        // console.log(data);
                        $('#TotalData').html("");
                        $.each(data, function (objindex1, value1) {
                            $.each(value1, function (objindex2, value2) {
                                //สร้าง Modal แสดงรายการสินค้าที่เลือก ที่จะสั่งซื้อ
                                if (value1[objindex2].AmountApprove > 0) {
                                    $('#myTableId tbody').append(
                                         '<tr>'
                                         + '<td>' + runno                                                                //0
                                         + '</td><td>' + value1[objindex2].OffID                                          //1
                                         + '</td><td class="hide">' + value1[objindex2].OfdNo                             //2
                                         + '</td><td>' + value1[objindex2].PrdID                                          //3
                                         + '</td><td>' + value1[objindex2].TypeName                                      //4
                                         + '</td><td>' + value1[objindex2].TrdName                                       //5
                                         + '</td><td>' + value1[objindex2].BrandName                                      //6
                                       //  + '</td><td>' + value1[objindex2].ClrName                                  //7
                                         + '</td><td>' + (value1[objindex2].Cost).toFixed(2)                                         //8
                                       //  + '</td><td>' + value1[objindex2].AmountPost                                  //9
                                         + '</td><td>' + value1[objindex2].AmountApprove                                      //10
                                         + '</td><td>' + (value1[objindex2].Cost * value1[objindex2].AmountApprove).toFixed(2)     //11
                                         + '</td></tr>');
                                    sumTotal += (value1[objindex2].Cost * value1[objindex2].AmountApprove);
                                    runno++;
                                }
                            });
                        });
                        tax = (sumTotal * 0.07).toFixed(2);
                        $("#modalOSubTotal").html(sumTotal.toFixed(2));
                        $("#modalOCalTax").html(tax);
                        var grand = (parseFloat(sumTotal) + parseFloat(tax)).toFixed(2);
                        $("#modalOGrandTotal").html(grand)
                        // $('#TotalData').html(sumTotal);
                    },
                    error: function (ex) {
                        alert('Failed to retrieve JsonOrderDetails' + ex);
                    }
                });
        }


        function btnDetails(oid, sn) {
            var sum = 0;
            var tax = 0;
            $('#tbl_showDetails tbody').empty();
            $("#showDetails").show();
            $.ajax({
                type: 'POST',
                url: "<%= Url.Action("JsonOrderDetails","Order") %>", // we are calling json method
                dataType: 'json',
                data: { id: oid, SupName: sn },
                success: function (data) {
                    console.log(data);
                    $.each(data, function (index, value) {
                        $('#tbl_showDetails tbody').append(
                             '<tr>'
                             + '<td>' + data[index].OfdNo
                             + '</td><td>' + data[index].PrdID
                             + '</td><td>' + data[index].TypeName
                             + '</td><td>' + data[index].TrdName
                             + '</td><td>' + data[index].BrandName
                             + '</td><td>' + data[index].ClrName
                             + '</td><td>' + data[index].Cost
                             + '</td><td>' + data[index].AmountPost
                             + '</td><td>' + data[index].AmountApprove
                             + '</td></tr>');
                        sum += (data[index].Cost * data[index].AmountApprove);
                    });
                    $("#showOffer").html("รหัสใบเสนอ : " + data[0].OffID);
                    $("#showSup").html("บริษัท : " + data[0].SupName)
                    //$("#totalcost").html("Total : " + sum);

                    tax = (sum * 0.07).toFixed(2);
                    $("#tblSubTotal").html(sum.toFixed(2));
                    $("#tblCalTax").html(tax);
                    var grand = (parseFloat(sum) + parseFloat(tax)).toFixed(2);
                    $("#tblGrandTotal").html(grand)
                },
                error: function (ex) {
                    alert('Failed to retrieve JsonOrderDetails' + ex);
                }
            });
        }

        function btnSend() {
            //var datatable = $('#myTableId').tableToJSON();
            //console.log(datatable)
            var MultiOjb = [];
            var _SupID = []; var tmpObj = { SupID: "" }; tmpObj.SupID = $("#SupID").val().toString();
            var _Total2 = []; var tmpTObj = { SubTotal: "", Tax: "", Total: "" }; tmpTObj.SubTotal = $("#modalOSubTotal").text(); tmpTObj.Tax = $("#modalOCalTax").text(); tmpTObj.Total = $("#modalOGrandTotal").text();
            _SupID.push(tmpObj);
            _Total2.push(tmpTObj);
            var _Total = [];
            var sum = 0;
            var rows = [];
            $('#myTableId tbody tr ').each(function () {
                rows.push({
                    OrdNo: $(this).find('td:eq(0)').text(),
                    OffID: $(this).find('td:eq(1)').text(),
                    OfdNo: $(this).find('td:eq(2)').text(),
                    PrdID: $(this).find('td:eq(3)').text(),
                    AmountApprove: $(this).find('td:eq(8)').text(),
                    // TypeName: $(this).find('td:eq(4)').text(),
                    // TrdName: $(this).find('td:eq(5)').text(),
                    // BrandName: $(this).find('td:eq(6)').text(),
                    // ClrName: $(this).find('td:eq(7)').text(),
                    // Cost: $(this).find('td:eq(8)').text(),
                    // AmountPost: $(this).find('td:eq(9)').text(),
                    // AmountApprove: $(this).find('td:eq(10)').text(),
                });
            });

            MultiOjb.push({
                SupID: _SupID,
                dataTable: rows,
                Total: _Total2,
            });
            console.log(JSON.stringify(MultiOjb));
            event.preventDefault();

            $.ajax({
                type: "POST",
                url: "<%= Url.Action("CreateOrder","Order")%>",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(MultiOjb),
                success: function () {
                    $('#orderModal').modal('hide');
                 //   var win = window.open("<%= Url.Action("OrderReport", "Order")%>", 'mywindow', 'fullscreen=yes, scrollbars=auto');
                    var win = window.open("<%= Url.Action("OrderReport", "Order")%>");
                    win.focus();
                    //Refresh
                    location.reload();
                },
                error: function () { alert("คุณทำการสั่่งซื้อไม่สำเร็จกรุณาทำใหม่อีกครั้ง"); }
            });
        }

        function btnClr() {
            $("#showDetails").hide();
        }


        <%--function btnT() {
            var obj = [];
            tmpObj = { OffID: "", EmpID: "", EmpName: "", EmpApprove: "", SupName: "", OffDate: "", OffStatus: "" };
            var index = 0;
            var _Total = [];
            var _sum = 0;
            if ($("input[name='case[]']:checked").length === 0) {
                //alert("Select at least one product")
                $(".modal-body").html("กรุณาเลือกรายการที่จะสั่งซื้อ !!")
                $("#btnOrder").hide();
            } else {
                $("#btnOrder").show();
                $(".modal-body").html('<table id="myTableId"  class="table table-striped table-condensed" ><thead><th>ลำดับ</th><th> รหัสใบเสนอ </th><th> รหัสพนักงาน </th><th> ผู้เสนอ </th><th> ผู้อนุมัติ </th><th> บริษัทคู่ค้า </th><th> วันที่เสนอ </th><th> สถานะ </th></thead><tbody></tbody><tfoot></tfoot></table>');
                $.each($("input[name='case[]']:checked").closest("td").siblings("td"),
                      function () {
                          if (index % 8 == 0) {
                              tmpObj = { OffID: "", EmpID: "", EmpName: "", EmpApprove: "", SupName: "", OffDate: "", OffStatus: "" };
                              tmpObj.OffID = $.trim($(this).text()).split(/\r\n|\r|\n/g).toString();
                              _Total.push($.trim($(this).text()).split(/\r\n|\r|\n/g).toString());
                          }
                          else if (index % 8 == 1)
                              tmpObj.EmpID = $.trim($(this).text()).split(/\r\n|\r|\n/g).toString();
                          else if (index % 8 == 2)
                              tmpObj.EmpName = $.trim($(this).text()).split(/\r\n|\r|\n/g).toString();
                          else if (index % 8 == 3)
                              tmpObj.EmpApprove = $.trim($(this).text()).split(/\r\n|\r|\n/g).toString();
                          else if (index % 8 == 4)
                              tmpObj.SupName = $.trim($(this).text()).split(/\r\n|\r|\n/g).toString();
                          else if (index % 8 == 5)
                              tmpObj.OffDate = $.trim($(this).text()).split(/\r\n|\r|\n/g).toString();
                          else if (index % 8 == 6) {
                              tmpObj.OffStatus = $.trim($(this).text()).split(/\r\n|\r|\n/g).toString();
                              obj.push(tmpObj);
                          }
                          index++;
                      });
                $("#example input[type=checkbox]:checked").each(function () {
                    $(this).prop("checked", false);
                });

                // for get total cost
                $.ajax({
                    type: 'POST',
                    url: "<%= Url.Action("JsonGetTotal","Order") %>", // we are calling json method
                    dataType: 'json',
                    data: JSON.stringify(_Total),
                    success: function (data) {
                        _sum = data;
                        $('#TotalData').html(_sum);
                    },
                    error: function (ex) {
                        alert('Failed to retrieve JsonGetTotal' + ex);
                    }
                });
                var jsonstring = JSON.stringify(obj);
                console.log(jsonstring);
                $('#myTableId tbody').empty();
                //สร้าง Modal แสดงรายการสินค้าที่เลือก ที่จะสั่งซื้อ
                $.each(obj, function (index, value) {
                    $('#myTableId tbody').append(
                             '<tr><td>' + (index + 1)
                             + '</td><td>' + obj[index].OffID
                             + '</td><td>' + obj[index].EmpID
                             + '</td><td>' + obj[index].EmpName
                             + '</td><td>' + obj[index].EmpApprove
                             + '</td><td>' + obj[index].SupName
                             + '</td><td>' + obj[index].OffDate
                             + '</td><td>' + obj[index].OffStatus
                             + '</td></tr>');
                });
            }
        }--%>

        $(function () {

            ////Optional: turn the chache off
            $.ajaxSetup({ cache: false });

            $('.edit-person').click(function () {
                //var url = "/Bootstrap/EditPerson"; // the url to the controller
                var id = $(this).attr('id');

                $('#edit-person-container').load(this.href, function () {
                    $('#edit-person').modal({
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
                        if (result.success) {
                            $('#edit-person').modal('hide');
                            //Refresh
                            location.reload();
                        } else {
                            $('#edit-person-container').html(result);
                            bindForm();

                        }
                    }
                });
                return false;
            });
        }
    </script>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <script src="<%: Url.Content("~/Scripts/jquery.dataTables.min.js") %>" type="text/javascript"></script>
    <link href="/Content/bootstrap.css" rel="stylesheet" type="text/css" />
    <%--  <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/plug-ins/9dcbecd42ad/integration/bootstrap/3/dataTables.bootstrap.css">
    <script type="text/javascript" language="javascript" src="//cdn.datatables.net/plug-ins/9dcbecd42ad/integration/bootstrap/3/dataTables.bootstrap.js"></script>--%>

    <script src="../../Scripts/dataTables.bootstrap.js"></script>
    <script src="../../Scripts/jquery.tabletojson.min.js"></script>
    <%-- 	<script type="text/javascript" language="javascript" src="//cdn.datatables.net/1.10.4/js/jquery.dataTables.min.js"></script>--%>
    <script src="<%: Url.Content("~/Scripts/cdn.datatables.net/plug-ins/input.js") %>" type="text/javascript"></script>
    <script src="<%: Url.Content("~/Scripts/cdn.datatables.net/plug-ins/scrolling.js") %>" type="text/javascript"></script>
    <script src="<%: Url.Content("~/Scripts/cdn.datatables.net/plug-ins/select.js") %>" type="text/javascript"></script>
    <link href="../../Content/css/jquery.dataTables.css" rel="stylesheet" />
    <link href="../../Content/css/docs.min.css" rel="stylesheet" />
</asp:Content>
