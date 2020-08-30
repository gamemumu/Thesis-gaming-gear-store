<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Shipping.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Index
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="features_items">
        <!--features_items-->
        <h2 class="title text-center">Features Items</h2>
    </div>
    <!--features_items-->
    <div class="recommended_items">
        <!--recommended_items-->
        <h2 class="title text-center">recommended items</h2>
    </div>
   
    <!--/recommended_items-->
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    <script type="text/javascript">
        $(document).delegate('*[data-toggle="lightbox"]', 'click', function (event) {
            event.preventDefault();
            $(this).ekkoLightbox();
        });
        $(document).ready(function () {
            var data_features = ""; var data_features_end = "";
            var data_discount = ""; var data_discount_end = "";
            var ava = "";
            //###### Feature  && DICOUNT ####
            $.ajax({
                type: 'Get',
                url: "<%= Url.Action("JsonFeaturesItems","Shipping") %>", // we are calling json method
                dataType: 'json',
                success: function (data) {
                    $.each(data.Promotion, function (i, obj) {
                        data_discount += '<div class="col-sm-4 ">' +
							'<div class="product-image-wrapper">' +
								'<div class="single-products">' +
										'<div class="productinfo text-center ">' +
                                         '<a href="' + obj.Photo1 + '" data-toggle="lightbox"  data-title="' + obj.TrdName + ' ' + obj.BrandName + '  [Amount : ' + obj.TempStock + ']"> <img src="' + obj.Photo1 + '" height="184" width="128"></a>' +
											'<h2>฿ ' + numeral(obj.Price - (obj.Price * (obj.Discount / 100))).format('0,0') + '&nbsp <small><s>' + numeral(obj.Price).format('0,0') + '</s></small></h2>' +
                                            '<p>' + obj.TrdName + '</p>';
                        if (obj.BrandName.length > 34) data_discount += '<p>' + obj.BrandName.substring(0, 71) + '</p>';
                        else data_discount += '<p>' + obj.BrandName + '<br><br></p>';
                        if (obj.Status) {
                            data_discount += '<button class="btn btn-default add-to-cart" type="button" onclick="addCart(\'' + obj.PrdID + '\')"><i class="fa fa-shopping-cart"></i>Add to cart</button>';
                            ava = "In Stock";
                        } else {
                            data_discount += '<button class="btn btn-default add-to-cart" type="button" disabled><i class="fa fa-shopping-cart" disabled></i>Out of stock</button>';
                            ava = "Out Stock";
                        }
                        data_discount += '</div>' +
                                '<img src="../../images/home/sale.png" class="new" alt="">' +
                               '</div>' +
                               '<div class="choose">'+
									'<ul class="nav nav-pills nav-justified">' +
                                    	'<li><a href="#">Availability : ' + ava + '</a></li>' +
										'<li><a href="#">Amount : ' + obj.TempStock + '</a></li>' +
									'</ul>'+
								'</div>'+
                         '</div></div>';
                    }); //end Promotion
                    $.each(data.Results, function (i, obj) {
                        data_features += '<div class="col-sm-4">' +
							'<div class="product-image-wrapper">' +
								'<div class="single-products">' +
										'<div class="productinfo text-center">' +
                                              '<a href="' + obj.Photo1 + '" data-toggle="lightbox" data-title="' + obj.TrdName + ' ' + obj.BrandName + '"> <img src="' + obj.Photo1 + '" height="184" width="128"></a>' +
											'<h2>฿ ' + numeral(obj.Price).format('0,0') + '</h2>' +
                                            '<p>' + obj.TrdName + '</p>';
                        if (obj.BrandName.length > 34) data_features += '<p>' + obj.BrandName.substring(0, 71) + '</p>';
                        else data_features += '<p>' + obj.BrandName + '<br><br></p>';
                        if (obj.Status) {
                            data_features += '<button class="btn btn-default add-to-cart" type="button" onclick="addCart(\'' + obj.PrdID + '\')"><i class="fa fa-shopping-cart"></i>Add to cart</button></div>';
                            ava = "In Stock";
                        } else {
                            data_features += '<button class="btn btn-default add-to-cart" type="button" disabled><i class="fa fa-shopping-cart"></i>Out of stock</button></div>';
                            ava = "Out Stock";
                        }
                        if (obj.PrdStatus == "สินค้าใหม่") {
                            data_features += '<img src="../../images/home/new.png" class="new" alt="">';
                        }
                        else if (obj.PrdStatus == "สินค้าขายดี") {
                            data_features += '<img src="../../images/home/best-seo.png" class="new" alt="">';
                        }
                        data_features += '</div>' +
                                    '<div class="choose">' +
									'<ul class="nav nav-pills nav-justified">' +
                                    	'<li><a href="#">Availability : ' + ava + '</a></li>' +
										'<li><a href="#">Amount : ' + obj.TempStock + '</a></li>' +
									'</ul>' +
								'</div>' +
                         '</div></div>';
                    });//end สินค้าขายดี สินค้าใหม่
                    $(data_discount + data_features).insertAfter(".features_items h2"); //###### Feature ####

                    //begin recommend
                    var recommended_items = '<div id="recommended-item-carousel" class="carousel slide" data-ride="carousel"><div class="carousel-inner">';
                    $.each(data.Recommended, function (i, obj) {
                        if (i % 3 == 0) {
                            if (i == 0) {
                                recommended_items += ' <div class="item active">';
                            } else {
                                recommended_items += '</div><div class="item">';
                            }
                        }
                        recommended_items += '<div class="col-sm-4"><div class="product-image-wrapper"><div class="single-products"><div class="productinfo text-center">' +
                                   '<a href="' + obj.Photo1 + '" data-toggle="lightbox"  data-title="' + obj.TrdName + ' ' + obj.BrandName + '"> <img src="' + obj.Photo1 + '" height="128"></a>' +
                                        '<h2>฿ ' + numeral(obj.Price).format('0,0.00') + '</h2>' +
                                        '<p>' + obj.TrdName + '</p>' +
                                        '<p>' + obj.BrandName + '</p>';
                        if (obj.Status) {
                            recommended_items += '<button class="btn btn-default add-to-cart" type="button" onclick="addCart(\'' + obj.PrdID + '\')"><i class="fa fa-shopping-cart"></i>Add to cart</button>' +
                            '</div></div></div></div>';
                        }
                        else{
                            recommended_items += '<button class="btn btn-default add-to-cart" type="button" disabled><i class="fa fa-shopping-cart"></i>Out of stock</button>' +
                                '</div></div></div></div>';
                        }
                    });
                    var end = '</div></div><a class="left recommended-item-control" href="#recommended-item-carousel" data-slide="prev"><i class="fa fa-angle-left"></i></a>' +
                             '<a class="right recommended-item-control" href="#recommended-item-carousel" data-slide="next"><i class="fa fa-angle-right"></i></a></div>';
                    var finish = recommended_items + end;
                    $(finish).insertAfter(".recommended_items h2"); 
                    // end recommend
                }//end success  
            });
        });//docready
        function addCart(id) {
            event.preventDefault();
            $.post("<%= Url.Action("AddtoCart","Shipping") %>", { id: id, }, function (data, status) { $("#yourCart").html(data); nofi(); });
        }
        function clearCart() {
            event.preventDefault();
            $.get("<%= Url.Action("ClearCart","Shipping") %>",function (data, status) { $("#yourCart").html(data); nofi(); });
        }
    </script>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
