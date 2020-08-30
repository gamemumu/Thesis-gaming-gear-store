<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Cart.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    SolutionShipping
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
 <div id="contact-page" class="container">
        <div class="bg">
            <div class="row">    		
	    		<div class="col-sm-12">    			   			
					<h2 class="title text-center">ขั้นตอนการสั่งซื้อสินค้า</h2>    			    				    				
				</div>			 		
			</div>    	
            <%for(int i=1;i<9;i++){%>
            <div class="row">
                <div class="col-sm-8">
                    <h2 class="title text-center">รูปขั้นตอนที่ <strong><%=i%></strong></h2>
                    <div id="gmap" class="contact-map">
                        <%string path = "../../images/soluShip/e" + i + ".png";%>
                        <a href="<%=path%>"  data-toggle="lightbox" data-title="รูปขั้นตอนที่ <%=i%>">
                            <img src="<%=path%>" width="100%" height="100%" />
                        </a>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="contact-info">
                            <h2 class="title text-center">ขั้นตอนการทำงานที่ <strong><%=i%></strong></h2>
                        <address>
                            <%switch(i){ %>
                            <%case 1: %><p>หาสินค้าที่ต้องการ</p>  <p>ทำการกดปุ่ม</p>  <p>Add to cart</p> <p>ถ้าขึ้น Out of Stock</p> <p>แสดงว่าสินค้านั้นหมด</p><%break; %>
                            <%case 2: %><p>เมื่อกด Add to cart</p><p>จะปรากฏข้อมูลสินค้าที่เราทำการซื้อทางด้านซ้าย</p>  <p>พร้อมแสดงจำนวนสินค้าที่สั่งซื้อ</p> <p>สามารถกดปุ่มเข้าไปดูสินค้าที่เราซื้อได้โดยกดที่</p> <p>View Full Cart</p><p>หรือกดสามารถปุ่ม Checkout เพื่อทำการสั่งซื้อ</p><%break; %>
                            <%case 3: %><p>ในกรณีที่กด View Full Cart จะมาหน้าเพจดังรูป</p>  <p>สามารถกดปุ่ม COUNTINUE SHOPPING </p>  <p>เพื่อทำการสั่งซื้อเพิ่มได้</p> <p>หรือกดปุ่ม CHECKOUT </p> <p>จะไปหน้าทำรายการสั่งซื้อ</p><%break; %>
                            <%case 4: %><p>ในกรณีที่ไม่มี User</p>  <p>ให้ทำการสมัครสมาชิกก่อน</p>  <p>โดยกดปุ่ม Signup</p> <p>หรือปุ่ม Register ด้านมุมบนขวาของเพจ</p> <p>ถ้ามี User แล้วสามารถทำการยืนยันการสั่งซื้อในขั้นตอนต่อไปได้</p><%break; %>
                            <%case 5: %><p>ทำการสมัครสมาชิกใหม่</p>  <p>และกรอกข้อมูลให้ครบถ้วน</p>  <p>จากนั้นกดปุ่ม CONFIRM เพื่อทำการยืนยันการสมัคร</p><%break; %>
                            <%case 6: %><p>เมื่อสมัครเสร็จแล้ว</p>  <p>สามารถแก้ไขข้อมูลที่จะจัดส่งสินค้าได้</p>  <p>โดยมี 2 ทางเลือกคือ</p><p>1. ใช้ที่อยู่ตาม Account ของตนเอง</p><p>2. ใช้ที่อยู่ตามที่กรอกใหม่ทางด้าน ขวา</p><p>กดปุ่ม COMFIRM ORDER เพื่อยืนยันการสั่งซื้อ</p><%break; %>
                            <%case 7: %><p>ข้อความแจ้งเตือน</p>  <p>การสั่งซื้อเสร็จสิน</p><%break; %>
                            <%case 8: %><p>จะไปยังหน้าประวัติการสั่งซื้อ</p>  <p>และจะได้ข้อมูลการสั่งซื้อของสมาชิกขึ้นมาตามที่สั่งซื้อไว้</p><%break; %>
                            <%} %>
                        </address>
                    </div>
                </div>
            </div>
            <%} %>
        <div class="row"> <a href="/Shipping/SolutionPayMent" class="btn btn-primary pull-right" >ขั้นตอนการชำระเงิน</a> </div>
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
