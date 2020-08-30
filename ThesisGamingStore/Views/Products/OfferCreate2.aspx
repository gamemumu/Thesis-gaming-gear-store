<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.OfferModel>" %>

<%@ Import Namespace="ThesisGamingStore.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    OfferCreate
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">




    <p>
        <h4><%: Html.ActionLink("Create Product", "ProductCreate") %></h4>
    </p>
    <div class="row">
        <div class="col-md-12">
            <div class="col-md-5">
                <div class="alert alert-success" id="alert-success">
                    <a href="#" class="close" data-dismiss="alert">&times;</a>
                    <strong>Success!</strong> Your message has been sent successfully.
                </div>
                <div class="alert alert-warning" id="alert-warning">
                    <a href="#" class="close" data-dismiss="alert">&times;</a>
                    <strong>Warning!</strong> Pleses select product for offer.
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-5 pull-left" id="SupSel">
            <h4><span class="label label-warning">Supplier</span>
                <%: Html.DropDownListFor(model => model.SupID, new SelectList(Enumerable.Empty<SelectListItem>()), new { style = "width:50%;height:25px;font-size:70%"  })%></h4>
            <%: Html.ValidationMessageFor(model => model.SupID) %>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <table id="example" class="table  table-striped table-condensed" cellspacing="0">
                <%--class="table table-hover table-condensed table-striped" style="width:100%">--%>
                <thead>
                    <tr>
                        <th style="width: 2%"></th>
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

                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>


            <%--## Send json ##--%>
            <%--<div class="text-center">--%>
                <%--<button id="btnT" onclick="btnT()"><i class="fa fa-arrow-circle-down fa-lg">&nbsp Send ProductList</i></button>--%>
               <%--    <a class="btn btn-inverse btn-primary" href="#headmyTableID" id="btnT" onclick="btnT()">ไปขั้นตอนต่อไป &nbsp<i class="fa fa-arrow-circle-right fa-lg"> &nbsp</i></a>
              </div>--%>
        </div>
    </div>
    <br />
    <div class="row">

        <div class="col-md-12">
            <legend id="headmyTableID">&nbsp รายการสินค้าที่กำลังดำเนินการเสนอ</legend>
            <div class="row">
                <div class="col-md-12 text-center">
                    <h4><span class="label label-primary">รหัส : <%:ViewBag.EmpID %>  &nbsp ผู้เสนอ : <%:ViewBag.EmpFname %>  &nbsp วันที่ : <%:ViewBag.DateNow %></span></h4>
                </div>
            </div>


            <table id="myTableId" class="table table-striped table-condensed" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <%--<th style="width: 3%">#</th>--%>
                        <th style="width: 10%">
                            <%: Html.DisplayName("รหัสคู่ค้า") %>
                        </th>
                        <th>
                            <%: Html.DisplayName("Product ID") %>
                        </th>
                        <th>
                            <%: Html.DisplayName("ประเภทสินค้า") %>
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

                        <th style="width: 10%">
                            <%: Html.DisplayName("ระยะประกัน") %>
                        </th>

                        <th style="width: 7%">
                            <%: Html.DisplayName("ราคา/หน่วย") %>
                        </th>
                        <th style="width: 7%">
                            <%: Html.DisplayName("จำนวน(ชื้น)") %>
                        </th>
                        <th style="width: 7%">
                            <%: Html.DisplayName("รวม") %>
                        </th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            <div class="pull-right">
                <div style="text-align:right">ราคารวม : &nbsp<span id="subTotal">0.00</span></div>
                <div style="text-align:right">TAX 7% : &nbsp<span id="calTax">0.00</span></div>
                 <div style="text-align:right">ราคารวมทั้งหมด : &nbsp<span id="grandTotal">0.00</span></div>
            </div>
        </div>
        <div class="pull-right" style="padding-right:1%">
             <button id="btnSendData" onclick="btnSendData()" class="btn btn-danger btn-primary">Confirm OFFER &nbsp<i class="fa fa-paper-plane fa-lg"></i></button>
                </div>
        <%-- <div class="col-md-5">
            <div class="bs-example" data-content="Example Header">
                <div class="row">
                    <div class="col-sm-12">
                        <span  id="_loading"><i class="fa fa-refresh fa-spin fa-lg"></i></span>
                        <p id="_ShowLog"></p>
                    </div>
                </div>
            </div>
        </div>--%>
       
    </div>






