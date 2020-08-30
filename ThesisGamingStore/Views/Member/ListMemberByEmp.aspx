<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="ThesisGamingStore.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    ListMemberByEmp
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
 <h3 class="page-header">รายการสมาชิก</h3>
<p>
       <h4><%: Html.ActionLink("สร้างสมาชิกใหม่","SignupMemberByEmp","Member") %></h4>
    </p>
 <table id="tbl_List" class="table table-condensed table-striped table-bordered" cellspacing="0" width="100%">
        <thead>
    <tr>
        <th>
            <%: Html.DisplayName("รหัสสมาชิก") %>
        </th>
        <th>
            <%: Html.DisplayName("ชื่อ") %>
        </th>
        <th>
            <%: Html.DisplayName("นามสกุล") %>
        </th>
         <th>
            <%: Html.DisplayName("ที่อยู่") %>
        </th>
         <th>
            <%: Html.DisplayName("Email") %>
        </th>
        <th>
            <%: Html.DisplayName("เบอร์โทร") %>
        </th>
        <th></th>
    </tr>
</thead>
<tbody>
    <%if (ViewData["ListMemberByEmp"] != null)
      { %>
<% foreach (var item in ViewData["ListMemberByEmp"] as List<MEMBER>)
   { %>
    <tr>
        <td>
            <%: Html.DisplayFor(modelItem => item.MemID) %>
        </td>
         <td>
            <%: Html.DisplayFor(modelItem => item.MFname) %>
        </td>
        <td>
            <%: Html.DisplayFor(modelItem => item.MLname) %>
        </td>
         <td>
            <%: Html.DisplayFor(modelItem => item.MAddress) %>
        </td>
         <td>
            <%: Html.DisplayFor(modelItem => item.MEmail) %>
        </td>
        <td>
            <p>
                <%var i = 0; %>
            <%foreach (var ph in item.MEMBER_PHONE)
              { %>
                <%if (i > 1)
                  { %>
                <label class="pull-right">more</label>  
                  <%break; %>
                <%} %>
               <%=ph.Phone%><br />
                <%i++; %>
            <%} %>
                </p>
        </td>
        <td>
            <%: Html.ActionLink("Edit", "EditMemberByEmp", new { MemID = item.MemID /* id=item.PrimaryKey */ }) %> 
            <%--<%: Html.ActionLink("Delete", "DeleteMemberByEmp", new { MemID = item.MemID/* id=item.PrimaryKey */ }) %>--%>
            <a href="#" class="btn btn-sm btn-link"" data-toggle="modal" data-target="#proModal" onclick="btnDelete('<%=item.MemID %>')">Delete</a>
        </td>
    </tr>
<% } %>
     <%} %>
</tbody>    
</table>

    
     <!-- ModalDel -->
    <div class="modal fade" id="proModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title" id="myModalLabel">Are you sure you want to delete this?</h4>
                    <br />
                </div>
                <div class="modal-body">
                    .....
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <%--<button type="button" class="btn btn-primary">Save changes</button>--%>
                    <button type="button" id="btnDel" class="btn btn-danger" onclick="btnSend()">ยืนยันการลบ &nbsp<i class="fa fa-eraser fa-1x"></i></button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $("#tbl_List").DataTable({
                "bDestroy": true,
                "bScrollCollapse": true,
                "bJQueryUI": true,
                "bPaginate": true,
                "sScrollY": "100%",
                "sScrollHeadInner": false,
                "bInfo": true,
                "bFilter": true,
                "bSort": true,
                "aoColumnDefs": [{ "bSortable": false, "aTargets": [6] }],
                "order": [[0, 'asc']]
            });
        });
        function btnDelete(id) {
            $(".modal-body").html("ต้องการลบสมาชิกนี้หรือไม่" + "  : " + '<span id="delPro">' + id + '</span>');
        }
        function btnSend() {
            $.post("<%= Url.Action("DeleteMember","Member")%>",
                          { id: $("#delPro").html(), }
                      , function (data, status) {
                          $('#proModal').modal('hide');
                          //Refresh
                          location.reload();
         });
        }
    </script>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
        <script src="<%: Url.Content("~/Scripts/jquery.dataTables.min.js") %>" type="text/javascript"></script>
    <link href="/Content/bootstrap.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/dataTables.bootstrap.js"></script>
    <script src="<%: Url.Content("~/Scripts/dataTables.bootstrap.js") %>" type="text/javascript"></script>
    <script src="../../Scripts/jquery.tabletojson.min.js"></script>
    <script src="<%: Url.Content("~/Scripts/cdn.datatables.net/plug-ins/input.js") %>" type="text/javascript"></script>
    <script src="<%: Url.Content("~/Scripts/cdn.datatables.net/plug-ins/scrolling.js") %>" type="text/javascript"></script>
    <script src="<%: Url.Content("~/Scripts/cdn.datatables.net/plug-ins/select.js") %>" type="text/javascript"></script>
    <link href="../../Content/css/jquery.dataTables.css" rel="stylesheet" />
    <link href="../../Content/css/docs.min.css" rel="stylesheet" />
</asp:Content>