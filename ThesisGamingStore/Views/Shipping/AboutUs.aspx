<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Cart.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    AboutUs
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div id="contact-page" class="container">
        <div class="bg">
            <div class="row">
                <div class="col-sm-8">
                    <h2 class="title text-center">Contact <strong>Us</strong></h2>
                    <div id="gmap" class="contact-map">
                        <a href="../../images/game/map_bangkapi.jpg" data-toggle="lightbox">
                            <img src="../../images/game/map_bangkapi.jpg" width="100%" height="100%" />
                        </a>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="contact-info">
                        <h2 class="title text-center">Contact Info</h2>
                        <address>
                            <p>มหาพรหม เซอร์วิส</p>
                            <p>ห้อง 2111 ลาดพร้าว แขวง คลองจั่น เขต บางกะปิ กรุงเทพมหานคร 10240</p>
                            <p>Mobile: 084-078-2384</p>
                            <p>Email: mahapromservice@shopper.com</p>
                        </address>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--/#contact-page-->
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    <script type="text/javascript">
        $(document).delegate('*[data-toggle="lightbox"]', 'click', function (event) {
            event.preventDefault();
            $(this).ekkoLightbox();
        });
    </script>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
