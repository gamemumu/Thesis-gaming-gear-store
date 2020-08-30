<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<ThesisGamingStore.Models.OrderDetailModel>>" %>
<%@ Import Namespace="ThesisGamingStore.Models" %>
<%--<script src="../../Scripts/jquery-bootstrap-modal-steps.js"></script>--%>

<div class="modal-content">
    <div class="modal-header">
        <%--<h3 class="js-title-step"></h3>--%>
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <%--<h4 id="myModalLabel">สินค้าที่ได้รับ</h4>--%>

        <div class="row">
            <div class="col-xs-5 col-sm-4">
                <h4>รหัสใบสั่งซื้อ : <%= ViewBag.OrdID %> </h4>
            </div>
            <div class="col-xs-9 col-sm-4">
                <h4>บริษัท : <%= ViewBag.SupName %></h4>
            </div>
            <div class="col-xs-4 col-sm-4">
                <button id="vali" class="btn btn-inverse btn btn-danger pull-left" type="submit" onclick="#" style="visibility: hidden;">* กรุณากรอกจำนวนให้ถูกต้อง !!</button>
            </div>
        </div>
    </div>
    <div class="modal-body">
        <%-- <div class="row hide" data-step="1" data-title="Step 1 > ใส่จำนวนสินค้าที่รับ">--%>
        <div style="padding-left: 10px; padding-right: 10px;">
            <table class="table table-striped table-condensed" id="tbl_receiving">
                <thead>
                    <tr>
                        <th style="display: none">
                            <%: Html.DisplayName("ลำดับใบรับ") %>
                        </th>
                        <th style="display: none">
                            <%: Html.DisplayName("รหัสใบสั่งซื้อ") %>
                        </th>
                        <th>
                            <%: Html.DisplayName("No") %>
                        </th>
                        <th>
                            <%: Html.DisplayName("รหัสสินค้า") %>
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
                        <th style="text-align: right">
                            <%: Html.DisplayName("จำนวนที่สั่ง") %>
                        </th>
                        <th style="text-align: right">
                            <%: Html.DisplayName("จำนวนที่รับแล้ว") %>
                        </th>
                        <th style="text-align: right">
                            <%: Html.DisplayName("ราคา") %>
                        </th>
                        <th style="text-align: right">
                            <%: Html.DisplayName("รวม") %>
                        </th>
                        <th style="text-align: right">
                            <%: Html.DisplayName("จำนวนที่รับ") %>
                        </th>
                        <th>
                            <%: Html.DisplayName("Serial") %> 
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <% decimal total_row = 0;%>
                    <% decimal total_all = 0;%>
                    <% int index = 1; %>
                    <% int sumReceive = 0; string CheckOrdId = ""; int CheckOrdNo = 0; bool flag = false;%>

                    <% if (ViewData["Flag"].ToString().Equals("DataOld"))
                       {%>

                    <% foreach (var item in Model)
                       { %>
                    <% foreach (var item2 in Model)
                       { %>
                    <%if (item.OrdNo != CheckOrdNo)
                      { %>
                    <%if (item.OrdID.Equals(item2.OrdID) && item.OrdNo == item2.OrdNo)
                      { %>
                    <% sumReceive += item2.AmountRec; %>
                    <% item.AmountRec = sumReceive; %>
                    <% flag = true; %>
                    <%}
                      else
                      { %>
                    <% continue; %>
                    <%} %>
                    <%} %>
                    <%} %>
                    <%if (flag)
                      { %>
                    <%if ((item.AmountApprove - item.AmountRec) > 0)
                      {%>
                    <tr id="<%:index %>">
                        <td style="display: none">
                            <%: index %>
                        </td>
                        <td style="display: none">
                            <%: Html.DisplayFor(modelItem => item.OrdID) %>
                        </td>
                        <td>
                            <%: Html.DisplayFor(modelItem => item.OrdNo) %>
                        </td>
                        <td>
                            <%: Html.DisplayFor(modelItem => item.PrdID) %>
                        </td>
                        <td>
                            <%: Html.DisplayFor(modelItem => item.TrdName) %>
                        </td>
                        <td>
                            <%: Html.DisplayFor(modelItem => item.BrandName) %>
                        </td>
                        <td>
                            <%: Html.DisplayFor(modelItem => item.ClrName) %>
                        </td>
                        <td class="_Amount" style="text-align: right">
                            <%: Html.DisplayFor(modelItem => item.AmountApprove) %>
                        </td>
                        <td class="_Amount" style="text-align: right">
                            <%: Html.DisplayFor(modelItem => item.AmountRec) %>
                        </td>
                        <td class="_Cost" style="text-align: right">
                            <%: Html.DisplayFor(modelItem => item.Cost) %>
                        </td>
                        <td class="_Cost" style="text-align: right">
                            <% total_row = (item.Cost * item.AmountApprove); %>
                            <% total_all += total_row; %>
                            <%: total_row%>
                        </td>
                        <td>
                            <input type="number" style="text-align: right; width: 100%" value="<%= item.AmountApprove - item.AmountRec%>" onkeypress="return isNumberKey(event)" name="AmountRec[]" min="0" max="<%=item.AmountApprove - item.AmountRec %>" />
                        </td>
                        <%if (item.SerialStatus.Equals("1"))
                          {%>
                        <td><a data-toggle="modal" href="#myModal2" onclick="Addserial('<%:index %>','<%:item.PrdID %>')"><span class="fa fa-wrench"></span></a></td>
                        <%}
                          else
                          { %>
                        <td></td>
                        <%} %>
                        <%index++; %>
                    </tr>
                    <%} %>
                    <%sumReceive = 0; %>
                    <%CheckOrdId = item.OrdID; %>
                    <%CheckOrdNo = item.OrdNo; %>
                    <% flag = false; %>
                    <%} %>
                    <%} %>
                    <%}
                       else if (ViewData["Flag"].ToString().Equals("DataNew"))
                       {%>
                    <% foreach (var item in Model)
                       { %>
                    <tr id="<%:index %>">
                        <td style="display: none">
                            <%: index %>
                        </td>
                        <td style="display: none">
                            <%: Html.DisplayFor(modelItem => item.OrdID) %>
                        </td>
                        <td>
                            <%: Html.DisplayFor(modelItem => item.OrdNo) %>
                        </td>
                        <td>
                            <%: Html.DisplayFor(modelItem => item.PrdID) %>
                        </td>
                        <td>
                            <%: Html.DisplayFor(modelItem => item.TrdName) %>
                        </td>
                        <td>
                            <%: Html.DisplayFor(modelItem => item.BrandName) %>
                        </td>
                        <td>
                            <%: Html.DisplayFor(modelItem => item.ClrName) %>
                        </td>
                        <td class="_Amount" style="text-align: right">
                            <%: Html.DisplayFor(modelItem => item.AmountApprove) %>
                        </td>
                        <td class="_Amount" style="text-align: right">
                            <%: Html.DisplayFor(modelItem => item.AmountRec) %>
                        </td>
                        <td class="_Cost" style="text-align: right">
                            <%: Html.DisplayFor(modelItem => item.Cost) %>
                        </td>
                        <td class="_Cost" style="text-align: right">
                            <% total_row = (item.Cost * item.AmountApprove); %>
                            <% total_all += total_row; %>
                            <%: total_row%>
                        </td>
                        <td>
                            <input style="text-align: right; width: 100%" type="number" value="<%= item.AmountApprove - item.AmountRec%>" onkeypress="return isNumberKey(event)" name="AmountRec[]" min="0" max="<%=item.AmountApprove - item.AmountRec %>" />
                        </td>
                        <%if (item.SerialStatus.Equals("1"))
                          {%>
                        <td><a data-toggle="modal" href="#myModal2" onclick="Addserial('<%:index %>','<%:item.PrdID %>')"><span class="fa fa-wrench"></span></a></td>
                        <%}
                          else
                          { %>
                        <td></td>
                        <%} %>
                        <%index++; %>
                    </tr>
                    <% } %>
                    <%} %>
                </tbody>
            </table>
            <div class="pull-right" style="padding-right: 15px">
                ราคารวมทั้งหมด :
            <label class="_Cost"><%=total_all%> </label>
                &nbsp Baht
            </div>
            <br />
        </div>
        <%--</div>--%>
        <%--<div class="row hide" data-step="2" data-title="Step 2 > ใส่ Serial สินค้า">
            <div class="well">As you can see, this is the second and last step!</div>
        </div>--%>
    </div>
    <div class="modal-footer ">
        <button class="btn  btn-default" data-dismiss="modal" aria-hidden="true">ยกเลิก</button>
        <%if (Page.User.IsInRole("สิทธิในการรับสินค้า"))
          {%>
        <%-- <button type="button" class="btn btn-warning js-btn-step" data-orientation="previous"></button>
        <button type="button" class="btn btn-success js-btn-step" data-orientation="next"></button>--%>
        <button class="btn btn-inverse btn-primary" type="submit" onclick="receiveOrder()">รับสินค้า</button>
        <%}
          else
          { %>
        <button class="btn btn-inverse btn-danger" type="submit" onclick="#">ไม่มีสิทธิ์รับ</button>
        <%} %>
    </div>
