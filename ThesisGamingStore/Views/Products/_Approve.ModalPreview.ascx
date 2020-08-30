<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<ThesisGamingStore.Models.OfferDetailModel>>" %>
<%@ Import Namespace="ThesisGamingStore.Models" %>


<div class="modal-content">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 id="myModalLabel">รายการสินค้าที่จะอนุมัติ</h3>
        <div class="row">
            <div class="col-md-6">
                <h5>รหัสใบเสนอ : <span id="_offID"><%= ViewBag.OffID %></span></h5>
            </div>
            <div class="col-md-6 pull-right">
                <h5>บริษัท : <%= ViewBag.SupName %></h5>
            </div>
        </div>
        </div>
        <div>
            <%-- <% using (Html.BeginForm("UpdateOffer", "Products", FormMethod.Post, new { @class = "modal-form" }))
       { %>--%>


            <table class="table table-striped table-condensed" id="tbl_approve">
                <thead>
                    <tr>
                        <th>
                            <%: Html.DisplayName("ลำดับ") %>
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
                            <%: Html.DisplayName("จำนวนเสนอ") %>
                        </th>
                        <th style="width:10%">
                            <%: Html.DisplayName("จำนวนอนุมัติ") %>
                        </th>
                         <th style="width:10%">
                            <%: Html.DisplayName("รวม") %>
                        </th>

                    </tr>
                </thead>
                <tbody>
                    <% foreach (var item in Model)
                       { %>
                    <tr>
                        <td>
                            <%: Html.DisplayFor(modelItem => item.OfdNo) %>
                        </td>
                        <td>
                            <%: Html.DisplayFor(modelItem => item.PrdID) %>
                        </td>
                        <td>
                            <%: Html.DisplayFor(modelItem => item.TypeName) %>
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
                         <td name="mCost[]">
                            <%--<%: Html.DisplayFor(modelItem => item.Cost) %>--%>
                             <%:item.Cost %>
                        </td>
                        <td name="mAmountPost[]">
                            <%--<%: Html.DisplayFor(modelItem => item.AmountPost) %>--%>
                             <%:item.AmountPost %>
                        </td>
                         <td style="width:10%"">
                            <% if (Page.User.IsInRole("สิทธิอนุมัติใบเสนอ"))
                               { %>
                            <%--<%: Html.NumberFor(modelItem => item.AmountApprove, new { htmlAttributes = new { @class = "form-control",@name="AmountApprove[]"}, onkeypress = "return isNumberKey(event)",style="width:100%"})%>--%>
                                <input type="number"  style="width:100%" value="<%=item.AmountApprove%>" onkeypress="return isNumberKey(event);" onKeyUp="apCostkey()" min= "0" name="mAmountApprove[]"/>
                             <%}
                               else
                               { %>
                            <%--<%: Html.DisplayFor(modelItem => item.AmountApprove, new { style="width:100%"})%>--%>
                            <%} %>
                        </td>
                         <td style="width:10%" name="msum[]">
                         </td>
                    </tr>
                    <% } %>
                </tbody>
                <tfoot>
                </tfoot>
            </table>
            <div class="pull-right" style="padding-right:15px">
                <div>ราคารวม :<span id="modalSubTotal">0.00</span> &nbsp Bath</div>
            </div>
            <br />
            <div class="pull-right" style="padding-right:15px">
                <div>TAX 7% :<span id="modalCalTax">0.00</span> &nbsp Bath</div>
            </div>
            <br />
             <div class="pull-right" style="padding-right:15px">
                <div>ราคารวมทั้งหมด :<span id="modalGrandTotal">0.00</span> &nbsp Bath</div>
            </div>
            <br />  


            <div class="modal-footer ">
                 <% if ((Page.User.IsInRole("สิทธิเสนอซื้อสินค้า") || Page.User.IsInRole("สิทธิอนุมัติใบเสนอ")) && ViewData["Approve"].ToString().Equals("false"))
                 {%>
                      <button class="btn btn-inverse btn btn-warning pull-left" type="submit" onclick="GetReport()">ออกใบเสนอ</button>
                <%} %>

                <button class="btn  btn-default" data-dismiss="modal" aria-hidden="true">ยกเลิก</button>
                <% if (!ViewData["Approve"].ToString().Equals("false") && Page.User.IsInRole("สิทธิอนุมัติใบเสนอ"))
                   { %>
                <button class="btn btn-inverse btn btn-warning" type="submit" onclick="sendApprove()">แก้ไขการอนุมัติ</button>
                <%}
                   else if (Page.User.IsInRole("สิทธิอนุมัติใบเสนอ"))
                   {%>
                <button class="btn btn-inverse btn btn-danger" type="submit" onclick="sendDel('<%= ViewBag.OffID %>')">ลบใบเสนอ</button>
                <button class="btn btn-inverse btn-primary" type="submit" onclick="sendApprove()">อนุมัติ</button>
                <%}
                   else
                   { %>
                <button class="btn btn-inverse btn-danger" type="submit" onclick="#">ไม่มีสิทธิ์อนุมัติ</button>
                <%} %>
            </div>
            <%--<%  } %>--%>
        </div>
    </div>


    <script type="text/javascript">
       // debugger;
        $(document).ready(function () {
            //คำนวณ ราคารวม กับ Tax
            var flag = "<%=ViewData["Approve"].ToString()%>";
            if(flag != "Approve"){
                        var countRow = document.getElementsByName('mCost[]').length;
                        var tax = 0;
                        var Total = 0;
                        for (var i = 0; i < countRow; i++) {
                            costObj = $.trim(document.getElementsByName('mCost[]').item(i).innerHTML);
                            amountObj = $.trim(document.getElementsByName('mAmountPost[]').item(i).innerHTML);
                            // sumObj = document.getElementsByName('sum[]').item(i).innerHTML;
                            document.getElementsByName('msum[]').item(i).innerHTML = (costObj * amountObj).toFixed(2);
                            Total += (costObj * amountObj)
                        }
                        tax = (Total * 0.07).toFixed(2);
                        $("#modalSubTotal").html(Total.toFixed(2));
                        $("#modalCalTax").html(tax);
                        var grand = (parseFloat(Total) + parseFloat(tax)).toFixed(2);
                        $("#modalGrandTotal").html(grand)
            }else{
                var countRow = document.getElementsByName('mCost[]').length;
                var tax = 0;
                var Total = 0;
                for (var i = 0; i < countRow; i++) {
                    costObj = $.trim(document.getElementsByName('mCost[]').item(i).innerHTML);
                    amountObj = $.trim(document.getElementsByName('mAmountApprove[]').item(i).value);
                    // sumObj = document.getElementsByName('sum[]').item(i).innerHTML;
                    document.getElementsByName('msum[]').item(i).innerHTML = (costObj * amountObj).toFixed(2);
                    Total += (costObj * amountObj)
                }
                tax = (Total * 0.07).toFixed(2);
                $("#modalSubTotal").html(Total.toFixed(2));
                $("#modalCalTax").html(tax);
                var grand = (parseFloat(Total) + parseFloat(tax)).toFixed(2);
                $("#modalGrandTotal").html(grand)
            }
        });
        function GetReport() {
           <%-- $.get("<%= Url.Action("OfferReport","Products") %>",
                       { id: id, }
                   , function (data, status) {
                       debugger;--%>
                       //calling generic report viewer page
                       window.open("<%= Url.Action("OfferReport","Products") %>", 'mywindow', 'fullscreen=yes, scrollbars=auto');
                       //alert("Data: " + data + "\nStatus: " + status);
                   //});
            //var datatable = $('#tbl_approve').tableToJSON();
            //var subTotal = $("#modalSubTotal").html();
            //var tax = $("#modalCalTax").html();
            //var grandTotal = $("#modalGrandTotal").html();
            //var MultiOjb = [];
            //var _dataCost = [];
            //var tmpObjCost = { OffID:"",SubTotal: "", Tax: "", GrandTotal: "" };
            //tmpObjCost.SubTotal = subTotal;
            //tmpObjCost.Tax = tax;
            //tmpObjCost.GrandTotal = grandTotal;
            //tmpObjCost.OffID = $("#_offID").html();
            //_dataCost.push(tmpObjCost);
            //MultiOjb.push({
            //    DATATABLE: datatable,
            //    DATACOST: _dataCost,
            //})
            //console.log(JSON.stringify(MultiOjb));
        }
        function sendDel(id) {
            $.post("<%= Url.Action("DeleteOffer","Products") %>",
                       {id: id,}
                   , function (data, status) {
                       //alert("Data: " + data + "\nStatus: " + status);
                   });
            $('#edit-person').modal('hide');
            $.get("/Products/ListOffer", function (data) {
                $("#_ShowLog").html(data);
            });
        }
        function sendApprove() {
            var rows = [];
            $('#tbl_approve tbody tr').each(function () {
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
                success: function () { },
                error: function () { }
            });
            $('#edit-person').modal('hide');
            $.get("/Products/ListOffer", function (data) {
                $("#_ShowLog").html(data);
            });
        }

        function apCostkey() {
                var countRow = document.getElementsByName('mCost[]').length;
                var tax = 0;
                var Total = 0;
                for (var i = 0; i < countRow; i++) {
                    costObj = $.trim(document.getElementsByName('mCost[]').item(i).innerHTML);
                    amountObj = $.trim(document.getElementsByName('mAmountApprove[]').item(i).value);
                    // sumObj = document.getElementsByName('sum[]').item(i).innerHTML;
                    document.getElementsByName('msum[]').item(i).innerHTML = (costObj * amountObj).toFixed(2);
                    Total += (costObj * amountObj)
                }
                tax = (Total * 0.07).toFixed(2);
                $("#modalSubTotal").html(Total.toFixed(2));
                $("#modalCalTax").html(tax);
                var grand = (parseFloat(Total) + parseFloat(tax)).toFixed(2);
                $("#modalGrandTotal").html(grand);
        }

        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }

    </script>
