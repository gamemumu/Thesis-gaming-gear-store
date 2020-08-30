<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.PositionModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    ListPosit
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


      <h3 class="page-header">รายการตำแหน่ง</h3>
    <p>
        <h4><%: Html.ActionLink("สร้างตำแหน่งใหม่","CreatePos2","Dep_Pos") %></h4>
    </p>

    <% if (ViewData["Listpos"] != null)
       { %>
    <table id="tbl_PostList" class="table table-condensed table-striped table-bordered" cellspacing="0" width="80%">
        <thead>
            <tr>
                <th>
                    <%: Html.DisplayNameFor(model => model.DepName) %>
                </th>
                <th style="width: 20%">
                    <%: Html.DisplayNameFor(model => model.PosID) %>
                </th>
               <%-- <th>
                    <%: Html.DisplayNameFor(model => model.DepName) %>
                </th>--%>
                <th>
                    <%: Html.DisplayNameFor(model => model.PosName) %>
                </th>
                
                <th style="width: 20%"></th>
            </tr>
        </thead>
        <tbody>
            <% foreach (var item in ViewData["Listpos"] as List<ThesisGamingStore.Entity.PositionsEntity>)
               { %>

            <tr>
                 <td>
                    <%: Html.DisplayFor(modelItem => item.DepName) %>
                </td>
                <td style="width: 20%">
                    <%: Html.DisplayFor(modelItem => item.PosID) %>
                </td>
              <%--  <td>
                    <%: Html.DisplayFor(modelItem => item.DepID) %>
                </td>--%>
                <td>
                    <%: Html.DisplayFor(modelItem => item.PosName) %>
                </td>
                <td style="width: 20%">
                    <%: Html.ActionLink("Edit", "EditPosInRole", new { PosID = item.PosID, DepID = item.DepID ,PosName=item.PosName ,DepName = item.DepName /* id=item.PrimaryKey */}) %>
                    <%--<%: Html.ActionLink("Delete", "DeletePos",new { PosID = item.PosID /* id=item.PrimaryKey */}) %>--%>
                    <button type="button" class="btn btn-sm btn-link" data-toggle="modal" data-target="#posModal" onclick="btnT('<%:item.PosID %>','<%:item.PosName %>')">Delete &nbsp <i class="fa fa-eraser"></i></button>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
    <% } %>

    <!-- ModalOrder -->
    <div class="modal fade" id="posModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
            $("#tbl_PostList").dataTable({
                "bDestroy": true,
                "bScrollCollapse": true,
                "bJQueryUI": true,
                "bPaginate": false,
                "bInfo": true,
                "bFilter": true,
                "bSort": true,
            });
        });
        function btnT(posID,posName) {
            $(".modal-body").html("ต้องการลบตำแหน่งนี้หรือไม่" + "  : " + '<span id="delpos">' + posID + "  &nbsp "+posName +'</span>');
        }

        function btnSend() {
            $.post("<%= Url.Action("DeletePos","Dep_Pos")%>",
                      { id: $("#delpos").html(), }
                  , function (data, status) {
                      $('#posModal').modal('hide');
                      //Refresh
                      location.reload();
                  });
           <%-- $.ajax({
                type: "POST",
                url: "<%= Url.Action("DeletePos","Dep_Pos")%>",
                dataType: 'json',
                data: { id: $("#delpos").html() },
                success: function () {
                    $('#posModal').modal('hide');
                    //Refresh
                    location.reload();
                },
                error: function () { }
            });--%>
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
