<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    ShowListOffer
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <h3 class="page-header">รายการใบเสนอ</h3>
    <div class="bs-example" data-content="Example Header">
        <div class="row">
            <div class="col-sm-12">
                <table id="ListOff" class="display" cellspacing="0" width="100%">
                    <thead>
                        <tr>
                            <th></th>
                            <th>
                                <%: Html.DisplayName("Offer ID") %>
                            </th>
                            <th>
                                <%: Html.DisplayName("Emp ID") %>
                            </th>
                            <th>
                                <%: Html.DisplayName("ผู้เสนอ") %>
                            </th>
                            <th>
                                <%: Html.DisplayName("บริษัท") %>
                            </th>
                            <th>
                                <%: Html.DisplayName("วันที่เสนอ") %>
                            </th>
                            <th >
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
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    <script type="text/javascript">

        var table; var aa; var _id;
        $(document).ready(function () {
            $('.bs-example').attr('data-content', "รายการใบเสนอ");
            $.get("<%= Url.Action("JsonListOffer")%>", function (data) {
                table = $('#ListOff').DataTable({
                    "bDestroy": true,
                    "bJQueryUI": true,
                    "bPaginate": false,
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
                    { "data": "OffID" },
                    { "data": "EmpID" },
                    { "data": "EmpName" },
                     { "data": "SupName" },
                      { "data": "OffDate" },
                       { "data": "OffStatus" },
                    ],  //These are dynamically created columns present in JSON object.
                    "order": [[1, 'desc']]
                });
            });

            // Add event listener for opening and closing details
            $('#ListOff tbody').on('click', 'td.details-control', function () {
                var tr = $(this).closest('tr');
                var row = table.row(tr);

                if (row.child.isShown()) {
                    // This row is already open - close it
                    row.child.hide();
                    tr.removeClass('shown');
                    _id = 0;
                }
                else {
                    // Open this row
                    var _detail_start = '<table class="table table-bordered table-striped table-condensed" id="' + row.data().OffID + '"> <thead><tr style="background-color:#DECF82 !important"><th style="width:6%">ลำดับ </th>' +
                         '<th style="width:9%">ProductID</th> <th style="width:10%">ประเภท</th><th style="width:10%">ยี่ห้อ </th><th style="width:20%">รุ่น</th> <th style="width:5%">สี </th><th style="width:10%">ราคา</th> <th style="width:10%">จำนวนเสนอ  </th>  <th style="width:10%">จำนวนอนุมัติ </th>' +
                         '<th style="width:10%">รวม   </th>   </tr> </thead><tbody>';

                    var _detail_end = '</tbody></table>';
                    var _detail_cost = '<div class="pull-right" style="padding-right:15px"> <div>ราคารวม :<span id="' + row.data().OffID + 'modalSubTotal">0.00</span> &nbsp Bath</div> </div> <br /><div class="pull-right" style="padding-right:15px"> <div>TAX 7% :<span id="' + row.data().OffID + 'modalCalTax">0.00</span> &nbsp Bath</div>' +
                        ' </div> <br /><div class="pull-right" style="padding-right:15px"> <div>ราคารวมทั้งหมด :<span id="' + row.data().OffID + 'modalGrandTotal">0.00</span> &nbsp Bath</div></div><br />';
                    var Approve; var OffID; var ReportOFFID; var SupName;
                    $.ajax({
                        type: 'POST',
                        url: "<%= Url.Action("JsonApproveOffer","Products") %>", // we are calling json method
                        data: { id: row.data().OffID, SupName: row.data().SupName, Approve: row.data().OffStatus },
                    }).done(function (data) {
                        $.each(data.Results, function (key, value) {
                            _detail_start += '<tr class="warning">' +
                                '<td>' + value.OfdNo + '</td>' +
                                '<td>' + value.PrdID + '</td>' +
                                '<td>' + value.TypeName + '</td>' +
                                '<td>' + value.TrdName + '</td>' +
                                '<td>' + value.BrandName + '</td>' +
                                '<td>' + value.ClrName + '</td>' +
                                '<td  style="text-align:right" name="' + row.data().OffID + 'mCost[]">' + (numeral(value.Cost).format('0,0.00')) + '</td>' +
                                '<td style="text-align:right" name="' + row.data().OffID + 'mAmountPost[]">' + (numeral(value.AmountPost).format('0,0')) + '</td>' +
                                '<td><input type="number" style="width:100%; text-align:right;" value="' + (numeral(value.AmountApprove).format('0,0')) + '" onkeypress="return isNumberKey(event);" onKeyUp="apCostkey()" min= "0" name="' + row.data().OffID + 'mAmountApprove[]" onfocus="takeID(event)"/></td>' +
                                '<td style="width:100%; text-align:right;" name="' + row.data().OffID + 'msum[]"></td>' +
                                '</tr>'
                        });
                        var permit_approve = "<%=Page.User.IsInRole("สิทธิอนุมัติใบเสนอ").ToString()%>";
                        var offer = "<%=Page.User.IsInRole("สิทธิเสนอซื้อสินค้า").ToString()%>";
                        Approve = data.DataDetail[0].Approve;

                        var action = '<div class="pull-right" style="padding-right:15px">';
                        if ((offer == 'True' || permit_approve == 'True') && Approve == 'false') {
                            action += '<button class="btn btn-inverse btn btn-warning pull-left" type="submit" onclick="GetReport(\'' + row.data().OffID + '\')">ออกใบเสนอ</button>';
                        }
                        if (!(Approve == 'false') && permit_approve == 'True') {
                            //action += '<button class="btn btn-inverse btn btn-warning" type="submit" onclick="sendApprove()">แก้ไขการอนุมัติ</button>';
                        }
                        else if (permit_approve == 'True') {
                            //action +=  '<button class="btn btn-inverse btn btn-danger" type="submit" onclick="sendDel(\'' + Approve + '\')">ลบใบเสนอ</button>';
                            action += '<button class="btn btn-inverse btn-primary" type="submit" onclick="sendApprove(\'' + row.data().OffID + '\')">อนุมัติ</button>';
                        } else {
                            action += '<button class="btn btn-inverse btn-danger" type="submit" onclick="#">ไม่มีสิทธิ์อนุมัติ</button>';
                        }
                        action += '</div>'
                        var dd = _detail_start + _detail_end + _detail_cost + action;
                        console.log(dd)
                        row.child(dd).show();
                        tr.addClass('shown');
                        check(row.data().OffID, data.DataDetail[0].Approve);
                    });
                    // row.child(format(row.data())).show();
                    //tr.addClass('shown');
                }
            });
        }); //doc ready


        function check(id,status) {
            var flag = status;
            if (flag != "Approve") {
                var countRow = document.getElementsByName(id+'mCost[]').length;
                var tax = 0;
                var Total = 0;
                for (var i = 0; i < countRow; i++) {
                    costObj = numeral().unformat($.trim(document.getElementsByName(id+'mCost[]').item(i).innerHTML));
                    amountObj = numeral().unformat($.trim(document.getElementsByName(id+'mAmountPost[]').item(i).innerHTML));
                    // sumObj = document.getElementsByName('sum[]').item(i).innerHTML;
                    document.getElementsByName(id + 'msum[]').item(i).innerHTML = numeral(costObj * amountObj).format('0,0.00');
                    Total += (costObj * amountObj)
                }
                tax = (Total * 0.07).toFixed(2);
                $("#" + id + "modalSubTotal").html(numeral(Total).format('0,0.00'));
                $("#" + id + "modalCalTax").html(numeral(tax).format('0,0.00'));
                var grand = (parseFloat(Total) + parseFloat(tax)).toFixed(2);
                $("#" + id + "modalGrandTotal").html(numeral(grand).format('0,0.00'));
            } else {
                var countRow = document.getElementsByName(id+'mCost[]').length;
                var tax = 0;
                var Total = 0;
                for (var i = 0; i < countRow; i++) {
                    costObj = numeral().unformat($.trim(document.getElementsByName(id+'mCost[]').item(i).innerHTML));
                    amountObj = numeral().unformat($.trim(document.getElementsByName(id+'mAmountApprove[]').item(i).value));
                    // sumObj = document.getElementsByName('sum[]').item(i).innerHTML;
                    document.getElementsByName(id+'msum[]').item(i).innerHTML = numeral(costObj * amountObj).format('0,0.00');
                    Total += (costObj * amountObj)
                }
                tax = (Total * 0.07).toFixed(2);
                $("#"+id+"modalSubTotal").html(numeral(Total).format('0,0.00'));
                $("#"+id+"modalCalTax").html(numeral(tax).format('0,0.00'));
                var grand = (parseFloat(Total) + parseFloat(tax)).toFixed(2);
                $("#"+id+"modalGrandTotal").html(numeral(grand).format('0,0.00'));
            }
        }

        function GetReport(data) {
            var win = window.open('<%= Url.Action("OfferReport", "Products")%>?id=' + data, 'mywindow', 'fullscreen=yes, scrollbars=auto');
            win.focus();
        }
        function sendDel(id) {
            $.post("<%= Url.Action("DeleteOffer","Products") %>",
                         { id: id, }
                     , function (data, status) {
                         //alert("Data: " + data + "\nStatus: " + status);
                     });
            $('#edit-person').modal('hide');
            $.get("/Products/ListOffer", function (data) {
                $("#_ShowLog").html(data);
            });
        }
        function sendApprove(id) {
            var rows = [];
            $('#'+id+' tbody tr').each(function () {
                rows.push({
                    OfdNo: $.trim($(this).find('td:eq(0)').text()).split(/\r\n|\r|\n/g).toString(),
                    PrdID: $.trim($(this).find('td:eq(1)').text()).split(/\r\n|\r|\n/g).toString(),
                    TypeName: $.trim($(this).find('td:eq(2)').text()).split(/\r\n|\r|\n/g).toString(),
                    TrdName: $.trim($(this).find('td:eq(3)').text()).split(/\r\n|\r|\n/g).toString(),
                    BrandName: $.trim($(this).find('td:eq(4)').text()).split(/\r\n|\r|\n/g).toString(),
                    ClrName: $.trim($(this).find('td:eq(5)').text()).split(/\r\n|\r|\n/g).toString(),
                    Cost: $.trim($(this).find('td:eq(6)').text()).split(/\r\n|\r|\n/g).toString(),
                    AmountPost: $.trim($(this).find('td:eq(7)').text()).split(/\r\n|\r|\n/g).toString(),
                    AmountApprove: $(this).find('td:eq(8) input').val(),
                });
            });

            // alert(JSON.stringify(rows));
            console.log(JSON.stringify(rows));
            $.ajax({
                type: "POST",
                url: "<%= Url.Action("UpdateOffer","Products")%>",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(rows),
                success: function () { location.reload(); },
                error: function () { }
            });
        }
        function apCostkey() {
            var countRow = document.getElementsByName(_id + 'mCost[]').length;
            var tax = 0;
            var Total = 0;
            for (var i = 0; i < countRow; i++) {
                costObj =  numeral().unformat($.trim(document.getElementsByName(_id + 'mCost[]').item(i).innerHTML));
                amountObj =  numeral().unformat($.trim(document.getElementsByName(_id + 'mAmountApprove[]').item(i).value));
                // sumObj = document.getElementsByName('sum[]').item(i).innerHTML;
                document.getElementsByName(_id + 'msum[]').item(i).innerHTML = numeral(costObj * amountObj).format('0,0.00');
                Total += (costObj * amountObj)
            }
            tax = (Total * 0.07).toFixed(2);
            $("#" + _id + "modalSubTotal").html(numeral(Total).format('0,0.00'));
            $("#" + _id + "modalCalTax").html(numeral(tax).format('0,0.00'));
            var grand = (parseFloat(Total) + parseFloat(tax)).toFixed(2);
            $("#" + _id + "modalGrandTotal").html(numeral(grand).format('0,0.00'));
        }

        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }
        function takeID(event) {
            _id = event.path[4].id;
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
</asp:Content>
