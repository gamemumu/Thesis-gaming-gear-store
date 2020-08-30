<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<%@ Import Namespace="ThesisGamingStore.Models" %>
<div class="modal-content">
    <div class="modal-header">
        <!--head-->
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 id="myModalLabel">รายละเอียดการชำระเงิน <small>รหัส : <%= ViewBag.SldID %> </small></h3>
    </div>
    <!--head-->
    <div style="padding:15px">
             <table class="table table-striped table-condensed" style="width:100%">
                <thead>
                    <tr>
                        <th style="width:3%">#</th>
                        <th  style="width:7%">รหัสขาย</th>
                          <th  style="width:13%">เลขที่บัญชี</th>
                          <th  style="width:13%">ธนาคาร</th>
                          <th  style="width:25%">ชื่อบัญชี</th>
                          <th  style="width:15%">วันที่แจ้งโอน</th>
                           <th  style="width:10%;text-align:right">ราคารวม</th>
                          <th  style="width:10%;text-align:right"">ยอดที่แจ้ง</th>
                          <th  style="width:5%">รูป</th>
                    </tr>
                </thead>
                <tbody>
                    <%var status = ""; %>
                    <% if (ViewData["PaymentDetail"] != null)
                       {
                           var i = 0;%>
                    <%foreach (var item in (List<PAYMENT>)ViewData["PaymentDetail"])
                      {%>
                    <% status = item.SELLPRODUCT.SlpStatus; %> 
                    <tr>
                        <td>
                           <%= i++ %>
                        </td>
                        <td>
                           <%=item.SlpID  %>
                        </td>
                        <td>
                           <%=item.BnkAccNumber %>
                        </td>
                        <td>
                           <%=item.BANK.BnkName %>
                        </td>
                        <td>
                          <%=item.BANK.BnkConName %>
                        </td>
                         <td>
                          <%=item.PayDate %>
                        </td>
                          <td style="text-align:right">
                         <p><%: Html.Raw(string.Format("{0:฿#,#}",item.SELLPRODUCT.SlpSum)) %></p>
                        </td>
                         <td style="text-align:right">
                         <p><%: Html.Raw(string.Format("{0:฿#,#}",item.PayPrice)) %></p>
                        </td>
                         <td>
                             <a href="<%=item.PayImg%>" data-toggle="lightbox">
                                <img src="<%=item.PayImg%>" class="img-responsive">
                            </a>
                        </td>
                    </tr>
                    <%}%>
                    <%} %>
                </tbody>
            </table>
        <%--</div>--%>
        <!--body-->
        <div class="modal-footer ">
            <!--footer-->
            <input placeholder="จำนวนเงินที่ขาด" id="iNofi" style="height: 35px;width:100px" class="pull-left" onkeypress="return isNumberKey(event)"/> 
            &nbsp&nbsp&nbsp<button class="btn btn-inverse btn-warning pull-left" type="submit" onclick="PaymentNofi('<%= ViewBag.SldID %>')">แจ้งชำระเงินไม่ครบ</button>
            <button class="btn btn-default pull-right" data-dismiss="modal" aria-hidden="true">ปิด</button>
            <%if (!status.Equals("ยืนยันการชำระเงิน") && !status.Equals("เตรียมจัดส่งสินค้า") && !status.Equals("ส่งของแล้ว") && !status.Equals("ชำระเงินไม่ครบ"))
              {%>
            <button class="btn btn-inverse btn-primary pull-right" type="submit" onclick="PaymentConfirm('<%= ViewBag.SldID %>')">ยืนยันการชำระเงิน</button>
            <%} %>
        </div>
        <!--footer-->
    </div>
</div>
