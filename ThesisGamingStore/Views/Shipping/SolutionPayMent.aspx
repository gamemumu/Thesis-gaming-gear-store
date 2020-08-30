<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Cart.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    SolutionPayMent
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
 <div id="contact-page" class="container">
       <div class="row">    		
	    		<div class="col-sm-12">    			   			
					<h2 class="title text-center">ขั้นตอนการแจ้งชำระเงิน</h2>    			    				    				
				</div>			 		
			</div>    	
        <div class="bg">
            <%for(int i=0;i<9;i++){%>
            <div class="row">
                <div class="col-sm-8">
                    <h2 class="title text-center">รูปขั้นตอนที่ <strong><%=i+1%></strong></h2>
                    <div id="gmap" class="contact-map">
                        <%string path = "../../images/soluPay/p" + i + ".png";%>
                        <a href="<%=path%>"  data-toggle="lightbox" data-title="รูปขั้นตอนที่ <%=i+1%>">
                            <img src="<%=path%>" width="100%" height="100%" />
                        </a>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="contact-info">
                            <h2 class="title text-center">ขั้นตอนการทำงานที่ <strong><%=i+1%></strong></h2>
                        <address>
                            <%switch(i){ %>
                            <%case 0: %><p>ในหน้าหน้าประวัติการสั่งซื้อ</p><p>แสดงข้อมูลประวัติสั่งซื้อสินค้าที่เคยทำการสั่งซื้อทั้งหมด</p><p>ถ้าแจ้งช้าเกินกว่า 3 วันระบบจะทำการยกเลิกการสั่งซื้อสินค้า</p><p>กดปุ่ม PAYMENT เพื่อทำการแจ้งการชำระ</p><p>กดปุ่ม INFO ดูรายละเอียดสินค้าที่สั่ง</p><p>กดปุ่ม DELETE ยกเลิกการสั่งซื้อ</p><%break; %>
                            <%case 1: %><p>เมื่อกดปุ่ม PAYMENT แล้วจะมายังเพจดังรูป</p>  <p>ให้ทำการกดปุ่มเลือกธนาคารที่โอนเงินเข้ามา</p>  <p>เพื่อให้พนักงานเช็คยอดได้</p><%break; %>
                            <%case 2: %><p>จากนั้นทำการคลิกที่ช่อง วันเวลา</p>  <p>เพื่อเป็นการระบุให้พนักงานอย่างชัดเจนว่า</p> <p>โอนมาวันไหน และเวลาเมื่อไหร่ ดังรูป</p><%break; %>
                            <%case 3: %><p>ทำการกรอกจำนวนเงินที่ทำการโอนเข้ามา</p><%break; %>
                            <%case 4: %><p>ทำการกดปุ่ม "เลือกไฟล์"</p>  <p>เพื่อทำการอัฟโหลดรูปสลิปให้พนักงานเช็คด้วย</p> <p>ทั้งเพื่อความไวในการตรวจสอบกรุณากรอกข้อมูลให้ตรงด้วย</p><%break; %>
                            <%case 5: %><p>เมื่อกรอกข้อมูลครบแล้ว</p>  <p>ทำการกดปุ่ม PAYMENT เพื่อแจ้งยืนยันการชำระเงิน</p><%break; %>
                            <%case 6: %><p>เมื่อแจ้งการชำระเงินไปแล้วจะเห็นว่า</p>  <p>แถบสถานะจะเปลี่ยนเป็น "ตรวจสอบการชำระ"</p><p>ซึ่งจะอยู่ในขั้นตอนการเช็คว่ายอดชำระตรงกับข้อมูลธนาคารหรือไม่</p><%break; %>
                            <%case 7: %><p>เมื่อเช็คข้อมูลเสร็จเรียบร้อยแล้วว่าข้อมูลถูกต้อง</p>  <p>แถบสถานะจะเปลี่ยนเป็น "เตรียมจัดส่งสินค้า"</p><%break; %>
                            <%case 8: %><p>เมื่อสินค้าถูกจัดส่งแล้วทางระบบ</p>  <p>จะแจ้งหมายเลข EMS ตรงแถบ "PAYMENT"</p><%break; %>
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