</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#btnSendData').hide();
            $("#myTableId").dataTable({
                "bDestroy": true,
                "bScrollCollapse": true,
                "bJQueryUI": true,
                "bPaginate": false,
                "bInfo": true,
                "bFilter": true,
                "bSort": true,
            });

            $.ajax({
                type: 'Get',
                url: "<%= Url.Action("JsonListSupplier","Supplier") %>", // we are calling json method
                dataType: 'json',
                success: function (data) {
                    //  $("#SupID").append('<option value=0>---- SELECT -----</option>');
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
               // $('#myTableId tbody').empty();
                $('#example thead').empty();
                //$('#btnSendData').hide();
                if ($("#SupID").val() != 0) {
                    // ดึ่ง ยี่ห้อ และ รุ่น ของบริษัทนั้น
                    $.ajax({
                        type: 'POST',
                        url: "<%= Url.Action("JsonProductSupp","Products") %>", // we are calling json method
                        dataType: 'json',
                        data: { id: $("#SupID").val() },
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
                                        if (key == "PrdID")
                                            rowData[0] = value;
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
                                        else if (key == "PsUpdate")
                                            rowData[8] = value;
                                        else if (key == "Price") {
                                            rowData[9] = numeral(value).format('0,0.00');
                                            //   rowData[9] = '<input type="number" style="width:100%;text-align:right;" value="' + numeral(value).format('0,0') + '" onkeypress="return isNumberKey(event);" min= "0" name="Cost[]" id="N' + rowData[0] + '" disabled/>';
                                            rowData[10] = '<input type="number"  id="A' + rowData[0] + $("#SupID").val() + '"style="width:100%;text-align:right;" value="0" onkeypress="return isNumberKey(event);" min= "0"/>';
                                            rowData[11] = '<button id="' + rowData[0] + $("#SupID").val() + '" class="btn btn-inverse btn-primary" onclick="AddProduct(\'' + rowData[0] + '\',\'' + $("#SupID").val() + '\')">เพิ่ม &nbsp <i class="fa fa-plus"></i></button>';
                                        }
                                    });
                                    rowDataSet[i] = rowData;
                                    i++;
                                });
                                $('#example').dataTable({
                                    "bDestroy": true,
                                    //"bScrollCollapse": true,
                                    //"bAutoWidth": true,
                                    "bJQueryUI": true,
                                    "bPaginate": false,
                                    "sScrollY": "90%",
                                    //"sScrollX": "100%",
                                    //"sScrollXInner": "100%",
                                    "sScrollHeadInner": true,
                                    "bInfo": true,
                                    "bFilter": true,
                                    "bSort": true,
                                    "aaData": rowDataSet,
                                    "aoColumns": [
                                  // { "sWidth": "3%", "sTitle": "#" },
                                   { "sWidth": "10%", "sTitle": "Product ID" },
                                   { "sWidth": "10%", "sTitle": "ประเภทสินค้า" },
                                   { "sWidth": "10%", "sTitle": "ยี่ห้อ" },
                                   { "sWidth": "20%", "sTitle": "รุ่นสินค้า" },
                                   { "sWidth": "5%", "sTitle": "สี" },
                                   { "sWidth": "8%", "sTitle": "สถานะสินค้า", "sClass": "center" },
                                   { "sWidth": "2%", "sTitle": "Waranty(Y)", "sClass": "center" },
                                   { "sWidth": "5%", "sTitle": "Photo" },
                                   { "sWidth": "6%", "sTitle": "อัพเดทล่าสุด", "sClass": "right" },
                                    { "sWidth": "9%", "sTitle": "ราคา/หน่วย", "sClass": "right" },
                                    { "sWidth": "9%", "sTitle": "จำนวนสั่งซื้อ", "sClass": "right" },
                                     { "sWidth": "5%", "sTitle": "    " },
                                    ]  //These are dynamically created columns present in JSON object.
                                });
                            } else {
                                $('#example').empty();
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

            $('.bs-example').attr('data-content', "รายการใบเสนอ");
            LoadLogfile()
           // $("#btnSendData").hide();
            $("#alert-warning").hide();
            $("#alert-success").hide();
        }); //doc ready

        var rowDataSet_ADD = [];
        var listPro = [];
        var k_add = 0; var flag = 0;
        function AddProduct(prd, sup) {
            var amount = "#A" + prd + sup;
            if ($(amount).val() == 0) {
                alert("กรุณาใส่จำนวน !!")
                return;
            }

            var bind = prd + sup;
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
            //ชื่อ บริษัทคู่ค้า $("#SupID option:selected").text()
            var id = "#" + prd + sup;
            var j = 0; k = 0;
            var t = $('#myTableId').dataTable();
            var rowData = [];
            rowData[k++] = sup;
            $.each($(id).closest("td").siblings("td"),
                      function () {
                          if (j != 5 && j != 7 && j != 8 && j != 10 && j != 11)
                              rowData[k++] = $(id).closest("td").siblings("td")[j].innerHTML;
                          j++;
                      });
            rowData[k++] = numeral($(amount).val()).format('0,0');
            rowData[k++] = '<label name="sum[]">' + numeral(numeral().unformat(rowData[7]) * $(amount).val()).format('0,0.00') + '</label>';
            rowDataSet_ADD[k_add++] = rowData;
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
                          { "sWidth": "10%", "sTitle": "รหัสคู่ค้า" },
                          { "sWidth": "10%", "sTitle": "Product ID", "bSortable": false },
                          { "sWidth": "10%", "sTitle": "ประเภทสินค้า", "bSortable": false },
                          { "sWidth": "10%", "sTitle": "ยี่ห้อ", "bSortable": false },
                          { "sWidth": "20%", "sTitle": "รุ่นสินค้า", "bSortable": false },
                          { "sWidth": "8%", "sTitle": "สี", "bSortable": false },
                          { "sWidth": "8%", "sTitle": "Waranty(Y)", "sClass": "center", "bSortable": false },
                          { "sWidth": "10%", "sTitle": "ราคา/หน่วย", "sClass": "right", "bSortable": false },
                          { "sWidth": "7%", "sTitle": "จำนวน(ชื้น)", "sClass": "right", "bSortable": false },
                          { "sWidth": "7%", "sTitle": "รวมราคา", "sClass": "right", "bSortable": false },
                ]  //These are dynamically created columns present in JSON object.
            });
            cal();
        }

        function btnT() {
            $("#btnSendData").show();
            var obj = [];
            var tmpObj = { PrdID: "", TypeName: "", TrdName: "", BrandName: "", ClrName: "", Waranty: "", Filepath: "" };
            var index = 0;
            var j = 0;
            if ($("input[name='case[]']:checked").length === 0) {
                //alert("Select at least one product")
                $("#alert-warning").show();
                $("#btnSendData").hide();
                $('#myTableId tbody').empty();
            }
            else {
                $("#SupSel").show();
                $.each($("input[name='case[]']:checked").closest("td").siblings("td"),
                      function () {
                          if (index % 7 == 0) {
                              tmpObj = { PrdID: "", TypeName: "", TrdName: "", BrandName: "", ClrName: "", Waranty: "", Filepath: "" };
                              tmpObj.PrdID = $.trim($(this).text()).split(/\r\n|\r|\n/g).toString();
                          }
                          else if (index % 7 == 1)
                              tmpObj.TypeName = $.trim($(this).text()).split(/\r\n|\r|\n/g).toString();
                          else if (index % 7 == 2)
                              tmpObj.TrdName = $.trim($(this).text()).split(/\r\n|\r|\n/g).toString();
                          else if (index % 7 == 3)
                              tmpObj.BrandName = $.trim($(this).text()).split(/\r\n|\r|\n/g).toString();
                          else if (index % 7 == 4)
                              tmpObj.ClrName = $.trim($(this).text()).split(/\r\n|\r|\n/g).toString();
                          else if (index % 7 == 5)
                              tmpObj.Waranty = $.trim($(this).text()).split(/\r\n|\r|\n/g).toString();
                          else if (index % 7 == 6) {
                              tmpObj.Filepath = $.trim($(this).text()).split(/\r\n|\r|\n/g).toString();
                              obj.push(tmpObj);
                          }
                          index++;
                      });
                $("#example input[type=checkbox]:checked").each(function () {
                    $(this).prop("checked", false);
                });
                var jsonstring = JSON.stringify(obj);
                //  console.log(jsonstring);
                $('#myTableId tbody').empty();
                $.each(obj, function (index, value) {
                    $('#myTableId tbody').append(
                         '<tr><td>' + (index + 1)
                         + '</td><td>' + obj[index].PrdID
                         + '</td><td>' + obj[index].TypeName
                         + '</td><td>' + obj[index].TrdName
                         + '</td><td>' + obj[index].BrandName
                         + '</td><td>' + obj[index].ClrName
                         + '</td><td>' + obj[index].Waranty
                         + '</td><td style="width:10%">' + '<input type="number" style="width:100%" value="0" onkeypress="return isNumberKey(event);" onKeyUp="calCostkey()" min= "0" name="Cost[]" />'
                         + '</td><td style="width:10%">' + '<input type="number"  style="width:100%" value="0" onkeypress="return isNumberKey(event);" onKeyUp="calCostkey()" min= "0" name="AmountPost[]"/>'
                         + '</td><td name="sum[]">0'
                         + '</td></tr>');
                });
                $("#btnSendData").show();
                $("#alert-warning").hide();
            }
            $("#alert-success").hide();
        }

        function btnSendData() {
            if (listPro.length > 0 && $("#myTableId_filter").find('label').find('input').val() == "") {
            var MultiOjb = [];
            var rows = [];
            var modelOffer = [];
            var index = 1; var temp = "";
            //tmpObj = { SupID: "" }; 
            $('#myTableId tbody tr ').each(function () {

                if (temp == $(this).find('td:eq(0)').text()) {
                    temp = $(this).find('td:eq(0)').text();
                    index++;
                } else {
                    temp = $(this).find('td:eq(0)').text();
                    index = 1;
                }

                modelOffer.push({
                    SupID: $(this).find('td:eq(0)').text(),
                });
                rows.push({
                    OfdNo: index,
                    PrdID: $(this).find('td:eq(1)').text(),
                    TypeName: $(this).find('td:eq(2)').text(),
                    TrdName: $(this).find('td:eq(3)').text(),
                    BrandName: $(this).find('td:eq(4)').text(),
                    ClrName: $(this).find('td:eq(5)').text(),
                    Waranty: $(this).find('td:eq(6)').text(),
                    Cost: numeral().unformat($(this).find('td:eq(7)').text()),
                    AmountPost: $(this).find('td:eq(8)').text(),
                });
            });
            MultiOjb.push({
                OfferModel: modelOffer,
                OfferDetail: rows
            })
            //console.log(JSON.stringify(MultiOjb));
            // alert(JSON.stringify(rows));
            //var stringJson = JSON.stringify(rows);
         // $('#myTableId tbody').empty();
            event.preventDefault();
           $.ajax({
                type: "POST",
                url: "<%= Url.Action("OfferCreatePos","Products")%>",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(MultiOjb),
                success: function () { location.reload(); },
                error: function () { }
            });
            $("#btnSendData").hide();
            $("#alert-warning").hide();
            $("#alert-success").show();
            $("#subTotal").html('0.00')
            $("#calTax").html('0.00');
            $("#grandTotal").html('0.00');
           // LoadLogfile()
            } else {
                alert("กรุณาเลือกสินค้าที่จะเสนอ หรือ นำการค้นหาข้อมูลออก !!")
            }
        }

        

        function LoadLogfile() {
            //$("#_loading").show();
            //$("#_ShowLog").hide();
            $.get("<%= Url.Action("ListOffer")%>", function (data) {
                $("#_ShowLog").html(data);
                //$("#_loading").hide();
                //$("#_ShowLog").show();
            });
        }
        function cal() {
            var countRow = document.getElementsByName('sum[]').length;
            var tax = 0;
            var Total = 0;
            for (var i = 0; i < countRow; i++) {
                Total +=  numeral().unformat(document.getElementsByName('sum[]').item(i).innerHTML);
            }
            tax = (Total * 0.07).toFixed(2);
            $("#subTotal").html(numeral(Total).format('0,0.00'));
            $("#calTax").html(numeral(tax).format('0,0.00'));
            var grand = (parseFloat(Total) + parseFloat(tax)).toFixed(2);
            $("#grandTotal").html(numeral(grand).format('0,0.00'));
        }

        function calCostkey() {
            var countRow = document.getElementsByName('AmountPost[]').length;
            var tax = 0;
            var Total = 0;
            for (var i = 0; i < countRow; i++) {
                // costObj = document.getElementsByName('Cost[]').item(i).value;
                //costObj = document.getElementsByName('Cost[]').item(i).innerHTML;
                costObj = numeral().unformat(document.getElementsByName('Cost[]').item(i).innerHTML);
                amountObj = (document.getElementsByName('AmountPost[]').item(i).value);
                // sumObj = document.getElementsByName('sum[]').item(i).innerHTML;
                document.getElementsByName('sum[]').item(i).innerHTML = numeral(costObj * amountObj).format('0,0.00');
                Total += (costObj * amountObj)
            }
            tax = (Total * 0.07).toFixed(2);
            $("#subTotal").html(Total.toFixed(2));
            $("#calTax").html(tax);
            var grand = (parseFloat(Total) + parseFloat(tax)).toFixed(2);
            $("#grandTotal").html(grand)
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
    <!-- Scripts --->
    <%--<script src="<%: Url.Content("~/Scripts/jquery-1.11.1.min.js") %>" type="text/javascript"></script>--%>
    <%--<script src="//cdnjs.cloudflare.com/ajax/libs/numeral.js/1.4.5/numeral.min.js"></script>--%>
    <script src="../../Scripts/numeral.min.js"></script>
    <script src="<%: Url.Content("~/Scripts/jquery.dataTables.min.js") %>" type="text/javascript"></script>
    <link href="/Content/bootstrap.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/dataTables.bootstrap.js"></script>
    <script src="../../Scripts/jquery.tabletojson.min.js"></script>
    <script src="<%: Url.Content("~/Scripts/cdn.datatables.net/plug-ins/input.js") %>" type="text/javascript"></script>
    <script src="<%: Url.Content("~/Scripts/cdn.datatables.net/plug-ins/scrolling.js") %>" type="text/javascript"></script>
    <script src="<%: Url.Content("~/Scripts/cdn.datatables.net/plug-ins/select.js") %>" type="text/javascript"></script>
    <link href="../../Content/css/jquery.dataTables.css" rel="stylesheet" />
    <link href="../../Content/css/docs.min.css" rel="stylesheet" />
</asp:Content>

<%--//โปรเก่า แบบเก่า
        function btnSendData() {
            var MultiOjb = [];
            var rows = [];
            var modelOffer = []; tmpObj = { SupID: "" }; tmpObj.SupID = $("#SupID").val().toString();
            modelOffer.push(tmpObj);
            //console.log(objSupID)
            $('#myTableId tbody tr ').each(function () {
                rows.push({
                    OfdNo: $(this).find('td:eq(0)').text(),
                    PrdID: $(this).find('td:eq(1)').text(),
                    TypeName: $(this).find('td:eq(2)').text(),
                    TrdName: $(this).find('td:eq(3)').text(),
                    BrandName: $(this).find('td:eq(4)').text(),
                    ClrName: $(this).find('td:eq(5)').text(),
                    Waranty: $(this).find('td:eq(6)').text(),
                    Cost: $(this).find('td:eq(7) input').val(),
                    AmountPost: $(this).find('td:eq(8) input').val(),
                });
            });
            MultiOjb.push({
                OfferModel: modelOffer,
                OfferDetail: rows
            })
            // console.log(JSON.stringify(MultiOjb));
            // alert(JSON.stringify(rows));
            //var stringJson = JSON.stringify(rows);
            $('#myTableId tbody').empty();
            event.preventDefault();
            $.ajax({
                type: "POST",
                url: "<%= Url.Action("OfferCreatePos","Products")%>",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(MultiOjb),
                success: function () { },
                error: function () { }
            });
            $("#btnSendData").hide();
            $("#alert-warning").hide();
            $("#alert-success").show();
            $("#subTotal").html('0.00')
            $("#calTax").html('0.00');
            $("#grandTotal").html('0.00');
            LoadLogfile()
        }--%>