</div>



<script type="text/javascript">
    $(document).ready(function () {
        $("._Amount").each(function (i) {
            $(this).html(numeral($.trim($("._Amount")[i].innerText).toString()).format('0,0'));
        });
        $("._Cost").each(function (i) {
            $(this).html(numeral($.trim($("._Cost")[i].innerText).toString()).format('0,0.00'));
        });
    });


    var listPro = [];
    var rowDataSet_ADD = []; var k_add = 0;
    var local_id = "";
    function confrimSerial() {
        var bind = $(".modal-title").text().substring(30, 38);
        var rowDataSet = [];
        var rowData = []; var xx = 0;
        var con_flag = true;
        rowData.push(bind);
        $('#serialData').find('input').each(function () {
            if ($(this).val().length > 0) {
                rowData.push($(this).val());
            } else {
                $("#sr_valid").css("visibility", "visible");
                event.preventDefault()
                con_flag = false;
            }
        });
        if (con_flag) {
            rowDataSet[xx++] = rowData;
            $.each(rowDataSet_ADD, function (index) {
                if (rowDataSet_ADD[index][0] == local_id) {
                    rowDataSet_ADD.splice(index, 1);
                    --k_add;
                }
            });
            $.each(rowDataSet, function (index) {
                rowDataSet_ADD[k_add++] = rowDataSet[index];
            });
            $("#sr_valid").css("visibility", "hidden");
            $('#myModal2').modal('hide');
        }
    }

    function Addserial(id, prd) {
        debugger;
        var amount = $("#" + id).find('input').val();
        var app = numeral().unformat($.trim($("#" + id).find('td:eq(7)').text()).split(/\r\n|\r|\n/g).toString());
        if (amount == 0) {
            $('#myModal2').modal('toggle')
            return;
        }
         if (amount <= app) {
            $('#myModal2 .modal-header .modal-title').html('ใส่ซีเรียลนัมเบอร์ของสินค้า : ' + $.trim($("#" + id).find('td')[3].innerHTML).split(/\r\n|\r|\n/g).toString() + ' ' + $.trim($("#" + id).find('td')[5].innerHTML).split(/\r\n|\r|\n/g).toString())
            var html = '<div class="row" id="serialData">';
            var _data = []; var flag = true;
            if (rowDataSet_ADD.length == 0) {
                for (i = 0; i < amount; i++) {
                    //html += '<div class="col-md-1">' + (i + 1) + '</div>' +
                    //    '<div class="col-md-3">' + '<input style="text-align: right; width: 100%" type="text"  name="serial[]">' + '</div>';

                    html += '<div class="col-md-1">' + (i + 1) + '</div>' +
                  '<div class="col-md-3">' + '<input style="text-align: right; width: 100%" type="text"  name="serial[]" value="' + randomString() + '">' + '</div>';
                    
                }
                html += '</div>'
                $('#myModal2 .modal-body').html(html);
                flag = false;
            } else {
                $.each(rowDataSet_ADD, function (index) {
                    if (rowDataSet_ADD[index][0] == prd) {
                        for (i = 1; i <= amount; i++) {
                            html += '<div class="col-md-1">' + i + '</div>' +
                                '<div class="col-md-3">' + '<input style="text-align: right; width: 100%" type="text"  name="serial[]" value="' + rowDataSet_ADD[index][i] + '">' + '</div>';
                        }
                        html += '</div>'
                        $('#myModal2 .modal-body').html(html);
                        flag = false;
                    }
                });
            }
            if (flag) {
                for (i = 0; i < amount; i++) {
                    //html += '<div class="col-md-1">' + (i + 1) + '</div>' +
                    //    '<div class="col-md-3">' + '<input style="text-align: right; width: 100%" type="text"  name="serial[]">' + '</div>';

                    html += '<div class="col-md-1">' + (i + 1) + '</div>' +
                       '<div class="col-md-3">' + '<input style="text-align: right; width: 100%" type="text"  name="serial[]" value="'+randomString()+'">' + '</div>';
                }
                html += '</div>'
                $('#myModal2 .modal-body').html(html);
            }
            local_id = prd;
        } else {
            $("#vali").text('* กรุณากรอกจำนวนซีเรียลให้ถูกต้อง !!')
            $("#vali").css("visibility", "visible");
            $('#myModal2').modal('toggle')
        }
    }


    function receiveOrder() {
        debugger;
        var rows = [];
        var flag = false;
        var a_app = 0; var a_rec = 0;
        var checkserial = 0;
        $('#tbl_receiving tbody tr').each(function () {
            a_app = numeral().unformat($.trim($(this).find('td:eq(7)').text()).split(/\r\n|\r|\n/g).toString());
            a_rec = numeral().unformat($.trim($(this).find('td:eq(8)').text()).split(/\r\n|\r|\n/g).toString());
            if ((numeral().unformat($(this).find('td:eq(11) input').val())) <= (a_app - a_rec)){
                flag = true;
            } else {
                flag = false;
                $("#vali").text('* กรุณากรอกจำนวนให้ถูกต้อง !!')
                $("#vali").css("visibility", "visible");
                return false;
            }
            //เช็คถ้ากรอกจำนวน !=0 เก็บลง เบส
            //ถ้า ==0 ให้ไปเช็คว่ามี tag serial ให้กรอกไหมถ้ามี ให้นำ tag นั้นไปลบ กับเงื่อนไข
            if (numeral().unformat($(this).find('td:eq(11) input').val()) != 0) {
                rows.push({
                    RecONo: $.trim($(this).find('td:eq(0)').text()).split(/\r\n|\r|\n/g).toString(),
                    OrdID: $.trim($(this).find('td:eq(1)').text()).split(/\r\n|\r|\n/g).toString(),
                    OrdNo: $.trim($(this).find('td:eq(2)').text()).split(/\r\n|\r|\n/g).toString(),
                    PrdID: $.trim($(this).find('td:eq(3)').text()).split(/\r\n|\r|\n/g).toString(),
                    Cost: numeral().unformat($.trim($(this).find('td:eq(9)').text()).split(/\r\n|\r|\n/g).toString()),
                    AmountRec: numeral().unformat($(this).find('td:eq(11) input').val()),
                });
            } else if (numeral().unformat($(this).find('td:eq(11) input').val()) == 0 && $(this).find('a').length > 0) {
                checkserial++;
            }
        });
        if (flag) {
            debugger;
            var data = $("#tbl_receiving tbody tr a");
            if (($("#tbl_receiving tbody tr a").length - checkserial) == rowDataSet_ADD.length) {
                var MultiOjb = [];
                MultiOjb.push({
                    dataTable: rows,
                    serial: rowDataSet_ADD,
                });
                console.log(JSON.stringify(MultiOjb));
                $.ajax({
                    type: "POST",
                    url: "<%= Url.Action("ReceiveProduct","Order")%>",
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(MultiOjb),
                    success: function () {
                        location.reload();
                    },
                    error: function () { }
                });
                $('#edit-person').modal('hide');
            } else {
                $("#vali").text('* กรุณากรอกซีเรียลให้ถูกต้อง !!')
                $("#vali").css("visibility", "visible");
                return false;
            }
        }
    }

    function isNumberKey(evt) {
        var charCode = (evt.which) ? evt.which : event.keyCode
        if (charCode > 31 && (charCode < 48 || charCode > 57))
            return false;
        return true;
    }

    function randomString() {
        var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz";
        var string_length = 8;
        var randomstring = '';
        for (var i = 0; i < string_length; i++) {
            var rnum = Math.floor(Math.random() * chars.length);
            randomstring += chars.substring(rnum, rnum + 1);
        }
        return randomstring;
    }
</script>
