<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models.ProductModel>" %>

<%@ Import Namespace="ThesisGamingStore.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    EditProduct
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

     <h3 class="page-header">Edit Product</h3>
    <% using (Html.BeginForm("EditProduct", "Products", FormMethod.Post, new { enctype = "multipart/form-data" }))
       { %>
    <%--<%: Html.AntiForgeryToken() %>--%>
    <%: Html.ValidationSummary(true) %>

    <div class="row">
        <div class="col-md-6">
            <div class="editor-label">
                <%: Html.Label("ประเภทสินค้า") %>
            </div>
            <div class="editor-field">
                <%: Html.DropDownListFor(model => model.TypeProductID, new SelectList(Enumerable.Empty<SelectListItem>()), new { style = "width:70%;height:30px;background-color: ButtonFace;"})%>
                 <button type="button" id="myButton" data-loading-text="Loading..." class="btn btn-sm btn-info" autocomplete="off" onclick="Change()">Change</button>
                <%: Html.ValidationMessageFor(model => model.TypeProductID) %>
                <%: Html.HiddenFor(model => model.TypeProductID,new {id = "_TypeProductID"}) %>
            </div>

            <div class="editor-label">
                <%: Html.Label("ยี่ห้อ และ รุ่นสินค้า") %>
            </div>
            <div class="editor-field">
                <%: Html.DropDownListFor(model => model.BrandID, new SelectList(Enumerable.Empty<SelectListItem>()), new { style = "width:70%;height:30px;background-color: ButtonFace;" })%>
                <%: Html.ValidationMessageFor(model => model.BrandID) %>
                <%: Html.HiddenFor(model => model.BrandID,new {id = "_BrandID"}) %>
            </div>

            <div class="row">
                 <div class="col-md-4">
                     <div class="editor-label">
                        <%: Html.Label("สีสินค้าเดิม") %>
                    </div>
                    <div class="editor-field">
                        <div class="editor-field">
                        <%: Html.TextBoxFor(model => model.ClrName,new { disabled="disabled", @readonly = "readonly",style = "background-color: ButtonFace !important;"}) %>
                        <%: Html.ValidationMessageFor(model => model.ClrName) %>
                    </div>
                 </div>
                </div>
                  <div class="col-md-6">
                    <div class="editor-label">
                        <%: Html.Label("สีสินค้า") %>
                    </div>
                    <div class="editor-field">
<%--                        <%: Html.DropDownListFor(model => model.ClrID, new SelectList(Enumerable.Empty<SelectListItem>()), new { style = "width:70%;height:30px;background-color: ButtonFace;" })%>--%>
                        <%: Html.DropDownListFor(model => model.ClrID, new SelectList(Enumerable.Empty<SelectListItem>()), new { style = "width:70%;" })%>
                        <%: Html.ValidationMessageFor(model => model.ClrID) %>
                        <%: Html.HiddenFor(model => model.ClrID,new {id = "_ClrID"}) %>
                    </div>
                  </div>
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
                <%: Html.NumberFor(model => model.Waranty,new { style = "width:30%;" })%>
                <%: Html.ValidationMessageFor(model => model.Waranty) %>
            </div>

            <div class="editor-label">
                <%: Html.LabelFor(model => model.Description) %>
            </div>
            <div class="editor-field">
                <%: Html.TextAreaFor(model => model.Description, new { style = "width:70%;height:100px;" })%>
                <%: Html.ValidationMessageFor(model => model.Description) %>
            </div>

            <p>
                <input type="submit" value="SAVE" onclick="btnSubmit()" />
            </p>

            <%: Html.HiddenFor(model => model.PrdID)%>
            <%: Html.HiddenFor(model => model.TrdName)%>
            <%: Html.HiddenFor(model => model.BrandName)%>
            <%: Html.HiddenFor(model => model.TypeName)%>
            <%: Html.HiddenFor(model => model.SubAddress)%>
            <%: Html.HiddenFor(model => model.SupName)%>


            <div>
                <%: Html.ActionLink("Back to List", "ListProduct") %>
            </div>
        </div>
        <div class="col-md-6">
            <h3>รูปภาพ</h3>
            <br />
            <% if (ViewData["Photo"] != null)
               { %>
            <% foreach (var item in ViewData["Photo"] as List<ThesisGamingStore.Entity.PhotoEntity>)
               { %>
            <%:Html.Image(item.Photo, item.PhotoID.ToString(), "80")%>
            <%} %>
            <hr />
            <div class="jquery-filestyle " style="display: inline;">
                <input type="file" accept="image/*" name="Photo" value="" multiple="multiple" data-size="350px" />
                <%: Html.ValidationMessageFor(model => model.Photo) %>
            </div>
        </div>
        <% } %>
        <%} %>
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

        var flagSup = 0; var flagBrandChange = 0;
        $(document).ready(function () {
            $(":file").jfilestyle({ iconName: "icon-plus", size: "350px" });
            flag = 0;

            // ดึ่ง ประเภท
           <%-- $.ajax({
                type: 'Get',
                url: "<%= Url.Action("JsonListType") %>", // we are calling json method
                dataType: 'json',
                success: function (data) {
                    $.each(data, function (i, obj) {
                        if ($("#_TypeProductID").val() == obj.TypeProductID) {
                            $("#TypeProductID").append('<option value="' + obj.TypeProductID + '"data-type="' + obj.TypeName + '">' + obj.TypeName + '</option>');
                        }
                    });
                },
                error: function (ex) {
                    alert('Failed to retrieve JsonListType' + ex);
                }
            });--%>

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
            $("#ClrID").empty();
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

            // ดึ่ง ยี่ห้อ และ รุ่น
            $.ajax({
                type: 'POST',
                url: "<%= Url.Action("JsonListBrandSupID") %>", // we are calling json method
                dataType: 'json',
                data: { id: $("#SupID").val() },
                success: function (data) {
                    $.each(data, function (i, obj) {
                        if ($("#_BrandID").val() == obj.BrandID) {
                            $("#BrandID").append('<option value="' + obj.BrandID + '"data-brand="' + obj.BrandName + '" data-trad="' + obj.TrdName + '" >' + obj.TrdName + '  [ ' + obj.BrandName + ' ]</option>');
                        }
                    });
                },
                error: function (ex) {
                    alert('Failed to retrieve JsonListBrand' + ex);
                }
            });
             <%--$.ajax({
                type: 'Get',
                url: "<%= Url.Action("JsonListSupplier","Supplier") %>", // we are calling json method
                dataType: 'json',
                success: function (data) {
                    $.each(data, function (i, obj) {
                        if ($("#_SupID").val() == obj.SupID) {
                            $("#SupID").append('<option value="' + obj.SupID + '">' + obj.SupName + '</option>');
                        }
                    });
                },
                error: function (ex) {
                    alert('Failed to retrieve Department' + ex);
                }
            });--%>
            


        <%--    $("#SupID").change(function () {
                if ($("#SupID").val() != 0) {

                    // ดึ่ง ยี่ห้อ และ รุ่น
                    $("#BrandID").empty();
                    $.ajax({
                        type: 'POST',
                        url: "<%= Url.Action("JsonListBrandSupID") %>", // we are calling json method
                        dataType: 'json',
                        data: { id: $("#SupID").val() },
                        success: function (data) {
                            $.each(data, function (i, obj) {
                                $("#BrandID").append('<option value="' + obj.BrandID + '"data-brand="' + obj.BrandName + '" data-trad="' + obj.TrdName + '" >' + obj.TrdName + '  [ ' + obj.BrandName + ' ]</option>');
                            });
                            flagSup = 1;
                        },
                        error: function (ex) {
                            alert('Failed to retrieve JsonListBrand' + ex);
                        }
                    });
                } else {
                    $("#BrandID").empty();
                }
            });--%>
        });

        var flag = 0;
        function Change() {
            $("select").css("background-color", "white");
            if (flag == 0) {
                $("#BrandID").empty();
                // ดึ่ง บริษัทคู่ค้า
                $("#SupID").empty();
                $.ajax({
                    type: 'Get',
                    url: "<%= Url.Action("JsonListSupplier","Supplier") %>", // we are calling json method
                    dataType: 'json',
                    success: function (data) {
                        $("#SupID").append('<option value=0>---- SELECT -----</option>');
                        $.each(data, function (i, obj) {
                            $("#SupID").append('<option value="' + obj.SupID + '"data-supname="' + obj.SupName + '" data-subaddress="' + obj.SubAddress + '">' + obj.SupName + '</option>');
                        });
                    },
                    error: function (ex) {
                        alert('Failed to retrieve JsonListType' + ex);
                    }
                });
                // ดึ่ง สี
                $("#ClrID").empty();
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
                $("#TypeProductID").empty();
                $.ajax({
                    type: 'Get',
                    url: "<%= Url.Action("JsonListType") %>", // we are calling json method
                    dataType: 'json',
                    success: function (data) {
                        $.each(data, function (i, obj) {
                            $("#TypeProductID").append('<option value="' + obj.TypeProductID + '"data-type="' + obj.TypeName + '">' + obj.TypeName + '</option>');
                        });
                    },
                    error: function (ex) {
                        alert('Failed to retrieve JsonListType' + ex);
                    }
                });
            }
        }
    </script>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <link href="../../Content/jquery-filestyle/css/jquery-filestyle.min.css" rel="stylesheet" />
    <script src="../../Content/jquery-filestyle/js/jquery-filestyle.min.js"></script>
</asp:Content>
