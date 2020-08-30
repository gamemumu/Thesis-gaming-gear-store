<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/MasterGaming.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    ViewReport
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h3 class="page-header">จัดการออกรายงาน</h3>

    <div class="row">
        <div class="col-lg-3 col-md-6">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-xs-2">
                            <i class="fa fa-eye fa-3x"></i>
                        </div>
                        <div class="col-xs-10 text-right">
                            <div class="huge" style="font-size: 20px !important">สรุปยอดขาย</div>
                            <div style="font-size: 13px !important">ตามช่วงเวลา</div>
                        </div>
                    </div>
                </div>
                <a href="#" onclick="GetViewReport('1')">
                    <div class="panel-footer">
                        <span class="pull-left">View Details</span>
                        <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                        <div class="clearfix"></div>
                    </div>
                </a>
            </div>
        </div>
        <div class="col-lg-3 col-md-6">
            <div class="panel panel-green">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-xs-2">
                            <i class="fa fa-eye fa-3x"></i>
                        </div>
                        <div class="col-xs-10 text-right">
                            <div class="huge" style="font-size: 20px !important">สรุปกำไรขาดทุน</div>
                            <div style="font-size: 13px !important">ตามช่วงเวลา</div>
                        </div>
                    </div>
                </div>
                <a href="#" onclick="GetViewReport('2')">
                    <div class="panel-footer">
                        <span class="pull-left">View Details</span>
                        <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                        <div class="clearfix"></div>
                    </div>
                </a>
            </div>
        </div>
        <div class="col-lg-3 col-md-6">
            <div class="panel panel-yellow">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-xs-2">
                            <i class="fa fa-eye fa-3x"></i>
                        </div>
                        <div class="col-xs-10 text-right">
                            <div class="huge" style="font-size: 20px !important">สรุปการเคลมสินค้า</div>
                            <div style="font-size: 13px !important">&nbsp</div>
                        </div>
                    </div>
                </div>
                <a href="#" onclick="GetViewReport('3')">
                    <div class="panel-footer">
                        <span class="pull-left">View Details</span>
                        <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                        <div class="clearfix"></div>
                    </div>
                </a>
            </div>
        </div>
        <div class="col-lg-3 col-md-6">
            <div class="panel panel-red">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-xs-2">
                            <i class="fa fa-eye fa-3x"></i>
                        </div>
                        <div class="col-xs-10 text-right">
                            <div class="huge" style="font-size: 20px !important">สรุปยอดขายรายปี</div>
                            <div style="font-size: 13px !important">ของสินค้าแต่ละประเภท</div>
                        </div>
                    </div>
                </div>
                <a href="#" onclick="GetViewReport('4')">
                    <div class="panel-footer">
                        <span class="pull-left">View Details</span>
                        <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                        <div class="clearfix"></div>
                    </div>
                </a>
            </div>
        </div>
    </div>

    <div class="panel panel-info" id="panelChange">
        <div class="panel-heading" style="font-size: 20px">
            <span id="headId">จัดการออกรายงาน</span>
            <div class="pull-right"><i class="fa fa-calendar-o"></i>&nbsp<%=System.DateTime.Today.ToString("dddd") %> &nbsp<%=System.DateTime.Today.ToString("dd/MM/yyyy") %></div>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-md-3" id="yearId" style="display: none">
                </div>
                <div class="col-md-7 col-md-offset-3" id="optionId" style="display: none">
                    <div class="list-group">
                        <span class="range range-info">
                            <output>วันเริ่มต้น</output>
                            &nbsp<span class="span12">
                                <input id="ProMStartDate" type="text" value="" style="width: 200px;" readonly="readonly">
                            </span>
                            <output>ถึง</output>
                            &nbsp<span class="span12">
                                <input id="ProMEndDate" class="input-fix-mousewheel1" type="text" value="" style="width: 200px;" readonly>
                            </span>
                            &nbsp<span class="span12">
                                <button class="btn btn-info btn-sm" onclick="_GetData()"><i class="fa fa-search"></i></button>
                            </span>
                        </span>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12" id="DataReport"></div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    <script type="text/javascript">
        jQuery.validator.addMethod("isValid", function (value, element) {
            var startDate = $('#ProMStartDate').val();
            var finDate = $('#ProMEndDate').val();
            return Date.parse(startDate) < Date.parse(finDate);
        }, "* End date must be after start date");
        jQuery(function ($) {
            //ตั้งหน้าแรก
            GetViewReport(4);

            jQuery('#ProMStartDate').datetimepicker({
                format: 'd/m/Y',
                onShow: function (ct) {
                    this.setOptions({
                        //  minDate: 0,
                        maxDate: jQuery('#ProMEndDate').val() ? jQuery('#ProMEndDate').val() : false, formatDate: 'd/m/Y'
                    })
                },
                timepicker: false,
                //    step: 60,
                // lang: 'en',
            });
            jQuery('#ProMEndDate').datetimepicker({
                format: 'd/m/Y',
                onShow: function (ct) {
                    this.setOptions({
                        minDate: jQuery('#ProMStartDate').val() ? jQuery('#ProMStartDate').val() : false, formatDate: 'd/m/Y'
                    })
                },
                timepicker: false,
                //   step: 60,
                //lang: 'en',
            });

        });
        var clickid = 0;
        function GetViewReport(id) {
            var Color = ""; var oldColor = "";
            if ($("#panelChange").hasClass('panel-info')) {
                oldColor = "panel-info";
            } else if ($("#panelChange").hasClass('panel-primary')) {
                oldColor = "panel-primary";
            } else if ($("#panelChange").hasClass('panel-green')) {
                oldColor = "panel-green";
            } else if ($("#panelChange").hasClass('panel-yellow')) {
                oldColor = "panel-yellow";
            } else if ($("#panelChange").hasClass('panel-red')) {
                oldColor = "panel-red";
            }

            if (id == 1) {
                Color = "panel-primary";
                $("#optionId").show();
                $("#headId").text("สรุปยอดขายตามช่วงเวลา");
                $("#panelChange").removeClass(oldColor).addClass(Color);
                $("#optionId").show();
                $("#yearId").hide();
                clickid = 1;
                $("#yearId").html("");
            } else if (id == 2) {
                Color = "panel-green";
                $("#optionId").show();
                $("#headId").text("สรุปกำไรขาดทุนตามช่วงเวลา");
                $("#panelChange").removeClass(oldColor).addClass(Color);
                $("#optionId").show();
                $("#yearId").hide();
                clickid = 2;
                $("#yearId").html("");
            } else if (id == 3) {
                Color = "panel-yellow";
                $("#headId").text("สรุปการเคลมสินค้า");
                $("#panelChange").removeClass(oldColor).addClass(Color);
                $("#optionId").hide();
                $("#yearId").hide();
                clickid = 3;
                $("#yearId").html("");
                //temp
                $.post("<%= Url.Action("DataClaimReport","Report")%>",
                   {
                       dStart: "07/04/2015",
                       dEnd: "08/04/2015"
                   },
                 function (data) {
                     $('#DataReport').html(data);
                 });
            } else if (id == 4) {
                Color = "panel-red";
                $("#headId").text("สรุปยอดขายรายปีของสินค้าแต่ละประเภท");
                $("#panelChange").removeClass(oldColor).addClass(Color);
                $("#optionId").hide();
                $("#yearId").show();
                if (clickid != 4) {
                    clickid = 4;
                    $.ajax({
                        type: 'Get',
                        url: "<%= Url.Action("JsonGetYear","Report") %>", // we are calling json method
                        dataType: 'json',
                        success: function (data) {
                            var _select = '<select id="myselect" style="width: 40%;height: 30px;" onchange="jsFunction()">';
                            $.each(data, function (i, obj) {
                                _select += '<option value="' + obj.Year + '">' + obj.Year + '</option>';
                            });
                            _select += '</select>';
                            $("#yearId").append(_select);
                            jsFunction();
                        }
                    });
                } else {
                    jsFunction();
                }
            }
            $('#DataReport').html("");
    }
