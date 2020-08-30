<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <meta name="viewport" content="width=device-width" />
    <title>
        Home | Gaming Gear 
    </title>
    <link href="../../Content/MemberCss/bootstrap.min.css" rel="stylesheet" />
    <link href="../../Content/MemberCss/font-awesome.min.css" rel="stylesheet" />
    <link href="../../Content/MemberCss/prettyPhoto.css" rel="stylesheet" />
    <link href="../../Content/MemberCss/price-range.css" rel="stylesheet" />
    <link href="../../Content/MemberCss/animate.css" rel="stylesheet" />
    <link href="../../Content/MemberCss/main.css" rel="stylesheet" />
    <link href="../../Content/MemberCss/responsive.css" rel="stylesheet" />
    <script src="../../Scripts/js_member/jquery.js"></script>
    <script src="../../Scripts/js_member/bootstrap.min.js"></script>
    <script src="../../Scripts/js_member/jquery.scrollUp.min.js"></script>
    <script src="../../Scripts/js_member/price-range.js"></script>
    <script src="../../Scripts/js_member/jquery.prettyPhoto.js"></script>
    <script src="../../Scripts/js_member/main.js"></script>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
    <link rel="shortcut icon" href="images/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="images/ico/apple-touch-icon-57-precomposed.png">
</head>
<!--/head-->
<body>
   	<div class="container text-center">
		<div class="logo-404">
			<a href="<%= Url.Action("index", "Shipping")%>"><img src="../../images/home/logo.png" alt="" /></a>
		</div>
		<div class="content-404">
			<img src="../../images/404/404.png" class="img-responsive" alt="" />
			<h1><b>OPPS!</b> We Couldn’t Find this Page</h1>
			<p>Uh... So it looks like you brock something. The page you are looking for has up and Vanished.</p>
			<h2><a href="<%= Url.Action("index", "Shipping")%>">Bring me back Home</a></h2>
		</div>
	</div>
</body>
</html>
