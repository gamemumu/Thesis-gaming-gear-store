<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Cart.Master" Inherits="System.Web.Mvc.ViewPage<ThesisGamingStore.Models._Payment>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    PayMent
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="step-one">
            <h2 class="heading">PAYMENT : <%=ViewData["SlpID"].ToString() %></h2>
        </div>
        <form id="PayMent" class="form-horizontal" enctype="multipart/form-data">
            <div class="shopper-informations">
                <div class="row">
                    <div class="col-sm-2">
                        <input hidden readonly name="SlpID" value="<%=ViewData["SlpID"].ToString() %>" />
                    </div>
                    <div class="col-sm-4 clearfix">
                        <div class="bill-to">
                            <p>SELECT BANK</p>
                            <div class="form-one" style="width: 100% !important;">
                                <%foreach (var item in (List<ThesisGamingStore.Models.BANK>)ViewData["BANK"])
                                  {%>
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="BnkAccNumber" value="<%=item.BnkAccNumber%>" style="margin-top: 30px">
                                        <%  var src = "";
                                            switch (item.BnkName)
                                            {
                                                case "ธนาคารกรุงเทพ": src = "../../images/bank/BBL.jpg"; break;
                                                case "ธนาคารกสิกรไทย": src = "../../images/bank/KBANK.jpg"; break;
                                                case "ธนาคารไทยพาณิชย์": src = "../../images/bank/SCB.jpg"; break;
                                                case "ธนาคารกรุงไทย": src = "../../images/bank/KTB.jpg"; break;
                                                case "ธนาคารกรุงศรีอยุธยา": src = "../../images/bank/KTB.jpg"; break;
                                            }%>
                                        <table>
                                            <tr>
                                                <td>
                                                    <img src="<%=src%>" alt="" height="65" width="65"></td>
                                                <td style="padding-left: 5px;"><%=item.BnkAccNumber %><br />
                                                    <%=item.BnkName %><br />
                                                    <%=item.BnkConName %>
                                                </td>
                                            </tr>
                                        </table>
                                    </label>
                                </div>
                                <hr />
                                <%} %>
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-6">
                        <div class="order-message">
                            <p>PAYMENT DETAIL</p>
                            <div class="form-group">
                                <label class="col-xs-2 control-label">วันเวลา</label>
                                <div class="col-xs-7 dateContainer">
                                    <div class="input-group date" id="datetimePicker">
                                        <input type="text" class="form-control" name="PayDate" placeholder="DD/MM/YYYY HH:mm" id="dateID" />
                                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-2 control-label">จำนวนเงิน</label>
                                <div class="col-xs-7 ">
                                    <div class="input-group">
                                        <div class="input-group-addon">฿</div>
                                        <input type="text" class="form-control" name="PayPrice" id="priceID" value="<%= ViewData["SlpSum"] %>"/>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-2 control-label">รูปภาพ</label>
                                <div class="col-xs-7 ">
                                    <div class="input-group">
                                        <input type="file" accept="image/*" name="Photo" value="" data-size="350px" id="picID" />
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-2 control-label"></label>
                                <div class="col-xs-7" style="text-align: right">
                                    <button type="submit" class="btn btn-primary">PAYMENT</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    <script type="text/javascript">
        var onCreate = true;
        $(document).ready(function () {
            $('.radio').find('input')[0].checked = true;
            $('#datetimePicker').datetimepicker({
                locale: 'th',
                format: 'DD/MM/YYYY HH:mm'
            });
            $('#PayMent').formValidation({
                framework: 'bootstrap',
                fields: {
                    PayDate: {
                        validators: {
                            notEmpty: {
                                message: 'The date is required'
                            },
                            date: {
                                format: 'DD/MM/YYYY HH:mm',
                                message: 'The value is not a valid date'
                            }
                        }
                    },
                    PayPrice: {
                        validators: {
                            notEmpty: {
                                message: 'The price is required'
                            },
                            numeric: {
                                message: 'The price must be a number'
                            }
                        }
                    },
                    Photo: {
                        validators: {
                            notEmpty: {
                                message: 'The photo is required'
                            },
                        }
                    }
                }
            })
                .on('success.form.fv', function (e) {
                    // Prevent form submission
                    e.preventDefault();
                    var $form = $(e.target),
                        fv = $form.data('formValidation');
                    data = new FormData($("#PayMent")[0]);

                    if (onCreate) {
                        onCreate = false;
                        // Use Ajax to submit form data
                        $.ajax({
                            url: "<%= Url.Action("PayMent","PayMent") %>",
                        type: 'POST',
                        // contentType: 'application/json',
                        contentType: false,
                        processData: false,
                        data: data,
                        success: function (result) {
                            if (result) {
                                setTimeout(function () {
                                    window.location.href = "/Member/MListOrder";
                                }, 500);
                            } else {
                                alert("ระบบมีความผิดพลาด");
                                setTimeout(function () {
                                    window.location.href = "/Shipping/Index";
                                }, 500);
                            }
                        }
                    });
                }
                });

            $('#datetimePicker').on('dp.change dp.show', function (e) {
                $('#PayMent').formValidation('revalidateField', 'PayDate');
            });
        });
    </script>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">

    <link href="../../Content/jquery-filestyle/css/jquery-filestyle.min.css" rel="stylesheet" />
    <script src="../../Content/jquery-filestyle/js/jquery-filestyle.min.js"></script>
    <script src="../../Scripts/jquery.mask.js"></script>
    <link href="../../Scripts/vendor/formValidation/css/formValidation.min.css" rel="stylesheet" />
    <script src="../../Scripts/vendor/formValidation/js/formValidation.min.js"></script>
    <script src="../../Scripts/vendor/formValidation/framework/bootstrap.min.js"></script>
    <link href="../../Scripts/vendor/formValidation/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <%--  <script src="../../Scripts/momentjs/2.8.2/moment.min.js"></script>
    <script src="../../Scripts/vendor/formValidation/js/bootstrap-datetimepicker.min.js"></script>--%>
    <script src="//cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
    <script src="//cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/d004434a5ff76e7b97c8b07c01f34ca69e635d97/src/js/bootstrap-datetimepicker.js"></script>
    <style type="text/css">
        /**
 * Override feedback icon position
 * See http://formvalidation.io/examples/adjusting-feedback-icon-position/
 */
        #meetingForm .dateContainer .form-control-feedback {
            top: 0;
            right: -15px;
        }
    </style>
</asp:Content>
