<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Cart.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    CheckOut
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <section id="cart_items">
        <div class="container">
            <div class="breadcrumbs">
                <ol class="breadcrumb">
                    <li><a href="/Shipping/Index">Home</a></li>
                    <li class="active">Check out</li>
                </ol>
            </div>
            <!--/breadcrums-->

            <div class="step-one">
                <h2 class="heading">Bill to</h2>
            </div>
            <!--form-->
            <div class="container">
                <div class="row">
                    <form action="#" role="form" data-toggle="validator" id="CheckOutForm">
                        <div class="col-sm-4 col-sm-offset-1">
                            <div class="login-form">
                                <!--signup form-->
                                <h2>ข้อมูลสถานที่จัดส่งเดิม</h2>
                                <div class="form-group">
                                    <label for="inputName" class="control-label">First Name</label>
                                    <input type="text" class="form-control" id="OFName" name="OFName" placeholder="<%=Session["MFname"]%>" readonly style="background-color: #fff !important">
                                </div>
                                <div class="form-group">
                                    <label for="inputName" class="control-label">Last Name</label>
                                    <input type="text" class="form-control" id="OLName" name="OLName" placeholder="<%=Session["MLname"]%>" readonly style="background-color: #fff !important">
                                </div>
                                <div class="form-group">
                                    <label class="control-label" for="textarea-field">Address</label>
                                    <textarea class="form-control" id="Otextarea-field" placeholder="<%=Session["MAddress"]%>" name="Oaddress" rows="5" readonly style="background-color: #fff !important"></textarea>
                                </div>
                                <div class="form-group">
                                    <label class="checkbox-inline">
                                        <input type="checkbox" style="height: auto" value="OldAdress" id="checkBoxAddress" checked="checked">ส่งตามที่อยู่จัดส่งเดิม
                                    </label>
                                </div>
                                <%--</form>--%>
                            </div>
                            <!--/signup form-->
                        </div>
                        <div class="col-sm-1">
                            <h2 class="or">OR</h2>
                        </div>
                        <div class="col-sm-4">
                            <div class="signup-form">
                                <!--sign up form-->
                                <h2>ข้อมูลสถานที่จัดส่งใหม่</h2>
                                <div class="form-group">
                                    <label for="inputName" class="control-label">First Name</label>
                                    <input type="text" class="form-control" id="inputFName" name="inputFName" placeholder="First Name" required readonly onkeypress="return textonly(event);">
                                </div>
                                <div class="form-group">
                                    <label for="inputName" class="control-label">Last Name</label>
                                    <input type="text" class="form-control" id="inputLName" name="inputLName" placeholder="Last Name" required readonly onkeypress="return textonly(event);">
                                </div>
                                <div class="form-group">
                                    <label class="control-label" for="textarea-field">Address</label>
                                    <textarea class="form-control" id="textarea-field" placeholder="Your Address" name="address" rows="5" required readonly></textarea>
                                </div>
                            </div>
                            <!--/sign up form-->
                        </div>
                    </form>
                </div>
            </div>


            <div class="review-payment">
                <h2>Review & Payment</h2>
            </div>
            <div id="your_cart_items"></div>

        </div>
    </section>
    <!--/#cart_items-->
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    <script type="text/javascript">
        function ConfirmOrder() {
            if ($('#checkBoxAddress')[0].checked) {
                $.post("<%= Url.Action("CheckOut","Shipping") %>", { name: "", lname: "", address: "" },
                    function (data, status) {
                        if (data.success) {
                            alert("การสั่งซื้อเสร็จสิ้น . . .")
                            setTimeout(function () {
                                window.location.href = "/Member/MListOrder";
                            }, 1000);
                        } else {
                            alert("การสั่งซื้อมีข้อผิดพลาด . . .");
                            setTimeout(function () {
                                window.location.href = "/Shipping/Index";
                            }, 1000);
                        }
                    });
            } else {
                if ($('#inputFName').val().trim().length > 0 && $('#inputLName').val().trim().length > 0 && $('#textarea-field').val().trim().length > 0) {
                    $.post("<%= Url.Action("CheckOut","Shipping") %>", { name: $('#inputFName').val(), lname: $('#inputLName').val(), address: $('#textarea-field').val() },
                        function (data, status) {
                            if (data.success) {
                                alert("การสั่งซื้อเสร็จสิ้น . . .")
                                setTimeout(function () {
                                    window.location.href = "/Member/MListOrder";
                                }, 1000);
                            } else {
                                alert("การสั่งซื้อมีข้อผิดพลาด . . .");
                                setTimeout(function () {
                                    window.location.href = "/Shipping/Index";
                                }, 1000);
                            }
                        });
                } else {
                    $("#CheckOutForm").data('formValidation').validate();
                }
            }
        }

        $(document).ready(function () {
            $('#checkBoxAddress').click(function () {
                if (this.checked) {
                    $("#inputFName").prop('readonly', true);
                    $("#inputLName").prop('readonly', true);
                    $("#textarea-field").prop('readonly', true);
                    $('#OFName').attr('style', 'background-color:#fff !important');
                    $('#OLName').attr('style', 'background-color:#fff !important');
                    $('#Otextarea-field').attr('style', 'background-color:#fff !important');
                } else {
                    $("#inputFName").prop('readonly', false);
                    $("#inputLName").prop('readonly', false);
                    $("#textarea-field").prop('readonly', false);
                    $('#OFName').attr('style', 'background-color:#eee !important');
                    $('#OLName').attr('style', 'background-color:#eee !important');
                    $('#Otextarea-field').attr('style', 'background-color:#eee !important');
                }
            });
            $.get("<%= Url.Action("getSessionCart","Shipping") %>", { Status: "ConfirmCheckOut" }, function (data, status) { $("#your_cart_items").html(data); });
            nofi();

            $('#CheckOutForm').formValidation({
                framework: 'bootstrap',
                fields: {
                    inputFName: {
                        validators: {
                            notEmpty: {
                            },
                            regexp: {
                                regexp: /^[a-z\s]+$/i,
                                message: 'The first name can consist of alphabetical characters and spaces only'
                            }
                        }
                    },
                    inputLName: {
                        validators: {
                            notEmpty: {
                            },
                            regexp: {
                                regexp: /^[a-z\s]+$/i,
                                message: 'The last name can consist of alphabetical characters and spaces only'
                            }
                        }
                    },
                    address: {
                        validators: {
                            notEmpty: {
                                message: 'The address can consist of alphabetical characters and spaces only'
                            }
                        }
                    }
                }
            });
        });//docready

        function deleteItem(id) {
            event.preventDefault();
            $.post("<%= Url.Action("DeleteCart","Shipping") %>", { id: id, Status: "ConfirmCheckOut" }, function (data, status) {
                if (data == false)
                    window.location.href = "/Shipping/Index";
                $("#your_cart_items").html(data); nofi();
            });
            }
            function upANDdown(id, flag) {
                event.preventDefault();
                $.post("<%= Url.Action("Quantity","Shipping") %>", { id: id, flag: flag, Status: "ConfirmCheckOut" }, function (data, status) { $("#your_cart_items").html(data); nofi(); });
            }
           
            function textonly(e) {
                var code;
                if (!e) var e = window.event;
                if (e.keyCode) code = e.keyCode;
                else if (e.which) code = e.which;
                var character = String.fromCharCode(code);
                var AllowRegex = /^[\ba-zA-Z\s-]$/;
                if (AllowRegex.test(character)) return true;
                return false;
            }
    </script>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <script src="../../Scripts/jquery.mask.js"></script>
    <link href="../../Scripts/vendor/formValidation/css/formValidation.min.css" rel="stylesheet" />
    <script src="../../Scripts/vendor/formValidation/js/formValidation.min.js"></script>
    <script src="../../Scripts/vendor/formValidation/framework/bootstrap.min.js"></script>
</asp:Content>