function _GetData() {
    switch (clickid) {
        case 1: // Sell Report
            $.post("<%= Url.Action("DataSellReport","Report")%>",
                               {
                                   dStart: $('#ProMStartDate').val(),
                                   dEnd: $('#ProMEndDate').val()
                               },
                            function (data) {
                                $('#DataReport').html(data);
                            });
            break;
        case 2:   // กำไรขาดทุน
            $.post("<%= Url.Action("DataProfitAndLossReport","Report")%>",
                   {
                       dStart: $('#ProMStartDate').val(),
                       dEnd: $('#ProMEndDate').val()
                   },
                function (data) {
                    $('#DataReport').html(data);
                }); break;
        case 3:   // Claim Report
            $.post("<%= Url.Action("DataClaimReport","Report")%>",
                    {
                        dStart: $('#ProMStartDate').val(),
                        dEnd: $('#ProMEndDate').val()
                    },
                  function (data) {
                      $('#DataReport').html(data);
                  }); break;
    }
}

function jsFunction() {
    $.post("<%= Url.Action("DataYearReport","Report")%>",
                             {
                                 year: $("#myselect").val()
                             },
                         function (data) {
                             $('#DataReport').html(data);
                         });
}
    </script>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <script src="<%: Url.Content("~/Scripts/moment.min.js") %>" type="text/javascript"></script>
    <link href="../../Content/Range.css" rel="stylesheet" />
    <script src="../../Scripts/date/daterangepicker.js"></script>
    <link href="../../Scripts/date/daterangepicker-bs3.css" rel="stylesheet" />
    <link href="//cdn.datatables.net/responsive/1.0.5/css/dataTables.responsive.css" rel="stylesheet" type="text/css" />
    <script src="//cdn.datatables.net/responsive/1.0.5/js/dataTables.responsive.js"></script>
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
