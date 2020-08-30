<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="ThesisGamingStore.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    ReciveClaim
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   <h3 class="page-header">จัดการรับเคลมสินค้า</h3>
    <div class="row">
    <table id="tbl_orderList" class="table table-condensed table-striped table-bordered" cellspacing="0" width="100%">
        <thead>
            <tr>
                <th>
                   รหัสใบส่งเคลม
                </th>
                <th>
                   วันที่ส่งเคลม
                </th>
                <th>
                    ผู้ดำเนินการ
                </th>
                 <th>
                    บริษัทที่ส่งเคลม
                </th>
                <th></th>
            </tr>
        </thead>
        <tbody>
               <% foreach (var item in ViewData["ReceiveClaim"] as List<ReceiveClaimModel>)
               { %>
            <tr>
                <td>
                    <%: Html.DisplayFor(modelItem => item.CLMID)%>
                </td>
                <td>
                    <%: Html.DisplayFor(modelItem => item.CLMDate)%>
                </td>
                <td>
                    <%: Html.DisplayFor(modelItem => item.EmpName)%>
                </td>
                <td>
                    <%: Html.DisplayFor(modelItem => item.SupName)%>
                </td>
                <td>
                 <button type="button" class="btn btn-sm btn-primary" onClick="btnDetails('<%=item.CLMID %>')">ดูรายการ</button>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
        </div>
     <br />

    <div id="showDetails">
        <h4>แสดงสินค้าส่งเคลม</h4>
        <div class="row">
            <div class="col-md-6">
                <h5 id="showOffer">รหัสส่งใบเคลม : CLM00001</h5>
            </div>
          <%--  <div class="col-md-6 pull-right">
                <h5 id="showSup">บริษัท : </h5>
            </div>--%>
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
                                <%: Html.DisplayName("รหัสใบเคลมของร้าน") %>
                            </th>
                            <th>
                                <%: Html.DisplayName("รหัสใบเคลมของลูกค้า") %>
                            </th>
                            <th>
                                <%: Html.DisplayName("ชื่อสินค้า") %>
                            </th>
                            <th>
                                <%: Html.DisplayName("ปัญหา") %>
                            </th>
                            <th>
                                <%: Html.DisplayName("Serial") %>
                            </th>
                            <th>
                                <%: Html.DisplayName("Serialเปลี่ยน") %>
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
                 <div class="modal-footer ">
                     <p>
                      <button class="btn  btn-default" onclick="btnClr()">ปิด</button>
                    <button class="btn  btn-success" onclick="btnRe()">รับสินค้า</button>
                     </p>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    <script type="text/javascript">

        $(document).ready(function () {
            $("#showDetails").hide();
        });

        function btnDetails() {
            $('#tbl_showDetails tbody').empty();
            $("#showDetails").show();
                        $('#tbl_showDetails tbody').append(
                             '<tr>'
                             + '<td>' + '1'
                             + '</td><td>' + '-'
                             + '</td><td>' + 'MCL00001'
                             + '</td><td>' + 'Steelseries Merc Stealth'
                             + '</td><td>' + 'เซนเซอร์ไม่คงที่'
                             + '</td><td>' + 'CfvSM2FX'
                             + '</td><td>' + '<input type="text" placeholder="ใส่เลขซีเรียลนัมเบอร์ที่เปลี่ยน"/>'
                             + '</td></tr>');

                        $('#tbl_showDetails tbody').append(
                                        '<tr>'
                                        + '<td>' + '2'
                                        + '</td><td>' + '-'
                                        + '</td><td>' + 'MCL00001'
                                        + '</td><td>' + 'Steelseries Rival Fnatic Mouse'
                                        + '</td><td>' + 'คลิกเบิ้ล'
                                        + '</td><td>' + '3SONNeUm'
                                        + '</td><td>' + '<input type="text" placeholder="ใส่เลขซีเรียลนัมเบอร์ที่เปลี่ยน"/>'
                                        + '</td></tr>');

                        $('#tbl_showDetails tbody').append(
                                        '<tr>'
                                        + '<td>' + '3'
                                        + '</td><td>' + 'SCL00001'
                                        + '</td><td>' + ''
                                        + '</td><td>' + 'Steelseries  Rival Fnatic Mouse'
                                        + '</td><td>' + 'คลิกเบิ้ล'
                                        + '</td><td>' + 'rP8zAHOo'
                                        + '</td><td>' + '<input type="text" placeholder="ใส่เลขซีเรียลนัมเบอร์ที่เปลี่ยน"/>'
                                        + '</td></tr>');
        }
        function btnClr() {
            $("#showDetails").hide();
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
    <link href="../../Scripts/bootstrap-lightbox/ekko-lightbox.min.css" rel="stylesheet" />
    <script src="../../Scripts/bootstrap-lightbox/ekko-lightbox.min.js"></script>
</asp:Content>
