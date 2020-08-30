<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.ProductSup>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    AddProductSup
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <h3 class="page-header">ราคาทุนของสินค้าต่อบริษัทคู่ค้า</h3>
    <div class="editor-label">
        <%: Html.Label("บริษัทคู่ค้า") %>
    </div>
    <div class="editor-field">
        <%: Html.DropDownListFor(model => model.SupID, new SelectList(Enumerable.Empty<SelectListItem>()), new { style = "width:40%;height:30px;" })%>
        <%: Html.ValidationMessageFor(model => model.SupID) %>
    </div>
    <table id="example" class="table table-striped table-condensed table-responsive" width="100%">
        <%--class="table table-hover table-condensed table-striped" style="width:100%">--%>
        <thead>
        </thead>
        <tbody>
        </tbody>
    </table>
    <%--## Send json ##--%>
    <%--   <div class="text-center">--%>
    <%--<button id="btnT" onclick="btnT()"><i class="fa fa-arrow-circle-down fa-lg">&nbsp Send ProductList</i></button>--%>
    <%--    <a class="btn btn-inverse btn-primary" href="#headmyTableID" id="btnT" onclick="btnT()">ยืนยันสินค้า &nbsp<i class="fa fa-arrow-circle-right fa-lg"> &nbsp</i></a>--%>
    <%--   </div>--%>
     <br />
      <a href="<%= Url.Action("EditProductSup","Products") %>" class="btn btn-inverse btn-info" id="btnList" onclick="btnList()">ดูรายการสินค้าที่เพิ่มแล้ว &nbsp<i class="fa fa-arrow-circle-right fa-lg"> &nbsp</i></a>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            // ดึ่ง บริษัทคู่ค้า
            $.ajax({
                type: 'Get',
                url: "<%= Url.Action("JsonListSupplier","Supplier") %>", // we are calling json method
                dataType: 'json',
                success: function (data) {
                    // $("#SupID").append('<option value=0>---- SELECT -----</option>');
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

            $("#SupID").change(function () {
                getData($("#SupID").val());
            });
        });

        function getData(sup) {
            if ($("#SupID").val() != 0) {
                // ดึ่ง ยี่ห้อ และ รุ่น ของบริษัทนั้น
                var checkID = "";
                $.ajax({
                    type: 'POST',
                    url: "<%= Url.Action("JsonProductCreateSup","Products") %>", // we are calling json method
                    dataType: 'json',
                    data: { id: $("#SupID").val() },
                    success: function (obj) {

                        // console.log(JSON.stringify(obj));
                        var JSONResult = JSON.stringify(obj);
                        var parseJSONResult = jQuery.parseJSON(JSONResult);

                        if (parseJSONResult != null && parseJSONResult.length > 0) {
                            var rowDataSet = [];
                            var i = 0;
                            $.each(parseJSONResult, function (key, value) {
                                var rowData = [];
                                //rowData[0] = '<input type="checkbox" class="checkthis" name="case[]"  />';
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
                                    else if (key == "Filepath")
                                        rowData[6] = '<img src="' + value + '" alt="alt" height="40" width="60">';
                                    else if (key == "Price") {
                                        rowData[7] = numeral(value).format('0,0');
                                        rowData[8] = '<input type="number" style="width:100%;text-align:right;" value="0" onkeypress="return isNumberKey(event);" min= "0" name="Cost[]" id="N' + rowData[0] + '" />';
                                        rowData[9] = '<button id="btnSendData" class="btn btn-inverse btn-primary" onclick="btnSendData(\'' + rowData[0] + '\',\'' + $("#SupID").val() + '\')">ยืนยันราคา</button>';
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
                               { "sWidth": "25%", "sTitle": "รุ่นสินค้า" },
                               { "sWidth": "5%", "sTitle": "สี" },
                               { "sWidth": "10%", "sTitle": "สถานะสินค้า", "sClass": "center" },
                               { "sWidth": "5%", "sTitle": "Photo" },
                               { "sWidth": "8%", "sTitle": "ราคาขาย" , "sClass": "right"},
                                { "sWidth": "8%", "sTitle": "ราคา/หน่วย" },
                                 { "sWidth": "7%", "sTitle": "    " },
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

        function btnSendData(prd, sup) {
            var price = ($('#N' + prd).val());
            var cost = numeral().unformat($('#N' + prd).closest("tr").find('td:eq(7)').text());
            var _price = numeral().unformat(price);
            if (_price > 0 && _price <= cost) {
                var obj = []; var index = 0;
                tmpObj = { PrdID: "", SupID: "", Price: "" };
                tmpObj.PrdID = prd;
                tmpObj.SupID = sup;
                tmpObj.Price = price;
                obj.push(tmpObj);
                console.log(JSON.stringify(obj))
                $.ajax({
                    type: "POST",
                    url: "<%= Url.Action("ProductSupCreate","Products")%>",
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(obj),
                    success: function () {
                        // location.reload();
                        getData(sup);
                    },
                    error: function () { }
                });
            } else {
                alert("กรุณากรอกจำนวนเงินมากกว่า 0 บาท หรือน้อยกว่าราคาขาย")
            }
        }


        function btnT() {
            var obj = []; var index = 0;
            if ($("input[name='case[]']:checked").length === 0) {
                alert("Select at least one Supplier")
            }
            else {
                $.each($("input[name='case[]']:checked").closest("td").siblings("td"),
                      function () {
                          if (index % 7 == 0) {
                              tmpObj = { PrdID: "", SupID: "" };
                              tmpObj.PrdID = $.trim($(this).text()).split(/\r\n|\r|\n/g).toString();
                              tmpObj.SupID = $("#SupID").val();
                              obj.push(tmpObj);
                          }
                          index++;
                      });
                console.log(JSON.stringify(obj))
                $.ajax({
                    type: "POST",
                    url: "<%= Url.Action("ProductSupCreate","Products")%>",
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(obj),
                    success: function () {
                        location.reload();
                    },
                    error: function () { }
                });
            }
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
    <link href="../../Content/jquery-filestyle/css/jquery-filestyle.min.css" rel="stylesheet" />
    <script src="../../Content/jquery-filestyle/js/jquery-filestyle.min.js"></script>
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
