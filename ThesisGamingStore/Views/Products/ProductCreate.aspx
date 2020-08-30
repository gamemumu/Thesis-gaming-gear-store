<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.ProductModel>" %>

<%@ Import Namespace="ThesisGamingStore.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    ProductCreate
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h3 class="page-header">สร้างสินค้าใหม่</h3>
    <% using (Html.BeginForm("ProductCreate", "Products", FormMethod.Post, new { enctype = "multipart/form-data" }))
       { %>
    <%--<%: Html.AntiForgeryToken() %>--%>
    <%: Html.ValidationSummary(true) %>

    <div class="row">
        <div class="col-md-6">
            <div class="editor-label">
                <%: Html.Label("ประเภทสินค้า") %>
            </div>
            <div class="editor-field">
                <%: Html.DropDownListFor(model => model.TypeProductID, new SelectList(Enumerable.Empty<SelectListItem>()), new { style = "width:75%;height:30px;" })%>
                <%: Html.ValidationMessageFor(model => model.TypeProductID) %>
            </div>

            <div class="editor-label">
                <%: Html.Label("ยี่ห้อ และ รุ่นสินค้า") %>
            </div>
            <div class="editor-field">
                <%: Html.DropDownListFor(model => model.BrandID, new SelectList(Enumerable.Empty<SelectListItem>()), new { style = "width:75%;height:30px;" })%>
                <%: Html.ValidationMessageFor(model => model.BrandID) %>
            </div>

            <div class="editor-label">
                <%: Html.Label("สีสินค้า") %>
            </div>
            <div class="editor-field">
                <%: Html.DropDownListFor(model => model.ClrID, new SelectList(Enumerable.Empty<SelectListItem>()), new { style = "width:75%;height:30px;" })%>
                <%: Html.ValidationMessageFor(model => model.ClrID) %>
            </div>
            <div class="editor-label">
                <%: Html.Label("สถานะซีเรียลนัมเบอร์สินค้า") %>
            </div>
            <div class="editor-field">
                <%: Html.DropDownListFor(model => model.SerialStatus,ViewData["SerialStatus"] as List<SelectListItem>, new { style = "width:75%;height:30px;" }) %>
                <%: Html.ValidationMessageFor(model => model.SerialStatus) %>
            </div>
            <div class="editor-label">
                <%: Html.Label("ราคาที่ขาย") %>
            </div>
            <div class="editor-field">
                <%: Html.NumberFor(model => model.Price, new { @maxlength = 6,  onkeypress="return isNumberKey(event);" ,@style = "width:30%;"})%>
                <%: Html.ValidationMessageFor(model => model.Price) %>
            </div>
            <div class="editor-label">
                <%: Html.Label("กำหนดจุดสั่งซื้อ") %>
            </div>
            <div class="editor-field">
                <%: Html.NumberFor(model => model.ReorderPoint, new { @maxlength = 4,  onkeypress="return isNumberKey(event);" ,@style = "width:30%;"})%>
                <%: Html.ValidationMessageFor(model => model.ReorderPoint) %>
            </div>

            <div class="editor-label">
                <%: Html.LabelFor(model => model.Waranty) %>
            </div>
            <div class="editor-field">
                <%: Html.NumberFor(model => model.Waranty, new { @maxlength = 2,  onkeypress="return isNumberKey(event);" ,@style = "width:30%;"})%>
                <%: Html.ValidationMessageFor(model => model.Waranty) %>
            </div>

            <div class="editor-label">
                <%: Html.LabelFor(model => model.Description) %>
            </div>
            <div class="editor-field">
                <%: Html.TextAreaFor(model => model.Description, new { style = "width:75%;height:100px;" })%>
                <%: Html.ValidationMessageFor(model => model.Description) %>
            </div>

            <p>
                <input type="submit" value="Create" onclick="btnSubmit()" class="btn btn-lg btn-success" />
            </p>


            <%: Html.HiddenFor(model => model.TrdName)%>
            <%: Html.HiddenFor(model => model.BrandName)%>
            <%: Html.HiddenFor(model => model.TypeName)%>
            <%: Html.HiddenFor(model => model.SubAddress)%>
            <%: Html.HiddenFor(model => model.SupName)%>
            <% } %>

            <div>
                <%: Html.ActionLink("Back to List", "ListProduct") %>
            </div>
        </div>
        <div class="col-md-6">
            <h3>รูปภาพ</h3>
            <br />
            <div class="jquery-filestyle " style="display: inline;">
                <input type="file" accept="image/*" name="Photo" value="" multiple="multiple" data-size="350px" />
                <%: Html.ValidationMessageFor(model => model.Photo) %>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    <script type="text/javascript">

        function btnSubmit() {
            var type = $('select#TypeProductID option:selected').data("type");
            var trad = $('select#BrandID option:selected').data("trad");
            var brand = $('select#BrandID option:selected').data("brand");
            $("#TypeName").val(type); $("#TrdName").val(trad); $("#BrandName").val(brand);
        }

        var flagBrandChange = 0;
        $(document).ready(function () {
            $(":file").jfilestyle({ iconName: "icon-plus", size: "350px" });

            $("#TypeProductID").change(function () {
                if ($("#TypeProductID").val() != 0) {
                    if (flagBrandChange == 0) {
                        // ดึ่ง รุ่น
                        $.ajax({
                            type: 'Get',
                            url: "<%= Url.Action("JsonListBrandCheckProduct") %>", // we are calling json method
                            dataType: 'json',
                            success: function (data) {
                                $.each(data, function (i, obj) {
                                    $("#BrandID").append('<option value="' + obj.BrandID + '"data-brand="' + obj.BrandName + '" data-trad="' + obj.TrdName + '" >' + obj.TrdName + '  [ ' + obj.BrandName + ' ]</option>');
                                });
                                flagBrandChange = 1;
                            },
                            error: function (ex) {
                                alert('Failed to retrieve JsonListBrand' + ex);
                            }
                        });
                    }
                }
            });
            // ดึ่ง สี
            $.ajax({
                type: 'Get',
                url: "<%= Url.Action("JsonListColor") %>", // we are calling json method
                dataType: 'json',
                success: function (data) {
                    $.each(data, function (i, obj) {
                        $("#ClrID").append('<option value="' + obj.ClrID + '"data-color="' + obj.ClrName + '">' + obj.ClrName + '</option>');
                    });
                },
                error: function (ex) {
                    alert('Failed to retrieve JsonListColor' + ex);
                }
            });

            // ดึ่ง ประเภท
            $.ajax({
                type: 'Get',
                url: "<%= Url.Action("JsonListType") %>", // we are calling json method
                dataType: 'json',
                success: function (data) {
                    $("#TypeProductID").append('<option value=0>---- SELECT -----</option>');
                    $.each(data, function (i, obj) {
                        $("#TypeProductID").append('<option value="' + obj.TypeProductID + '"data-type="' + obj.TypeName + '">' + obj.TypeName + '</option>');
                    });
                },
                error: function (ex) {
                    alert('Failed to retrieve JsonListType' + ex);
                }
            });
        });

        function btnT() {
            var obj = []; var index = 0;
            if ($("input[name='case[]']:checked").length === 0) {
                alert("Select at least one Supplier")
            }
            else {
                $.each($("input[name='case[]']:checked").closest("td").siblings("td"),
                      function () {
                          if (index % 7 == 0) {
                              tmpObj = { PrdID: "", SupID: "" };
                              tmpObj.PrdID = $.trim($(this).text()).split(/\r\n|\r|\n/g).toString();
                              tmpObj.SupID = $("#SupID").val();
                              obj.push(tmpObj);
                          }
                          index++;
                      });
                console.log(JSON.stringify(obj))
                $.ajax({
                    type: "POST",
                    url: "<%= Url.Action("ProductSupCreate","Products")%>",
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(obj),
                    success: function () {
                        location.reload();
                    },
                    error: function () { }
                });
            }
        }

        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }
    </script>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <link href="../../Content/jquery-filestyle/css/jquery-filestyle.min.css" rel="stylesheet" />
    <script src="../../Content/jquery-filestyle/js/jquery-filestyle.min.js"></script>
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
