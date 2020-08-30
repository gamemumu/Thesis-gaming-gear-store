<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<ThesisGamingStore.Models.OrderDetailModel>>" %>
<%@ Import Namespace="ThesisGamingStore.Models" %>


<div class="modal-content">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 id="myModalLabel">สินค้าที่ได้รับ</h3>
        <div class="row">
            <div class="col-md-6">
                <h5>รหัสใบสั่งซื้อ : <%= ViewBag.OrdID %> </h5>
            </div>
            <div class="col-md-6 pull-right">
                <h5>บริษัท : <%= ViewBag.SupName %></h5>
            </div>
        </div>
    </div>
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
                        <%: Html.DisplayName("ลำดับสั่งซื้อ") %>
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
                    <%index++; %>
                </tr>
                <% } %>
                <%} %>
            </tbody>
            <tfoot>
            </tfoot>
        </table>
        <div class="pull-right" style="padding-right: 15px">
            ราคารวมทั้งหมด :
            <label class="_Cost"><%=total_all%> </label>
            &nbsp Baht
        </div>
        <br />


        <div class="modal-footer ">
            <button id="vali" class="btn btn-inverse btn btn-danger pull-left" type="submit" onclick="#" style="visibility: hidden;">* กรุณากรอกจำนวนให้ถูกต้อง !!</button>
            <button class="btn  btn-default" data-dismiss="modal" aria-hidden="true">ยกเลิก</button>
            <%if (Page.User.IsInRole("สิทธิในการรับสินค้า"))
              {%>
            <button class="btn btn-inverse btn-primary" type="submit" onclick="receiveOrder()">รับสินค้า</button>
            <%}
              else
              { %>
            <button class="btn btn-inverse btn-danger" type="submit" onclick="#">ไม่มีสิทธิ์รับ</button>
            <%} %>
        </div>
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

    function receiveOrder() {
        var rows = [];
        var flag = false;
        debugger;
        var a_app = 0; var a_rec = 0;
        $('#tbl_receiving tbody tr').each(function () {
            rows.push({
                RecONo: $.trim($(this).find('td:eq(0)').text()).split(/\r\n|\r|\n/g).toString(),
                OrdID: $.trim($(this).find('td:eq(1)').text()).split(/\r\n|\r|\n/g).toString(),
                OrdNo: $.trim($(this).find('td:eq(2)').text()).split(/\r\n|\r|\n/g).toString(),
                PrdID: $.trim($(this).find('td:eq(3)').text()).split(/\r\n|\r|\n/g).toString(),
                Cost: numeral().unformat($.trim($(this).find('td:eq(9)').text()).split(/\r\n|\r|\n/g).toString()),
                AmountRec: numeral().unformat($(this).find('td:eq(11) input').val()),
            });
            a_app = numeral().unformat($.trim($(this).find('td:eq(7)').text()).split(/\r\n|\r|\n/g).toString());
            a_rec = numeral().unformat($.trim($(this).find('td:eq(8)').text()).split(/\r\n|\r|\n/g).toString());
            if ((numeral().unformat($(this).find('td:eq(11) input').val())) <= (a_app - a_rec)) {
                flag = true;
            } else {
                flag = false;
                $("#vali").css("visibility", "visible");
                return false;
            }
        });
        if (flag) {
            //console.log(JSON.stringify(rows));
            $.ajax({
                type: "POST",
                url: "<%= Url.Action("ReceiveProduct","Order")%>",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(rows),
            success: function () {
                location.reload();
            },
            error: function () { }
        });
        $('#edit-person').modal('hide');
    }
}

function isNumberKey(evt) {
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
}
</script>
