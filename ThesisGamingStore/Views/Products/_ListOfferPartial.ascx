<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<ThesisGamingStore.Models.OfferModel>>" %>
 <%--id="ListOff"--%>
<table id="ListOff"  class="display"  cellspacing="0" width="100%">
                 <thead>
                    <tr>
                        <th>
                            <%: Html.DisplayName("Offer ID") %>
                        </th>
                       <%-- <th>
                            <%: Html.DisplayName("Emp ID") %>
                        </th>--%>

                       <%-- <th>
                            <%: Html.DisplayName("ผู้เสนอ") %>
                        </th>--%>

                       <%-- <th>
                            <%: Html.DisplayName("บริษัท") %>
                        </th>--%>

                        <th>
                            <%: Html.DisplayName("วันที่เสนอ") %>
                        </th>

                        <th>
                            <%: Html.DisplayName("สถานะ") %>
                        </th>

                        <th>
                           
                        </th>
                    </tr>
                </thead>
<% foreach (var item in Model) { %>
    <tr>
        <td>
            <%: Html.DisplayFor(modelItem => item.OffID) %>
        </td>
      <%--  <td>
            <%: Html.DisplayFor(modelItem => item.EmpID) %>
        </td>--%>
      <%--  <td>
            <%: Html.DisplayFor(modelItem => item.EmpName) %>
        </td>--%>
       <%-- <td>
            <%: Html.DisplayFor(modelItem => item.SupName) %>
        </td>--%>
        <td>
            <%: Html.DisplayFor(modelItem => item.OffDate) %>
        </td>
        <td>
            <% if(item.OffStatus.Equals("Approve")){ %>
            <span style="color:#4F8A10;">
                <%: Html.DisplayFor(modelItem => item.OffStatus) %>
                </span>
            <%}else{ %>
                    <span style="color: red">
              <%: Html.DisplayFor(modelItem => item.OffStatus) %>
                </span>
            <%} %>
        </td>
        <td>
            <%--<%: Html.ActionLink("Edit", "Edit", new { OffID= item.OffID/* id=item.PrimaryKey */ }) %> |--%>
             <% if(item.OffStatus.Equals("Approve")){ %>
                  <%: Html.ActionLink("Details", "ApproveOffer", "Products", new { id = item.OffID,@SupName = item.SupName ,@Approve = "Approve"}, new {  @class = "btn btn-small btn-success edit-person" })%>
            <%}else{ %>
               <%: Html.ActionLink("Details", "ApproveOffer", "Products", new { id = item.OffID,@SupName = item.SupName}, new {  @class = "btn btn-small btn-info edit-person" })%>
            <%} %>
            <%--<%: Html.ActionLink("Delete", "Delete", new { OffID= item.OffID/* id=item.PrimaryKey */ }) %>--%>
        </td>
    </tr>
<% } %>

</table>

<div class="modal  fade in" id="edit-person" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div id="edit-person-container" class="modal-dialog modal-lg"></div>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        $("#ListOff").dataTable({
            //"scrollCollapse": true,
            "aaSorting": [[1, 'desc']],
            "autoWidth": false,
            "paging": false,
        });
    });
    $(function () {

        ////Optional: turn the chache off
        //$.ajaxSetup({ cache: false });

        $('.edit-person').click(function () {
            //var url = "/Bootstrap/EditPerson"; // the url to the controller
            var id = $(this).attr('id');
            $('#edit-person-container').load(this.href + '/' + id, function () {
                $('#edit-person').modal({
                    backdrop: 'static',
                    keyboard: true
                }, 'show');
                bindForm(this);
            });
            return false;
        });
    });

    function bindForm(dialog) {
        $('form', dialog).submit(function () {
            $.ajax({
                url: this.action,
                type: this.method,
                data: $(this).serialize(),
                success: function (result) {
                    $('#edit-person').modal('hide');
                    //if (result.success) {
                    //    $('#edit-person').modal('hide');
                    //    // Refresh:
                    //    // location.reload();
                    //} else {
                    //    $('#edit-person-container').html(result);
                    //    bindForm();
                    //}
                }
            });
            return false;
        });
    }
</script>