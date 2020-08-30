<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<ThesisGamingStore.Models.OfferDetailModel>>" %>
<%@ Import Namespace="ThesisGamingStore.Models" %>


<div class="modal-content">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 id="myModalLabel">สินค้าที่ผ่านอนุมัติ</h3>
        <div class="row">
            <div class="col-md-6">
                <h5>รหัสใบเสนอ : <%= ViewBag.OffID %> </h5>
            </div>
            <div class="col-md-6 pull-right">
                <h5>บริษัท : <%= ViewBag.SupName %></h5>
            </div>
        </div>
        </div>
        <div>
            <table class="table table-striped table-condensed" id="tbl_approve" style="width:100%">
                <thead>
                    <tr>
                        <th>
                            <%: Html.DisplayName("No.") %>
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
                        <td></td>

                    </tr>
                </thead>
                <tbody>
                    <% decimal total = 0;%>
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
                        <td>
                            <%: Html.DisplayFor(modelItem => item.Cost) %>
                        </td>
                        <td>
                            <%: Html.DisplayFor(modelItem => item.AmountPost) %>
                        </td>
                        <td>
                            <%: Html.DisplayFor(modelItem => item.AmountApprove) %>
                        </td>
                        <td>
                            <%--<button id="btnT" onclick="#"><i class="fa fa fa-times fa-1x"> </i></button>--%>
                        </td>
                        <% total += (item.Cost * item.AmountApprove); %>
                    </tr>
                    <% } %>
                   
                </tbody>
                <tfoot>
                     <tr>
                        <td>Total :</td>
                        <td colspan="10"><%=total%> Baht</td>
                    </tr>
                </tfoot>
            </table>
            <div class="modal-footer ">
                <button class="btn  btn-default" data-dismiss="modal" aria-hidden="true">ปิด</button>
            </div>
        </div>
    </div>